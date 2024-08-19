Shader "Hidden/Post FX/Screen Offset"
{
	Properties
	{
		_MainTex("Base (RGB)", 2D) = "white" {}
	}

	CGINCLUDE
	#include "UnityCG.cginc"

	uniform sampler2D _MainTex;
	uniform float _OffsetStrength;
	uniform float _OffsetPercent;

	uniform float _YLeft;
	uniform float _YRight;
	uniform float _MidBlack;

	float4 frag(v2f_img i) : SV_Target
	{
		fixed y = lerp(_YLeft, _YRight, i.uv.x);
		fixed flagTop = step(y, i.uv.y);
		fixed flagBottom = 1 - flagTop;		
		fixed2 lineDir = fixed2(1, _YRight - _YLeft);
		fixed2 verticalDir = normalize(fixed2(_YRight - _YLeft, 1));	
		fixed2 offsetTop = (verticalDir * _MidBlack + lineDir) * _OffsetStrength * _OffsetPercent * flagTop * (1 - i.uv.x);
		fixed2 offsetBottom = (-verticalDir * _MidBlack - lineDir) * _OffsetStrength * _OffsetPercent * flagBottom * (i.uv.x);
		fixed2 offset = offsetTop + offsetBottom;

		fixed blackFlag = (y - _MidBlack * _OffsetPercent > i.uv.y) || (y + _MidBlack * _OffsetPercent < i.uv.y);

		float3 col = tex2D(_MainTex, i.uv.xy + offset).rgb * blackFlag;

		return float4(col, 1);
	}

	ENDCG

	SubShader
	{
		Pass
		{
			ZTest Always Cull Off ZWrite Off

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

