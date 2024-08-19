
#ifndef MRT_CG_INCLUDE
#define MRT_CG_INCLUDE

#include "Common.cginc"
#include "Misc.cginc"

float3 ComputeBloomPercent(half4 refC, half texChannel)
{
	half maxC = Max3(refC.rgb);
	half k = maxC * refC.a;
	return k * texChannel;
}

// retur 0 - 1.0
float TransferDepthForMrt(float4 iPos)
{
	//return COMPUTE_DEPTH_01;
	return -(UnityObjectToViewPos(iPos).z * _ProjectionParams.w);
	//return UNITY_TRANSFER_DEPTH(projPos);
}

float2 OutputDepthForMrt(float depth)
{
	//float depth = zw.x / zw.y;		
	//float depth = UNITY_OUTPUT_DEPTH(zw);

	//return EncodeFloatRG(depth);	
	return EncodeFloatRGB(depth);
}

sampler2D G_DepthBloomTexture;

// 输入从 ComputeScreenPos(o.projPos) 来，返回视空间的线性深度 0-1
float ComputeDepth01ForMrt(float4 screenPos)
{
	half4 depthTex = SAMPLE_RAW_DEPTH_TEXTURE_PROJ(G_DepthBloomTexture, UNITY_PROJ_COORD(screenPos));	
	//float rd = DecodeFloatRG(depthTex.rg);
	float rd = DecodeFloatRGB(depthTex.rgb);
	return rd;
}

// 返回视空间的线性深度
float ComputeEyeDepthForMrt(float depth)
{
	/*if (depth == 0)
	{
		depth = 1.0;
	}*/
	return depth / _ProjectionParams.w;
}

half4 OutputWithDepthMrt1(half4 finalC, fixed4 miscC, float depth)
{
	half4 outM1;

	outM1.a = 1.0;
	outM1.b = ComputeBloomPercent(finalC, miscC.b);

	outM1.rg = OutputDepthForMrt(depth);
	return outM1;
}

half4 OutputMrt1(half4 finalC, fixed4 miscC)
{
	half4 outM1;

	outM1.a = 1.0;
	outM1.b = ComputeBloomPercent(finalC, miscC.b);

	outM1.rg = 0.0;
	return outM1;
}

half4 OutputWithDepthMrtEx1(half4 finalC, float depth)
{
	half4 outM1;

	outM1.a = 1.0;
	outM1.b = 0.0;

	outM1.rg = OutputDepthForMrt(depth);
	return outM1;
}

half4 OutputMrtEx1(half4 finalC)
{
	half4 outM1;

	outM1.a = 1.0;
	outM1.b = 0.0;

	outM1.rg = 0.0;
	return outM1;
}

#endif