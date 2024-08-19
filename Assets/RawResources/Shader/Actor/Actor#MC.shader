// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "IXS_Actor/Actor#MC" 
{
	Properties
	{
		_TintColor("Tint Color", Color) = (0.5, 0.5, 0.5, 1.0)
		_Intensity("Intensity", Float) = 2.0
		_MainTex ("Base", 2D) = "white" {}	

		_HSVCMaskTex("HSVC Mask", 2D) = "black" {}
		
		_MatCapTex("Mat Cap Tex", 2D) = "gray" {}		
		_MatCapIntensity("Mat Cap Intensity", Float) = 1.0
		_MatCapDarkFactor("Mat Cap Dark Factor", Range(0.0, 1.0)) = 0.7
		_MatCapFactor("Mat Cap Factor", Range(0, 1)) = 1	
	}	
		
	// ---- Fragment program cards
	SubShader
	{
		Tags { "Queue"="AlphaTest+2" "RenderType"="Opaque" "IgnoreProjector"="True" }
				
		Cull Back 
		Lighting Off 
		ZWrite On 
		ZTest LEqual
		AlphaTest Off
		Blend SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
		Fog { Mode Off } 
		
		Pass
		{		
			CGPROGRAM
			#pragma target 2.0

			#pragma vertex vert
			#pragma fragment frag	
			#pragma fragmentoption ARB_precision_hint_fastest	

			#pragma multi_compile __ TINTAGE
			
															
			#include "UnityCG.cginc"						
			#include "../Include/MatCap.cginc"
			#include "../Include/HSVC.cginc"
													
			
			struct appdata_t
			{
				float4 vertex : POSITION;						
				half2 texcoord : TEXCOORD0;				
				float3 normal : NORMAL;				
			};

			struct v2f
			{
				float4 vertex : POSITION;						
				half2 texcoord : TEXCOORD0;										
				half2 uv_mat_cap : TEXCOORD1;
			};
			
			sampler2D _MainTex;	
			fixed4 _TintColor;
			float _Intensity;		
			
			half4 _MainTex_ST;						

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);					
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);								
								
				half2 capCoord;					 

				capCoord.x = dot(UNITY_MATRIX_IT_MV[0].xyz, normalize(v.normal));	
				capCoord.y = dot(UNITY_MATRIX_IT_MV[1].xyz, normalize(v.normal));
				o.uv_mat_cap.xy = capCoord * 0.5 + 0.5;
													
				return o;
			}							
			
			sampler2D _MatCapTex;

			float _MatCapFactor;
			float _MatCapIntensity;
			float _MatCapDarkFactor;
									
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 texColor = tex2D(_MainTex, i.texcoord);

#if TINTAGE
				texColor.rgb = ApplyHSVC(texColor.rgb, i.texcoord);			
#endif
				
				texColor.rgb = saturate(texColor.rgb * _TintColor.rgb * _Intensity);
				texColor.a *= _TintColor.a;	

				fixed4 mc = tex2D(_MatCapTex, i.uv_mat_cap);				
				texColor.rgb = ApplyMatCap(texColor.rgb, mc.rgb, _MatCapIntensity, _MatCapDarkFactor, _MatCapFactor);
								
				return texColor;
			}
			ENDCG 
		}
	} 
		
	Fallback off
}
