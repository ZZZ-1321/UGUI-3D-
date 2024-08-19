// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "IXS_Actor/Character_Lighting" 
{
	Properties
	{
		_MainTex ("Base Texture", 2D) = "gray" {}
		_NormalMap ("Normal Map", 2D) = "bump" {}
		_Metallic("Metallic", 2D) = "gray" {}

		_ColorR("ColorR", Color) = (1, 0, 0, 1.0)
		_ColorG("ColorG", Color) = (0, 1, 0, 1.0)
		_ColorB("ColorB", Color) = (0, 0, 1, 1.0)

		_SpecularFactor("Specular Factor", Range(0, 20)) = 0.1
		_Smoothness("Smoothness", Range(0.001, 1)) = 0.1
		_EmissionFactor("Emission Factor", Range(0,10)) = 0.5

		_LightColorAdd("Light Color Add", Range(0, 1)) = 0.75

		[ToggleOff] _UseNormalMap("Use Normal Map", Float) = 1.0

		_StencilRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilCompare("Stencil Compare", Float) = 0
	}

	CGINCLUDE
	ENDCG

	SubShader
	{
		Tags{ "Queue" = "AlphaTest+2" "RenderType" = "TransparentCutout" "IgnoreProjector" = "True" }

		Blend One Zero, Zero Zero
		ZTest LEqual
		Cull Back
		ZWrite On

		Stencil
		{
			Ref[_StencilRef]
			Comp[_StencilCompare]
		}
        
        Pass 
        {
			Name "ForwardBase"
			Tags{ "LightMode" = "ForwardBase" }
	
			CGPROGRAM

			#pragma vertex VertexLightingMain
			#pragma fragment FragLightingMain

			#pragma target 3.0

			#pragma shader_feature _ _USENORMALMAP_OFF

			//#pragma multi_compile _ SGAME_QUALITY_MEDIUM

			#include "UnityCG.cginc"	
			#include "UnityStandardUtils.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			#include "../Include/Character_Base.cginc"

			ENDCG
        }
	}

	Fallback "IXS_Other/Texture"
}