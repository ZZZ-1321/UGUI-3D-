namespace UnityEngine.PostProcessing
{
    public sealed class RadialBlurComponent : PostProcessingComponentRenderTexture<RadialBlurModel>
    {
        static class Uniforms
        {
            internal static readonly int _SampleDistance = Shader.PropertyToID("_RadialBlur_SampleDist");
            internal static readonly int _Strength = Shader.PropertyToID("_RadialBlur_Strength");
            internal static readonly int _RadialBlurTex = Shader.PropertyToID("_RadialBlur_Tex");
        }

        public override bool active
        {
            get
            {
                return model.enabled
                       && !context.interrupted;
            }
        }

        public void Prepare(RenderTexture source, Material uberMaterial)
        {
            var material = context.materialFactory.Get("Hidden/Post FX/Radial Blur");

            material.SetFloat(Uniforms._SampleDistance, model.settings.sampleDistance);

            int th = 512;
            int tw = 512 * source.width / source.height;
            RenderTexture blurBuffer = context.renderTextureFactory.Get(tw, th, 0, RenderTextureFormat.Default);
            blurBuffer.name = "RadialBlurBuffer";

            Graphics.Blit(source, blurBuffer, material, 0);

            uberMaterial.SetFloat(Uniforms._Strength, model.settings.strength);
            uberMaterial.SetTexture(Uniforms._RadialBlurTex, blurBuffer);

            uberMaterial.EnableKeyword("RADIAL_BLUR");
        }
    }
}
