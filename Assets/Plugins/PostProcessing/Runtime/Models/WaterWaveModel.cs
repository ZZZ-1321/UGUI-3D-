using System;

namespace UnityEngine.PostProcessing
{
    [Serializable]
    public class WaterWaveModel : PostProcessingModel
    {
        [Serializable]
        public struct Settings
        {
            [Range(0f, 100f)]
            public float waterWaveDistance;

            [Range(0f, 100f)]
            public float waterWaveSpeed;

            [Range(0f, 5f)]
            public float waterWaveStrength;

            public static Settings defaultSettings
            {
                get
                {
                    return new Settings
                    {
                        waterWaveDistance = 30,
                        waterWaveSpeed = 10,
                        waterWaveStrength = 3.0f,
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
