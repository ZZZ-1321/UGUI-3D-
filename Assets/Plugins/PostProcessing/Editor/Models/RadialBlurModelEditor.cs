using UnityEngine;
using UnityEngine.PostProcessing;

namespace UnityEditor.PostProcessing
{
    using Settings = RadialBlurModel.Settings;

    [PostProcessingModelEditor(typeof(RadialBlurModel))]
    public class RadialBlurModelEditor : PostProcessingModelEditor
    {
        SerializedProperty m_SampleDistance;
        SerializedProperty m_Strength;

        public override void OnEnable()
        {
            m_SampleDistance = FindSetting((Settings x) => x.sampleDistance);
            m_Strength = FindSetting((Settings x) => x.strength);
        }

        public override void OnInspectorGUI()
        {
            EditorGUILayout.PropertyField(m_SampleDistance);
            EditorGUILayout.PropertyField(m_Strength);
        }
    }
}
