
#ifndef FOG_CG_INCLUDE
#define FOG_CG_INCLUDE

float g_fogNear = 10.0;
float g_fogFar = 100.0;
float g_fogDist = 90.0;
fixed3 g_fogColor;		

inline fixed3 ApplyLinearFog(float viewDepth, fixed3 color)
{
	float fFogFactor = clamp(viewDepth, g_fogNear, g_fogFar);
	fFogFactor = (fFogFactor - g_fogNear) / g_fogDist;
	return lerp(color, g_fogColor, fFogFactor);
}

sampler2D _SimFogDisTex1;
sampler2D _SimFogDisTex2;

sampler2D _SimFogTex;
float _DepthVerticalFogBlendFactor;
float4 _SimFogRange;
float4 _SimFogExp;
fixed4 _SimFogColor;
float _SimFogDisScale;

inline fixed3 ApplySimFog(fixed3 inC, float2 vvd, half2 uv_fog_dis1, half2 uv_fog_dis2)
{
	half2 fog_uv;

	float3 disC1 = tex2D(_SimFogDisTex1, uv_fog_dis1);
	float3 disC2 = tex2D(_SimFogDisTex2, uv_fog_dis2);

	float disK = (dot(disC1, disC2) / 3.0 - 0.5) * _SimFogDisScale;

	fog_uv.y = 0.5;
	fog_uv.x = clamp(vvd.x + disK, _SimFogRange.x, _SimFogRange.y);
	fog_uv.x = (fog_uv.x - _SimFogRange.x) / (_SimFogRange.y - _SimFogRange.x);
	fixed4 fogV = tex2D(_SimFogTex, fog_uv);

	fog_uv.x = clamp(vvd.y, _SimFogRange.z, _SimFogRange.w);
	fog_uv.x = (fog_uv.x - _SimFogRange.z) / (_SimFogRange.w - _SimFogRange.z);
	fixed4 fogD = tex2D(_SimFogTex, fog_uv);

	float fFogV = pow(fogV.r, _SimFogExp.x);
	float fFogD = pow(fogD.g, _SimFogExp.y);

	float fogF = lerp(fFogD, fFogV, _DepthVerticalFogBlendFactor);
	return lerp(inC, _SimFogColor.rgb, fogF);
}

#endif