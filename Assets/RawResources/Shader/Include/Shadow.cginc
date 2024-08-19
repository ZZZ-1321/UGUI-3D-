
#ifndef SHADOW_CG_INCLUDE
#define SHADOW_CG_INCLUDE

sampler2D G_SHADOW_TEXTURE;
float4x4 G_PROJ_SHADOW_MATRIX;
fixed4 G_SHADOW_COLOR;

inline half3 ApplyShadow(half3 inputC, float3 uv_shadow_depth)
{
	half2 suv = (uv_shadow_depth.xy + half2(1.0, 1.0)) * 0.5;
	float4 depth_alpha = tex2D(G_SHADOW_TEXTURE, suv);
	float fShadowFactor = step(depth_alpha.r, uv_shadow_depth.z);
	return lerp(inputC.rgb, inputC.rgb * G_SHADOW_COLOR.rgb, fShadowFactor);
}

inline half3 ApplyShadowWithLightmapAtten(half3 inputC, float3 uv_shadow_depth, half fLightmapAtten)
{
	half2 suv = (uv_shadow_depth.xy + half2(1.0, 1.0)) * 0.5;
	float4 depth_alpha = tex2D(G_SHADOW_TEXTURE, suv);
	float fShadowFactor = step(depth_alpha.r, uv_shadow_depth.z);
	//fShadowFactor = lerp(1.0, fShadowFactor, fLightmapAtten);
	half3 shadowC = lerp(inputC.rgb, inputC.rgb * G_SHADOW_COLOR.rgb, fLightmapAtten);
	return lerp(inputC.rgb, shadowC, fShadowFactor);
}
#endif