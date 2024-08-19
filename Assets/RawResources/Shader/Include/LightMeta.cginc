// Upgrade NOTE: replaced 'defined _EXTRALIGHT_ONE' with 'defined (_EXTRALIGHT_ONE)'
// Upgrade NOTE: replaced 'defined _EXTRALIGHT_TWO' with 'defined (_EXTRALIGHT_TWO)'


#ifndef LIGHTMETA_GL_CG_INCLUDE
#define LIGHTMETA_GL_CG_INCLUDE

#include "UnityCG.cginc"
#include "Lighting.cginc"			

#include "UnityMetaPass.cginc"	

struct v2f
{
	float4 pos:SV_POSITION;

	half3 color:COLOR;

#if defined (_T4M_2TEX) || defined (_T4M_2TEX_2NRM)
	half4 uv_tex12 : TEXCOORD0;
	half2 uv_tex34 : TEXCOORD1;
#elif defined (_T4M_3TEX) || defined (_T4M_3TEX_2NRM)
	half4 uv_tex12 : TEXCOORD0;
	half4 uv_tex34 : TEXCOORD1;
#elif defined (_T4M_4TEX) || defined (_T4M_4TEX_2NRM)
	half4 uv_tex12 : TEXCOORD0;
	half4 uv_tex34 : TEXCOORD1;
	half2 uv_tex56 : TEXCOORD2;
#else
	float2 uv:TEXCOORD0;
#endif	

#if defined (_T4M_2TEX) || defined (_T4M_3TEX) || defined (_T4M_4TEX) || defined (_T4M_2TEX_2NRM) || defined (_T4M_3TEX_2NRM) || defined (_T4M_4TEX_2NRM)
	half2 uv_misc : TEXCOORD3;
#endif
};

fixed4 _TintColor;
sampler2D _MainTex;

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

sampler2D _MiscTex;
half4 _MiscTex_ST;

half _Cutoff;

v2f vertMeta(appdata_full v)
{
	v2f o;

	UNITY_INITIALIZE_OUTPUT(v2f, o);
	o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);

#if defined (_T4M_2TEX) || defined (_T4M_2TEX_2NRM)
	o.uv_tex12.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
	o.uv_tex12.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
	o.uv_tex34.xy = TRANSFORM_TEX(v.texcoord, _Control);
#elif defined (_T4M_3TEX) || defined (_T4M_3TEX_2NRM)
	o.uv_tex12.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
	o.uv_tex12.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
	o.uv_tex34.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
	o.uv_tex34.zw = TRANSFORM_TEX(v.texcoord, _Control);
#elif defined (_T4M_4TEX) || defined (_T4M_4TEX_2NRM)
	o.uv_tex12.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
	o.uv_tex12.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
	o.uv_tex34.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
	o.uv_tex34.zw = TRANSFORM_TEX(v.texcoord, _Control);
	o.uv_tex56.xy = TRANSFORM_TEX(v.texcoord, _Splat3);
#else
	o.uv = v.texcoord.xy;
#endif	

#if defined (_T4M_2TEX) || defined (_T4M_3TEX) || defined (_T4M_4TEX) || defined (_T4M_2TEX_2NRM) || defined (_T4M_3TEX_2NRM) || defined (_T4M_4TEX_2NRM)
	o.uv_misc = TRANSFORM_TEX(v.uv, _MiscTex);
#endif
	return o;
}

fixed4 fragMeta(v2f i) :SV_Target
{
	UnityMetaInput metaIN;

#if defined (_T4M_2TEX) || defined (_T4M_2TEX_2NRM)
	fixed4 splat_control = tex2D(_Control, i.uv_tex34).rgba;
	fixed4 lay1 = tex2D(_Splat0, i.uv_tex12.xy);
	fixed4 lay2 = tex2D(_Splat1, i.uv_tex12.zw);

	fixed4 miscC = tex2D(_MiscTex, i.uv_misc);

	float specInst = lay1.a * splat_control.r + lay2.a * splat_control.g;
	half3 specularColor = _SpecColor.rgb * specInst * miscC.r;

	half3 mainColor = (lay1 * splat_control.r + lay2 * splat_control.g) * _TintColor.rgb * 2.0;
#elif defined (_T4M_3TEX) || defined (_T4M_3TEX_2NRM)
	fixed4 splat_control = tex2D(_Control, i.uv_tex34.zw).rgba;
	fixed4 lay1 = tex2D(_Splat0, i.uv_tex12.xy);
	fixed4 lay2 = tex2D(_Splat1, i.uv_tex12.zw);
	fixed4 lay3 = tex2D(_Splat2, i.uv_tex34.xy);

	fixed4 miscC = tex2D(_MiscTex, i.uv_misc);

	float specInst = lay1.a * splat_control.r + lay2.a * splat_control.g + lay3.a * splat_control.b;
	half3 specularColor = _SpecColor.rgb * specInst * miscC.r;

	half3 mainColor = (lay1 * splat_control.r + lay2 * splat_control.g + lay3 * splat_control.b) * _TintColor.rgb * 2.0;
#elif defined (_T4M_4TEX) || defined (_T4M_4TEX_2NRM)
	fixed4 splat_control = tex2D(_Control, i.uv_tex34.zw).rgba;
	fixed4 lay1 = tex2D(_Splat0, i.uv_tex12.xy);
	fixed4 lay2 = tex2D(_Splat1, i.uv_tex12.zw);
	fixed4 lay3 = tex2D(_Splat2, i.uv_tex34.xy);
	fixed4 lay4 = tex2D(_Splat3, i.uv_tex56.xy);

	fixed4 miscC = tex2D(_MiscTex, i.uv_misc);

	float specInst = lay1.a * splat_control.r + lay2.a * splat_control.g + lay3.a * splat_control.b + lay4.a * splat_control.a;
	half3 specularColor = _SpecColor.rgb * specInst * miscC.r;

	half3 mainColor = (lay1 * splat_control.r + lay2 * splat_control.g + lay3 * splat_control.b + lay4*splat_control.a) * _TintColor.rgb * 2.0;
#else
	fixed4 miscC = tex2D(_MiscTex, i.uv);
	half3 specularColor = _SpecColor.rgb * miscC.r;

	half3 mainColor = tex2D(_MainTex, i.uv).rgb * _TintColor.rgb * 2.0;
#endif		

	UNITY_INITIALIZE_OUTPUT(UnityMetaInput,metaIN);
	metaIN.Albedo = mainColor;
	metaIN.Emission = 0;
	metaIN.SpecularColor = specularColor;
	return UnityMetaFragment(metaIN);
}

fixed4 fragMetaCutoff(v2f i) :SV_Target
{
	UnityMetaInput metaIN;
	
	half alpha = 1.0;

#if defined (_T4M_2TEX) || defined (_T4M_2TEX_2NRM)
	fixed4 splat_control = tex2D(_Control, i.uv_tex34).rgba;
	fixed4 lay1 = tex2D(_Splat0, i.uv_tex12.xy);
	fixed4 lay2 = tex2D(_Splat1, i.uv_tex12.zw);

	fixed4 miscC = tex2D(_MiscTex, i.uv_misc);

	float specInst = lay1.a * splat_control.r + lay2.a * splat_control.g;
	half3 specularColor = _SpecColor.rgb * specInst * miscC.r;

	half3 mainColor = (lay1 * splat_control.r + lay2 * splat_control.g) * _TintColor.rgb * 2.0;
	alpha = _TintColor.a;
#elif defined (_T4M_3TEX) || defined (_T4M_3TEX_2NRM)
	fixed4 splat_control = tex2D(_Control, i.uv_tex34.zw).rgba;
	fixed4 lay1 = tex2D(_Splat0, i.uv_tex12.xy);
	fixed4 lay2 = tex2D(_Splat1, i.uv_tex12.zw);
	fixed4 lay3 = tex2D(_Splat2, i.uv_tex34.xy);

	fixed4 miscC = tex2D(_MiscTex, i.uv_misc);

	float specInst = lay1.a * splat_control.r + lay2.a * splat_control.g + lay3.a * splat_control.b;
	half3 specularColor = _SpecColor.rgb * specInst * miscC.r;

	half3 mainColor = (lay1 * splat_control.r + lay2 * splat_control.g + lay3 * splat_control.b) * _TintColor.rgb * 2.0;
	alpha = _TintColor.a;
#elif defined (_T4M_4TEX) || defined (_T4M_4TEX_2NRM)
	fixed4 splat_control = tex2D(_Control, i.uv_tex34.zw).rgba;
	fixed4 lay1 = tex2D(_Splat0, i.uv_tex12.xy);
	fixed4 lay2 = tex2D(_Splat1, i.uv_tex12.zw);
	fixed4 lay3 = tex2D(_Splat2, i.uv_tex34.xy);
	fixed4 lay4 = tex2D(_Splat3, i.uv_tex56.xy);

	fixed4 miscC = tex2D(_MiscTex, i.uv_misc);

	float specInst = lay1.a * splat_control.r + lay2.a * splat_control.g + lay3.a * splat_control.b + lay4.a * splat_control.a;
	half3 specularColor = _SpecColor.rgb * specInst * miscC.r;

	half3 mainColor = (lay1 * splat_control.r + lay2 * splat_control.g + lay3 * splat_control.b + lay4*splat_control.a) * _TintColor.rgb * 2.0;
	alpha = _TintColor.a;
#else
	fixed4 miscC = tex2D(_MiscTex, i.uv);
	half3 specularColor = _SpecColor.rgb * miscC.r;

	half4 texC = tex2D(_MainTex, i.uv);
	half3 mainColor = texC.rgb * _TintColor.rgb * 2.0;
	alpha = _TintColor.a * texC.a;
#endif		

	clip(alpha - _Cutoff);

	UNITY_INITIALIZE_OUTPUT(UnityMetaInput,metaIN);
	metaIN.Albedo = mainColor;
	metaIN.Emission = 0;
	metaIN.SpecularColor = specularColor;
	return UnityMetaFragment(metaIN);
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

v2f vertMetaPlant(appdata_full v)
{
	v2f o;

	UNITY_INITIALIZE_OUTPUT(v2f, o);

	v.vertex = MoveVertex(v.vertex, v.color.a);
	o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);

#if defined (_T4M_2TEX) || defined (_T4M_2TEX_2NRM)
	o.uv_tex12.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
	o.uv_tex12.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
	o.uv_tex34.xy = TRANSFORM_TEX(v.texcoord, _Control);
#elif defined (_T4M_3TEX) || defined (_T4M_3TEX_2NRM)
	o.uv_tex12.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
	o.uv_tex12.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
	o.uv_tex34.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
	o.uv_tex34.zw = TRANSFORM_TEX(v.texcoord, _Control);
#elif defined (_T4M_4TEX) || defined (_T4M_4TEX_2NRM)
	o.uv_tex12.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
	o.uv_tex12.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
	o.uv_tex34.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
	o.uv_tex34.zw = TRANSFORM_TEX(v.texcoord, _Control);
	o.uv_tex56.xy = TRANSFORM_TEX(v.texcoord, _Splat3);
#else
	o.uv = v.texcoord.xy;
#endif	

#if defined (_T4M_2TEX) || defined (_T4M_3TEX) || defined (_T4M_4TEX) || defined (_T4M_2TEX_2NRM) || defined (_T4M_3TEX_2NRM) || defined (_T4M_4TEX_2NRM)
	o.uv_misc = TRANSFORM_TEX(v.uv, _MiscTex);
#endif
	return o;
}

#endif