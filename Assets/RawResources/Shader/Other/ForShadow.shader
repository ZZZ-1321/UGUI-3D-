// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "IXS_Other/ForShadow" 
{
	Properties
	{
		_MainTex("Base", 2D) = "gray" {}
		_AlphaCut("Alpha Cut Off Value", Range(0.0, 1.0)) = 0.0
		//_TintColor("Tint Color", Color) = (0.5, 0.5, 0.5, 1.0)
	}
	
	// ---- Fragment program cards
	SubShader
	{
		Tags { "Queue"="Geometry" "RenderType"="Opaque" "IgnoreProjector"="True" }
				
		Cull Back 
		Lighting Off 
		ZWrite On 
		ZTest LEqual
		AlphaTest Off
		Blend One Zero		
		Fog { Mode Off } 		

		Pass
		{		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			//#pragma multi_compile_particles
			
			#include "UnityCG.cginc"				
			
			struct appdata_t
			{
				float4 vertex : POSITION;	
				half2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : POSITION;
				float3 uv_depth : TEXCOORD0;				
			};	

			half4 _MainTex_ST;

			float4x4 G_PROJ_SHADOW_MATRIX;

			v2f vert (appdata_t v)
			{
				v2f o;

				o.vertex = UnityObjectToClipPos(v.vertex);		
				o.uv_depth.xy = TRANSFORM_TEX(v.uv, _MainTex);	

				float3 worldPos = mul(unity_ObjectToWorld, v.vertex);
				float4 proj_pos = mul(G_PROJ_SHADOW_MATRIX, float4(worldPos, 1.0));
				o.uv_depth.z = proj_pos.z / proj_pos.w;
				return o;
			}

			sampler2D _MainTex;
			//fixed4 _TintColor;
			float _AlphaCut;
			
			float4 frag (v2f i) : COLOR
			{	
				fixed4 baseColor = tex2D(_MainTex, i.uv_depth.xy);
				clip(baseColor.a - _AlphaCut);
				//baseColor.a = baseColor.a;
					
				return float4(i.uv_depth.z, 0.0, 0.0, 0.0);
			}
			ENDCG 
		}
	}
	
	Fallback Off 	
}
