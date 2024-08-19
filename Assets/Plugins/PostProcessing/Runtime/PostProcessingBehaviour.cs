using System;
using System.Collections.Generic;
using UnityEngine.Rendering;

namespace UnityEngine.PostProcessing
{
    using DebugMode = BuiltinDebugViewsModel.Mode;

#if UNITY_5_4_OR_NEWER
    [ImageEffectAllowedInSceneView]
#endif
    [RequireComponent(typeof(Camera)), DisallowMultipleComponent, ExecuteInEditMode]
    [AddComponentMenu("Effects/Post-Processing Behaviour", -1)]
    public class PostProcessingBehaviour : MonoBehaviour
    {
        // Inspector fields
        public PostProcessingProfile profile;

        public Func<Vector2, Matrix4x4> jitteredMatrixFunc;

        // Internal helpers
        Dictionary<Type, KeyValuePair<CameraEvent, CommandBuffer>> m_CommandBuffers;
        List<PostProcessingComponentBase> m_Components;
        Dictionary<PostProcessingComponentBase, bool> m_ComponentStates;

        MaterialFactory m_MaterialFactory;
        RenderTextureFactory m_RenderTextureFactory;
        PostProcessingContext m_Context;
        Camera m_Camera;
        PostProcessingProfile m_PreviousProfile;

        bool m_RenderingInSceneView = false;

        // Effect components
        //BuiltinDebugViewsComponent m_DebugViews;
        //AmbientOcclusionComponent m_AmbientOcclusion;
        //DepthOfFieldComponent m_DepthOfField;
        BloomComponent m_Bloom;
        ColorGradingComponent m_ColorGrading;
        //UserLutComponent m_UserLut;
        //VignetteComponent m_Vignette;
        //FxaaComponent m_Fxaa;
        RadialBlurComponent m_RadialBlur;
        WaterWaveComponent m_WaterWave;

        void OnEnable()
        {
            m_CommandBuffers = new Dictionary<Type, KeyValuePair<CameraEvent, CommandBuffer>>();
            m_MaterialFactory = new MaterialFactory();
            m_RenderTextureFactory = new RenderTextureFactory();
            m_Context = new PostProcessingContext();

            // Keep a list of all post-fx for automation purposes
            m_Components = new List<PostProcessingComponentBase>();

            // Component list
            //m_DebugViews = AddComponent(new BuiltinDebugViewsComponent());
            //m_AmbientOcclusion = AddComponent(new AmbientOcclusionComponent());
            //m_DepthOfField = AddComponent(new DepthOfFieldComponent());
            m_Bloom = AddComponent(new BloomComponent());
            m_ColorGrading = AddComponent(new ColorGradingComponent());
            //m_UserLut = AddComponent(new UserLutComponent());
            //m_Vignette = AddComponent(new VignetteComponent());
            //m_Fxaa = AddComponent(new FxaaComponent());
            m_RadialBlur = AddComponent(new RadialBlurComponent());
            m_WaterWave = AddComponent(new WaterWaveComponent());

            // Prepare state observers
            m_ComponentStates = new Dictionary<PostProcessingComponentBase, bool>();

            foreach (var component in m_Components)
                m_ComponentStates.Add(component, false);

            useGUILayout = false;
        }

        void OnPreCull()
        {
            // All the per-frame initialization logic has to be done in OnPreCull instead of Update
            // because [ImageEffectAllowedInSceneView] doesn't trigger Update events...

            m_Camera = GetComponent<Camera>();

            if (profile == null || m_Camera == null)
                return;

#if UNITY_EDITOR
            // Track the scene view camera to disable some effects we don't want to see in the
            // scene view
            // Currently disabled effects :
            //  - Temporal Antialiasing
            //  - Depth of Field
            //  - Motion blur
            m_RenderingInSceneView = UnityEditor.SceneView.currentDrawingSceneView != null
                && UnityEditor.SceneView.currentDrawingSceneView.camera == m_Camera;
#endif

            // Prepare context
            var context = m_Context.Reset();
            context.profile = profile;
            context.renderTextureFactory = m_RenderTextureFactory;
            context.materialFactory = m_MaterialFactory;
            context.camera = m_Camera;

            // Prepare components
            //m_DebugViews.Init(context, profile.debugViews);
            //m_AmbientOcclusion.Init(context, profile.ambientOcclusion);
            //m_DepthOfField.Init(context, profile.depthOfField);
            m_Bloom.Init(context, profile.bloom);
            m_ColorGrading.Init(context, profile.colorGrading);
            //m_UserLut.Init(context, profile.userLut);
            //m_Vignette.Init(context, profile.vignette);
            //m_Fxaa.Init(context, profile.antialiasing);
            m_RadialBlur.Init(context, profile.radialBlur);
            m_WaterWave.Init(context, profile.waterWave);

            // Handles profile change and 'enable' state observers
            if (m_PreviousProfile != profile)
            {
                DisableComponents();
                m_PreviousProfile = profile;
            }

            CheckObservers();

            // Find out which camera flags are needed before rendering begins
            // Note that motion vectors will only be available one frame after being enabled
            var flags = context.camera.depthTextureMode;
            foreach (var component in m_Components)
            {
                if (component.active)
                    flags |= component.GetCameraFlags();
            }

            context.camera.depthTextureMode = flags;
        }

        void OnPreRender()
        {
            if (profile == null)
                return;

            // Command buffer-based effects should be set-up here
            //TryExecuteCommandBuffer(m_DebugViews);
            //TryExecuteCommandBuffer(m_AmbientOcclusion);
        }

        void OnPostRender()
        {
            if (profile == null || m_Camera == null)
                return;
        }

        // Classic render target pipeline for RT-based effects
        void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
            if (profile == null || m_Camera == null)
            {
                Graphics.Blit(source, destination);
                return;
            }

            // Uber shader setup
            bool uberActive = false;
            //bool fxaaActive = m_Fxaa.active;
            bool fxaaActive = false;
            //bool dofActive = m_DepthOfField.active && !m_RenderingInSceneView;
            bool dofActive = false;

            var uberMaterial = m_MaterialFactory.Get("Hidden/Post FX/Uber Shader");
            uberMaterial.shaderKeywords = null;

            var src = source;
            var dst = destination;

#if UNITY_EDITOR
            // Render to a dedicated target when monitors are enabled so they can show information
            // about the final render.
            // At runtime the output will always be the backbuffer or whatever render target is
            // currently set on the camera.
            if (profile.monitors.onFrameEndEditorOnly != null)
                dst = m_RenderTextureFactory.Get(src);
#endif

            if (dofActive)
            {
                uberActive = true;
                //m_DepthOfField.Prepare(src, uberMaterial, false, Vector2.zero, 0);
            }

            if(m_RadialBlur.active && !m_RenderingInSceneView)
            {
                uberActive = true;
                m_RadialBlur.Prepare(src, uberMaterial);
            }

            if(m_WaterWave.active && !m_RenderingInSceneView)
            {
                uberActive = true;
                m_WaterWave.Prepare(src, uberMaterial);
            }

            if (m_Bloom.active)
            {
                uberActive = true;
                m_Bloom.Prepare(src, uberMaterial);
            }

            //uberActive |= TryPrepareUberImageEffect(m_ColorGrading, uberMaterial);
            //uberActive |= TryPrepareUberImageEffect(m_Vignette, uberMaterial);
            //uberActive |= TryPrepareUberImageEffect(m_UserLut, uberMaterial);

            var fxaaMaterial = fxaaActive
                ? m_MaterialFactory.Get("Hidden/Post FX/FXAA")
                : null;

            if (fxaaActive)
            {
                fxaaMaterial.shaderKeywords = null;

                if (uberActive)
                {
                    var output = m_RenderTextureFactory.Get(src);
                    Graphics.Blit(src, output, uberMaterial, 0);
                    src = output;
                }

                //m_Fxaa.Render(src, dst);
            }
            else
            {
                if (uberActive)
                {
                    if (!GraphicsUtils.isLinearColorSpace)
                        uberMaterial.EnableKeyword("UNITY_COLORSPACE_GAMMA");

                    Graphics.Blit(src, dst, uberMaterial, 0);
                }
            }

            if (!uberActive && !fxaaActive)
                Graphics.Blit(src, dst);

#if UNITY_EDITOR
            if (profile.monitors.onFrameEndEditorOnly != null)
            {
                Graphics.Blit(dst, destination);

                var oldRt = RenderTexture.active;
                profile.monitors.onFrameEndEditorOnly(dst);
                RenderTexture.active = oldRt;
            }
#endif

            m_RenderTextureFactory.ReleaseAll();
        }

        void OnGUI()
        {
            if (Event.current.type != EventType.Repaint)
                return;

            if (profile == null || m_Camera == null)
                return;

            else if (m_ColorGrading.active && profile.debugViews.IsModeActive(DebugMode.LogLut))
                m_ColorGrading.OnGUI();
            //else if (m_UserLut.active && profile.debugViews.IsModeActive(DebugMode.UserLut))
            //    m_UserLut.OnGUI();
        }

        void OnDisable()
        {
            // Clear command buffers
            foreach (var cb in m_CommandBuffers.Values)
            {
                m_Camera.RemoveCommandBuffer(cb.Key, cb.Value);
                cb.Value.Dispose();
            }

            m_CommandBuffers.Clear();

            // Clear components
            if (profile != null)
                DisableComponents();

            m_Components.Clear();

            // Factories
            m_MaterialFactory.Dispose();
            m_RenderTextureFactory.Dispose();
            GraphicsUtils.Dispose();
        }

        public void SetBloomActive(bool active)
        {
            enabled = false;

            if (profile != null)
            {
                profile.bloom.enabled = active;
                CheckDisableBehavior();
            }
        }

        public bool IsBloomActive()
        {
            if (profile == null)
            {
                return false;
            }
            return profile.bloom.enabled;
        }

        public void SetBloomIntensity(float intensity)
        {
            if (m_Bloom != null && m_Bloom.model != null)
            {
                BloomModel.Settings settings = m_Bloom.model.settings;
                settings.bloom.intensity = intensity;
                m_Bloom.model.settings = settings;
            }
        }

        public void SetRadialBlurActive(bool active)
        {
            enabled = false;

            if (profile != null)
            {
                profile.radialBlur.enabled = active;
                CheckDisableBehavior();
            }
        }

        public void SetWaterWaveActive(bool active)
        {
            enabled = false;

            if (profile != null)
            {
                profile.waterWave.enabled = active;
                CheckDisableBehavior();
            }
        }

        public void SetColorGradingActive(bool active)
        {
            enabled = false;

            if (profile != null)
            {
                profile.colorGrading.enabled = active;
                CheckDisableBehavior();
            }
        }

        public void CheckDisableBehavior()
        {
            if (profile.bloom.enabled)
            {
                enabled = true;
                return;
            }

            if (profile.colorGrading.enabled)
            {
                enabled = true;
                return;
            }

            if(profile.radialBlur.enabled)
            {
                enabled = true;
                return;
            }

            if(profile.waterWave.enabled)
            {
                enabled = true;
                return;
            }

            if(profile.colorGrading.enabled)
            {
                enabled = true;
                return;
            }

            enabled = false;
        }

        #region State management

        List<PostProcessingComponentBase> m_ComponentsToEnable = new List<PostProcessingComponentBase>();
        List<PostProcessingComponentBase> m_ComponentsToDisable = new List<PostProcessingComponentBase>();

        void CheckObservers()
        {
            foreach (var cs in m_ComponentStates)
            {
                var component = cs.Key;
                var state = component.GetModel().enabled;

                if (state != cs.Value)
                {
                    if (state) m_ComponentsToEnable.Add(component);
                    else m_ComponentsToDisable.Add(component);
                }
            }

            for (int i = 0; i < m_ComponentsToDisable.Count; i++)
            {
                var c = m_ComponentsToDisable[i];
                m_ComponentStates[c] = false;
                c.OnDisable();
            }

            for (int i = 0; i < m_ComponentsToEnable.Count; i++)
            {
                var c = m_ComponentsToEnable[i];
                m_ComponentStates[c] = true;
                c.OnEnable();
            }

            m_ComponentsToDisable.Clear();
            m_ComponentsToEnable.Clear();
        }

        void DisableComponents()
        {
            foreach (var component in m_Components)
            {
                var model = component.GetModel();
                if (model != null && model.enabled)
                    component.OnDisable();
            }
        }

        #endregion

        #region Command buffer handling & rendering helpers
        // Placeholders before the upcoming Scriptable Render Loop as command buffers will be
        // executed on the go so we won't need of all that stuff
        CommandBuffer AddCommandBuffer<T>(CameraEvent evt, string name)
            where T : PostProcessingModel
        {
            var cb = new CommandBuffer { name = name };
            var kvp = new KeyValuePair<CameraEvent, CommandBuffer>(evt, cb);
            m_CommandBuffers.Add(typeof(T), kvp);
            m_Camera.AddCommandBuffer(evt, kvp.Value);
            return kvp.Value;
        }

        void RemoveCommandBuffer<T>()
            where T : PostProcessingModel
        {
            KeyValuePair<CameraEvent, CommandBuffer> kvp;
            var type = typeof(T);

            if (!m_CommandBuffers.TryGetValue(type, out kvp))
                return;

            m_Camera.RemoveCommandBuffer(kvp.Key, kvp.Value);
            m_CommandBuffers.Remove(type);
            kvp.Value.Dispose();
        }

        CommandBuffer GetCommandBuffer<T>(CameraEvent evt, string name)
            where T : PostProcessingModel
        {
            CommandBuffer cb;
            KeyValuePair<CameraEvent, CommandBuffer> kvp;

            if (!m_CommandBuffers.TryGetValue(typeof(T), out kvp))
            {
                cb = AddCommandBuffer<T>(evt, name);
            }
            else if (kvp.Key != evt)
            {
                RemoveCommandBuffer<T>();
                cb = AddCommandBuffer<T>(evt, name);
            }
            else cb = kvp.Value;

            return cb;
        }

        void TryExecuteCommandBuffer<T>(PostProcessingComponentCommandBuffer<T> component)
            where T : PostProcessingModel
        {
            if (component.active)
            {
                var cb = GetCommandBuffer<T>(component.GetCameraEvent(), component.GetName());
                cb.Clear();
                component.PopulateCommandBuffer(cb);
            }
            else RemoveCommandBuffer<T>();
        }

        bool TryPrepareUberImageEffect<T>(PostProcessingComponentRenderTexture<T> component, Material material)
            where T : PostProcessingModel
        {
            if (!component.active)
                return false;

            component.Prepare(material);
            return true;
        }

        T AddComponent<T>(T component)
            where T : PostProcessingComponentBase
        {
            m_Components.Add(component);
            return component;
        }

        #endregion
    }
}
