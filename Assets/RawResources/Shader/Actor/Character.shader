// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "IXS_Actor/Character" 
{
	Properties
	{
		_MainTex ("Base Texture", 2D) = "gray" {}
		_MatCap ("MatCap (RGB)", 2D) = "gray" {}

		_ColorR("ColorR", Color) = (1, 0, 0, 1.0)
		_ColorG("ColorG", Color) = (0, 1, 0, 1.0)
		_ColorB("ColorB", Color) = (0, 0, 1, 1.0)

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
			CGPROGRAM

			#pragma vertex VertexMain
			#pragma fragment FragMain

			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			#include "../Include/Character_Base.cginc"

			ENDCG
        }
	}

	Fallback "IXS_Other/Texture"
}