using UnityEngine;
using UnityEngine.PostProcessing;

namespace UnityEditor.PostProcessing
{
    using Settings = WaterWaveModel.Settings;

    [PostProcessingModelEditor(typeof(WaterWaveModel))]
    public class WaterWaveModelEditor : PostProcessingModelEditor
    {
        SerializedProperty m_WaterWaveDistance;
        SerializedProperty m_WaterWaveSpeed;
        SerializedProperty m_WaterWaveStrength;

        public override void OnEnable()
        {
            m_WaterWaveDistance = FindSetting((Settings x) => x.waterWaveDistance);
            m_WaterWaveSpeed = FindSetting((Settings x) => x.waterWaveSpeed);
            m_WaterWaveStrength = FindSetting((Settings x) => x.waterWaveStrength);
        }

        public override void OnInspectorGUI()
        {
            EditorGUILayout.PropertyField(m_WaterWaveDistance);
            EditorGUILayout.PropertyField(m_WaterWaveSpeed);
            EditorGUILayout.PropertyField(m_WaterWaveStrength);
        }
    }
}
