Shader "Hidden/ScreenSpaceFluidRendering/CalcNormal"
{
	Properties
	{
		_MainTex ("", 2D) = "black"
	}
	CGINCLUDE

	#include "UnityCG.cginc"

	// 深度バッファ
	sampler2D _DepthBuffer;
	float4    _DepthBuffer_TexelSize;
	// ビュー変換を行うマトリックス
	float4x4 _ViewMatrix;

	// --------------------------------------------------------------------
	// Fragment Shader
	// --------------------------------------------------------------------
	// スクリーンのUVから視点座標系での位置を求める
	float3 uvToEye(float2 uv, float z)
	{
		float2 xyPos = uv * 2.0 - 1.0;
		// クリップ座標系での位置
		float4 clipPos = float4(xyPos.xy, z, 1.0);
		// 視点座標系での位置
		float4 viewPos = mul(unity_CameraInvProjection, clipPos);
		// 正規化
		viewPos.xyz = viewPos.xyz / viewPos.w;

		return viewPos.xyz;
	}
	
	// 深度の値を深度バッファから得る
	float sampleDepth(float2 uv)
	{
#if UNITY_REVERSED_Z
		return 1.0 - tex2D(_DepthBuffer, uv).r;
#else
		return tex2D(_DepthBuffer, uv).r;
#endif
	}

	// 視点座標系での位置を得る
	float3 getEyePos(float2 uv)
	{
		return uvToEye(uv, sampleDepth(uv));
	}

	float4 frag(v2f_img i) : SV_Target
	{
		// スクリーン座標からテクスチャのUV座標に変換
		float2 uv = i.uv.xy;
		// 深度を取得
		float depth = tex2D(_DepthBuffer, uv);

		// 深度が書き込まれていなければピクセルを破棄
#if UNITY_REVERSED_Z
		if (Linear01Depth(depth) > 1.0 - 1e-3)
			discard;
#else
		if (Linear01Depth(depth) < 1e-3)
			discard;
#endif
		// テクセルサイズを格納
		float2 ts = _DepthBuffer_TexelSize.xy;

		// 視点座標系（カメラから見た）位置をスクリーンのuv座標から求める
		float3 posEye = getEyePos(uv);

		// xについて偏微分
		float3 ddx  = getEyePos(uv + float2(ts.x, 0.0)) - posEye;
		float3 ddx2 = posEye - getEyePos(uv - float2(ts.x, 0.0));
		ddx = abs(ddx.z) > abs(ddx2.z) ? ddx2 : ddx;
		
		// yについて偏微分
		float3 ddy = getEyePos(uv + float2(0.0, ts.y)) - posEye;
		float3 ddy2 = posEye - getEyePos(uv - float2(0.0, ts.y));
		ddy = abs(ddy.z) > abs(ddy2.z) ? ddy2 : ddy;

		// 外積から上で求めたベクトルと直交する法線を求める
		float3 N = normalize(cross(ddx, ddy));

		// 法線をカメラの位置との関係で変更する
		float4x4 vm = _ViewMatrix;
		N = normalize(mul(vm, float4(N, 0.0)));
		
		// (-1.0～1.0) を (0.0～1.0) に変換 
		float4 col = float4(N * 0.5 + 0.5, 1.0);

		return col;
	}
	ENDCG

	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma target   3.0
			#pragma vertex   vert_img
			#pragma fragment frag
			ENDCG
		}
	}
}
