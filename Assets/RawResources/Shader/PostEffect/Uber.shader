Shader "Hidden/Post FX/Uber Shader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BloomTex ("", 2D) = "" {}
        _LogLut ("", 2D) = "" {}
        _UserLut ("", 2D) = "" {}
        _Vignette_Mask ("", 2D) = "" {}
    }

    CGINCLUDE

        #pragma target 3.0

        #pragma multi_compile __ UNITY_COLORSPACE_GAMMA
        #pragma multi_compile __ BLOOM
        //#pragma multi_compile __ COLOR_GRADING
        #pragma multi_compile __ RADIAL_BLUR
        #pragma multi_compile __ WATER_WAVE

        #include "UnityCG.cginc"
        #include "Bloom.cginc"
        #include "ColorGrading.cginc"
        #include "UberSecondPass.cginc"

        // Chromatic aberration
        half _ChromaticAberration_Amount;
        sampler2D _ChromaticAberration_Spectrum;

        // Depth of field
        sampler2D_float _CameraDepthTexture;
        sampler2D _DepthOfFieldTex;
        sampler2D _DepthOfFieldCoCTex;
        float4 _DepthOfFieldTex_TexelSize;
        float3 _DepthOfFieldParams; // x: distance, y: f^2 / (N * (S1 - f) * film_width * 2), z: max coc

        // Bloom
        sampler2D _BloomTex;
        float4 _BloomTex_TexelSize;
        half2 _Bloom_Settings; // x: sampleScale, y: bloom.intensity

        // Color grading & tonemapping
        sampler2D _LogLut;
        half3 _LogLut_Params; // x: 1 / lut_width, y: 1 / lut_height, z: lut_height - 1
        half _ExposureEV; // EV (exp2)

        // User lut
        sampler2D _UserLut;
        half4 _UserLut_Params; // @see _LogLut_Params

        // Vignette
        half3 _Vignette_Color;
        half2 _Vignette_Center; // UV space
        half4 _Vignette_Settings; // x: intensity, y: smoothness, z: roundness, w: rounded
        sampler2D _Vignette_Mask;
        half _Vignette_Opacity; // [0;1]

		// Radial Blur
        sampler2D _RadialBlur_Tex;
        half _RadialBlur_Strength;

		// Water Wave
        sampler2D _WaterWave_Tex;

        struct VaryingsFlipped
        {
            float4 pos : SV_POSITION;
            float2 uv : TEXCOORD0;
        };

        VaryingsFlipped VertUber(AttributesDefault v)
        {
            VaryingsFlipped o;
            o.pos = UnityObjectToClipPos(v.vertex);
            o.uv = v.texcoord.xy;

        #if UNITY_UV_STARTS_AT_TOP
            if (_MainTex_TexelSize.y < 0.0)
                o.uv.y = 1.0 - o.uv.y;
        #endif

            return o;
        }

        half4 FragUber(VaryingsFlipped i) : SV_Target
        {
            float2 uv = i.uv;
            half3 color = (0.0).xxx;

            //
            // HDR effects
            // ---------------------------------------------------------

			color = tex2D(_MainTex, uv).rgb;

			#if RADIAL_BLUR
			{
				half3 radialBlurColor = tex2D(_RadialBlur_Tex, uv).rgb;
				half2 dir = half2(0.5,0.5) - uv;
			 	half dist = length(dir); 
				half radialBlurStrength = saturate(dist * _RadialBlur_Strength); 
				color = lerp(color, radialBlurColor, radialBlurStrength);
			}
			#elif WATER_WAVE
			{
				half3 waterWaveColor = tex2D(_WaterWave_Tex, uv).rgb;
				half2 dir = half2(0.5,0.5) - uv;
			 	half dist = length(dir); 
				half waveStrength = saturate(dist * 10); 
				color = lerp(color, waterWaveColor, waveStrength);
			}
			#endif

            // Gamma space... Gah.
            #if UNITY_COLORSPACE_GAMMA
            {
                color = GammaToLinearSpace(color);
            }
            #endif

            // HDR Bloom
            #if BLOOM
            {
                half3 bloom = UpsampleFilter(_BloomTex, uv, _BloomTex_TexelSize.xy, _Bloom_Settings.x) * _Bloom_Settings.y;
                color += bloom;
            }
            #endif

            // HDR color grading & tonemapping
            #if COLOR_GRADING
            {
				#if (SHADER_TARGET >= 30)
					color *= _ExposureEV; // Exposure is in ev units (or 'stops')

					half3 colorLogC = saturate(LinearToLogC(color));
					color = ApplyLut2d(_LogLut, colorLogC, _LogLut_Params);
				#endif
            }
            #endif

            //
            // All the following effects happen in LDR
            // ---------------------------------------------------------

            color = saturate(color);

            // Back to gamma space if needed
            #if UNITY_COLORSPACE_GAMMA
            {
                color = LinearToGammaSpace(color);
            }
            #endif

            // Done !
            return half4(color, 1.0);
        }

    ENDCG

    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        // (0)
        Pass
        {
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma vertex VertUber
                #pragma fragment FragUber

            ENDCG
        }
    }
}
