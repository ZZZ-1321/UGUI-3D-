// Upgrade NOTE: replaced 'defined _LIGHTING_HIGH' with 'defined (_LIGHTING_HIGH)'
// Upgrade NOTE: replaced 'defined _LIGHTING_NORMAL' with 'defined (_LIGHTING_NORMAL)'
// Upgrade NOTE: replaced 'defined _T4M_2TEX' with 'defined (_T4M_2TEX)'
// Upgrade NOTE: replaced 'defined _T4M_2TEX_2NRM' with 'defined (_T4M_2TEX_2NRM)'
// Upgrade NOTE: replaced 'defined _T4M_3TEX' with 'defined (_T4M_3TEX)'
// Upgrade NOTE: replaced 'defined _T4M_3TEX_2NRM' with 'defined (_T4M_3TEX_2NRM)'
// Upgrade NOTE: replaced 'defined _T4M_4TEX' with 'defined (_T4M_4TEX)'
// Upgrade NOTE: replaced 'defined _T4M_4TEX_2NRM' with 'defined (_T4M_4TEX_2NRM)'

// Upgrade NOTE: replaced 'defined _EXTRALIGHT_ONE' with 'defined (_EXTRALIGHT_ONE)'
// Upgrade NOTE: replaced 'defined _EXTRALIGHT_TWO' with 'defined (_EXTRALIGHT_TWO)'


#ifndef LIGHTING_GL_CG_INCLUDE
#define LIGHTING_GL_CG_INCLUDE

//#define POINT

//#include "AutoLight.cginc"

half NONE_LIGHTING_BREGHTNESS_SCALE = 0.55;


// 注意：传入的法线等向量都是单位化的
inline fixed3 ApplyLightingLambert(float3 normal, float3 invLightDir, 
				fixed3 lightColor, fixed4 diffuseColor, float lightIntensity)
{
	//float3 worldNormal = normalize(normal);
	float fNDot = saturate(dot(invLightDir, normal));
	return lightColor * diffuseColor.rgb * fNDot * lightIntensity;
}

inline fixed3 ApplyLightingSimpleGL(float3 normal, float3 invLightDir, 
				fixed3 lightColor, fixed4 diffuseColor, 
				float lightIntensity, float glSlope)
{
	//float3 worldNormal = normalize(normal);
	float fNL = dot(invLightDir, normal);
	//fNL = clamp(fNL, glSlope, 1.0);
	//float fNDot = (fNL - glSlope) / (1.0 - glSlope);	
	float fNDot = (fNL + 1.0) * (1.0 - glSlope) * 0.5 + glSlope;
	return lightColor * diffuseColor.rgb * fNDot * lightIntensity;
}	

inline fixed3 ApplyLightingSimpleGLSimple(float3 normal, float3 invLightDir,
	fixed4 diffuseColor, float fDiffuseIntensity, float glSlope)
{
	//float3 worldNormal = normalize(normal);
	float fNL = dot(invLightDir, normal);
	//fNL = clamp(fNL, glSlope, 1.0);
	//float fNDot = (fNL - glSlope) / (1.0 - glSlope);	
	float fNDot = (fNL + 1.0) * (1.0 - glSlope) * 0.5 + glSlope;
	return diffuseColor.rgb * fNDot * fDiffuseIntensity;
}

inline fixed3 ApplyLightingGL(float3 normal, float3 invViewDir, 
				float3 invLightDir, 
				fixed3 lightColor, fixed4 diffuseColor, 
				float lightIntensity, float glSlope)
{
	//float3 worldNormal = normalize(normal);
	//float3 V = normalize(invViewDir);		
	float3 invLightDirSlope = invLightDir * glSlope;		
	float3 N1 = normalize(normal + invLightDirSlope);
	float3 N2 = normalize(normal - invLightDirSlope);
	float diff1 = max(0, dot(N1, invLightDir));
	float diff2 = max(0, dot(N2, invLightDir));
	float k1 = max(0, dot(invViewDir, N1));
	float k2 = max(0, dot(invViewDir, N2));
	float diff = max( k1 * diff1, k2 * diff2 );
							
	return lightColor * diffuseColor.rgb * diff * lightIntensity;
}

inline fixed3 ApplyLightingPhong(float3 normal, float3 invLightDir, float3 invViewDir,
	fixed3 lightColor, fixed4 specColor, float shininess, float specIntensity, float lightIntensity)
{
	float3 R = normalize(reflect(-invLightDir, normal));
	float specularLight = pow(max(dot(invViewDir, R), 0), shininess);
	return lightColor * specColor.rgb * specularLight * specIntensity * lightIntensity;
}

inline fixed3 ApplyLightingPhongSimple(float3 normal, float3 invLightDir, float3 invViewDir,
	fixed4 specColor, float shininess, float specIntensity)
{
	float3 R = normalize(reflect(-invLightDir, normal));
		float specularLight = pow(max(dot(invViewDir, R), 0), shininess);
	return specColor.rgb * specularLight * specIntensity;
}

inline fixed3 ApplyLightingBlinn(float3 normal, float3 invLightDir, float3 invViewDir, 
	fixed3 lightColor, fixed4 specColor, float shininess, float specIntensity, float lightIntensity)
{
	float3 H = normalize(invLightDir + invViewDir);
	float specularLight = pow(max(dot(H, normal), 0), shininess);
	return lightColor * specColor.rgb * specularLight * specIntensity * lightIntensity;
}

inline fixed3 ApplyLightingBlinnSimple(float3 normal, float3 invLightDir, float3 invViewDir,
	fixed4 specColor, float shininess, float specIntensity)
{
	float3 H = normalize(invLightDir + invViewDir);
		float specularLight = pow(max(dot(H, normal), 0), shininess);
	return specColor.rgb * specularLight * specIntensity;
}

float4 G_ExtraLightPos0;
float4 G_ExtraLightPos1;
half3 G_ExtraLightColor0;
half3 G_ExtraLightColor1;

// must point light
// only compute diffuse now
inline half3 ComputeExtraLight(float3 normal, float3 worldPos, float3 invViewDir)
{
	if (!any(G_ExtraLightColor0))
	{
		return 0;
	}

#if defined (_LIGHTING_NORMAL)	
	float3 vlDist = G_ExtraLightPos0.xyz - worldPos;
	float3 invLightDir = normalize(vlDist);
	float k = saturate(dot(normal, invLightDir));
	float lengthSq = dot(vlDist, vlDist);
	//float len = sqrt(lengthSq);
	//float uv = saturate(len / G_ExtraLightPos0.w);
	float atten = 1.0 / (1.0 + lengthSq * G_ExtraLightPos0.w);	
	//float atten = tex2D(_LightTexture0, float2(uv, uv)).UNITY_ATTEN_CHANNEL;
	half3 ec = G_ExtraLightColor0 * k * atten;	
	return ec;
#elif defined (_LIGHTING_HIGH)
	float3 vlDist = G_ExtraLightPos0.xyz - worldPos;
	float3 invLightDir = normalize(vlDist);
	float k = saturate(dot(normal, invLightDir));
	float lengthSq = dot(vlDist, vlDist);
	float atten = 1.0 / (1.0 + lengthSq * G_ExtraLightPos0.w);
	half3 ec0 = G_ExtraLightColor0.rgb * k * atten;

	vlDist = G_ExtraLightPos1.xyz - worldPos;
	invLightDir = normalize(vlDist);
	k = saturate(dot(normal, invLightDir));
	lengthSq = dot(vlDist, vlDist);
	atten = 1.0 / (1.0 + lengthSq * G_ExtraLightPos1.w);
	half3 ec1 = G_ExtraLightColor1.rgb * k * atten;

	return ec0 + ec1;
#else
	return 0;
#endif
}

// normal blend function
/*float3 blend_linear(float3 n1, float3 n2)
{
float3 r = (n1 + n2) * 2 - 2;
return r;
}

float3 blend_overlay(float3 n1, float3 n2)
{
n1 = n1 * 4 - 2;
float4 a = n1 >= 0 ? -1 : 1;
float4 b = n1 >= 0 ? 1 : 0;
n1 = 2 * a + n1;
n2 = n2 * a + b;
float3 r = n1*n2 - a;
return r;
}

float3 blend_pd(float3 n1, float3 n2)
{
n1 = n1 * 2 - 1;
n2 = n2.xyzz*float4(2, 2, 2, 0) + float4(-1, -1, -1, 0);
float3 r = n1.xyz*n2.z + n2.xyw*n1.z;
return r;
}

float3 blend_whiteout(float3 n1, float3 n2)
{
n1 = n1 * 2 - 1;
n2 = n2 * 2 - 1;
float3 r = float3(n1.xy + n2.xy, n1.z*n2.z);
return r;
}*/

float3 blend_udn(float3 n1, float3 n2)
{
	float3 c = float3(2, 1, 0);
	float3 r;
	r = n2*c.yyz + n1.xyz;
	r = r*c.xxx - c.xxy;
	return r;
}

/*float3 blend_rnm(float3 n1, float3 n2)
{
float3 t = n1.xyz*float3(2, 2, 2) + float3(-1, -1, 0);
float3 u = n2.xyz*float3(-2, -2, 2) + float3(1, 1, -1);
float3 r = t*dot(t, u) - u*t.z;
return r;
}

float3 blend_unity(float3 n1, float3 n2)
{
n1 = n1.xyzz*float4(2, 2, 2, -2) + float4(-1, -1, -1, 1);
n2 = n2 * 2 - 1;
float3 r;
r.x = dot(n1.zxx, n2.xyz);
r.y = dot(n1.yzy, n2.xyz);
r.z = dot(n1.xyz, -n2.xyz);
return r;
}*/

//sampler2D _BumpMap;
//float _BumpMapScale;
//sampler2D _BumpMap2;
//float _BumpMapScale2;

float3 BlendTwoNormalForT4M2Layer(half2 uv, half2 uv2, float r_factor, float g_factor, sampler2D bumpMap, float bumpScale, sampler2D bumpMap2, float bumpScale2)
{
	float3 nrm1 = UnpackScaleNormal(tex2D(bumpMap, uv), bumpScale) * r_factor;
	float3 nrm2 = UnpackScaleNormal(tex2D(bumpMap2, uv2), bumpScale2) * g_factor;
	//float3 nrm = normalize(blend_udn(nrm1, nrm2));
	float3 nrm = nrm1 + nrm2;
	return nrm;
}

float3 BlendTwoNormalForT4M3Layer(half2 uv, half2 uv2, float r_factor, float g_factor, float b_factor, sampler2D bumpMap, float bumpScale, sampler2D bumpMap2, float bumpScale2)
{
	float3 nrm1 = UnpackScaleNormal(tex2D(bumpMap, uv), bumpScale) * r_factor;
	float3 nrm2 = UnpackScaleNormal(tex2D(bumpMap2, uv2), bumpScale2) * g_factor;
	float3 nrm3 = float3(0.0, 0.0, 1.0) * b_factor;
	//float3 nrm = normalize(blend_udn(nrm1, nrm2));
	float3 nrm = nrm1 + nrm2 + nrm3;
	return nrm;
}

float3 BlendTwoNormalForT4M4Layer(half2 uv, half2 uv2, float r_factor, float g_factor, float b_factor, float a_factor, sampler2D bumpMap, float bumpScale, sampler2D bumpMap2, float bumpScale2)
{
	float3 nrm1 = UnpackScaleNormal(tex2D(bumpMap, uv), bumpScale) * r_factor;
	float3 nrm2 = UnpackScaleNormal(tex2D(bumpMap2, uv2), bumpScale2) * g_factor;
	//float3 nrm1 = UnpackNormal(tex2D(bumpMap, uv)) * r_factor;
	//float3 nrm2 = UnpackNormal(tex2D(bumpMap2, uv2)) * g_factor;
	float3 nrm3 = float3(0.0, 0.0, 1.0) * b_factor;
	float3 nrm4 = float3(0.0, 0.0, 1.0) * a_factor;	
	float3 nrm = nrm1 + nrm2 + nrm3 + nrm4;
	return nrm;
}
#endif