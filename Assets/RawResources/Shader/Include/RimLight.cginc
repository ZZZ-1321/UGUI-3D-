
#ifndef RIM_LIGHT_CG_INCLUDE
#define RIM_LIGHT_CG_INCLUDE


// 注意：传入的法线等向量都是单位化的
inline half3 ApplyRimLight0(float3 worldNrm, float3 invViewDir, 
				fixed3 inputColor, float rimMin, float rimMax, 
				float rimIntensity, fixed4 rimColor, float rimBlendFactor, 
				float3 rimSimLightDir, float rimSimLightMin, float rimSimLightMax)
{
	//float3 normal = normalize(worldNrm);
	//float3 V = normalize(_WorldSpaceCameraPos - worldPos);
	float fCos = dot(worldNrm, invViewDir);
	float rim = 1.0 - saturate( fCos );
	float fRimFactor = smoothstep(rimMin, rimMax, rim);	
	//fRimFactor = pow(fRimFactor, rimPower);
		
	half3 cRimColor = rimColor.rgb * fRimFactor * rimIntensity;

	float fK = dot(worldNrm, normalize(rimSimLightDir));
	fK = smoothstep(rimSimLightMin, rimSimLightMax, fK);
	cRimColor *= fK;

	return lerp(inputColor, cRimColor + inputColor, rimBlendFactor);
}

// 注意：传入的法线等向量都是单位化的
inline half3 ApplyRimLight1(float3 worldNrm, float3 invViewDir,
	fixed3 inputColor, float rimOutMin, float rimOutMax,
	float rimOutIntensity, fixed4 rimOutColor, 
	float rimInMin, float rimInMax, float rimInIntensity, fixed4 rimInColor,
	float rimBlendFactor, float3 rimSimLightDir, float rimSimLightMin, float rimSimLightMax, 
	float fOutInRimLine)
{	
	float fCos = dot(worldNrm, invViewDir);
	float rim = 1.0 - saturate(fCos);

	float fRimFactor;
	half3 cRimColor;
	
	if (rim >= fOutInRimLine)
	{
		rim = (rim - fOutInRimLine) / (1.0 - fOutInRimLine);
		fRimFactor = smoothstep(rimOutMin, rimOutMax, rim);
		cRimColor = rimOutColor.rgb * fRimFactor * rimOutIntensity;
	}
	else
	{
		rim = (fOutInRimLine - rim) / fOutInRimLine;
		fRimFactor = smoothstep(rimInMin, rimInMax, rim);
		cRimColor = rimInColor.rgb * fRimFactor * rimInIntensity;
	}

	float fK = dot(worldNrm, normalize(rimSimLightDir));
	fK = smoothstep(rimSimLightMin, rimSimLightMax, fK);
	cRimColor *= fK;

	return lerp(inputColor, cRimColor + inputColor, rimBlendFactor);
}

inline half3 ApplyRimLight2(float3 worldNrm, float3 invViewDir,
				fixed3 inputColor, float rimMin, float rimMax, 
				float rimPower, fixed4 rimColor, float rimBlendFactor,
				float rimSmoothPower)
{
	//float3 normal = normalize(worldNrm);
	//float3 V = normalize(_WorldSpaceCameraPos - worldPos);
	float fCos = dot(worldNrm, invViewDir);
	float rim = 1.0 - saturate( fCos );
	float fRimFactor = smoothstep(rimMin, rimMax, rim);	
	fRimFactor = pow(fRimFactor, rimPower);
	
	half3 cRimColor = inputColor * rimColor.rgb * fRimFactor * rimBlendFactor;
	half3 highC = max(inputColor, cRimColor);
	float ol = (inputColor.r + inputColor.g + inputColor.b) / 3.0;	
	ol = pow(ol, rimSmoothPower);
	return lerp(highC, inputColor, ol);	
}
#endif