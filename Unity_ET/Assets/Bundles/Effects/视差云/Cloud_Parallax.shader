Shader "Custom/Cloud/ParallaxCloud" 
{
	Properties 
	{
		_Color("主颜色",Color) = (1,1,1,1)
		_MainTex("RGB颜色 A高度",2D)="white"{}
		_AlphaCof("透明度系数", Range(0, 1)) = 0.5
		_Height("云层高度",range(0.1, 1)) = 0.15
		_HeightAmount("云层厚度",range(0, 2)) = 1
		_HeightTileSpeed("扰动&速度Tiling", Vector) = (1.0,1.0, 0.05,0.0)
		_StepCount("视差步数", range(2, 20)) = 5

		_FX_Soft_Hide("隐藏区", Range(0, 1)) = 0
        _FX_Soft_Blend("渐变区", Range(0.01, 10)) = 1
	}

	SubShader 
	{
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Transparent+1000" }

		Pass
		{
		    Name "FORWARD"
            Tags { "LightMode"="UniversalForward" }
			Blend SrcAlpha OneMinusSrcAlpha, Zero Zero
			Cull Off

			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

			CBUFFER_START(UnityPerMaterial)
				float4 _MainTex_ST;
				float _Height;
				float4 _HeightTileSpeed;
				float _HeightAmount;
				float4 _Color;
				float _AlphaCof;
				float _StepCount;

				float _FX_Soft_Hide;
				float _FX_Soft_Blend;
			CBUFFER_END

			TEXTURE2D(_MainTex); SAMPLER(sampler_MainTex);
			TEXTURE2D(_CameraDepthTexture); SAMPLER(sampler_CameraDepthTexture);

			float SoftParticlesAlphaCof(float near, float far_inv, float4 projection)
			{
    			//near和far都大于0
				float2 ScreenUV = projection.xy / projection.w;
    			float sceneZ = LinearEyeDepth(SAMPLE_TEXTURE2D_X(_CameraDepthTexture, sampler_CameraDepthTexture, ScreenUV).r, _ZBufferParams);
				float NDCdepth = projection.z / projection.w;
    			float thisZ = LinearEyeDepth(NDCdepth, _ZBufferParams);
    			return smoothstep(0.0, 1.0, far_inv * (sceneZ - thisZ - near));
			}

			struct a2v
			{
    			float3 vertex 		: POSITION;
				float3 normal 		: NORMAL;
				float4 tangent		: TANGENT;
				float2 uv 			: TEXCOORD0;
			};

			struct v2f 
			{
				float4 clipPos 		: SV_POSITION;
				float4 uv 			: TEXCOORD0;
				float3 normalDir 	: TEXCOORD1;
				float3 viewDir 		: TEXCOORD2; //切线空间的观察方向
				float3 posWS 		: TEXCOORD3;
				//float fogFactor    	: TEXCOORD4;
				float4 positionNDC : TEXCOORD5;
			};

			v2f vert (a2v v) 
			{
				v2f o = (v2f)0;
				o.clipPos = TransformObjectToHClip(v.vertex);
				o.posWS = TransformObjectToWorld(v.vertex);
				o.uv.xy = v.uv * _MainTex_ST.xy + _MainTex_ST.zw;
				o.uv.xy += frac(_Time.y * _HeightTileSpeed.zw);
				o.uv.zw = v.uv * _HeightTileSpeed.xy;
				o.normalDir = TransformObjectToWorldNormal(v.normal);
				float3 binormal = cross(v.normal, v.tangent.xyz) * v.tangent.w;
				float3x3 rotation = float3x3(v.tangent.xyz, binormal, v.normal);
				float3 viewDirWS = _WorldSpaceCameraPos - o.posWS;
				o.viewDir = mul((float3x3)GetWorldToObjectMatrix(), viewDirWS);;
				o.viewDir = mul(rotation, o.viewDir); //切线空间的观察方向
				//o.fogFactor = ComputeFogFactor(o.clipPos.z);

				float4 ndc = o.clipPos * 0.5;
    			o.positionNDC.xy = float2(ndc.x, ndc.y * _ProjectionParams.x) + ndc.w;
    			o.positionNDC.zw = o.clipPos.zw;
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float3 viewRay= normalize(i.viewDir * -1);
				viewRay.z = abs(viewRay.z) + 0.2;
				viewRay.xy *= _Height;
				float4 _RandomColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv.zw); //扰动
				float _RandomHeight = _RandomColor.a * _HeightAmount; //不随着时间流动
				float3 _StepOffset = viewRay / (viewRay.z * _StepCount); //步长

				//场景假设：表面默认深度值为0 根据噪音图随机凹陷 深度值为0.5表示低于表面0.5
				//每增加一步 观察点沿着观察方向前进一步 新的观察点的深度值增加 采样新的观察点得到场景的深度值
				//场景深度值 = 1 - 高度 * 随机扰动
				//当观察点的深度值大于场景的深度值 则停止进步 使用浮雕视差映射或视差遮蔽映射继续判断落点
				//如果初始位置的深度大于等于0则此处是平的
				float2 _UV_0 = i.uv.xy;
				float _Depth_0 = 0.0;
				float _Depth_1 = 1.0 - SAMPLE_TEXTURE2D_LOD(_MainTex, sampler_MainTex, _UV_0, 0).a * _RandomHeight;
				float2 prev_UV_0 = _UV_0;
				float prev_Depth_0 = _Depth_0;
				float prev_Depth_1 = _Depth_1;
				while(_Depth_1 > _Depth_0) //采样深度 vs 观察点深度  
				{
					prev_UV_0 = _UV_0;
					prev_Depth_0 = _Depth_0;
					prev_Depth_1 = _Depth_1;
					_UV_0 += _StepOffset.xy;
					_Depth_0 += _StepOffset.z;
					_Depth_1 = 1.0 - SAMPLE_TEXTURE2D_LOD(_MainTex, sampler_MainTex, _UV_0, 0).a * _RandomHeight;
				}

				float _DepthOffset = _Depth_1 - _Depth_0; //负值
				float prev_DepthOffset = prev_Depth_1 - prev_Depth_0; //正值
				float _UV_Shift = _DepthOffset / (_DepthOffset - prev_DepthOffset);
				_UV_Shift = saturate(_UV_Shift);
				_UV_0 = lerp(_UV_0, prev_UV_0, _UV_Shift);

				float4 Color = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, _UV_0) * _RandomColor * _Color;
				float Alpha = lerp(Color.a, 1.0, _AlphaCof);
				Alpha *= SoftParticlesAlphaCof(_FX_Soft_Hide, 1.0 / _FX_Soft_Blend, i.positionNDC);

				float3 normal = normalize(i.normalDir);
				Light mainLight = GetMainLight();
				float NdotL = max(0, dot(normal, mainLight.direction));
                float3 finalColor = Color.rgb * (NdotL * mainLight.color + 1.0);
                return float4(finalColor.rgb, Alpha);
			}
		ENDHLSL
		}
	}
}
