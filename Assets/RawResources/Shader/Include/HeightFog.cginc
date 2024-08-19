
#ifndef HEIGHT_FOG_CG_INCLUDE
#define HEIGHT_FOG_CG_INCLUDE

//float4 G_FogHeight;			// x, y use for smoothstep input, z for pow adjust
//float4 G_FogDistance;		// x, y for smoothstep input, z for pow
//float G_DistHeightMixFactor;
fixed4 G_FogNearColor;
fixed4 G_FogFarColor;
float G_FogAlpha;

float4 G_FogDepthHeightDensity;		// x for depth density, y for height density, z for zero ref depth, w for zero ref height; use exp2 fog mode
//float4 _FogColorBlendFactor;

float4 G_FogSpeed;
sampler2D G_FogNoiseTex0;
sampler2D G_FogNoiseTex1;
float4 G_NoiseParam;

inline half3 ApplyHeightFog(half3 inC, float3 worldPos, float2 proj_pos)
{
	//float4 proj_pos = mul(UNITY_MATRIX_VP, float4(worldPos, 1.0));
	//proj_pos.xy /= proj_pos.w;	
#ifdef _FLOWING_HEIGHT_FOG
	float2 xzr = proj_pos.xy * G_NoiseParam.x + _Time.yy * G_FogSpeed.xy;
	float noise0 = tex2D(G_FogNoiseTex0, xzr).g * G_NoiseParam.y;

	xzr = proj_pos.xy * G_NoiseParam.z + _Time.yy * G_FogSpeed.zw;
	float noise1 = tex2D(G_FogNoiseTex1, xzr).g * G_NoiseParam.w;	

	float nt = noise0 + noise1;
	worldPos.y -= nt;
#endif

	float fDist = distance(worldPos, _WorldSpaceCameraPos);
	fDist = fDist - G_FogDepthHeightDensity.z;
	fDist = max(0, fDist);
	float dk = G_FogDepthHeightDensity.x * fDist;
	float fDistFactor = exp(-dk * dk);
	fDistFactor = 1.0 - saturate(fDistFactor);	

	half3 dColor;
	half3 finalC;
	float fFogF;

	// fallback to legency fog
	if (G_FogDepthHeightDensity.w < -9999.0)
	{		
		dColor = lerp(G_FogNearColor, G_FogFarColor, fDistFactor);
		fFogF = lerp(0.0, fDistFactor, G_FogAlpha);
		finalC = lerp(inC, dColor, fFogF);
		return finalC;
	}

	float fHeight = worldPos.y - G_FogDepthHeightDensity.w;
	fHeight = max(0, fHeight);
	float hk = G_FogDepthHeightDensity.y * fHeight;
	float fHeightFactor = exp(-hk * hk);
	fHeightFactor = saturate(fHeightFactor);
	
	float fSumM = max(fDistFactor, fHeightFactor);
	float fSumS = saturate(fDistFactor + fHeightFactor);	
	float fSumF = (fSumM + fSumS) * 0.5;
		
	fFogF = lerp(0.0, fSumF, G_FogAlpha);

	dColor = lerp(G_FogNearColor, G_FogFarColor, fDistFactor);
	half3 vColor = lerp(G_FogNearColor, G_FogFarColor, fHeightFactor);	
	half3 fColor = lerp(vColor, dColor, fDistFactor);	

	finalC = lerp(inC, fColor, fFogF);	
	return finalC;
}

#endif