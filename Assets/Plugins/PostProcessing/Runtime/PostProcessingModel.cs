using System;

namespace UnityEngine.PostProcessing
{
    [Serializable]
    public abstract class PostProcessingModel
    {
        [SerializeField, GetSet("enabled")]
        bool m_Enabled;
        public bool enabled
        {
            get { return m_Enabled || IsOverride; }
            set
            {
                m_Enabled = value;

                if (value)
                    OnValidate();
            }
        }

        public abstract void Reset();

        public virtual void OnValidate()
        {}

        bool m_IsOverride = false;
        public bool IsOverride {
            get { return m_IsOverride; }
            set { m_IsOverride = value; if (value) { OnValidate(); } }
        }
    }
}
