Shader "Hidden/Post FX/Depth Of Field"
{
    Properties
    {
        _MainTex ("", 2D) = "black"
    }

    CGINCLUDE
        #pragma exclude_renderers d3d11_9x
    ENDCG

    // SubShader with SM 5.0 support
    // Gather intrinsics are used to reduce texture sample count.
    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        Pass // 0
        {
            Name "CoC Calculation"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragCoC
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 1
        {
            Name "CoC Temporal Filter"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 5.0
                #pragma vertex VertDOF
                #pragma fragment FragTempFilter
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 2
        {
            Name "Downsample and Prefilter"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 5.0
                #pragma vertex VertDOF
                #pragma fragment FragPrefilter
                #pragma multi_compile __ UNITY_COLORSPACE_GAMMA
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 3
        {
            Name "Bokeh Filter (small)"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragBlur
                #define KERNEL_SMALL
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 4
        {
            Name "Bokeh Filter (medium)"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragBlur
                #define KERNEL_MEDIUM
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 5
        {
            Name "Bokeh Filter (large)"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragBlur
                #define KERNEL_LARGE
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 6
        {
            Name "Bokeh Filter (very large)"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragBlur
                #define KERNEL_VERYLARGE
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 7
        {
            Name "Postfilter"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragPostBlur
                #include "DepthOfField.cginc"
            ENDCG
        }
    }

    // Fallback SubShader with SM 3.0
    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        Pass // 0
        {
            Name "CoC Calculation"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragCoC
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 1
        {
            Name "CoC Temporal Filter"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragTempFilter
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 2
        {
            Name "Downsample and Prefilter"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragPrefilter
                #pragma multi_compile __ UNITY_COLORSPACE_GAMMA
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 3
        {
            Name "Bokeh Filter (small)"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragBlur
                #define KERNEL_SMALL
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 4
        {
            Name "Bokeh Filter (medium)"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragBlur
                #define KERNEL_MEDIUM
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 5
        {
            Name "Bokeh Filter (large)"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragBlur
                #define KERNEL_LARGE
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 6
        {
            Name "Bokeh Filter (very large)"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragBlur
                #define KERNEL_VERYLARGE
                #include "DepthOfField.cginc"
            ENDCG
        }

        Pass // 7
        {
            Name "Postfilter"
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore
                #pragma target 3.0
                #pragma vertex VertDOF
                #pragma fragment FragPostBlur
                #include "DepthOfField.cginc"
            ENDCG
        }
    }

    FallBack Off
}
