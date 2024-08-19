

#ifndef MAT_CAP_CG_INCLUDE
#define MAT_CAP_CG_INCLUDE


inline fixed3 ApplyMatCap(fixed3 inputC, fixed3 mc, float fMatCapIntensity, float fMatCapDarkFactor, float fMatCapFactor)
{	
	fixed3 lc = inputC + (mc * 2.0 * fMatCapIntensity) - 1.0;
	fixed3 minOrg = inputC * fMatCapDarkFactor;
	//fixed3 lc = saturate(inputC * mc.rgb * _MatCapIntensity);	
	lc = max(lc, minOrg);
	lc = lerp(inputC, lc, fMatCapFactor);
	return lc;
}

inline fixed3 ApplyMatCapWithSpec(fixed3 inputC, fixed3 mc, fixed3 specC, fixed4 miscTex, float fMatCapIntensity, float fMatCapDarkFactor, float fMatCapFactor,
	float fSpecIntensity, fixed4 specColor, float fSpecBlendFactor)
{
	fixed3 lc = inputC + (mc * 2.0 * fMatCapIntensity) - 1.0;
	fixed3 minOrg = inputC * fMatCapDarkFactor;	
	lc = max(lc, minOrg);

	lc = lerp(inputC, lc, fMatCapFactor);

	fixed3 specFinal = saturate(specC * specColor.rgb * miscTex.r * fSpecIntensity);
	fixed3 specK = lc + specFinal;

	lc = lerp(lc, specK, fSpecBlendFactor);
	return lc;
}
#endif