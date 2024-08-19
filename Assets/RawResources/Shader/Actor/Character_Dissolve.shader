// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "IXS_Actor/Character_Dissolve" 
{
	Properties
	{
		_MainTex ("Base Texture", 2D) = "white" {}

		_DissolveTex ("Dissolve Texture", 2D) = "white" {}
		_DissolveAmount ("Dissolve Amount", Range (0, 1)) = 0.5
		_DissolveColorAmount("Dissolve Color Amount", Range(0, 1)) = 0.1
		_DissolveColor ("Dissolve Color", Color) = (1,1,1,1)
		_DissolveColorStrength("Dissolve Color Strength", Range(0, 5)) = 2
	}

	CGINCLUDE
	ENDCG

	SubShader
	{
		Tags { "Queue" = "AlphaTest+2" "RenderType" = "TransparentCutout" "IgnoreProjector" = "True" }
        
        Pass 
        {
			CGPROGRAM

			#pragma vertex VertexDissolve
			#pragma fragment FragDissolve

			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			#include "../Include/Character_Base.cginc"

			ENDCG
        }
	}

	Fallback "IXS_Other/Texture"
}