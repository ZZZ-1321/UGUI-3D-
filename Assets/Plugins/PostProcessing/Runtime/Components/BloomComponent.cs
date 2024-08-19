namespace UnityEngine.PostProcessing
{
    public sealed class BloomComponent : PostProcessingComponentRenderTexture<BloomModel>
    {
        static class Uniforms
        {
            internal static readonly int _Threshold           = Shader.PropertyToID("_Threshold");
            internal static readonly int _Curve               = Shader.PropertyToID("_Curve");
            internal static readonly int _SampleScale         = Shader.PropertyToID("_SampleScale");
            internal static readonly int _BaseTex             = Shader.PropertyToID("_BaseTex");
            internal static readonly int _BloomTex            = Shader.PropertyToID("_BloomTex");
            internal static readonly int _Bloom_Settings      = Shader.PropertyToID("_Bloom_Settings");
        }

        const int k_MaxPyramidBlurLevel = 8;
        readonly RenderTexture[] m_BlurBuffer1 = new RenderTexture[k_MaxPyramidBlurLevel];
        readonly RenderTexture[] m_BlurBuffer2 = new RenderTexture[k_MaxPyramidBlurLevel];

        public override bool active
        {
            get
            {
                return model.enabled
                       && model.settings.bloom.intensity > 0f
                       && !context.interrupted;
            }
        }

        private int GetIterationsByQuality()
        {
            int iterations = 4;

            //RenderSetting renderSetting = RenderSetting.Instance;

            //if(renderSetting != null)
            //{
            //    if(renderSetting.renderQuality == RenderQuality.PERFECT)
            //    {
            //        iterations = 4;
            //    }
            //    else if(renderSetting.renderQuality == RenderQuality.HIGH)
            //    {
            //        iterations = 3;
            //    }
            //    else if(renderSetting.renderQuality == RenderQuality.MEDIUM)
            //    {
            //        iterations = 2;
            //    }
            //    else
            //    {
            //        iterations = 2;
            //    }
            //}

            //IxQualitySetting kQS = IxQualitySetting.ms_kSig;
            //if ( kQS != null )
            //{
            //    if ( kQS._RenderQuality == IxQualitySetting.RENDER_QUALITY.PERFECT)
            //    {
            //        iterations = 4;
            //    }
            //    else if ( kQS._RenderQuality == IxQualitySetting.RENDER_QUALITY.HIGH)
            //    {
            //        iterations = 3;
            //    }
            //    else if ( kQS._RenderQuality == IxQualitySetting.RENDER_QUALITY.MEDIUM)
            //    {
            //        iterations = 2;
            //    }
            //    else
            //    {
            //        iterations = 2;
            //    }
            //}

            return iterations;
        }

        private float GetSampleScaleByQuality()
        {
            float sampleScale = 2.0f;

            //RenderSetting renderSetting = RenderSetting.Instance;

            //if(renderSetting != null)
            //{
            //    if (renderSetting.renderQuality == RenderQuality.PERFECT)
            //    {
            //        sampleScale = 1.0f;
            //    }
            //    else if (renderSetting.renderQuality == RenderQuality.HIGH)
            //    {
            //        sampleScale = 2.0f;
            //    }
            //    else if (renderSetting.renderQuality == RenderQuality.MEDIUM)
            //    {
            //        sampleScale = 3.0f;
            //    }
            //    else
            //    {
            //        sampleScale = 3.0f;
            //    }
            //}

            //IxQualitySetting kQS = IxQualitySetting.ms_kSig;
            //if ( kQS != null )
            //{
            //    if ( kQS._RenderQuality == IxQualitySetting.RENDER_QUALITY.PERFECT)
            //    {
            //        sampleScale = 1.0f;
            //    }
            //    else if ( kQS._RenderQuality == IxQualitySetting.RENDER_QUALITY.HIGH)
            //    {
            //        sampleScale = 2.0f;
            //    }
            //    else if ( kQS._RenderQuality == IxQualitySetting.RENDER_QUALITY.MEDIUM)
            //    {
            //        sampleScale = 3.0f;
            //    }
            //    else
            //    {
            //        sampleScale = 3.0f;
            //    }
            //}
 
            return sampleScale;
        }
        private int GetBloomRTHeight()
        {
            int height = 512;

            //RenderSetting renderSetting = RenderSetting.Instance;

            //if(renderSetting != null)
            //{
            //    if(renderSetting.renderQuality == RenderQuality.PERFECT)
            //    {
            //        height = 512;
            //    }
            //    else if(renderSetting.renderQuality == RenderQuality.HIGH)
            //    {
            //        height = 512;
            //    }
            //    else if(renderSetting.renderQuality == RenderQuality.MEDIUM)
            //    {
            //        height = 256;
            //    }
            //    else
            //    {
            //        height = 256;
            //    }
            //}

            //IxQualitySetting kQS = IxQualitySetting.ms_kSig;
            //if ( kQS != null )
            //{
            //    if ( kQS._RenderQuality == IxQualitySetting.RENDER_QUALITY.PERFECT)
            //    {
            //        height = 512;
            //    }
            //    else if ( kQS._RenderQuality == IxQualitySetting.RENDER_QUALITY.HIGH)
            //    {
            //        height = 512;
            //    }
            //    else if ( kQS._RenderQuality == IxQualitySetting.RENDER_QUALITY.MEDIUM)
            //    {
            //        height = 256;
            //    }
            //    else
            //    {
            //        height = 256;
            //    }
            //}

            return height;
        }

        public void Prepare(RenderTexture source, Material uberMaterial)
        {
            var bloom = model.settings.bloom;
            var material = context.materialFactory.Get("Hidden/Post FX/Bloom");
            material.shaderKeywords = null;

            // Do bloom on a half-res buffer, full-res doesn't bring much and kills performances on
            // fillrate limited platforms
            int th = GetBloomRTHeight();
            int tw = th * source.width / source.height;

            // Blur buffer format
            // TODO: Extend the use of RGBM to the whole chain for mobile platforms
            var useRGBM = Application.isMobilePlatform;
            var rtFormat = useRGBM
                ? RenderTextureFormat.Default
                : RenderTextureFormat.DefaultHDR;

            // Determine the iteration count
            int iterations = GetIterationsByQuality();

            // Uupdate the shader properties
            float lthresh = bloom.thresholdLinear;
            material.SetFloat(Uniforms._Threshold, lthresh);

            float knee = lthresh * bloom.softKnee + 1e-5f;
            var curve = new Vector3(lthresh - knee, knee * 2f, 0.25f / knee);
            material.SetVector(Uniforms._Curve, curve);

            float sampleScale = GetSampleScaleByQuality();
            material.SetFloat(Uniforms._SampleScale, sampleScale);

            // Prefilter pass
            var prefiltered = context.renderTextureFactory.Get(tw, th, 0, rtFormat);
            Graphics.Blit(source, prefiltered, material, 0);

            // Construct a mip pyramid
            var last = prefiltered;

            for (int level = 0; level < iterations; level++)
            {
                m_BlurBuffer1[level] = context.renderTextureFactory.Get(
                        last.width / 2, last.height / 2, 0, rtFormat
                        );

                int pass = (level == 0) ? 1 : 2;
                Graphics.Blit(last, m_BlurBuffer1[level], material, pass);

                last = m_BlurBuffer1[level];
            }

            // Upsample and combine loop
            for (int level = iterations - 2; level >= 0; level--)
            {
                var baseTex = m_BlurBuffer1[level];
                material.SetTexture(Uniforms._BaseTex, baseTex);

                m_BlurBuffer2[level] = context.renderTextureFactory.Get(
                        baseTex.width, baseTex.height, 0, rtFormat
                        );

                Graphics.Blit(last, m_BlurBuffer2[level], material, 3);
                last = m_BlurBuffer2[level];
            }

            var bloomTex = last;

            // Release the temporary buffers
            for (int i = 0; i < k_MaxPyramidBlurLevel; i++)
            {
                if (m_BlurBuffer1[i] != null)
                    context.renderTextureFactory.Release(m_BlurBuffer1[i]);

                if (m_BlurBuffer2[i] != null && m_BlurBuffer2[i] != bloomTex)
                    context.renderTextureFactory.Release(m_BlurBuffer2[i]);

                m_BlurBuffer1[i] = null;
                m_BlurBuffer2[i] = null;
            }

            context.renderTextureFactory.Release(prefiltered);

            // Push everything to the uber material
            uberMaterial.SetTexture(Uniforms._BloomTex, bloomTex);
            uberMaterial.SetVector(Uniforms._Bloom_Settings, new Vector2(sampleScale, bloom.intensity));

            uberMaterial.EnableKeyword("BLOOM");
        }
    }
}
