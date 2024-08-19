#ifndef LIGHTING_BASE
#define LIGHTING_BASE

    uniform half _SG_AmbientStrength;
    uniform half4 _SG_AmbientColor;

    uniform half4 _SG_ShadowColor;
    uniform half _SG_DarkStrength;

    uniform half4 _SG_FogColor;

    uniform half _SG_FogDensity;

	uniform half4 _SG_FogRangeVector;
	uniform half4 _SG_FogHeightVector;

	uniform half _SG_WetFactor;
    uniform half4 _SG_WetColor;
    uniform half4 _SG_WetSpecularColor;
	uniform half _SG_WetSpecularStrength;
	uniform half _SG_WetSmoothness;

	uniform sampler2D _SG_WetRippleTex;
	uniform half _SG_WetRippleStrength;
	uniform half _SG_WetRippleSpeed;
	uniform half _SG_WetRippleTiling;
	uniform half _SG_WetRippleBumpScale;

    uniform half4 _SG_ThunderColor;
	uniform half _SG_ThunderStrength;
    uniform half4 _SG_ThunderDirection;

    uniform half4 _SG_PointLightColor;
	uniform half _SG_PointLightStrength;
	uniform half _SG_PointLightRange;
    uniform half4 _SG_PointLightPosition;
    uniform half _SG_PointLightEmissionDecrease;


	inline half3 ApplyWYCLXToneMapping(half3 color)
	{
		return (color) / (color * 0.9661836 + 0.180676);
	}

	inline half3 ApplyACEToneMapping(half3 x)
	{
		half tA = 2.51f;
		half tB = 0.03f;
		half tC = 2.43f;
		half tD = 0.59f;
		half tE = 0.14f;

		return saturate((x * (tA * x + tB)) / (x * (tC * x + tD) + tE));
	}

	inline half2 ComputeRipple(float2 UV, half currentTime, half weight)
	{
		half4 ripple = tex2D(_SG_WetRippleTex, UV);
		ripple.yz = ripple.yz * 2 - 1; 

		half dropFrac = frac(ripple.w + currentTime); // Apply time shift
		half timeFrac = dropFrac - 1.0f + ripple.x;
		half dropFactor = saturate(0.2f + weight * 0.8f - dropFrac);
		half finalFactor = dropFactor * ripple.x * sin(clamp(timeFrac * 9.0f, 0.0f, 3.0f) * 3.141592653589793);
		return ripple.yz * finalFactor;
	}

	//  Add Water Ripples to Waterflow
	inline half3 AddWetRipples(float3 worldPos, half3 worldNormal)
	{
		half weight = saturate(_SG_WetRippleStrength * 4);
		half animSpeed = _Time.y * _SG_WetRippleSpeed;
		half2 ripple = ComputeRipple(float2(worldPos.xz * _SG_WetRippleTiling), animSpeed, weight);
		half3 rippleNormal = half3( weight * ripple.xy, 1) * _SG_WetRippleBumpScale;
		return lerp( half3(0,0,1), rippleNormal, _SG_WetFactor * (worldNormal.y > 0.7));
	} 

	/*inline half3 GetPointLightDiffuse(half3 mainColor, float3 worldPos, half3 worldNormal)
	{
		half3 worldPointLightDir = _SG_PointLightPosition - worldPos; 
		half squaredDistance = dot(worldPointLightDir, worldPointLightDir);
		half squaredPointLightRange = _SG_PointLightRange * _SG_PointLightRange;
		half pointLightAtten = 1 / (1 + 25 * squaredDistance / squaredPointLightRange);
		half pointLightNDotL = saturate(dot(worldNormal, normalize(worldPointLightDir)));
		half3 pointLightDiffuse = mainColor * _SG_PointLightColor * pointLightNDotL * _SG_PointLightStrength * pointLightAtten; 

		return pointLightDiffuse;
	}*/

	inline half3 BlinnPhoneLighting(half3 mainColor, float3 worldPos, half3 worldNormal, half3 worldViewDir, half3 specularColor, half smoothness, half lightAtten)
	{
		#if defined(SGAME_QUALITY_PERFECT) || defined(SGAME_QUALITY_HIGH)
			#if defined(SGAME_WET)
				mainColor = lerp(mainColor, mainColor * _SG_WetColor, _SG_WetFactor);
				#if defined(SGAME_QUALITY_PERFECT) || defined(SGAME_QUALITY_HIGH)
					specularColor = lerp(specularColor, specularColor * _SG_WetSpecularColor * _SG_WetSpecularStrength, _SG_WetFactor);
					smoothness = lerp(lerp(smoothness, _SG_WetSmoothness, _SG_WetFactor), smoothness, smoothness > _SG_WetSmoothness);
				#endif
			#endif
		#endif

		#if defined(UNITY_PASS_FORWARDBASE)
			half3 lightColor = lerp(_SG_ShadowColor, _LightColor0.rgb, lightAtten);
		#else
			half3 lightColor = lerp(half3(0,0,0), _LightColor0.rgb, lightAtten);
		#endif

		//Diffuse
		half3 worldLightDir = normalize(UnityWorldSpaceLightDir(worldPos)); 
		half NDotL = saturate(dot(worldNormal, worldLightDir));
		half3 diffuse = mainColor * lightColor * NDotL; 

		#if defined(SGAME_QUALITY_PERFECT) || defined(SGAME_QUALITY_HIGH)
			#if defined(SGAME_WET)
				half thunderNDotL = saturate(dot(worldNormal, _SG_ThunderDirection));
				half3 thunderDiffuse = mainColor * lerp(half3(0, 0, 0), _SG_ThunderColor, max(lightAtten,0.1)) * thunderNDotL * _SG_ThunderStrength; 
				diffuse += thunderDiffuse;
			#endif
		#endif

		#if defined(SGAME_QUALITY_PERFECT) || defined(SGAME_QUALITY_HIGH)
			//Specular
			worldViewDir = normalize(worldViewDir);
			half3 halfDir = normalize(worldLightDir + worldViewDir);
			half NDotH = saturate(dot(worldNormal, halfDir));
			half specularPow = pow(NDotH, smoothness * 128.0);
			half3 specular = lightColor * specularColor.rgb * specularPow;

			//Total
			half3 finalColor = diffuse + specular;
		#else
			half3 finalColor = diffuse;
		#endif

		return finalColor;
	}

	inline half3 LambertLighting(half3 mainColor, float3 worldPos, half3 worldNormal, half lightAtten)
	{
		#if defined(SGAME_QUALITY_PERFECT) || defined(SGAME_QUALITY_HIGH)
			#if defined(SGAME_WET)
				mainColor = lerp(mainColor, mainColor * _SG_WetColor, _SG_WetFactor);
			#endif
		#endif

		#if defined(UNITY_PASS_FORWARDBASE)
			half3 lightColor = lerp(_SG_ShadowColor, _LightColor0.rgb, lightAtten);
		#else
			half3 lightColor = lerp(half3(0,0,0), _LightColor0.rgb, lightAtten);
		#endif

		//Diffuse
		half3 worldLightDir = normalize(UnityWorldSpaceLightDir(worldPos)); 
		half NDotL = saturate(dot(worldNormal, worldLightDir));
		half3 diffuse = mainColor * lightColor * NDotL * lightAtten; 

		#if defined(SGAME_QUALITY_PERFECT) || defined(SGAME_QUALITY_HIGH)
			#if defined(SGAME_WET)
				half thunderNDotL = saturate(dot(worldNormal, _SG_ThunderDirection));
				half3 thunderDiffuse = mainColor * lerp(half3(0, 0, 0), _SG_ThunderColor, lightAtten) * NDotL * _SG_ThunderStrength; 
				diffuse += thunderDiffuse;
			#endif
		#endif

		return diffuse;
	}

	inline half3 CharacterLighting(half3 mainColor, half3 lightColor, float3 worldPos, half3 worldNormal, half3 worldViewDir, half3 specularColor, half smoothness)
	{
		#if UNITY_COLORSPACE_GAMMA
		{
			mainColor = GammaToLinearSpace(mainColor);
			specularColor = GammaToLinearSpace(specularColor);
		}
		#endif

		//Diffuse
		half3 worldLightDir = worldViewDir; 
		half NDotL = saturate(dot(worldNormal, worldLightDir) * 0.5 + 0.5);		
		half3 diffuse = mainColor * lightColor * NDotL; 

		//Specular
		half3 halfDir = worldViewDir;
		half NDotH = saturate(dot(worldNormal, halfDir));
		half specularPow = pow(NDotH, smoothness * 128.0);
		half3 specular = lightColor * specularColor.rgb * specularPow;

		//Total
		half3 finalColor = diffuse + specular;

		#if UNITY_COLORSPACE_GAMMA
		{
			finalColor = LinearToGammaSpace(finalColor);
		}
		#endif

		return finalColor;
	}

	inline half3 CharacterFixedLightingUIFwdBase(half3 mainColor, half3 lightColor, half3 worldNormal, 
		half3 worldLightDir, half3 worldViewDir, half3 specularColor, half smoothness, half lambertK, half3 lambertB )
	{
		#if UNITY_COLORSPACE_GAMMA
		{
			mainColor = GammaToLinearSpace(mainColor);
			specularColor = GammaToLinearSpace(specularColor);
		}
		#endif

		//Diffuse
		half NDotL = saturate(dot(worldNormal, worldLightDir) * lambertK + lambertB);
		half3 diffuse = mainColor * lightColor * NDotL; 

		//Specular
		half3 halfDir = normalize(worldViewDir + worldLightDir);
		half NDotH = saturate(dot(worldNormal, halfDir));
		half specularPow = pow(NDotH, smoothness * 128.0);
		half3 specular = lightColor * specularColor.rgb * specularPow;

		//Total
		half3 finalColor = diffuse + specular;

		#if UNITY_COLORSPACE_GAMMA
		{
			finalColor = LinearToGammaSpace(finalColor);
		}
		#endif

		return finalColor;
	}

	inline half3 GetAmbientColor(half3 mainColor, half3 shLight)
	{
		#ifdef LIGHTMAP_ON
			half3 ambient = mainColor * shLight;
		#else
			half3 ambient = mainColor * (UNITY_LIGHTMODEL_AMBIENT.xyz + shLight);
		#endif

		ambient *= _SG_AmbientColor; 
		ambient *= _SG_AmbientStrength;

		return ambient;
	}

	inline half3 BlinnPhoneLightingFwdBase(half3 mainColor, float3 worldPos, half3 worldNormal, half3 worldViewDir, half3 shLight, half lightAtten, half3 specularColor, half smoothness, out half3 pointLightDiffuse)
	{
		half3 gammaMainColor = mainColor;

		#if UNITY_COLORSPACE_GAMMA
		{
			mainColor = GammaToLinearSpace(mainColor);
			shLight = GammaToLinearSpace(shLight);

			#if defined(SGAME_QUALITY_PERFECT) || defined(SGAME_QUALITY_HIGH)
				specularColor = GammaToLinearSpace(specularColor);
			#endif
		}
		#endif

		half3 ambient = GetAmbientColor(mainColor, shLight);

		half3 baseLighting = BlinnPhoneLighting(mainColor, worldPos, worldNormal, worldViewDir, specularColor, smoothness, lightAtten);

		#if defined(SGAME_QUALITY_PERFECT) || defined(SGAME_QUALITY_HIGH)
			pointLightDiffuse = GetPointLightDiffuse(gammaMainColor, worldPos, worldNormal);
		#else
			pointLightDiffuse = 0;
		#endif

		half3 finalColor = ambient + baseLighting;

		#if UNITY_COLORSPACE_GAMMA
		{
			finalColor = LinearToGammaSpace(finalColor);
		}
		#endif

		return finalColor;
	}

	inline half3 BlinnPhoneLightingFwdAdd(half3 mainColor, float3 worldPos, half3 worldNormal, half3 worldViewDir, half lightAtten, half3 specularColor, half smoothness)
	{
		return BlinnPhoneLighting(mainColor, worldPos, worldNormal, worldViewDir, specularColor, smoothness, lightAtten);
	}

	inline half3 LambertLightingFwdBase(half3 mainColor, float3 worldPos, half3 worldNormal, half3 shLight, half lightAtten, half3 pointLightDiffuse)
	{
		half3 gammaMainColor = mainColor;

		#if UNITY_COLORSPACE_GAMMA
		{
			mainColor = GammaToLinearSpace(mainColor);
			shLight = GammaToLinearSpace(shLight);
		}
		#endif

		half3 ambient = GetAmbientColor(mainColor, shLight);

		half3 baseLighting = LambertLighting(mainColor, worldPos, worldNormal, lightAtten);

		#if defined(SGAME_QUALITY_PERFECT) || defined(SGAME_QUALITY_HIGH)
			pointLightDiffuse = GetPointLightDiffuse(gammaMainColor, worldPos, worldNormal);
		#else
			pointLightDiffuse = 0;
		#endif

		half3 finalColor = ambient + baseLighting;

		#if UNITY_COLORSPACE_GAMMA
		{
			finalColor = LinearToGammaSpace(finalColor);
		}
		#endif

		return finalColor;
	}

	inline half3 LambertLightingFwdAdd(half3 mainColor, float3 worldPos, half3 worldNormal, half lightAtten)
	{
		return LambertLighting(mainColor, worldPos, worldNormal, lightAtten);
	}

	inline half3 CharacterLightingFwdBase(half3 mainColor, half3 lightColor, float3 worldPos, half3 worldNormal, half3 worldViewDir, half3 specularColor, half smoothness/*, out half3 pointLightDiffuse*/)
	{
		half3 baseLighting = CharacterLighting(mainColor, lightColor, worldPos, worldNormal, worldViewDir, specularColor, smoothness);

		/*#if !defined(SGAME_QUALITY_MEDIUM)
			pointLightDiffuse = GetPointLightDiffuse(mainColor, worldPos, worldNormal);
		#else
			pointLightDiffuse = 0;
		#endif*/

		return baseLighting;		
	}

	half ComputeFogDensity(float3 worldPos)
	{
		half dist = length(_WorldSpaceCameraPos.xyz - worldPos.xyz);

		half xzFactor = saturate((dist - _SG_FogRangeVector.x) * _SG_FogRangeVector.y);

		half yFactor = 1 - saturate((worldPos.y - _SG_FogHeightVector.x) * _SG_FogHeightVector.y);
		yFactor *= yFactor;

		return saturate((xzFactor + yFactor) * _SG_FogDensity);
	}

	half3 ApplyFog(half3 mainColor, half fogDensity, half fogDensityMultiplier)
	{
		half3 avgColor = half3(0.5, 0.5, 0.5);
		mainColor = lerp(avgColor, mainColor, 1.1);

		half3 finalColor = lerp(mainColor, _SG_FogColor.rgb, fogDensity * fogDensityMultiplier);
		return finalColor;
	}

	half3 ApplyDark(half3 mainColor)
	{
		#if defined(SGAME_QUALITY_PERFECT) || defined(SGAME_QUALITY_HIGH)
			return lerp(mainColor, half3(0, 0, 0), _SG_DarkStrength);
		#else
			return mainColor;
		#endif
	}

	half3 ApplyPointLight(half3 mainColor, half3 pointLightDiffuse)
	{
		#if defined(SGAME_QUALITY_PERFECT) || defined(SGAME_QUALITY_HIGH)
			return mainColor + pointLightDiffuse;
		#else
			return mainColor;
		#endif
	}

	half3 RgbToHsv(half3 c)
	{
		half4 K = half4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
		half4 p = lerp(half4(c.bg, K.wz), half4(c.gb, K.xy), step(c.b, c.g));
		half4 q = lerp(half4(p.xyw, c.r), half4(c.r, p.yzx), step(p.x, c.r));
		half d = q.x - min(q.w, q.y);
		half e = 1.0e-4;
		return half3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
	}

	half3 HsvToRgb(half3 c)
	{
		half4 K = half4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
		half3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
		return c.z * lerp(K.xxx, saturate(p - K.xxx), c.y);
	}

#endif

