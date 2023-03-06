Shader "PortalGate/PortalGate"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_OpenRate("OpenRate", Range(0,1)) = 1
		_ConnectRate("ConnectRate", Range(0,1)) = 1
		_FrameColor0("FrameColor0", Color) = (1,0,0)
		_FrameColor1("FrameColor1", Color) = (0,0,1)
	}
	SubShader
	{
		Tags { "RenderType"="Transparent" "Queue" = "Transparent"}
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite Off
		LOD 100

		GrabPass
        {
            "_BackgroundTexture"
        }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "Noise.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			float4x4 _MainCameraViewProj;
			sampler2D _BackgroundTexture;

			float _OpenRate;
			float _ConnectRate;

			float3 _FrameColor0;
			float3 _FrameColor1;

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 sposOnMain : TEXCOORD1;
				float4 grabPos : TEXCOORD2;
			};

			v2f vert(appdata_img In)
			{
				v2f o;

				float3 posWorld = mul(unity_ObjectToWorld, float4(In.vertex.xyz, 1)).xyz;
				float4 clipPos = mul(UNITY_MATRIX_VP, float4(posWorld, 1));
				float4 clipPosOnMain = mul(_MainCameraViewProj, float4(posWorld, 1));

				o.pos = clipPos;
				o.uv = In.texcoord;
				o.sposOnMain = ComputeScreenPos(clipPosOnMain);
				o.grabPos = ComputeGrabScreenPos(o.pos);
				return o;
			}

			fixed4 frag (v2f In) : SV_Target
			{
				float2 uv = In.uv.xy;
				uv = (uv - 0.5) * 2; // map 0~1 to -1~1
				float insideRate = (1 - length(uv)) * _OpenRate;

				// background
				float4 grabUV = In.grabPos;
				float2 grabOffset = float2(
					snoise(float3(uv, _Time.y     )),
					snoise(float3(uv, _Time.y + 10))
				);
				grabUV.xy += grabOffset * 0.3 * insideRate;
				float4 bgColor = tex2Dproj(_BackgroundTexture, grabUV);

				// portal other side
				float2 sUV = In.sposOnMain.xy / In.sposOnMain.w;
				float4 sideColor = tex2D(_MainTex, sUV);

				// color
				float4 col = lerp(bgColor, sideColor, _ConnectRate);

				// frame
				float frame = smoothstep(0, 0.1, insideRate);
				float frameColorRate = 1 - abs(frame - 0.5) * 2;
				float mixRate = saturate(grabOffset.x + grabOffset.y);
				float3 frameColor = lerp(_FrameColor0, _FrameColor1, mixRate);
				col.xyz = lerp(col.xyz, frameColor, frameColorRate);

				col.a = frame;

				return col;
			}
			ENDCG
		}
	}
}
