
#ifndef PROJECTOR_CG_INCLUDE
#define PROJECTOR_CG_INCLUDE

#include "Mrt.cginc"

sampler2D G_TEX_PROJ_01;
sampler2D G_TEX_PROJ_02;
sampler2D G_TEX_PROJ_03;
sampler2D G_TEX_PROJ_04;

fixed4 G_TINT_COLOR_01;
fixed4 G_TINT_COLOR_02;
fixed4 G_TINT_COLOR_03;
fixed4 G_TINT_COLOR_04;

float4x4 G_PROJ_MATRIX_01;
float4x4 G_PROJ_MATRIX_02;
float4x4 G_PROJ_MATRIX_03;
float4x4 G_PROJ_MATRIX_04;

int G_PROJ_BLEND_01;
int G_PROJ_BLEND_02;
int G_PROJ_BLEND_03;
int G_PROJ_BLEND_04;

float4x4 _ClipToWorld;

float3 ComputeCameraToFarPlane(float4 proj_pos)
{
	// Clip space X and Y coords
	float2 clipXY = proj_pos.xy / proj_pos.w;

	// Position of the far plane in clip space
	float4 farPlaneClip = float4(clipXY, 1, 1);

	// Homogeneous world position on the far plane
	//farPlaneClip *= float4(1, _ProjectionParams.x, 1, 1);		
	farPlaneClip.y *= _ProjectionParams.x;

#if UNITY_SINGLE_PASS_STEREO
	_ClipToWorld = mul(_ClipToWorld, unity_CameraInvProjection);
#endif
	float4 farPlaneWorld4 = mul(_ClipToWorld, farPlaneClip);

	// World position on the far plane
	float3 farPlaneWorld = farPlaneWorld4.xyz / farPlaneWorld4.w;

	// Vector from the camera to the far plane
	return farPlaneWorld - _WorldSpaceCameraPos;
}

float3 ComputeWorldPosFromDepth(float4 screen_pos, float3 far_world)
{
	float depth = ComputeDepth01ForMrt(screen_pos);
	float3 worldPos = (far_world * depth) + _WorldSpaceCameraPos;
	return worldPos;
}

half3 BlendProjectorColor(half3 inC, float blend, half4 projC)
{
	if (blend < 0.5)
	{
		return projC.rgb * projC.a + inC.rgb * (1.0 - projC.a);
	}
	else
	{
		return projC.rgb * projC.a + inC.rgb;
	}
}

float2 ComputeProjTexUV(float4 proj_pos, float main_tex_size_y)
{
	float2 uv = (proj_pos.xy / proj_pos.w + 1.0) *  0.5;

#if UNITY_UV_STARTS_AT_TOP
	if (main_tex_size_y < 0)
	{
		// Depth texture is inverted WRT the main texture
		uv.y = 1.0 - uv.y;
	}
#endif

	return uv;

}

half3 ApplyProject1(half3 inC, float4 screen_pos, float3 far_world, float main_tex_size_y)
{
	float3 world_pos = ComputeWorldPosFromDepth(screen_pos, far_world);
	float4 proj_pos = mul(G_PROJ_MATRIX_01, float4(world_pos, 1.0));
	float2 uv = ComputeProjTexUV(proj_pos, main_tex_size_y);
	half4 tex_c = tex2D(G_TEX_PROJ_01, uv);
	tex_c.rgb = tex_c.rgb * G_TINT_COLOR_01.rgb * 2.0;
	tex_c.a = tex_c.a * G_TINT_COLOR_01.a;
	return BlendProjectorColor(inC, G_PROJ_BLEND_01, tex_c);
}

half3 ApplyProject2(half3 inC, float4 screen_pos, float3 far_world, float main_tex_size_y)
{
	float3 world_pos = ComputeWorldPosFromDepth(screen_pos, far_world);
	float4 proj_pos = mul(G_PROJ_MATRIX_01, float4(world_pos, 1.0));
	float2 uv = ComputeProjTexUV(proj_pos, main_tex_size_y);
	half4 tex_c = tex2D(G_TEX_PROJ_01, uv);
	tex_c.rgb = tex_c.rgb * G_TINT_COLOR_01.rgb * 2.0;
	tex_c.a = tex_c.a * G_TINT_COLOR_01.a;
	
	half3 out_c = BlendProjectorColor(inC, G_PROJ_BLEND_01, tex_c);

	proj_pos = mul(G_PROJ_MATRIX_02, float4(world_pos, 1.0));
	uv = ComputeProjTexUV(proj_pos, main_tex_size_y);
	tex_c = tex2D(G_TEX_PROJ_02, uv);
	tex_c.rgb = tex_c.rgb * G_TINT_COLOR_02.rgb * 2.0;
	tex_c.a = tex_c.a * G_TINT_COLOR_02.a;
	out_c = BlendProjectorColor(out_c, G_PROJ_BLEND_02, tex_c);
	return out_c;
}

half3 ApplyProject3(half3 inC, float4 screen_pos, float3 far_world, float main_tex_size_y)
{
	float3 world_pos = ComputeWorldPosFromDepth(screen_pos, far_world);
	float4 proj_pos = mul(G_PROJ_MATRIX_01, float4(world_pos, 1.0));
	float2 uv = ComputeProjTexUV(proj_pos, main_tex_size_y);
	half4 tex_c = tex2D(G_TEX_PROJ_01, uv);
	tex_c.rgb = tex_c.rgb * G_TINT_COLOR_01.rgb * 2.0;
	tex_c.a = tex_c.a * G_TINT_COLOR_01.a;

	half3 out_c = BlendProjectorColor(inC, G_PROJ_BLEND_01, tex_c);

	proj_pos = mul(G_PROJ_MATRIX_02, float4(world_pos, 1.0));
	uv = ComputeProjTexUV(proj_pos, main_tex_size_y);
	tex_c = tex2D(G_TEX_PROJ_02, uv);
	tex_c.rgb = tex_c.rgb * G_TINT_COLOR_02.rgb * 2.0;
	tex_c.a = tex_c.a * G_TINT_COLOR_02.a;
	out_c = BlendProjectorColor(out_c, G_PROJ_BLEND_02, tex_c);

	proj_pos = mul(G_PROJ_MATRIX_03, float4(world_pos, 1.0));
	uv = ComputeProjTexUV(proj_pos, main_tex_size_y);
	tex_c = tex2D(G_TEX_PROJ_03, uv);
	tex_c.rgb = tex_c.rgb * G_TINT_COLOR_03.rgb * 2.0;
	tex_c.a = tex_c.a * G_TINT_COLOR_03.a;
	out_c = BlendProjectorColor(out_c, G_PROJ_BLEND_03, tex_c);
	return out_c;
}

half3 ApplyProject4(half3 inC, float4 screen_pos, float3 far_world, float main_tex_size_y)
{
	float3 world_pos = ComputeWorldPosFromDepth(screen_pos, far_world);
	float4 proj_pos = mul(G_PROJ_MATRIX_01, float4(world_pos, 1.0));
	float2 uv = ComputeProjTexUV(proj_pos, main_tex_size_y);
	half4 tex_c = tex2D(G_TEX_PROJ_01, uv);
	tex_c.rgb = tex_c.rgb * G_TINT_COLOR_01.rgb * 2.0;
	tex_c.a = tex_c.a * G_TINT_COLOR_01.a;

	half3 out_c = BlendProjectorColor(inC, G_PROJ_BLEND_01, tex_c);

	proj_pos = mul(G_PROJ_MATRIX_02, float4(world_pos, 1.0));
	uv = ComputeProjTexUV(proj_pos, main_tex_size_y);
	tex_c = tex2D(G_TEX_PROJ_02, uv);
	tex_c.rgb = tex_c.rgb * G_TINT_COLOR_02.rgb * 2.0;
	tex_c.a = tex_c.a * G_TINT_COLOR_02.a;
	out_c = BlendProjectorColor(out_c, G_PROJ_BLEND_02, tex_c);

	proj_pos = mul(G_PROJ_MATRIX_03, float4(world_pos, 1.0));
	uv = ComputeProjTexUV(proj_pos, main_tex_size_y);
	tex_c = tex2D(G_TEX_PROJ_03, uv);
	tex_c.rgb = tex_c.rgb * G_TINT_COLOR_03.rgb * 2.0;
	tex_c.a = tex_c.a * G_TINT_COLOR_03.a;
	out_c = BlendProjectorColor(out_c, G_PROJ_BLEND_03, tex_c);

	proj_pos = mul(G_PROJ_MATRIX_04, float4(world_pos, 1.0));
	uv = ComputeProjTexUV(proj_pos, main_tex_size_y);
	tex_c = tex2D(G_TEX_PROJ_04, uv);
	tex_c.rgb = tex_c.rgb * G_TINT_COLOR_04.rgb * 2.0;
	tex_c.a = tex_c.a * G_TINT_COLOR_04.a;
	out_c = BlendProjectorColor(out_c, G_PROJ_BLEND_04, tex_c);
	return out_c;
}
#endif