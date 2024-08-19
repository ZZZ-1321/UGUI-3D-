namespace UnityEngine.PostProcessing
{
    public sealed class WaterWaveComponent : PostProcessingComponentRenderTexture<WaterWaveModel>
    {
        static class Uniforms
        {
            internal static readonly int _WaterWaveDistance = Shader.PropertyToID("_WaterWave_Distance");
            internal static readonly int _WaterWaveSpeed = Shader.PropertyToID("_WaterWave_Speed");
            internal static readonly int _WaterWaveStrength = Shader.PropertyToID("_WaterWave_Strength");
            internal static readonly int _WaterWaveTex = Shader.PropertyToID("_WaterWave_Tex");
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
            var material = context.materialFactory.Get("Hidden/Post FX/Water Wave");

            material.SetFloat(Uniforms._WaterWaveDistance, model.settings.waterWaveDistance);
            material.SetFloat(Uniforms._WaterWaveSpeed, model.settings.waterWaveSpeed);
            material.SetFloat(Uniforms._WaterWaveStrength, model.settings.waterWaveStrength);

            int th = 512;
            int tw = 512 * source.width / source.height;
            RenderTexture waterWaveBuffer = context.renderTextureFactory.Get(tw, th, 0, RenderTextureFormat.Default);
            waterWaveBuffer.name = "WaterWaveBuffer";

            Graphics.Blit(source, waterWaveBuffer, material, 0);

            uberMaterial.SetTexture(Uniforms._WaterWaveTex, waterWaveBuffer);

            uberMaterial.EnableKeyword("WATER_WAVE");
        }
    }
}
