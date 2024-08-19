
#ifndef CARTOON_TGR_INCLUDE
#define CARTOON_TGR_INCLUDE

inline fixed3 ApplyCartoon(float3 worldNrm, float3 worldPos, fixed3 inputColor, 
				float rimMin, float rimMax, float rimPower, float3 invLightDir, 
				sampler2D cartoonRampTex, float rampTexOffset, fixed4 shadowColor,
				fixed4 highlightColor, fixed4 diffuseColor, fixed3 lightColor, 
				float lightIntensity, float rimBlendFactor, float rimSmoothPower, fixed4 rimColor)
{
	float3 normal = normalize(worldNrm);
	float3 V = normalize(_WorldSpaceCameraPos - worldPos);
	float fCos = dot(normal, V);								
	float rim = 1.0 - saturate( fCos );
	float fRimFactor = smoothstep(rimMin, rimMax, rim);		
	fRimFactor = pow(fRimFactor, rimPower);	
	half3 rimEmission = rimColor.rgb * fRimFactor * rimColor.a;

	float d = dot(normal, invLightDir) * 0.5 + 0.5;
	half3 ramp = tex2D(cartoonRampTex, float2(d + rampTexOffset, d)).xyz;
	ramp = lerp(shadowColor, highlightColor, ramp);
	half3 lightDiffuse = diffuseColor.rgb * ramp * lightColor * lightIntensity;

	half3 lightC = saturate((lightDiffuse + UNITY_LIGHTMODEL_AMBIENT.rgb) * inputColor);
	
	half3 rimColorL = saturate(lightC * rimEmission * rimBlendFactor);	
	half3 highC = max(lightC, rimColorL);	

	half ol = (lightC.r + lightC.g + lightC.b) / 3.0;	
	ol = pow(ol, rimSmoothPower);
	return lerp(highC, lightC, ol);	
}
#endif