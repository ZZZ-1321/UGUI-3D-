// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Post FX/Radial Blur" 
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_RadialBlur_SampleDist ("Sample Distance", Range(0.0, 1.0)) = 0.2
	}
	
	SubShader
    {
        Pass
        {
            ZTest Always Cull Off ZWrite Off
           
            CGPROGRAM
				#pragma only_renderers gles d3d9 d3d11 gles3 metal glcore

                #pragma vertex vert
                #pragma fragment frag
               
                #include "UnityCG.cginc"
              
                uniform sampler2D _MainTex;
                uniform float4 _MainTex_ST;
               
                float _RadialBlur_SampleDist;
               
                struct v2f
                {
                    float4 pos : SV_POSITION;
                    float2 mainTexcoord : TEXCOORD0;
                };

                v2f vert(appdata_base v)
                {
                    v2f o;
                   
                    o.pos = UnityObjectToClipPos (v.vertex);
                    o.mainTexcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                   
                    return o;
                }
                
                half4 frag(v2f inFrag) : COLOR
                {   
			        half2 dir = half2(0.5,0.5) - inFrag.mainTexcoord.xy;
			        
			 		half dist = length(dir); 
					dir /= dist; 
				
					const half PreWeights[10] = 
					{
					   -0.21,-0.13,-0.08,-0.03,-0.01,0.01,0.03,0.08,0.13,0.21
					};
				
					half4 sum = half4(0, 0, 0, 0);
					
					for (int i = 0; i < 10; ++i)  
					{  
						sum += tex2D(_MainTex, inFrag.mainTexcoord.xy + dir * PreWeights[i] * _RadialBlur_SampleDist); 
					}
					
					sum *= 0.1; 

					return sum;
                }
                
            ENDCG
        }
    }
    
	FallBack "SGame/Scene/SimpleTexture"
}