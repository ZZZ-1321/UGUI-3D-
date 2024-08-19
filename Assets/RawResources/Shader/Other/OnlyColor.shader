// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "IXS_Other/OnlyColor" 
{
	Properties
	{
		_Color ("Base (RGBA)", color) = (1,1,1,1)		
	}

	SubShader
	{
		Tags	{ "RenderType"="Transparent" "Queue"="Transparent" "IgnoreProjector"="false" }
		
		Fog {Mode Off}
		Cull Back 
		Lighting Off 
		ZWrite On
		ZTest LEqual
		AlphaTest Off
		Blend SrcAlpha OneMinusSrcAlpha	
		
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			float4 _Color;

			struct v2f
			{
				float4 pos:SV_POSITION;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}

			float4 frag(v2f v):COLOR
			{
				return _Color;
			}
			
			ENDCG
		}
	} 
	FallBack Off
}
