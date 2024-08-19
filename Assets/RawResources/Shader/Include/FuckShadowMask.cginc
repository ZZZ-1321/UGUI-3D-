
#ifndef FUCK__SHADOW_MASK_CG_INCLUDE
#define FUCK__SHADOW_MASK_CG_INCLUDE

#if !defined(SHADOWS_SHADOWMASK)
	#define SHADOWS_SHADOWMASK
#endif

#if defined (SHADOWS_SHADOWMASK)	
		// 操，u3d 这里会报 unity_ShadowMask 未定义
		
		//UNITY_DECLARE_TEX2D(unity_ShadowMask);	
		//SamplerState sampler##tex		
#endif

fixed4 G_STATIC_SHADOW_COLOR;

fixed UnitySampleBakedOcclusionNoLightProbe(float2 lightmapUV)
{
    #if defined (SHADOWS_SHADOWMASK)
        #if defined(LIGHTMAP_ON)
            //fixed4 rawOcclusionMask = UNITY_SAMPLE_TEX2D_SAMPLER(unity_ShadowMask, unity_Lightmap, lightmapUV.xy);
			fixed4 rawOcclusionMask = UNITY_SAMPLE_TEX2D(unity_ShadowMask, lightmapUV.xy);
        #else
            //fixed4 rawOcclusionMask = fixed4(1.0, 1.0, 1.0, 1.0);
            /*#if UNITY_LIGHT_PROBE_PROXY_VOLUME
                if (unity_ProbeVolumeParams.x == 1.0)
                    rawOcclusionMask = LPPV_SampleProbeOcclusion(worldPos);
                else
                    rawOcclusionMask = UNITY_SAMPLE_TEX2D(unity_ShadowMask, lightmapUV.xy);
            #else*/
			fixed4 rawOcclusionMask = UNITY_SAMPLE_TEX2D(unity_ShadowMask, lightmapUV.xy);
            //#endif
        #endif
        return saturate(dot(rawOcclusionMask, unity_OcclusionMaskSelector));

    #else
        //Handle LPPV baked occlusion for subtractive mode
        /*#if UNITY_LIGHT_PROBE_PROXY_VOLUME && !defined(LIGHTMAP_ON) && !UNITY_STANDARD_SIMPLE
            fixed4 rawOcclusionMask = fixed4(1.0, 1.0, 1.0, 1.0);
            if (unity_ProbeVolumeParams.x == 1.0)
                rawOcclusionMask = LPPV_SampleProbeOcclusion(worldPos);
            return saturate(dot(rawOcclusionMask, unity_OcclusionMaskSelector));
        #endif*/

        return 1.0;
    #endif
}

half4 ApplyBakedOcclusionToLight(half2 uvlm, half3 lightColor)
{
	half4 ret;

	ret.a = UnitySampleBakedOcclusionNoLightProbe(uvlm);
	ret.rgb = lerp(G_STATIC_SHADOW_COLOR, lightColor, ret.a);
	return ret;
}

#endif