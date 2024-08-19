namespace UnityEngine.PostProcessing
{
#if UNITY_5_4_OR_NEWER
    [ImageEffectAllowedInSceneView]
#endif
    [DisallowMultipleComponent, ExecuteInEditMode]
    public sealed class ScreenOffset : MonoBehaviour
    {
        static class Uniforms
        {
            internal static readonly int _OffsetStrength = Shader.PropertyToID("_OffsetStrength");
            internal static readonly int _OffsetPercent = Shader.PropertyToID("_OffsetPercent");
            internal static readonly int _MidBlack = Shader.PropertyToID("_MidBlack");
            internal static readonly int _YLeft = Shader.PropertyToID("_YLeft");
            internal static readonly int _YRight = Shader.PropertyToID("_YRight");
        }

        static readonly string SHADER_NAME = "Hidden/Post FX/Screen Offset";

        
        private Material m_Material = null;
        private float m_CurrentOffsetPercent = 0f;
        private Material ScreenOffsetMaterial
        {
            get
            {
                if(m_Material == null)
                {
                    Shader shader = Shader.Find(SHADER_NAME);
                    //Shader shader = ShaderManager.FindEx(SHADER_NAME);
                    if (shader == null)
                    {
                        return null;
                    }

                    m_Material = new Material(shader);
                }

                return m_Material;
            }
        }

        public void InitParams(float yLeft, float yRight, float offsetStrength, float midBlack)
        {
            Material material = ScreenOffsetMaterial;
            material.SetFloat(Uniforms._YLeft, yLeft);
            material.SetFloat(Uniforms._YRight, yRight);
            material.SetFloat(Uniforms._MidBlack, midBlack * 0.01f);
            material.SetFloat(Uniforms._OffsetStrength, offsetStrength * 0.01f);
        }

        public void SetOffsetPercent(float offsetPercent)
        {
            m_CurrentOffsetPercent = offsetPercent;
        }

        void OnRenderImage(RenderTexture src, RenderTexture dest)
        {
            Material material = ScreenOffsetMaterial;
            material.SetFloat(Uniforms._OffsetPercent, m_CurrentOffsetPercent);

            FilterMode oldMode = src.filterMode;
            src.filterMode = FilterMode.Point; 
            Graphics.Blit(src, dest, material, 0);
            src.filterMode = oldMode;
        }
    }
}
