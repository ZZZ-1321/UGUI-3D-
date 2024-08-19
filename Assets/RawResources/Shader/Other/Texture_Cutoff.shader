// Upgrade NOTE: commented out 'half4 unity_LightmapST', a built-in variable
// Upgrade NOTE: commented out 'sampler2D unity_Lightmap', a built-in variable
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

Shader "IXS_Other/Texture_Cutoff" 
{
	Properties
	{
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,1)		
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.5

		_StencilRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilCompare("Stencil Compare", Float) = 0
	}	
		
	// ---- Fragment program cards
	SubShader
	{
		Tags { "Queue"="AlphaTest" "RenderType"="TransparentCutout" "IgnoreProjector"="True" }
		
		Cull Back 		
		ZWrite On 
		ZTest LEqual		
		Blend SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
		
		Stencil
		{
			Ref[_StencilRef]
			Comp[_StencilCompare]
		}

		Pass
		{		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#pragma fragmentoption ARB_precision_hint_fastest			
			
			#include "UnityCG.cginc"			
			
			struct appdata_t
			{
				float4 vertex : POSITION;						
				half2 uv : TEXCOORD0;			
			};

			struct v2f
			{
				float4 vertex : POSITION;				
				half2 uv : TEXCOORD0;		
			};	
			
			sampler2D _MainTex;				
			fixed4 _TintColor;

			half4 _MainTex_ST;	

			fixed _Cutoff;
			
			v2f vert (appdata_t v)
			{
				v2f o;

				o.vertex = UnityObjectToClipPos(v.vertex);					
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 finalC = tex2D(_MainTex, i.uv);
				finalC.rgb = finalC.rgb * _TintColor.rgb * 2.0;
				finalC.a = finalC.a * _TintColor.a;	
				clip(finalC.a - _Cutoff);

				return finalC;
			}
			ENDCG 
		}			
	} 	

	Fallback Off
}
