// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "IXS_Effect/P_AlphaBlend" 
{
	Properties
	{
		_TintColor ("Modulate Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Base(RGB)", 2D) = "white" {}	
		_Intensity("Intensity", Float) = 2.0

		[Enum(UnityEngine.Rendering.BlendMode)] _AlphaChannelSrcBlend("Alpha Channel Src Blend Mode", Float) = 3
		[Enum(UnityEngine.Rendering.BlendMode)] _AlphaChannelDestDestBlend("Alpha Channel Dest Blend Mode", Float) = 6
	}

	Category
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }		
		
		Blend SrcAlpha OneMinusSrcAlpha,[_AlphaChannelSrcBlend][_AlphaChannelDestDestBlend]
		
		Cull Off 
		Lighting Off 
		ZTest LEqual
		ZWrite Off 
		Fog { Mode Off }
		
		BindChannels
		{
			Bind "Color", color
			Bind "Vertex", vertex
			Bind "TexCoord", texcoord
		}
	
		// ---- Fragment program cards	
		SubShader
		{
			Pass
			{		
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma fragmentoption ARB_precision_hint_fastest
				//#pragma multi_compile_particles
			
				#include "UnityCG.cginc"

				sampler2D _MainTex;				
				fixed4 _TintColor;
			
				struct appdata_t
				{				
					float4 vertex : POSITION;
					fixed4 color : COLOR;
					half2 texcoord : TEXCOORD0;
				};

				struct v2f
				{
					float4 vertex : POSITION;
					fixed4 color : COLOR;
					half2 texcoord : TEXCOORD0;
				};
			
				float4 _MainTex_ST;

				v2f vert (appdata_t v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.color = v.color;
					//o.texcoord = v.texcoord;
					o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
					return o;
				}

				float _Intensity;
			
				fixed4 frag (v2f i) : COLOR
				{	
					fixed4 colorOut = tex2D(_MainTex, i.texcoord);								
					return _Intensity * i.color * _TintColor * colorOut;
				}
				ENDCG 
			}
		} 
		
		Fallback Off		
	}
}
