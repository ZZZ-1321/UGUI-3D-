// Upgrade NOTE: replaced 'defined _Z_OFFSET' with 'defined (_Z_OFFSET)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'


Shader "IXS_Effect/P_Additive"
{
	Properties
	{
		_TintColor ("Modulate Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Base(RGB)", 2D) = "white" {}	

		_Intensity("Intensity", Float) = 2.0

		_ZOffset("Z Offset", Float) = 0		

		[Toggle(_Z_OFFSET)] _EnableZOffset("Enable Z Offset", Float) = 0

		//[Enum(UnityEngine.Rendering.BlendMode)] _SourceBlend("Source Blend Mode", Float) = 5
		//[Enum(UnityEngine.Rendering.BlendMode)] _DestBlend("Dest Blend Mode", Float) = 1		
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest", Float) = 4
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull Mode", Float) = 0

		_StencilRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilCompare("Stencil Compare", Float) = 0
	}

	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }

		ZTest[_ZTest]
		Cull[_Cull]

		Stencil
		{
			Ref[_StencilRef]
			Comp[_StencilCompare]
		}

		Blend SrcAlpha One, Zero One		
		Lighting Off 		
		ZWrite Off 
		Fog { Mode Off }	
		
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#pragma multi_compile __ _Z_OFFSET

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
			float _ZOffset;

			v2f vert (appdata_t v)
			{
				v2f o;

				//float4 viewPos = mul(UNITY_MATRIX_MV, v.vertex);
#if defined (_Z_OFFSET)
				float3 viewPos = UnityObjectToViewPos(v.vertex);
				viewPos.z -= _ZOffset;
					
				o.vertex = mul(UNITY_MATRIX_P, float4(viewPos, 1.0));
#else

				o.vertex = UnityObjectToClipPos(v.vertex);
#endif
				o.color = v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
				return o;
			}

			half _Intensity;
			
			half4 frag (v2f i) : COLOR
			{
				fixed4 colorOut = tex2D(_MainTex, i.texcoord);								
				return _Intensity * i.color * _TintColor * colorOut;
			}
			ENDCG 
		}
	}	
		
	Fallback Off
}