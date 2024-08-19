// Upgrade NOTE: replaced 'defined _EXTRALIGHT_ONE' with 'defined (_EXTRALIGHT_ONE)'
// Upgrade NOTE: replaced 'defined _EXTRALIGHT_TWO' with 'defined (_EXTRALIGHT_TWO)'


#ifndef LIGHTADD_GL_CG_INCLUDE
#define LIGHTADD_GL_CG_INCLUDE

//#define POINT			

#include "UnityCG.cginc"	
#include "UnityLightingCommon.cginc"	
#include "Autolight.cginc" 
#include "UnityPBSLighting.cginc"				
#include "UnityStandardUtils.cginc"
#include "HeightFog.cginc"
#include "Lighting.cginc"

struct appdata_t
{
	float4 vertex : POSITION;
	half2 uv : TEXCOORD0;	
	//float2 texcoord1 : TEXCOORD1;
	float3 normal : NORMAL;
	half4 color : COLOR;

#ifdef _LIGHTING_HIGH				
	float4 tangent : TANGENT;
#endif
};

struct v2f
{
	float4 pos : SV_POSITION;
	half4 uv : TEXCOORD0;

	float3 world_view : TEXCOORD1;
	float3 world_light : TEXCOORD2;
	float3 world_nrm : TEXCOORD3;

	float3 world_pos : TEXCOORD4;

#ifdef _LIGHTING_HIGH				
	float3 world_tangent : TEXCOORD5;
	float3 world_binormal : TEXCOORD6;
#endif

#if defined (_T4M_2TEX) || defined (_T4M_2TEX_2NRM)
	half4 uv_t4m_0 : TEXCOORD8;
	half2 uv_t4m_1 : TECOORD8;
#elif defined (_T4M_3TEX) || defined (_T4M_3TEX_2NRM)
	half4 uv_t4m_0 : TEXCOORD8;
	half4 uv_t4m_1 : TEXCOORD9;
#elif defined (_T4M_4TEX) || defined (_T4M_4TEX_2NRM)
	half4 uv_t4m_0 : TEXCOORD8;
	half4 uv_t4m_1 : TEXCOORD9;
	half2 uv_t4m_2 : TEXCOORD10;
#endif

#if defined (_T4M_2TEX_2NRM) || defined (_T4M_3TEX_2NRM) || defined (_T4M_4TEX_2NRM)
	half2 uv_bump2 : TEXCOORD11;
#endif

#if defined (_FLOWING_HEIGHT_FOG)
	float3 depth_proj_pos : TEXCOORD12;		// x for depth, yz for proj pos
#endif
};

sampler2D _MainTex;
half4 _MainTex_ST;

fixed4 _TintColor;

sampler2D _Splat0;
sampler2D _Splat1;
sampler2D _Splat2;
sampler2D _Splat3;
sampler2D _Control;

half4 _Splat0_ST;
half4 _Splat1_ST;
half4 _Splat2_ST;
half4 _Splat3_ST;
half4 _Control_ST;

sampler2D _BumpMap;
half4 _BumpMap_ST;

sampler2D _BumpMap2;
half4 _BumpMap2_ST;

float _BumpMapScale;
float _BumpMapScale2;

half _Cutoff;

v2f vertAdd(appdata_t v)
{
	v2f o = (v2f)0;

	o.pos = UnityObjectToClipPos(v.vertex);

#if defined (_T4M_2TEX) || defined (_T4M_3TEX) || defined (_T4M_4TEX) || defined (_T4M_2TEX_2NRM) || defined (_T4M_3TEX_2NRM) || defined (_T4M_4TEX_2NRM)
	o.uv.xy = 0;
	o.uv.zw = TRANSFORM_TEX(v.uv, _BumpMap);
#else
	o.uv.xy = TRANSFORM_TEX(v.uv, _MainTex);
	o.uv.zw = 0;
#endif

#if defined (_T4M_2TEX_2NRM) || defined (_T4M_3TEX_2NRM) || defined (_T4M_4TEX_2NRM)
	o.uv_bump2 = TRANSFORM_TEX(v.uv, _BumpMap2);
#endif

#if defined (_T4M_2TEX) || defined (_T4M_2TEX_2NRM)
	o.uv_t4m_0.xy = TRANSFORM_TEX(v.uv, _Splat0);
	o.uv_t4m_0.zw = TRANSFORM_TEX(v.uv, _Splat1);
	o.uv_t4m_1 = TRANSFORM_TEX(v.uv, _Control);
#elif defined (_T4M_3TEX) || defined (_T4M_3TEX_2NRM)
	o.uv_t4m_0.xy = TRANSFORM_TEX(v.uv, _Splat0);
	o.uv_t4m_0.zw = TRANSFORM_TEX(v.uv, _Splat1);
	o.uv_t4m_1.xy = TRANSFORM_TEX(v.uv, _Splat2);
	o.uv_t4m_1.zw = TRANSFORM_TEX(v.uv, _Control);
#elif defined (_T4M_4TEX) || defined (_T4M_4TEX_2NRM)
	o.uv_t4m_0.xy = TRANSFORM_TEX(v.uv, _Splat0);
	o.uv_t4m_0.zw = TRANSFORM_TEX(v.uv, _Splat1);
	o.uv_t4m_1.xy = TRANSFORM_TEX(v.uv, _Splat2);
	o.uv_t4m_1.zw = TRANSFORM_TEX(v.uv, _Splat3);
	o.uv_t4m_2 = TRANSFORM_TEX(v.uv, _Control);
#endif

	o.world_light = WorldSpaceLightDir(v.vertex);
	o.world_view = WorldSpaceViewDir(v.vertex);
	o.world_nrm = normalize(UnityObjectToWorldNormal(v.normal));

#ifdef _LIGHTING_HIGH
	o.world_tangent = UnityObjectToWorldDir(v.tangent.xyz);
	float tangentSign = v.tangent.w * unity_WorldTransformParams.w;
	o.world_binormal = cross(o.world_nrm, o.world_tangent) * tangentSign;
#endif				

#ifdef _FLOWING_HEIGHT_FOG
	o.depth_proj_pos.x = 0;
	o.depth_proj_pos.yz = o.pos.xy / o.pos.w;
#endif

	o.world_pos = mul(unity_ObjectToWorld, v.vertex);	
	return o;
}

half4 fragAdd(v2f i) : COLOR
{
	half4 finalC;

#if defined (_T4M_2TEX) || defined (_T4M_2TEX_2NRM)
	fixed4 splat_control = tex2D(_Control, i.uv_t4m_1);
	fixed3 lay1 = tex2D(_Splat0, i.uv_t4m_0.xy);
	fixed3 lay2 = tex2D(_Splat1, i.uv_t4m_0.zw);

	finalC.rgb = (lay1 * splat_control.r + lay2 * splat_control.g + lay1 * splat_control.b + lay2 * splat_control.a) * _TintColor.rgb * 2.0;
	finalC.a = _TintColor.a;
#elif defined (_T4M_3TEX) || defined (_T4M_3TEX_2NRM)
	fixed4 splat_control = tex2D(_Control, i.uv_t4m_1.zw);
	fixed3 lay1 = tex2D(_Splat0, i.uv_t4m_0.xy);
	fixed3 lay2 = tex2D(_Splat1, i.uv_t4m_0.zw);
	fixed3 lay3 = tex2D(_Splat2, i.uv_t4m_1.xy);

	finalC.rgb = (lay1 * splat_control.r + lay2 * splat_control.g + lay3 * splat_control.b + lay2 * splat_control.a) * _TintColor.rgb * 2.0;
	finalC.a = _TintColor.a;
#elif defined (_T4M_4TEX) || defined (_T4M_4TEX_2NRM)
	fixed4 splat_control = tex2D(_Control, i.uv_t4m_2);
	fixed3 lay1 = tex2D(_Splat0, i.uv_t4m_0.xy);
	fixed3 lay2 = tex2D(_Splat1, i.uv_t4m_0.zw);
	fixed3 lay3 = tex2D(_Splat2, i.uv_t4m_1.xy);
	fixed3 lay4 = tex2D(_Splat3, i.uv_t4m_1.zw);

	finalC.rgb = (lay1 * splat_control.r + lay2 * splat_control.g + lay3 * splat_control.b + lay4*splat_control.a) * _TintColor.rgb * 2.0;
	finalC.a = _TintColor.a;
#else
	finalC = tex2D(_MainTex, i.uv.xy);
	finalC.rgb = finalC.rgb * _TintColor.rgb * 2.0;
	finalC.a = finalC.a * _TintColor.a;
#endif		

//#if UNITY_COLORSPACE_GAMMA
//	finalC.rgb = GammaToLinearSpace(finalC.rgb);
//#endif

	float3 worldNrm = normalize(i.world_nrm);

#if defined (_LIGHTING_HIGH)			
	#if defined (_T4M_2TEX) || defined (_T4M_3TEX) || defined (_T4M_4TEX)
		float3 raw_nrm = UnpackScaleNormal(tex2D(_BumpMap, i.uv.zw), _BumpMapScale);
	#elif defined (_T4M_2TEX_2NRM)
		float3 raw_nrm = BlendTwoNormalForT4M2Layer(i.uv.zw, i.uv_bump2, splat_control.r, splat_control.g, _BumpMap, _BumpMapScale, _BumpMap2, _BumpMapScale2);
	#elif defined (_T4M_3TEX_2NRM)
		float3 raw_nrm = BlendTwoNormalForT4M3Layer(i.uv.zw, i.uv_bump2, splat_control.r, splat_control.g, splat_control.b, _BumpMap, _BumpMapScale, _BumpMap2, _BumpMapScale2);
	#elif defined (_T4M_4TEX_2NRM)
		float3 raw_nrm = BlendTwoNormalForT4M4Layer(i.uv.zw, i.uv_bump2, splat_control.r, splat_control.g, splat_control.b, splat_control.a, _BumpMap, _BumpMapScale, _BumpMap2, _BumpMapScale2);
	#else
		float3 raw_nrm = UnpackScaleNormal(tex2D(_BumpMap, i.uv.xy), _BumpMapScale);
	#endif

	worldNrm = normalize(mul(raw_nrm, float3x3(i.world_tangent, i.world_binormal, i.world_nrm)));
#endif

	float3 worldLightDir = normalize(i.world_light);
	float3 worldViewDir = normalize(i.world_view);

	float dotNL = dot(worldNrm, worldLightDir);
	float diffK = saturate(dotNL);

	UNITY_LIGHT_ATTENUATION(attenuation, i, i.world_pos);

	finalC.rgb = _LightColor0.rgb * diffK * finalC.rgb * attenuation;

//#if UNITY_COLORSPACE_GAMMA
//	finalC.rgb = LinearToGammaSpace(finalC.rgb);
//#endif

#if defined (_FOG_LH)
	#if defined (_FLOWING_HEIGHT_FOG)
		finalC.rgb = ApplyHeightFog(finalC.rgb, i.world_pos, i.depth_proj_pos.yz);
	#else
		finalC.rgb = ApplyHeightFog(finalC.rgb, i.world_pos, float2(0.0, 0.0));
	#endif
#endif	

	return finalC;
}

//v2f vertAddCutoff(appdata_t v)
//{
//	v2f o = (v2f)0;
//
//	o.pos = UnityObjectToClipPos(v.vertex);
//	o.uv.xy = TRANSFORM_TEX(v.uv, _MainTex);
//	o.uv.zw = 0;
//
//	o.world_light = WorldSpaceLightDir(v.vertex);
//	o.world_view = WorldSpaceViewDir(v.vertex);
//	o.world_nrm = normalize(UnityObjectToWorldNormal(v.normal));
//
//#ifdef _LIGHTING_HIGH
//	o.world_tangent = UnityObjectToWorldDir(v.tangent.xyz);
//	float tangentSign = v.tangent.w * unity_WorldTransformParams.w;
//	o.world_binormal = cross(o.world_nrm, o.world_tangent) * tangentSign;
//#endif				
//
//#ifdef _FLOWING_HEIGHT_FOG
//	o.depth_proj_pos.x = 0;
//	o.depth_proj_pos.yz = o.pos.xy / o.pos.w;
//#endif
//
//	o.world_pos = mul(unity_ObjectToWorld, v.vertex);
//	return o;
//}

half4 fragAddCutoff(v2f i) : COLOR
{
	half4 finalC;

#if defined (_T4M_2TEX) || defined (_T4M_2TEX_2NRM)
	fixed4 splat_control = tex2D(_Control, i.uv_t4m_1);
	fixed3 lay1 = tex2D(_Splat0, i.uv_t4m_0.xy);
	fixed3 lay2 = tex2D(_Splat1, i.uv_t4m_0.zw);

	finalC.rgb = (lay1 * splat_control.r + lay2 * splat_control.g + lay1 * splat_control.b + lay2 * splat_control.a) * _TintColor.rgb * 2.0;
	finalC.a = _TintColor.a;
#elif defined (_T4M_3TEX) || defined (_T4M_3TEX_2NRM)
	fixed4 splat_control = tex2D(_Control, i.uv_t4m_1.zw);
	fixed3 lay1 = tex2D(_Splat0, i.uv_t4m_0.xy);
	fixed3 lay2 = tex2D(_Splat1, i.uv_t4m_0.zw);
	fixed3 lay3 = tex2D(_Splat2, i.uv_t4m_1.xy);

	finalC.rgb = (lay1 * splat_control.r + lay2 * splat_control.g + lay3 * splat_control.b + lay2 * splat_control.a) * _TintColor.rgb * 2.0;
	finalC.a = _TintColor.a;
#elif defined (_T4M_4TEX) || defined (_T4M_4TEX_2NRM)
	fixed4 splat_control = tex2D(_Control, i.uv_t4m_2);
	fixed3 lay1 = tex2D(_Splat0, i.uv_t4m_0.xy);
	fixed3 lay2 = tex2D(_Splat1, i.uv_t4m_0.zw);
	fixed3 lay3 = tex2D(_Splat2, i.uv_t4m_1.xy);
	fixed3 lay4 = tex2D(_Splat3, i.uv_t4m_1.zw);

	finalC.rgb = (lay1 * splat_control.r + lay2 * splat_control.g + lay3 * splat_control.b + lay4*splat_control.a) * _TintColor.rgb * 2.0;
	finalC.a = _TintColor.a;
#else
	finalC = tex2D(_MainTex, i.uv.xy);
	finalC.rgb = finalC.rgb * _TintColor.rgb * 2.0;
	finalC.a = finalC.a * _TintColor.a;
#endif	

	clip(finalC.a - _Cutoff);

	float3 worldNrm = normalize(i.world_nrm);

#if defined (_LIGHTING_HIGH)			
	#if defined (_T4M_2TEX) || defined (_T4M_3TEX) || defined (_T4M_4TEX)
		float3 raw_nrm = UnpackScaleNormal(tex2D(_BumpMap, i.uv.zw), _BumpMapScale);
	#elif defined (_T4M_2TEX_2NRM)
		float3 raw_nrm = BlendTwoNormalForT4M2Layer(i.uv.zw, i.uv_bump2, splat_control.r, splat_control.g, _BumpMap, _BumpMapScale, _BumpMap2, _BumpMapScale2);
	#elif defined (_T4M_3TEX_2NRM)
		float3 raw_nrm = BlendTwoNormalForT4M3Layer(i.uv.zw, i.uv_bump2, splat_control.r, splat_control.g, splat_control.b, _BumpMap, _BumpMapScale, _BumpMap2, _BumpMapScale2);
	#elif defined (_T4M_4TEX_2NRM)
		float3 raw_nrm = BlendTwoNormalForT4M4Layer(i.uv.zw, i.uv_bump2, splat_control.r, splat_control.g, splat_control.b, splat_control.a, _BumpMap, _BumpMapScale, _BumpMap2, _BumpMapScale2);
	#else
		float3 raw_nrm = UnpackScaleNormal(tex2D(_BumpMap, i.uv.xy), _BumpMapScale);
	#endif

	worldNrm = normalize(mul(raw_nrm, float3x3(i.world_tangent, i.world_binormal, i.world_nrm)));
#endif

	float3 worldLightDir = normalize(i.world_light);
	float3 worldViewDir = normalize(i.world_view);

	float dotNL = dot(worldNrm, worldLightDir);
	float diffK = saturate(dotNL);

	UNITY_LIGHT_ATTENUATION(attenuation, i, i.world_pos);

	finalC.rgb = _LightColor0.rgb * diffK * finalC.rgb * attenuation;

#if defined (_FOG_LH)
	#if defined (_FLOWING_HEIGHT_FOG)
		finalC.rgb = ApplyHeightFog(finalC.rgb, i.world_pos, i.depth_proj_pos.yz);
	#else
		finalC.rgb = ApplyHeightFog(finalC.rgb, i.world_pos, float2(0.0, 0.0));
	#endif
#endif	

	return finalC;
}

half _PlantMoveDist;
half _PlantMoveSpeed;
half _PlantMoveSpeedOffset;	

inline float4 MoveVertex(float4 vertex, half colorAlpha)
{
	float a = vertex.x * vertex.z;
	float fa = fmod(a, 2);
	float sinA = sin(a);
	vertex.xyz += float3(sinA, 0, sinA) * _PlantMoveDist * sin(_Time.w * (_PlantMoveSpeed + _PlantMoveSpeedOffset*(1 - fa)) + a) * colorAlpha;
	return vertex;
}

v2f vertAddPlant(appdata_t v)
{
	v2f o = (v2f)0;

	v.vertex = MoveVertex(v.vertex, v.color.a);

	o.pos = UnityObjectToClipPos(v.vertex);
	o.uv.xy = TRANSFORM_TEX(v.uv, _MainTex);

	o.world_light = WorldSpaceLightDir(v.vertex);
	o.world_view = WorldSpaceViewDir(v.vertex);
	o.world_nrm = normalize(UnityObjectToWorldNormal(v.normal));

//#ifdef _FLOWING_HEIGHT_FOG
//	o.depth_proj_pos = o.pos.xy / o.pos.w;
//#endif

#ifdef _FLOWING_HEIGHT_FOG
	o.depth_proj_pos.x = 0;
	o.depth_proj_pos.yz = o.pos.xy / o.pos.w;
#endif

	o.world_pos = mul(unity_ObjectToWorld, v.vertex);
	return o;
}

half _WindSpeed;
half _WindBending;

void FastSinCos(float4 val, out float4 s, out float4 c)
{
	val = val * 6.408849 - 3.1415927;
	float4 r5 = val * val;
	float4 r6 = r5 * r5;
	float4 r7 = r6 * r5;
	float4 r8 = r6 * r5;
	float4 r1 = r5 * val;
	float4 r2 = r1 * r5;
	float4 r3 = r2 * r5;
	float4 sin7 = { 1, -0.16161616, 0.0083333, -0.00019841 };
	float4 cos8 = { -0.5, 0.041666666, -0.0013888889, 0.000024801587 };
	s = val + r1 * sin7.y + r2 * sin7.z + r3 * sin7.w;
	c = 1 + r5 * cos8.x + r6 * cos8.y + r7 * cos8.z + r8 * cos8.w;
}

float4 ApplyFastWind(float4 vertex, float texCoordY)
{
	half speed = _WindSpeed;

	half4 _waveXmove = half4 (0.024, 0.04, -0.12, 0.096);
	half4 _waveZmove = half4 (0.006, .02, -0.02, 0.1);

	const half4 waveSpeed = float4 (1.2, 2, 1.6, 4.8);

	half4 waves;
	waves = vertex.x * _WindBending;
	waves += vertex.z * _WindBending;

	waves += _Time.x * (1 - 0.4) * waveSpeed * speed;

	half4 s, c;
	waves = frac(waves);
	FastSinCos(waves, s, c);

	float waveAmount = texCoordY * (1 + 0.4);
	s *= waveAmount;

	s *= normalize(waveSpeed);

	s = s * s;
	float fade = dot(s, 1.3);
	s = s * s;

	float3 waveMove = float3 (0, 0, 0);
	waveMove.x = dot(s, _waveXmove);
	waveMove.z = dot(s, _waveZmove);

	vertex.xz -= waveMove.xz;

	return vertex;
}

v2f vertAddGrass(appdata_t v)
{
	v2f o = (v2f)0;

	//o.uvTex0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
	o.uv.xy = TRANSFORM_TEX(v.uv, _MainTex);

	float4 worldPos = mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1));
	worldPos = ApplyFastWind(worldPos, o.uv.y);

	//o.pos = UnityObjectToClipPos(v.vertex);	
	o.pos = mul(UNITY_MATRIX_VP, float4(worldPos.xyz, 1.0));

	o.world_light = WorldSpaceLightDir(v.vertex);
	o.world_view = WorldSpaceViewDir(v.vertex);
	o.world_nrm = normalize(UnityObjectToWorldNormal(v.normal));

//#ifdef _FLOWING_HEIGHT_FOG
//	o.depth_proj_pos = o.pos.xy / o.pos.w;
//#endif

#ifdef _FLOWING_HEIGHT_FOG
	o.depth_proj_pos.x = 0;
	o.depth_proj_pos.yz = o.pos.xy / o.pos.w;
#endif

	o.world_pos = worldPos.xyz;
	return o;
}
#endif