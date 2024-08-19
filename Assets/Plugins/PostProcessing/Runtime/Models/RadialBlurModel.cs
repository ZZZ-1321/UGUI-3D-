using System;

namespace UnityEngine.PostProcessing
{
    [Serializable]
    public class RadialBlurModel : PostProcessingModel
    {
        [Serializable]
        public struct Settings
        {
            [Range(0f, 0.3f)]
            public float sampleDistance;

            [Range(0f, 6f)]
            public float strength;

            public static Settings defaultSettings
            {
                get
                {
                    return new Settings
                    {
                        sampleDistance = 0.2f,
                        strength = 3.0f,
                    };
                }
            }
        }

        [SerializeField]
        Settings m_Settings = Settings.defaultSettings;
        public Settings settings
        {
            get { return m_Settings; }
            set { m_Settings = value; }
        }

        public override void Reset()
        {
            m_Settings = Settings.defaultSettings;
        }
    }
}
