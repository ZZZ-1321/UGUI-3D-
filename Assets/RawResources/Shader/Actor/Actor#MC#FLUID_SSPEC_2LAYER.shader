// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "IXS_Actor/Actor#MC#FLUID_SSPEC_2LAYER" 
{
	Properties
	{
		_TintColor("Tint Color", Color) = (0.5, 0.5, 0.5, 1.0)
		_Intensity("Intensity", Float) = 2.0
		_MainTex ("Base", 2D) = "white" {}		

		//_MiscTex("Misc Tex(rg for mask)", 2D) = "white" {}	

		_MatCapTex("Mat Cap Tex", 2D) = "gray" {}
		_MatCapIntensity("Mat Cap Intensity", Float) = 1.0
		_MatCapDarkFactor("Mat Cap Dark Factor", Range(0.0, 1.0)) = 0.7
		_MatCapFactor("Mat Cap Factor", Range(0, 1)) = 1

		_SpecTex1("Spec Tex 1", 2D) = "white" {}
		_SpecTex2("Spec Tex 2", 2D) = "white" {}
		_SpecColor1("Spec Color1", Color) = (0.5, 0.5, 0.5, 1.0)
		_SpecColor2("Spec Color2", Color) = (0.5, 0.5, 0.5, 1.0)

		_SpecMask1("Spec Mask 1", 2D) = "white" {}
		_SpecMask2("Spec Mask 2", 2D) = "white" {}
		
		_SpecIntensity("Spec Intensity", Vector) = (2.0, 2.0, 0.0, 0.0)			
		
		_SpecTexUVSpeed("Spec Tex UV Speed", Vector) = (0.0, 0.0, 0.0, 0.0)				

		_SpecDisturbTex1("Spec Disturb Tex 1", 2D) = "black" {}
		_SpecDisturbTex2("Spec Disturb Tex 2", 2D) = "black" {}
		_SpecDisturbUVSpeed("Spec Disturb UV Speed", Vector) = (0.0, 0.0, 0.0, 0.0)
		_SpecDisturbPower("Spec Disturb Power(x for layer 1, y for layer 2)", Vector) = (0.7, 0.7, 0.0, 0.0)

		_SpecBlendFactor("Spec Blend Factor", Range(0, 1)) = 0.5

		[Enum(UnityEngine.Rendering.BlendMode)] _AlphaChannelSrcBlend("Alpha Channel Src Blend Mode", Float) = 3
		[Enum(UnityEngine.Rendering.BlendMode)] _AlphaChannelDestDestBlend("Alpha Channel Dest Blend Mode", Float) = 6
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
		Blend SrcAlpha OneMinusSrcAlpha,[_AlphaChannelSrcBlend][_AlphaChannelDestDestBlend]
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

			sampler2D _SpecDisturbTex1;
			half4 _SpecDisturbTex1_ST;
			sampler2D _SpecDisturbTex2;
			half4 _SpecDisturbTex2_ST;

			float4 _SpecDisturbUVSpeed;			

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);					
				o.uv_main_and_cap.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

				o.uv_spec.xy = TRANSFORM_TEX(v.texcoord, _SpecTex1) + _SpecTexUVSpeed.xy * _Time.xx;
				o.uv_spec.zw = TRANSFORM_TEX(v.texcoord, _SpecTex2) + _SpecTexUVSpeed.zw * _Time.xx;

				half2 disturbTexUV1 = TRANSFORM_TEX(v.texcoord, _SpecDisturbTex1);
				half2 disturbTexUV2 = TRANSFORM_TEX(v.texcoord, _SpecDisturbTex2);
				o.uv_spec_disturb.xy = disturbTexUV1 + _SpecDisturbUVSpeed.xy * _Time.xx;
				o.uv_spec_disturb.zw = disturbTexUV2 + _SpecDisturbUVSpeed.zw * _Time.xx;

				half2 capCoord;

				capCoord.x = dot(UNITY_MATRIX_IT_MV[0].xyz, normalize(v.normal));
				capCoord.y = dot(UNITY_MATRIX_IT_MV[1].xyz, normalize(v.normal));
				o.uv_main_and_cap.zw = capCoord * 0.5 + 0.5;
				
				return o;
			}				
			
			sampler2D _SpecMask1;
			sampler2D _SpecMask2;
			
			float _SpecBlendFactor;

			fixed4 _SpecColor1;	
			fixed4 _SpecColor2;			

			float4 _SpecDisturbPower;

			float4 _SpecIntensity;

			sampler2D _MatCapTex;
			float _MatCapFactor;
			float _MatCapIntensity;
			float _MatCapDarkFactor;
									
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 texColor = tex2D(_MainTex, i.uv_main_and_cap.xy);
				
				texColor.rgb = saturate(texColor.rgb * _TintColor.rgb * _Intensity);
				texColor.a *= _TintColor.a;	
				
				float4 specUIDistb1 = tex2D(_SpecDisturbTex1, i.uv_spec_disturb.xy);
				float2 sd1 = (specUIDistb1.xz - 0.5) * _SpecDisturbPower.x;
				float4 specUIDistb2 = tex2D(_SpecDisturbTex2, i.uv_spec_disturb.zw);
				float2 sd2 = (specUIDistb2.xz - 0.5) * _SpecDisturbPower.y;
				
				fixed4 specMC1 = tex2D(_SpecTex1, i.uv_spec.xy + sd1);
				fixed4 specMC2 = tex2D(_SpecTex2, i.uv_spec.zw + sd2);

				fixed4 mask1 = tex2D(_SpecMask1, i.uv_main_and_cap.xy);
				fixed4 mask2 = tex2D(_SpecMask2, i.uv_main_and_cap.xy);

				specMC1.rgb = specMC1.rgb * _SpecColor1.rgb * _SpecIntensity.x * mask1.rgb;
				specMC2.rgb = specMC2.rgb * _SpecColor2.rgb * _SpecIntensity.y * mask2.rgb;
				
				fixed3 specC = lerp(specMC1.rgb, specMC2.rgb, _SpecBlendFactor);

				fixed4 mc = tex2D(_MatCapTex, i.uv_main_and_cap.zw);

				texColor.rgb = ApplyMatCap(texColor.rgb, mc.rgb, _MatCapIntensity, _MatCapDarkFactor, _MatCapFactor);

				texColor.rgb += specC;
				return texColor;
			}
			ENDCG 
		}
	} 
		
	Fallback off
}
