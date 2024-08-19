// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:33325,y:33002,varname:node_4013,prsc:2|emission-8309-OUT;n:type:ShaderForge.SFN_Color,id:1304,x:32312,y:32734,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1304,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:9763,x:32312,y:32887,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_9763,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4921-OUT;n:type:ShaderForge.SFN_Tex2d,id:4420,x:31637,y:32942,ptovrint:False,ptlb:NiuQu,ptin:_NiuQu,varname:node_4420,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ValueProperty,id:4513,x:32312,y:33079,ptovrint:False,ptlb:Value,ptin:_Value,varname:node_4513,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_Multiply,id:3793,x:32604,y:32976,varname:node_3793,prsc:2|A-1304-RGB,B-9763-RGB,C-4513-OUT,D-1153-RGB,E-1153-A;n:type:ShaderForge.SFN_Multiply,id:2987,x:31901,y:32906,varname:node_2987,prsc:2|A-4420-R,B-479-OUT;n:type:ShaderForge.SFN_TexCoord,id:3307,x:31637,y:32641,varname:node_3307,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:4921,x:32116,y:32887,varname:node_4921,prsc:2|A-9597-OUT,B-2987-OUT;n:type:ShaderForge.SFN_Slider,id:479,x:31480,y:33125,ptovrint:False,ptlb:NiuQu Max,ptin:_NiuQuMax,varname:node_479,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Add,id:9597,x:31901,y:32773,varname:node_9597,prsc:2|A-3307-UVOUT,B-6736-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2189,x:31134,y:32811,ptovrint:False,ptlb:U,ptin:_U,varname:node_2189,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:9346,x:31134,y:32881,ptovrint:False,ptlb:V,ptin:_V,varname:node_9346,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:1628,x:31335,y:32811,varname:node_1628,prsc:2|A-2189-OUT,B-9346-OUT;n:type:ShaderForge.SFN_Time,id:9465,x:31345,y:32678,varname:node_9465,prsc:2;n:type:ShaderForge.SFN_Multiply,id:6736,x:31637,y:32792,varname:node_6736,prsc:2|A-9465-T,B-1628-OUT;n:type:ShaderForge.SFN_Tex2d,id:6805,x:32312,y:33285,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_6805,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:5947,x:32814,y:32976,varname:node_5947,prsc:2|A-3793-OUT,B-6805-RGB;n:type:ShaderForge.SFN_VertexColor,id:1153,x:32312,y:33139,varname:node_1153,prsc:2;n:type:ShaderForge.SFN_Add,id:8309,x:33103,y:33101,varname:node_8309,prsc:2|A-5947-OUT,B-3068-OUT;n:type:ShaderForge.SFN_Color,id:2694,x:32307,y:33554,ptovrint:False,ptlb:Color_2,ptin:_Color_2,varname:_Color_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:3284,x:32307,y:33707,ptovrint:False,ptlb:Texture_2,ptin:_Texture_2,varname:_Texture_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9261-OUT;n:type:ShaderForge.SFN_Tex2d,id:1678,x:31632,y:33762,ptovrint:False,ptlb:NiuQu_2,ptin:_NiuQu_2,varname:_NiuQu_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ValueProperty,id:4049,x:32307,y:33899,ptovrint:False,ptlb:Value_2,ptin:_Value_2,varname:_Value_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_Multiply,id:9501,x:32599,y:33796,varname:node_9501,prsc:2|A-2694-RGB,B-3284-RGB,C-4049-OUT,D-8971-RGB,E-8971-A;n:type:ShaderForge.SFN_Multiply,id:6451,x:31896,y:33726,varname:node_6451,prsc:2|A-1678-R,B-4864-OUT;n:type:ShaderForge.SFN_TexCoord,id:4196,x:31632,y:33461,varname:node_4196,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:9261,x:32111,y:33707,varname:node_9261,prsc:2|A-2074-OUT,B-6451-OUT;n:type:ShaderForge.SFN_Slider,id:4864,x:31475,y:33945,ptovrint:False,ptlb:NiuQu Max_2,ptin:_NiuQuMax_2,varname:_NiuQuMax_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Add,id:2074,x:31896,y:33593,varname:node_2074,prsc:2|A-4196-UVOUT,B-8527-OUT;n:type:ShaderForge.SFN_ValueProperty,id:158,x:31129,y:33631,ptovrint:False,ptlb:U_2,ptin:_U_2,varname:_U_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:3272,x:31129,y:33701,ptovrint:False,ptlb:V_2,ptin:_V_2,varname:_V_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:7255,x:31330,y:33631,varname:node_7255,prsc:2|A-158-OUT,B-3272-OUT;n:type:ShaderForge.SFN_Time,id:4037,x:31340,y:33498,varname:node_4037,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8527,x:31632,y:33612,varname:node_8527,prsc:2|A-4037-T,B-7255-OUT;n:type:ShaderForge.SFN_Tex2d,id:5387,x:32307,y:34105,ptovrint:False,ptlb:Mask_2,ptin:_Mask_2,varname:_Mask_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:3068,x:32809,y:33796,varname:node_3068,prsc:2|A-9501-OUT,B-5387-RGB;n:type:ShaderForge.SFN_VertexColor,id:8971,x:32307,y:33959,varname:node_8971,prsc:2;proporder:9763-1304-4513-4420-479-6805-2189-9346-3284-2694-4049-1678-4864-5387-158-3272;pass:END;sub:END;*/

Shader "IXS_Effect/B_MaskAdd2" 
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
        _Texture_2 ("Texture_2", 2D) = "white" {}
        _Color_2 ("Color_2", Color) = (1,1,1,1)
        _Value_2 ("Value_2", Float ) = 2
        _NiuQu_2 ("NiuQu_2", 2D) = "white" {}
        _NiuQuMax_2 ("NiuQu Max_2", Range(0, 10)) = 1
        _Mask_2 ("Mask_2", 2D) = "white" {}
        _U_2 ("U_2", Float ) = 0
        _V_2 ("V_2", Float ) = 0

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
			Lighting Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE

            #include "UnityCG.cginc"

            uniform float4 _Color;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform sampler2D _NiuQu; uniform float4 _NiuQu_ST;
            uniform float _Value;
            uniform float _NiuQuMax;
            uniform float _U;
            uniform float _V;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float4 _Color_2;
            uniform sampler2D _Texture_2; uniform float4 _Texture_2_ST;
            uniform sampler2D _NiuQu_2; uniform float4 _NiuQu_2_ST;
            uniform float _Value_2;
            uniform float _NiuQuMax_2;
            uniform float _U_2;
            uniform float _V_2;
            uniform sampler2D _Mask_2; uniform float4 _Mask_2_ST;

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
                //float4 node_9465 = _Time;
                float4 _NiuQu_var = tex2D(_NiuQu,TRANSFORM_TEX(i.uv0, _NiuQu));
                float2 node_4921 = ((i.uv0 + (_Time.g * float2(_U, _V))) + (_NiuQu_var.r * _NiuQuMax));
                float4 _Texture_var = tex2D(_Texture, TRANSFORM_TEX(node_4921, _Texture));
                float4 _Mask_var = tex2D(_Mask, TRANSFORM_TEX(i.uv0, _Mask));
                //float4 node_4037 = _Time;
                float4 _NiuQu_2_var = tex2D(_NiuQu_2, TRANSFORM_TEX(i.uv0, _NiuQu_2));
                float2 node_9261 = ((i.uv0 + (_Time.g * float2(_U_2, _V_2))) + (_NiuQu_2_var.r * _NiuQuMax_2));
                float4 _Texture_2_var = tex2D(_Texture_2, TRANSFORM_TEX(node_9261, _Texture_2));
                float4 _Mask_2_var = tex2D(_Mask_2, TRANSFORM_TEX(i.uv0, _Mask_2));
				float3 vectexC = i.vertexColor.rgb * i.vertexColor.a;
                float3 emissive = (((_Color.rgb * _Texture_var.rgb * _Value * vectexC) * _Mask_var.rgb) + ((_Color_2.rgb * _Texture_2_var.rgb * _Value_2 * vectexC) * _Mask_2_var.rgb));
                //float3 finalColor = emissive;
                return fixed4(emissive,1);
            }
            ENDCG
        }
    }

    FallBack Off    
}
