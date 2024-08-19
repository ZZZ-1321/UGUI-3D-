// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "IXS_Actor/Actor#MC#FLUID_SSPEC" 
{
	Properties
	{
		_TintColor("Tint Color", Color) = (0.5, 0.5, 0.5, 1.0)
		_Intensity("Intensity", Float) = 2.0
		_MainTex ("Base", 2D) = "white" {}		

		_MiscTex("Misc Tex", 2D) = "white" {}
		
		_MatCapTex("Mat Cap Tex", 2D) = "gray" {}
		_MatCapIntensity("Mat Cap Intensity", Float) = 1.0
		_MatCapDarkFactor("Mat Cap Dark Factor", Range(0.0, 1.0)) = 0.7
		_MatCapFactor("Mat Cap Factor", Range(0, 1)) = 1

		_SpecBlendFactor("Spec Blend Factor", Range(0, 1)) = 1

		_SpecTex1("Spec Tex 1", 2D) = "white" {}
		_SpecTex2("Spec Tex 2", 2D) = "white" {}
		//_SpecBlendFactor("Spec Blend Factor", Range(0, 1)) = 0.5
		_SpecTexUVSpeed("Spec Tex UV Speed", Vector) = (0.0, 0.0, 0.0, 0.0)
		_SpecColor("Spec Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_SpecIntensity("Spec Intensity", Float) = 1.0

		_SpecDisturbTex("Spec Disturb Tex", 2D) = "black" {}
		_SpecDisturbUVSpeed("Spec Disturb UV Speed", Vector) = (0.0, 0.0, 0.0, 0.0)
		_SpecDisturbPower("Spec Disturb Power", Vector) = (0.7, 0.7, 0.0, 0.0)
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
			#pragma vertex vert
			#pragma fragment frag	

			#pragma fragmentoption ARB_precision_hint_fastest			
			
															
			#include "UnityCG.cginc"						
			#include "../Include/MatCap.cginc"
													
			
			struct appdata_t
			{
				float4 vertex : POSITION;						
				half2 texcoord : TEXCOORD0;				
				float3 normal : NORMAL;				
			};

			struct v2f
			{
				float4 vertex : POSITION;						
				half4 uv_main_and_cap : TEXCOORD0;					
				float4 uv_spec : TEXCOORD1;
				float4 uv_spec_disturb : TEXCOORD2;
			};
			
			sampler2D _MainTex;	
			fixed4 _TintColor;
			float _Intensity;		
			
			half4 _MainTex_ST;	

			float4 _SpecTexUVSpeed;

			sampler2D _SpecTex1;
			half4 _SpecTex1_ST;

			sampler2D _SpecTex2;
			half4 _SpecTex2_ST;

			sampler2D _SpecDisturbTex;
			half4 _SpecDisturbTex_ST;
			float4 _SpecDisturbUVSpeed;			

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);					
				o.uv_main_and_cap.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

				o.uv_spec.xy = TRANSFORM_TEX(v.texcoord, _SpecTex1) + _SpecTexUVSpeed.xy * _Time.xx;
				o.uv_spec.zw = TRANSFORM_TEX(v.texcoord, _SpecTex2) + _SpecTexUVSpeed.zw * _Time.xx;

				half2 org_spec_disturb = TRANSFORM_TEX(v.texcoord, _SpecDisturbTex);
				o.uv_spec_disturb.xy = org_spec_disturb + _SpecDisturbUVSpeed.xy * _Time.xx;
				o.uv_spec_disturb.zw = org_spec_disturb + _SpecDisturbUVSpeed.zw * _Time.xx;
								
				half2 capCoord;				
				 
				capCoord.x = dot(UNITY_MATRIX_IT_MV[0].xyz, normalize(v.normal));
				capCoord.y = dot(UNITY_MATRIX_IT_MV[1].xyz, normalize(v.normal));
				o.uv_main_and_cap.zw = capCoord * 0.5 + 0.5;
													
				return o;
			}							
			
			sampler2D _MatCapTex;
			sampler2D _MiscTex;			

			float _MatCapFactor;
			float _SpecBlendFactor;

			float _MatCapIntensity;
			float _MatCapDarkFactor;
			float _SpecIntensity;
			fixed4 _SpecColor;	

			//float _SpecBlendFactor;

			float4 _SpecDisturbPower;
									
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 texColor = tex2D(_MainTex, i.uv_main_and_cap.xy);
				
				texColor.rgb = saturate(texColor.rgb * _TintColor.rgb * _Intensity);
				texColor.a *= _TintColor.a;	

				fixed4 mc = tex2D(_MatCapTex, i.uv_main_and_cap.zw);
				//half2 specMCUV = i.uv_mat_cap + _MatCapSpecTexUVSpeed.xy * _Time.xx;
				float4 specUIDistb1 = tex2D(_SpecDisturbTex, i.uv_spec_disturb.xy);
				float2 sd1 = (specUIDistb1.xz - 0.5) * _SpecDisturbPower.x;
				float4 specUIDistb2 = tex2D(_SpecDisturbTex, i.uv_spec_disturb.zw);
				float2 sd2 = (specUIDistb2.xz - 0.5) * _SpecDisturbPower.y;
				
				fixed4 specMC1 = tex2D(_SpecTex1, i.uv_spec.xy + sd1);
				fixed4 specMC2 = tex2D(_SpecTex2, i.uv_spec.zw + sd2);
				//fixed3 specC = lerp(specMC1.rgb, specMC2.rgb, _SpecBlendFactor);
				fixed3 specC = specMC1.rgb * specMC2.rgb;

				fixed4 miscC = tex2D(_MiscTex, i.uv_main_and_cap.xy);
				texColor.rgb = ApplyMatCapWithSpec(texColor.rgb, mc, specC, miscC, _MatCapIntensity, _MatCapDarkFactor, _MatCapFactor,
					_SpecIntensity, _SpecColor, _SpecBlendFactor);
				
				return texColor;
			}
			ENDCG 
		}
	} 
		
	Fallback off
}
