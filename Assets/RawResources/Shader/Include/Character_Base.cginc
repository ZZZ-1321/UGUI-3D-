#ifndef OPAQUEOBJECT_BASE
#define OPAQUEOBJECT_BASE

	#include "./Lighting_Base.cginc"

	sampler2D _MainTex;
	float4 _MainTex_ST;

	sampler2D _NormalMap;
	float4 _NormalMap_ST;
	half _NormalMapScale;

	sampler2D _Metallic;
	float4 _Metallic_ST;

	half _SpecularFactor;
	half _Smoothness;
	half _EmissionFactor;

	half4 _Color;
	half4 _ColorR;
	half4 _ColorG;
	half4 _ColorB;
 
	sampler2D _MatCap;
	float4 _MatCap_ST;

	half4 _OutlineColor;

	half _MainTexStrength;
	half _FresnelStrength;
	half _FresnelColorStrength;
	half _Alpha;

	half _DissolveAmount;
	half _DissolveColorAmount;
	half4 _DissolveColor;
	half _DissolveColorStrength;

	sampler2D _DissolveTex;
	float4 _DissolveTex_ST;

	sampler2D _DistortTex;
	float4 _DistortTex_ST;

	half _DistortStrength;
	half _MainTexUSpeed;
	half _MainTexVSpeed;
	half _DistortTexUSpeed;
	half _DistortTexVSpeed;

	sampler2D _UVLightDistortTex1;
	float4 _UVLightDistortTex1_ST;
	half _UVLightDistortStrength1;

	sampler2D _UVLightDistortTex2;
	float4 _UVLightDistortTex2_ST;
	half _UVLightDistortStrength2;

	half4 _UVLightDistortSpeed;

	sampler2D _UVLightTex1;
	float4 _UVLightTex1_ST;
	sampler2D _UVLightTex2;
	float4 _UVLightTex2_ST;

	half _UVLightStrength1;
	half _UVLightStrength2;

	half4 _UVLightColor1;
	half4 _UVLightColor2;
	half4 _UVLightSpeed;

	sampler2D _UVLightMaskTex;
	sampler2D _UVLightMaskTex_ST;

	half _UVLightBlendFactor;

	//Character_CutOff
	half _Cutoff;

	//Character_Lighting
	half _LightColorAdd;

	sampler2D _MixTex;
	float4 _MixTex_ST;
	half _MetallicScale;
	half _SmoothnessScale;
	half _AnisotropicScale;
	half _CurvatureScale;

	sampler2D _SSSLutTex;
	float4 _SSSLutTex_ST;

	sampler2D _RefMaskTex;
	float4 _RefMaskTex_ST;

	//float _XRayRimMin;
	//float _XRayRimMax;
	fixed4 _XRayRimColor;

	// x min, y max, z intensity, w power
	float4 _XRayParam;
	//float _XRayRimIntensity;
	//float _XRayRimPower;

	struct appdata_xray
	{
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f_xray
	{
		float4 vertex : POSITION;
		float3 normal : TEXCOORD0;
		float3 world_pos : TEXCOORD1;
	};
	

	struct v2f 
	{
		UNITY_POSITION(pos);
		float4 uvTex0 : TEXCOORD0;
	};

	struct v2f_full
	{
		UNITY_POSITION(pos);
		float4 uvTex0 : TEXCOORD0;
		half3 worldViewDir : TEXCOORD1;
		half3 worldNormal : TEXCOORD2;
	};

	struct v2f_uvlight 
	{
		UNITY_POSITION(pos);

		float4 uvTex0 : TEXCOORD0;
		float4 uvTex1 : TEXCOORD1;

		#if !defined(_TWOUVLIGHT_OFF)
			float4 uvTex2 : TEXCOORD2;
		#endif
	};

	struct v2f_lighting 
	{
		UNITY_POSITION(pos);
		float4 uvTex0 : TEXCOORD0;
		float3 worldPos : TEXCOORD1;

		#if defined(_USENORMALMAP_OFF)
			half3 worldNormal : TEXCOORD2;
			half3 worldViewDir : TEXCOORD3;
		#else
			half4 worldTangentDir : TEXCOORD2;
			half4 worldBitangentDir : TEXCOORD3;
			half4 worldNormalDir : TEXCOORD4;					
		#endif
	};

	struct v2f_ghost
	{
		UNITY_POSITION(pos);
		float4 uvTex0 : TEXCOORD0;

		half3 worldNormal : TEXCOORD1;
		half3 worldViewDir : TEXCOORD2;
		#if !defined(_USENORMALMAP_OFF)
			half3 worldTangentDir : TEXCOORD3;
			half3 worldBitangentDir : TEXCOORD4;
		#endif
	};

	struct a2v_ghost
	{
		float4 vertex : POSITION;
		float4 normal : NORMAL;
		float2 texcoord : TEXCOORD0;
		#if !defined(_USENORMALMAP_OFF)
			float4 tangent: TANGENT;
		#endif

	};

	struct v2f_clx
	{
		UNITY_POSITION(pos);
		float4 uvTex0 : TEXCOORD0;

		float4 worldTangentDir : TEXCOORD1;
		float4 worldBitangentDir : TEXCOORD2;
		float4 worldNormalDir : TEXCOORD3;

		float3 worldViewDir : TEXCOORD4;

		UNITY_LIGHTING_COORDS(5,6)
	};

	struct a2v
	{
		float4 vertex : POSITION;
		float4 normal : NORMAL;
		float2 texcoord : TEXCOORD0;
	};

	struct a2v_lighting
	{
		float4 vertex : POSITION;
		float4 normal : NORMAL;
		float4 tangent: TANGENT;
		float2 texcoord : TEXCOORD0;
	};

	v2f_xray VertexXRay(appdata_xray v)
	{
		v2f_xray o;
		o.vertex = UnityObjectToClipPos(v.vertex);
		o.normal = mul((float3x3)unity_ObjectToWorld, v.normal);
		o.world_pos = (float3)mul(unity_ObjectToWorld, v.vertex);
		return o;
	}

	// x min, y max, z intensity, w power
	//float4 _XRayParam;

	half4 FragXRay(v2f_xray i) : COLOR
	{
		float3 worldNrm = normalize(i.normal);
		float3 invViewDir = normalize(_WorldSpaceCameraPos - i.world_pos);

		float fCos = dot(worldNrm, invViewDir);
		float rim = 1.0 - abs(fCos);
		float fRimFactor = smoothstep(_XRayParam.x, _XRayParam.y, rim);

		half4 finalC;

		finalC.a = _XRayRimColor.a * pow(fRimFactor, _XRayParam.w);
		finalC.rgb = _XRayRimColor.rgb * fRimFactor * _XRayParam.z;

		return finalC;
	}

	v2f VertexMain (a2v v) 
	{
		v2f o;
		UNITY_INITIALIZE_OUTPUT(v2f,o);

		o.pos = UnityObjectToClipPos(v.vertex);
		o.uvTex0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

		float3 viewNormal = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal).xyz);
		o.uvTex0.zw = viewNormal.xy * 0.5 + 0.5;

		return o;
	}

	half4 FragMain (v2f i) : SV_Target 
	{
		half4 mainColor = tex2D( _MainTex, i.uvTex0.xy );
		mainColor.rgb = LinearToGammaSpace(mainColor.rgb);
		half4 matCapColor = tex2D( _MatCap, i.uvTex0.zw );

		half4 changedColor = (mainColor.r * _ColorR + mainColor.g * _ColorG + mainColor.b * _ColorB);
		half4 finalColor = lerp(mainColor, changedColor, mainColor.a);
		finalColor.rgb = finalColor.rgb + (matCapColor.rgb * 2.0 - 1);
		
		//finalColor.rgb = finalColor + (matCapColor.rgb * 2.0 - 1);
		finalColor.rgb = GammaToLinearSpace(finalColor.rgb);
		return finalColor;
	}

	v2f_lighting VertexLightingMain (a2v_lighting v) 
	{
		v2f_lighting o;
		UNITY_INITIALIZE_OUTPUT(v2f_lighting,o);

		o.pos = UnityObjectToClipPos(v.vertex);
		o.uvTex0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

		float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
		half3 worldViewDir = _WorldSpaceCameraPos.xyz - worldPos;
		half3 worldNormal = UnityObjectToWorldNormal(v.normal);
		o.worldPos = worldPos;

		#if defined(_USENORMALMAP_OFF)
			o.worldViewDir = worldViewDir;
			o.worldNormal = worldNormal;
		#else
			half3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
			half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
			half3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;

			o.worldTangentDir = half4(worldTangent, worldViewDir.x);
			o.worldBitangentDir = half4(worldBinormal, worldViewDir.y);
			o.worldNormalDir = half4(worldNormal, worldViewDir.z);
		#endif

		return o;
	}

	half4 FragLightingMain (v2f_lighting i) : SV_Target 
	{
		half4 mainColor = tex2D( _MainTex, i.uvTex0 );
		half4 metallicTex = tex2D( _Metallic, i.uvTex0 );

		half4 changedColor = (mainColor.r * _ColorR + mainColor.g * _ColorG + mainColor.b * _ColorB);
		mainColor = lerp(mainColor, changedColor, mainColor.a);
		float3 worldPos = i.worldPos;

		#if defined(_USENORMALMAP_OFF)
			half3 worldNormal = normalize(i.worldNormal);
			half3 worldViewDir = normalize(i.worldViewDir);
		#else
			half3 worldViewDir = normalize(half3(i.worldTangentDir.w, i.worldBitangentDir.w, i.worldNormalDir.w));

			half3 tangentNormal = UnpackNormal( tex2D( _NormalMap, i.uvTex0 ) );
			half3 worldNormal = normalize(mul(tangentNormal, half3x3(i.worldTangentDir.xyz, i.worldBitangentDir.xyz, i.worldNormalDir.xyz)));
		#endif

		half metallic = metallicTex.r;
		half smoothness = _Smoothness;
		half emission = metallicTex.b * _EmissionFactor;

		half oneMinusReflectivity;
		half3 specularColor;
		half3 diffuseColor = DiffuseAndSpecularFromMetallic (mainColor, metallic, /*out*/ specularColor, /*out*/ oneMinusReflectivity);

		specularColor = specularColor * _SpecularFactor * metallicTex.a;

		half3 ambient = diffuseColor * UNITY_LIGHTMODEL_AMBIENT.xyz;
		half3 lightColor = clamp(ambient + _LightColor0.rgb + half3(_LightColorAdd, _LightColorAdd, _LightColorAdd), 0, 1.7);
		//half3 pointLightDiffuse = 0;
		half3 finalColor = CharacterLightingFwdBase(diffuseColor, lightColor, worldPos, worldNormal, worldViewDir, specularColor, smoothness/*, pointLightDiffuse*/);

		half3 emissionColor = mainColor * ( emission + 0.2 );
		finalColor += emissionColor;

		//finalColor += pointLightDiffuse;

		half mainColorFactor = metallicTex.g;
		finalColor = mainColor * mainColorFactor + finalColor * (1 - mainColorFactor);

		finalColor = clamp(finalColor, 0, 1);

		return half4(finalColor, 1);
	}

	v2f_clx VertexCLXForwardBase(a2v_lighting v)
	{
		v2f_clx o;
		UNITY_INITIALIZE_OUTPUT(v2f_clx,o);

		o.pos = UnityObjectToClipPos(v.vertex);
		o.uvTex0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

		float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
		float3 worldNormal = UnityObjectToWorldNormal(v.normal);

		fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
		fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
		fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;

		o.worldTangentDir = float4(worldTangent, worldPos.x);
		o.worldBitangentDir = float4(worldBinormal, worldPos.y);
		o.worldNormalDir = float4(worldNormal, worldPos.z);

		o.worldViewDir = _WorldSpaceCameraPos.xyz - worldPos;

		UNITY_TRANSFER_LIGHTING(o, o.uvTex0);

		return o;
	}

	v2f_lighting VertexFixedLightingMain (a2v_lighting v) 
	{
		v2f_lighting o;
		UNITY_INITIALIZE_OUTPUT(v2f_lighting,o);

		o.pos = UnityObjectToClipPos(v.vertex);
		o.uvTex0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

		float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
		half3 worldViewDir = normalize(_WorldSpaceCameraPos.xyz - worldPos);
		half3 worldNormal = UnityObjectToWorldNormal(v.normal);
		o.worldPos = worldPos;

		#if defined(_USENORMALMAP_OFF)
			o.worldViewDir = worldViewDir;
			o.worldNormal = worldNormal;
		#else
			half3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
			half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
			half3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;

			o.worldTangentDir = half4(worldTangent, worldViewDir.x);
			o.worldBitangentDir = half4(worldBinormal, worldViewDir.y);
			o.worldNormalDir = half4(worldNormal, worldViewDir.z);
		#endif

		return o;
	}

	half4 FragFixedLightingMain (v2f_lighting i) : SV_Target 
	{
		half4 mainColor = tex2D( _MainTex, i.uvTex0 );
		half4 metallicTex = tex2D( _Metallic, i.uvTex0 );

		half4 changedColor = (mainColor.r * _ColorR + mainColor.g * _ColorG + mainColor.b * _ColorB);
		mainColor = lerp(mainColor, changedColor, mainColor.a);
		float3 worldPos = i.worldPos;

		#if defined(_USENORMALMAP_OFF)
			half3 worldNormal = normalize(i.worldNormal);
			half3 worldViewDir = normalize(i.worldViewDir);
		#else
			half3 worldViewDir = normalize(half3(i.worldTangentDir.w, i.worldBitangentDir.w, i.worldNormalDir.w));

			half3 tangentNormal = UnpackNormal( tex2D( _NormalMap, i.uvTex0 ) );
			half3 worldNormal = normalize(mul(tangentNormal, half3x3(i.worldTangentDir.xyz, i.worldBitangentDir.xyz, i.worldNormalDir.xyz)));
		#endif

		half metallic = metallicTex.r;
		half smoothness = _Smoothness;
		half emission = metallicTex.b * _EmissionFactor;

		half oneMinusReflectivity;
		half3 specularColor;
		half3 diffuseColor = DiffuseAndSpecularFromMetallic (mainColor, metallic, /*out*/ specularColor, /*out*/ oneMinusReflectivity);

		specularColor = specularColor * _SpecularFactor * metallicTex.a;

		const half3 mainLightDir = half3(0.243, 0.616, -0.749);
		const half3 mainLightColor = half3(1.8, 1.786, 1.722);	//(1, 0.9921569, 0.9568627) * 1.8
		half3 finalColorMain = CharacterFixedLightingUIFwdBase(diffuseColor, mainLightColor, worldNormal, mainLightDir, worldViewDir, specularColor, smoothness, 0.5, 0.5);

		const half3 secondLightDir = half3(-0.432, -0.096, 0.897);
		const half3 secondLightColor = half3(2.741, 2.541, 0.894);	//(0.9137255, 0.8470588, 0.2980392) * 3
		half3 finalColorSecond = CharacterFixedLightingUIFwdBase(diffuseColor, secondLightColor, worldNormal, secondLightDir, worldViewDir, specularColor, smoothness, 1, 0);

		half3 emissionColor = mainColor * emission;
		half3 finalLightingColor = finalColorMain + finalColorSecond;
		finalLightingColor += emissionColor;
		finalLightingColor += mainColor * 0.13;

		half mainColorFactor = metallicTex.g;
		half3 finalColor = mainColor * mainColorFactor + finalLightingColor * (1 - mainColorFactor);

		return half4(finalColor, 1);
	}

	v2f_ghost VertexGhost (a2v_ghost v) 
	{
		v2f_ghost o;
		UNITY_INITIALIZE_OUTPUT(v2f_ghost,o);

		o.pos = UnityObjectToClipPos(v.vertex);
		o.uvTex0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

		half3 worldNormal = UnityObjectToWorldNormal(v.normal);

		#if !defined(_USENORMALMAP_OFF)
			half3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
			half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
			half3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
			o.worldTangentDir = worldTangent;
			o.worldBitangentDir = worldBinormal;
		#endif

		o.worldNormal = worldNormal;
		o.worldViewDir = normalize(_WorldSpaceCameraPos.xyz - mul( unity_ObjectToWorld, v.vertex ).xyz);

		return o;
	}

	half4 FragGhost (v2f_ghost i) : SV_Target 
	{
		half4 mainColor = tex2D( _MainTex, i.uvTex0 );

		half4 changedColor = (mainColor.r * _ColorR + mainColor.g * _ColorG + mainColor.b * _ColorB);
		mainColor = lerp(mainColor, changedColor, mainColor.a);

		#if defined(_USENORMALMAP_OFF)
			half3 worldNormal = normalize(i.worldNormal);
		#else
			half3 tangentNormal = UnpackNormal( tex2D( _NormalMap, i.uvTex0 ) );
			half3 worldNormal = normalize(mul(tangentNormal, half3x3(i.worldTangentDir, i.worldBitangentDir, i.worldNormal)));
		#endif
		
		half3 viewDirection = normalize(i.worldViewDir);

		half fresnelStrength = pow(1.002-saturate(dot(worldNormal, viewDirection)), _FresnelStrength);
		half3 finalColor = _Color * fresnelStrength * _FresnelColorStrength;
		finalColor = lerp(finalColor, mainColor, _MainTexStrength);


		return half4(finalColor, saturate(fresnelStrength * _Alpha));
	}

	v2f_full VertexHurtHightlight (a2v v) 
	{
		v2f_full o;
		UNITY_INITIALIZE_OUTPUT(v2f_full,o);

		o.pos = UnityObjectToClipPos(v.vertex);
		o.uvTex0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

		o.worldViewDir = _WorldSpaceCameraPos.xyz - mul( unity_ObjectToWorld, v.vertex ).xyz;
		o.worldNormal = UnityObjectToWorldNormal(v.normal);

		return o;
	}

	half4 FragHurtHightlight (v2f_full i) : SV_Target 
	{
		half4 mainColor = tex2D( _MainTex, i.uvTex0 );

		half4 changedColor = (mainColor.r * _ColorR + mainColor.g * _ColorG + mainColor.b * _ColorB);
		mainColor = lerp(mainColor, changedColor, mainColor.a);

		half3 worldNormal = normalize(i.worldNormal);
		half3 viewDirection = normalize(i.worldViewDir);

		half fresnelParam = 1.002-saturate(dot(worldNormal, viewDirection));
		fresnelParam = fresnelParam * fresnelParam * 1.5;

		half3 finalColor = _OutlineColor * fresnelParam * _FresnelColorStrength;
		finalColor = finalColor + mainColor * _MainTexStrength;

		return half4(finalColor, 1);
	}

	v2f VertexDissolve (a2v v) 
	{
		v2f o;
		UNITY_INITIALIZE_OUTPUT(v2f,o);

		o.pos = UnityObjectToClipPos(v.vertex);
		o.uvTex0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

		return o;
	}

	half4 FragDissolve (v2f i) : SV_Target 
	{
		half clipTex = tex2D( _DissolveTex, i.uvTex0 ).r;
		half clipAmount = clipTex - _DissolveAmount;

		clip(clipAmount);

		half4 mainColor = tex2D( _MainTex, i.uvTex0 );

		half colorAmount = step(clipAmount, _DissolveColorAmount);

		return lerp(mainColor, _DissolveColor * _DissolveColorStrength, colorAmount);
	}

	v2f_full VertexRimLight (a2v v) 
	{
		v2f_full o;
		UNITY_INITIALIZE_OUTPUT(v2f_full,o);

		o.pos = UnityObjectToClipPos(v.vertex);
		o.uvTex0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
		o.uvTex0.zw = TRANSFORM_TEX(v.texcoord, _DistortTex);

		o.worldViewDir = normalize(_WorldSpaceCameraPos.xyz - mul( unity_ObjectToWorld, v.vertex ).xyz);
		o.worldNormal = UnityObjectToWorldNormal(v.normal);

		return o;
	}

	half4 FragRimLight (v2f_full i) : SV_Target 
	{
		half2 distortUV = i.uvTex0.zw + _Time.g * half2( _DistortTexUSpeed, _DistortTexVSpeed );
		distortUV = tex2D( _DistortTex, distortUV ).rr;

		half2 mainUV = i.uvTex0.xy + _Time.g * half2(_MainTexUSpeed, _MainTexVSpeed) + distortUV * _DistortStrength;
		half4 mainColor = tex2D( _MainTex, mainUV ) * _Color;

		half3 worldNormal = normalize(i.worldNormal);
		half3 viewDirection = normalize(i.worldViewDir);

		half fresnelParam = pow(1.002-saturate(dot(worldNormal, viewDirection)), _FresnelStrength * 3);

		half3 finalColor = _OutlineColor * fresnelParam * _FresnelColorStrength;
		finalColor = finalColor + mainColor * _MainTexStrength;

		return half4(finalColor, 1);
	}

	v2f_full VertexRimLightDissolve (a2v v) 
	{
		v2f_full o;
		UNITY_INITIALIZE_OUTPUT(v2f_full,o);

		o.pos = UnityObjectToClipPos(v.vertex);
		o.uvTex0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
		o.uvTex0.zw = TRANSFORM_TEX(v.texcoord, _DissolveTex);

		float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
		o.worldViewDir = _WorldSpaceCameraPos.xyz - worldPos;
		o.worldNormal = UnityObjectToWorldNormal(v.normal);

		return o;
	}

	half4 FragRimLightDissolve (v2f_full i) : SV_Target 
	{
		half clipTex = tex2D(_DissolveTex, i.uvTex0.zw).r;
		half clipAmount = clipTex - _DissolveAmount;

		clip(clipAmount);

		half2 distortUV = i.uvTex0.xy + _Time.g * half2( _DistortTexUSpeed, _DistortTexVSpeed );
		distortUV = tex2D( _DistortTex, TRANSFORM_TEX(distortUV, _DistortTex) ).rr;

		half2 mainUV = i.uvTex0.xy + _Time.g * half2(_MainTexUSpeed, _MainTexVSpeed) + distortUV * _DistortStrength;
		half4 mainColor = tex2D( _MainTex, mainUV ) * _Color;

		half3 worldNormal = normalize(i.worldNormal);
		half3 viewDirection = normalize(i.worldViewDir);

		half fresnelParam = pow(1.002-saturate(dot(worldNormal, viewDirection)), _FresnelStrength * 3);

		half3 finalColor = _OutlineColor * fresnelParam * _FresnelColorStrength;
		finalColor = finalColor + mainColor * _MainTexStrength;

		half colorAmount = step(clipAmount, _DissolveColorAmount);
		finalColor = lerp(finalColor, _DissolveColor.rgb * _DissolveColorStrength, colorAmount);

		return half4(finalColor, 1);
	}

	v2f_uvlight VertexUVLight (a2v v) 
	{
		v2f_uvlight o;
		UNITY_INITIALIZE_OUTPUT(v2f_uvlight,o);

		o.pos = UnityObjectToClipPos(v.vertex);
		o.uvTex0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

		o.uvTex1.xy = TRANSFORM_TEX(v.texcoord, _UVLightTex1) + _UVLightSpeed.xy * _Time.xx;
		o.uvTex1.zw = TRANSFORM_TEX(v.texcoord, _UVLightDistortTex1) + _UVLightDistortSpeed.xy * _Time.xx;

		#if !defined(_TWOUVLIGHT_OFF)
			o.uvTex2.xy = TRANSFORM_TEX(v.texcoord, _UVLightTex2) + _UVLightSpeed.zw * _Time.xx;
			o.uvTex2.zw = TRANSFORM_TEX(v.texcoord, _UVLightDistortTex2) + _UVLightDistortSpeed.zw * _Time.xx;
		#endif

		return o;
	}

	half4 FragUVLight (v2f_uvlight i) : SV_Target 
	{
		half4 mainColor = tex2D( _MainTex, i.uvTex0 );

		half4 changedColor = (mainColor.r * _ColorR + mainColor.g * _ColorG + mainColor.b * _ColorB) * _Color;
		mainColor = lerp(mainColor, changedColor, mainColor.a);

		half4 mask = tex2D(_UVLightMaskTex, i.uvTex0.xy);

		float2 distort1UV = tex2D(_UVLightDistortTex1, i.uvTex1.zw).xy * _UVLightDistortStrength1;
		distort1UV = (distort1UV - 0.5);
		half3 lightColor1 = tex2D(_UVLightTex1, i.uvTex1.xy + distort1UV).rgb * _UVLightColor1.rgb * _UVLightStrength1 * mask.r;

		half3 uvLight = lightColor1;

		#if !defined(_TWOUVLIGHT_OFF)
			float2 distort2UV = tex2D(_UVLightDistortTex2, i.uvTex2.zw).xy * _UVLightDistortStrength2;
			distort2UV = (distort2UV - 0.5);
			half3 lightColor2 = tex2D(_UVLightTex2, i.uvTex2.xy + distort2UV).rgb * _UVLightColor2.rgb * _UVLightStrength2 * mask.g;
			uvLight = lerp(lightColor1, lightColor2, _UVLightBlendFactor);
		#endif

		return half4(mainColor.rgb + uvLight, 1);
	}

	v2f_uvlight VertexUVLightDissolve (a2v v) 
	{
		v2f_uvlight o;
		UNITY_INITIALIZE_OUTPUT(v2f_uvlight,o);

		o.pos = UnityObjectToClipPos(v.vertex);
		o.uvTex0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

		o.uvTex1.xy = TRANSFORM_TEX(v.texcoord, _UVLightTex1) + _UVLightSpeed.xy * _Time.xx;
		o.uvTex1.zw = TRANSFORM_TEX(v.texcoord, _UVLightDistortTex1) + _UVLightDistortSpeed.xy * _Time.xx;

		#if !defined(_TWOUVLIGHT_OFF)
			o.uvTex2.xy = TRANSFORM_TEX(v.texcoord, _UVLightTex2) + _UVLightSpeed.zw * _Time.xx;
			o.uvTex2.zw = TRANSFORM_TEX(v.texcoord, _UVLightDistortTex2) + _UVLightDistortSpeed.zw * _Time.xx;
		#endif

		return o;
	}

	half4 FragUVLightDissolve (v2f_uvlight i) : SV_Target 
	{
		half clipTex = tex2D( _DissolveTex, i.uvTex0 ).r;
		half clipAmount = clipTex - _DissolveAmount;

		clip(clipAmount);

		half4 mainColor = tex2D( _MainTex, i.uvTex0 );
		mainColor *= _Color;

		half4 mask = tex2D(_UVLightMaskTex, i.uvTex0.xy);

		float2 distort1UV = tex2D(_UVLightDistortTex1, i.uvTex1.zw).xy * _UVLightDistortStrength1;
		distort1UV = (distort1UV - 0.5);
		half3 lightColor1 = tex2D(_UVLightTex1, i.uvTex1.xy + distort1UV).rgb * _UVLightColor1.rgb * _UVLightStrength1 * mask.r;

		half3 uvLight = lightColor1;

		#if !defined(_TWOUVLIGHT_OFF)
			float2 distort2UV = tex2D(_UVLightDistortTex2, i.uvTex2.zw).xy * _UVLightDistortStrength2;
			distort2UV = (distort2UV - 0.5);
			half3 lightColor2 = tex2D(_UVLightTex2, i.uvTex2.xy + distort2UV).rgb * _UVLightColor2.rgb * _UVLightStrength2 * mask.g;
			uvLight = lerp(lightColor1, lightColor2, _UVLightBlendFactor);
		#endif

		mainColor.rgb += uvLight;

		half colorAmount = step(clipAmount, _DissolveColorAmount);

		return lerp(mainColor, _DissolveColor * _DissolveColorStrength, colorAmount);
	}

	half4 FragTransparent (v2f i) : SV_Target 
	{
		half4 mainColor = tex2D( _MainTex, i.uvTex0.xy );
		half4 matCapColor = tex2D( _MatCap, i.uvTex0.zw );
		mainColor.rgb += matCapColor.rgb * 2.0 - 1;
		mainColor.a *= saturate(_Alpha);

		return mainColor;
	}

	half4 FragCutOff (v2f i) : SV_Target 
	{
		half4 mainColor = tex2D( _MainTex, i.uvTex0.xy );
		//half alpha = mainColor.a;

		clip(mainColor.a - _Cutoff);


		mainColor.rgb = LinearToGammaSpace(mainColor.rgb);

		//half4 mainColor = texColor;
		half4 matCapColor = tex2D( _MatCap, i.uvTex0.zw );
		mainColor.rgb += matCapColor.rgb * 2.0 - 1;

		mainColor.rgb = GammaToLinearSpace(mainColor.rgb);
		return mainColor;
	}

#endif

