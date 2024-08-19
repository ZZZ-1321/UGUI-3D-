Shader "IXS_UI/ForLinearUI"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
    }

    CGINCLUDE

        #include "UnityCG.cginc" 

		struct VInput
		{		
			float4 vertex : POSITION;
			float2 uv : TEXCOORD0;
		};

        struct VOutput
        {
            float2 uv : TEXCOORD0;
            float4 vertex : SV_POSITION;
        };

		sampler2D _MainTex;
		half4 _MainTex_ST;

		float2 _MainTex_TexelSize;

		VOutput VertFinal(VInput v)
        {
			VOutput o;
            o.vertex = UnityObjectToClipPos(v.vertex);
            o.uv = UnityStereoScreenSpaceUVAdjust(v.uv, _MainTex_ST);
            return o;
        }

        half4 FragFinal(VOutput i) : SV_Target
        {
            half4 col = tex2D(_MainTex, i.uv);
			col.rgb = GammaToLinearSpace(col.rgb);
            return col;
        }

		VOutput VertCopyScene(VInput v)
		{
			VOutput o;

			o.vertex = UnityObjectToClipPos(v.vertex);
			o.uv = UnityStereoScreenSpaceUVAdjust(v.uv, _MainTex_ST);

			o.uv.y = 1.0 - o.uv.y;

#if UNITY_UV_STARTS_AT_TOP
			if (_MainTex_TexelSize.y < 0.0)
			{
				o.uv.y = 1.0 - o.uv.y;
			}				
#endif
			return o;
		}

		half4 FragCopyScene(VOutput i) : SV_Target
		{
			half4 col = tex2D(_MainTex, i.uv);
			//col.rgb = GammaToLinearSpace(col.rgb);
			return col;
		}

    ENDCG

    SubShader
    {
	
        Cull Off
		ZWrite Off
		ZTest Always
		Blend One Zero

		// final copy to frame buffer
        Pass
        {
            CGPROGRAM

			#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore

            #pragma vertex VertFinal
            #pragma fragment FragFinal

            ENDCG
        }

		// copy scene pass
		Pass
		{
			CGPROGRAM

			#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore

			#pragma vertex VertCopyScene
			#pragma fragment FragCopyScene

			ENDCG
		}
    }
}
