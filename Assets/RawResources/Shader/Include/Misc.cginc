
#ifndef MISC_CG_INCLUDE
#define MISC_CG_INCLUDE

//#include "Common.cginc"

//float3 ComputeBloomPercent(half4 refC, half texChannel)
//{
//	half maxC = Max3(refC.rgb);
//	half k = maxC * refC.a;
//	return k * texChannel;
//}

inline float3 EncodeFloatRGB(float v)
{
	float3 kEncodeMul = float3(1.0, 255.0, 65025.0);       // k1
	float kEncodeBit = 1.0 / 255.0;
	float3 enc = kEncodeMul * v;
	enc = frac(enc);

	/*Vector3 e2;

	e2.z = 0.0f;
	e2.y = enc.z * kEncodeBit;
	e2.x = enc.y * kEncodeBit;*/
	float3 e2 = float3(enc.y * kEncodeBit, enc.z * kEncodeBit, 0.0);
	enc -= e2;
	return enc;
}

inline float DecodeFloatRGB(float3 enc)
{
	float3 kDecodeDot = float3(1.0, 1 / 255.0, 1 / 65025.0);
	return dot(enc, kDecodeDot);
}

#endif