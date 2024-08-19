
#ifndef HSVC_CG_INCLUDE
#define HSVC_CG_INCLUDE

float4x4 L_ColorMatrixMaskR;
float4x4 L_ColorMatrixMaskG;
float4x4 L_ColorMatrixMaskB;

inline fixed4 ApplyHSVC(fixed4 i, fixed4 mask)
{
	float4 k = float4(i.rgb, 1.0);
	fixed4 hsvc = mul(L_ColorMatrixMaskR, k);
	fixed3 outC = lerp(i.rgb, hsvc.rgb, mask.r);
	hsvc = mul(L_ColorMatrixMaskG, k);
	outC = lerp(outC, hsvc.rgb, mask.g);
	hsvc = mul(L_ColorMatrixMaskB, k);
	outC = lerp(outC, hsvc.rgb, mask.b);
	return fixed4(outC, i.a);	
}
#endif