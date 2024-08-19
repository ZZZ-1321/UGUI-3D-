// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "IXS_Actor/Character_Ghost" 
{
	Properties
	{
		_MainTex ("Base Texture", 2D) = "gray" {}
		_NormalMap ("Normal Map", 2D) = "bump" {}
		_Color("Color", Color) = (0.5, 0.5, 0.5, 1.0)

		_ColorR("ColorR", Color) = (1, 0, 0, 1.0)
		_ColorG("ColorG", Color) = (0, 1, 0, 1.0)
		_ColorB("ColorB", Color) = (0, 0, 1, 1.0)

		_MainTexStrength ("MainTex Strength", Range(0, 1)) = 0.5
		_FresnelStrength ("Fresnel Strength", Range(0.01, 5)) = 0.5
		_FresnelColorStrength ("Fresnel Color Strength", Range(0, 5)) = 1
		_Alpha ("Alpha", Range(0, 5)) = 1

		[ToggleOff] _UseNormalMap("Use Normal Map", Float) = 0.0

		_StencilRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilCompare("Stencil Compare", Float) = 0
	}

	CGINCLUDE
	ENDCG

	SubShader
	{
		Tags { "Queue" = "Transparent+10" "RenderType" = "Transparent" }

		Stencil
		{
			Ref[_StencilRef]
			Comp[_StencilCompare]
		}
        
        Pass 
		{
			//Tags { "LightMode" = "ForwardBase"}	//use for GhostShadowEffect.cs 
			ZWrite On
			ColorMask 0
		}

        Pass 
        {
			Blend One OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			ZWrite Off

			CGPROGRAM

			#pragma vertex VertexGhost
			#pragma fragment FragGhost

			#pragma shader_feature _ _USENORMALMAP_OFF

			#include "UnityCG.cginc"	
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			#include "../Include/Character_Base.cginc"

			ENDCG
        }
	}

	Fallback "IXS_Other/Texture"
}