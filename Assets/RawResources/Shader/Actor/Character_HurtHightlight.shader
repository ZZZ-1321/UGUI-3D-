// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "IXS_Actor/Character_HurtHightlight" 
{
	Properties
	{
		_MainTex ("Base Texture", 2D) = "white" {}

		_MainTexStrength ("MainTex Strength", Range(0, 1)) = 0.8
		_OutlineColor("Outline Color", Color) = (0.5, 0.5, 0.5, 1.0)
		//_FresnelStrength ("Fresnel Strength", Range(0, 5)) = 0.5
		_FresnelColorStrength ("Fresnel Color Strength", Range(0, 5)) = 1

		_ColorR("ColorR", Color) = (1, 0, 0, 1.0)
		_ColorG("ColorG", Color) = (0, 1, 0, 1.0)
		_ColorB("ColorB", Color) = (0, 0, 1, 1.0)

	}

	CGINCLUDE
	ENDCG

	SubShader
	{
		Tags{ "Queue" = "AlphaTest+2" "RenderType" = "TransparentCutout" "IgnoreProjector" = "True" }
        
        Pass 
        {
			CGPROGRAM

			#pragma vertex VertexHurtHightlight
			#pragma fragment FragHurtHightlight

			#include "UnityCG.cginc"	
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			#include "../Include/Character_Base.cginc"

			ENDCG
        }
	}

	Fallback "IXS_Other/Texture"
}