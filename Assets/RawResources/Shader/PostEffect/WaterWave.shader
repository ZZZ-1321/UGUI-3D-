Shader "Hidden/Post FX/Water Wave" 
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
 
	CGINCLUDE
	#include "UnityCG.cginc"

	uniform sampler2D _MainTex;
	float4 _MainTex_TexelSize;

	uniform half _WaterWave_Distance;
	uniform half _WaterWave_Speed;
    uniform half _WaterWave_Strength;
 
	fixed4 frag(v2f_img i) : SV_Target
	{
		float2 dv = float2(0.5, 0.5) - i.uv;
		//dv = dv * float2(_ScreenParams.x / _ScreenParams.y, 1);

		float dis = sqrt(dv.x * dv.x + dv.y * dv.y);
		float sinFactor = sin(dis * _WaterWave_Distance + _Time.y * _WaterWave_Speed) * _WaterWave_Strength * 0.01;
		float2 dv1 = normalize(dv);
		float2 offset = dv1  * sinFactor;
		float2 uv = offset + i.uv;
		return tex2D(_MainTex, uv);	
	}
 
	ENDCG
 
	SubShader 
	{
		Pass
		{
			ZTest Always
			Cull Off
			ZWrite Off
			Fog { Mode off }
 
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest 
			#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
			ENDCG
		}
	}

	FallBack "SGame/Scene/SimpleTexture"
}

