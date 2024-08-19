// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "IXS_Actor/Character_CutOff" 
{
	Properties
	{
		_MainTex ("Base Texture", 2D) = "gray" {}
		_MatCap ("MatCap (RGB)", 2D) = "gray" {}
		_Cutoff ("Cut Off", Range(0, 1)) = 0

		[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull Mode", Float) = 2

		_StencilRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilCompare("Stencil Compare", Float) = 0
	}

	CGINCLUDE
	ENDCG

	SubShader
	{
		Tags { "Queue"="AlphaTest+2" "RenderType"="TransparentCutout" "IgnoreProjector"="True" }

		Blend SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
		ZWrite On

		Cull[_Cull]

		Stencil
		{
			Ref[_StencilRef]
			Comp[_StencilCompare]
		}
        
        Pass 
        {
			CGPROGRAM

			#pragma vertex VertexMain
			#pragma fragment FragCutOff

			#include "UnityCG.cginc"	
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			#include "../Include/Character_Base.cginc"

			ENDCG
        }
	}

	FallBack "IXS_Other/Texture_Cutoff"
}