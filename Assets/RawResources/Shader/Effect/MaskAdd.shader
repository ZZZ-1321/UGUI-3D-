// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:32998,y:32895,varname:node_4013,prsc:2|emission-5947-OUT;n:type:ShaderForge.SFN_Color,id:1304,x:32302,y:32752,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1304,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:9763,x:32302,y:32905,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_9763,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4921-OUT;n:type:ShaderForge.SFN_Tex2d,id:4420,x:31627,y:32960,ptovrint:False,ptlb:NiuQu,ptin:_NiuQu,varname:node_4420,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ValueProperty,id:4513,x:32302,y:33097,ptovrint:False,ptlb:Value,ptin:_Value,varname:node_4513,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_Multiply,id:3793,x:32594,y:32994,varname:node_3793,prsc:2|A-1304-RGB,B-9763-RGB,C-4513-OUT,D-1153-RGB,E-1153-A;n:type:ShaderForge.SFN_Multiply,id:2987,x:31891,y:32924,varname:node_2987,prsc:2|A-4420-R,B-479-OUT;n:type:ShaderForge.SFN_TexCoord,id:3307,x:31627,y:32659,varname:node_3307,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:4921,x:32106,y:32905,varname:node_4921,prsc:2|A-9597-OUT,B-2987-OUT;n:type:ShaderForge.SFN_Slider,id:479,x:31470,y:33143,ptovrint:False,ptlb:NiuQu Max,ptin:_NiuQuMax,varname:node_479,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Add,id:9597,x:31891,y:32791,varname:node_9597,prsc:2|A-3307-UVOUT,B-6736-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2189,x:31124,y:32829,ptovrint:False,ptlb:U,ptin:_U,varname:node_2189,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:9346,x:31124,y:32899,ptovrint:False,ptlb:V,ptin:_V,varname:node_9346,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:1628,x:31325,y:32829,varname:node_1628,prsc:2|A-2189-OUT,B-9346-OUT;n:type:ShaderForge.SFN_Time,id:9465,x:31335,y:32696,varname:node_9465,prsc:2;n:type:ShaderForge.SFN_Multiply,id:6736,x:31627,y:32810,varname:node_6736,prsc:2|A-9465-T,B-1628-OUT;n:type:ShaderForge.SFN_Tex2d,id:6805,x:32302,y:33303,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_6805,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:5947,x:32804,y:32994,varname:node_5947,prsc:2|A-3793-OUT,B-6805-RGB;n:type:ShaderForge.SFN_VertexColor,id:1153,x:32302,y:33157,varname:node_1153,prsc:2;proporder:9763-1304-4513-4420-479-6805-2189-9346;pass:END;sub:END;*/

Shader "IXS_Effect/B_MaskAdd" 
{
    Properties 
	{
        _Texture ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _Value ("Value", Float ) = 2
        _NiuQu ("NiuQu", 2D) = "white" {}
        _NiuQuMax ("NiuQu Max", Range(0, 10)) = 1
        _Mask ("Mask", 2D) = "white" {}
        _U ("U", Float ) = 0
        _V ("V", Float ) = 0

		[Enum(UnityEngine.Rendering.BlendMode)] _AlphaChannelSrcBlend("Alpha Channel Src Blend Mode", Float) = 3
		[Enum(UnityEngine.Rendering.BlendMode)] _AlphaChannelDestDestBlend("Alpha Channel Dest Blend Mode", Float) = 6
    }
    SubShader
		{
        Tags
		{
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }

        Pass 
		{
            Blend One One,[_AlphaChannelSrcBlend][_AlphaChannelDestDestBlend]
            Cull Off
            ZWrite Off
			ZTest LEqual
			Lighting Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            //#pragma multi_compile_fwdbase
            //#pragma only_renderers d3d9 d3d11 glcore gles 
            //#pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _Texture; 
			uniform float4 _Texture_ST;
            uniform sampler2D _NiuQu; 
			uniform float4 _NiuQu_ST;
            uniform float _Value;
            uniform float _NiuQuMax;
            uniform float _U;
            uniform float _V;
            uniform sampler2D _Mask; 
			uniform float4 _Mask_ST;

            struct VertexInput 
			{
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput
			{
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
				float2 NiuQu_UV : TEXCOORD1;
				float2 Mask_UV : TEXCOORD2;
                float4 vertexColor : COLOR;
            };

            VertexOutput vert (VertexInput v)
			{
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
				o.NiuQu_UV = TRANSFORM_TEX(v.texcoord0, _NiuQu);
				o.Mask_UV = TRANSFORM_TEX(v.texcoord0, _Mask);
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }

            float4 frag(VertexOutput i, float facing : VFACE) : COLOR 
			{
                //float isFrontFace = ( facing >= 0 ? 1 : 0 );
				//float isFrontFace = step(0, facing);
                //float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                //float4 node_9465 = _Time;
                //float4 _NiuQu_var = tex2D(_NiuQu,TRANSFORM_TEX(i.uv0, _NiuQu));
				fixed4 _NiuQu_var = tex2D(_NiuQu, i.NiuQu_UV);
                float2 node_4921 = ((i.uv0+(_Time.g*float2(_U,_V)))+(_NiuQu_var.r*_NiuQuMax));
                fixed4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(node_4921, _Texture));
                //float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(i.uv0, _Mask));
				fixed4 _Mask_var = tex2D(_Mask, i.Mask_UV);				
                fixed3 emissive = ((_Color.rgb*_Texture_var.rgb*_Value*i.vertexColor.rgb*i.vertexColor.a)*_Mask_var.rgb);
                //float3 finalColor = emissive;
                return fixed4(emissive,1);
				//return fixed4(1.0, 0.0, 0.0, 1.0);
            }
            ENDCG
        }        
    }

    FallBack Off
}
