// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "IXS_Other/Texture" 
{
	Properties
	{	
		_MainTex ("Base", 2D) = "gray" {}
		_TintColor("Tint Color", Color) = (0.5, 0.5, 0.5, 1.0)

		_StencilRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilCompare("Stencil Compare", Float) = 0
	}		

	SubShader
	{
		Tags { "Queue"="Geometry" "RenderType"="Opaque" "IgnoreProjector"="True" }
				
		Cull Back 		
		ZWrite On 
		ZTest LEqual
		AlphaTest Off
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
			//#pragma multi_compile_particles
			
			#include "UnityCG.cginc"

			sampler2D _MainTex;			
			
			struct appdata_t
			{
				float4 vertex : POSITION;				
				half2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : POSITION;				
				half2 texcoord : TEXCOORD0;
			};
			
			half4 _MainTex_ST;			

			v2f vert (appdata_t v)
			{
				v2f o;

				o.vertex = UnityObjectToClipPos(v.vertex);					
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);					
				return o;
			}

			fixed4 _TintColor;
			
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 outC;
											
				fixed4 texC = tex2D(_MainTex, i.texcoord);
				outC.rgb = texC.rgb * _TintColor.rgb * 2.0;
				outC.a = texC.a * _TintColor.a;				
				return outC;
			}
			ENDCG 
		}
			
		UsePass "VertexLit/SHADOWCASTER"
	}
	
	Fallback Off 	
}
