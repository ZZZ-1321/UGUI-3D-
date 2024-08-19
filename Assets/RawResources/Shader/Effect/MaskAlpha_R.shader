// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:32921,y:32791,varname:node_4013,prsc:2|emission-3017-OUT,alpha-7230-OUT;n:type:ShaderForge.SFN_Color,id:1304,x:32302,y:32752,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1304,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:9763,x:32302,y:32905,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_9763,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4921-OUT;n:type:ShaderForge.SFN_Tex2d,id:4420,x:31627,y:32960,ptovrint:False,ptlb:NiuQu,ptin:_NiuQu,varname:node_4420,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-1047-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4513,x:32302,y:33086,ptovrint:False,ptlb:Value,ptin:_Value,varname:node_4513,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_Multiply,id:3793,x:32565,y:32889,varname:node_3793,prsc:2|A-1304-RGB,B-9763-RGB,C-4513-OUT,D-1153-RGB,E-1153-A;n:type:ShaderForge.SFN_Multiply,id:2987,x:31891,y:32924,varname:node_2987,prsc:2|A-4420-R,B-479-OUT;n:type:ShaderForge.SFN_TexCoord,id:3307,x:31627,y:32659,varname:node_3307,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:4921,x:32106,y:32905,varname:node_4921,prsc:2|A-9597-OUT,B-2987-OUT;n:type:ShaderForge.SFN_Slider,id:479,x:31470,y:33143,ptovrint:False,ptlb:NiuQu Max,ptin:_NiuQuMax,varname:node_479,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Add,id:9597,x:31891,y:32791,varname:node_9597,prsc:2|A-3307-UVOUT,B-6736-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2189,x:31124,y:32829,ptovrint:False,ptlb:U,ptin:_U,varname:node_2189,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:9346,x:31124,y:32899,ptovrint:False,ptlb:V,ptin:_V,varname:node_9346,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:1628,x:31325,y:32829,varname:node_1628,prsc:2|A-2189-OUT,B-9346-OUT;n:type:ShaderForge.SFN_Time,id:9465,x:31335,y:32696,varname:node_9465,prsc:2;n:type:ShaderForge.SFN_Multiply,id:6736,x:31627,y:32810,varname:node_6736,prsc:2|A-9465-T,B-1628-OUT;n:type:ShaderForge.SFN_VertexColor,id:1153,x:32302,y:33157,varname:node_1153,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7230,x:32606,y:33044,varname:node_7230,prsc:2|A-9763-A,B-1153-A,C-4513-OUT,D-4928-A,E-4928-R;n:type:ShaderForge.SFN_Multiply,id:3017,x:32724,y:32726,varname:node_3017,prsc:2|A-4928-RGB,B-3793-OUT;n:type:ShaderForge.SFN_Tex2d,id:4928,x:32372,y:32551,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_4928,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:1293,x:30943,y:33014,varname:node_1293,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:1047,x:31207,y:33146,varname:node_1047,prsc:2|A-1293-UVOUT,B-1190-OUT;n:type:ShaderForge.SFN_ValueProperty,id:517,x:30440,y:33184,ptovrint:False,ptlb:N_U,ptin:_N_U,varname:_U_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:6822,x:30440,y:33254,ptovrint:False,ptlb:N_V,ptin:_N_V,varname:_V_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:3513,x:30641,y:33184,varname:node_3513,prsc:2|A-517-OUT,B-6822-OUT;n:type:ShaderForge.SFN_Time,id:2938,x:30651,y:33051,varname:node_2938,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1190,x:30943,y:33165,varname:node_1190,prsc:2|A-2938-T,B-3513-OUT;proporder:9763-1304-4513-2189-9346-4420-479-517-6822-4928;pass:END;sub:END;*/

Shader "IXS_Effect/B_MaskAlpha_R"
{
    Properties
	{
        _Texture ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _Value ("Value", Float ) = 2
        _U ("U", Float ) = 0
        _V ("V", Float ) = 0
        _NiuQu ("NiuQu", 2D) = "white" {}
        _NiuQuMax ("NiuQu Max", Range(0, 10)) = 1
        _N_U ("N_U", Float ) = 0
        _N_V ("N_V", Float ) = 0
        _Mask ("Mask", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5

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
            Blend SrcAlpha OneMinusSrcAlpha,[_AlphaChannelSrcBlend][_AlphaChannelDestDestBlend]
            Cull Off
            ZWrite Off
			Lighting Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            
            uniform float4 _Color;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform sampler2D _NiuQu; uniform float4 _NiuQu_ST;
            uniform float _Value;
            uniform float _NiuQuMax;
            uniform float _U;
            uniform float _V;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float _N_U;
            uniform float _N_V;

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
                float4 vertexColor : COLOR;
            };

            VertexOutput vert (VertexInput v)
			{
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }

            float4 frag(VertexOutput i) : COLOR
			{                
                float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(i.uv0, _Mask));
                //float4 node_9465 = _Time;
                //float4 node_2938 = _Time;
                float2 node_1047 = (i.uv0+(_Time.g*float2(_N_U,_N_V)));
                float4 _NiuQu_var = tex2D(_NiuQu,TRANSFORM_TEX(node_1047, _NiuQu));
                float2 node_4921 = ((i.uv0+(_Time.g*float2(_U,_V)))+(_NiuQu_var.r*_NiuQuMax));
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(node_4921, _Texture));
                float3 emissive = (_Mask_var.rgb*(_Color.rgb*_Texture_var.rgb*_Value*i.vertexColor.rgb*i.vertexColor.a));
                //float3 finalColor = emissive;
                return fixed4(emissive,(_Texture_var.a*i.vertexColor.a*_Value*_Mask_var.a*_Mask_var.r));
            }
            ENDCG
        }        
    }

    FallBack Off
}