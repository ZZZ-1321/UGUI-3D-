// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:False,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.8088235,fgcg:0.7824097,fgcb:0.6720372,fgca:1,fgde:0.005,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33993,y:32452,varname:node_3138,prsc:2|emission-9545-OUT;n:type:ShaderForge.SFN_Tex2d,id:7833,x:32893,y:32434,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-2623-OUT;n:type:ShaderForge.SFN_TexCoord,id:8076,x:32500,y:32455,varname:node_8076,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2d,id:9985,x:33082,y:32742,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:_MaskTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-2745-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:2745,x:32895,y:32742,varname:node_2745,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:1266,x:33469,y:32573,varname:node_1266,prsc:2|A-7833-A,B-9985-R,C-1550-A,D-7552-A;n:type:ShaderForge.SFN_Multiply,id:4525,x:33469,y:32399,varname:node_4525,prsc:2|A-9434-OUT,B-1550-RGB,C-6642-OUT,D-7552-RGB,E-9985-RGB;n:type:ShaderForge.SFN_VertexColor,id:7552,x:33082,y:32557,varname:node_7552,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:9434,x:33082,y:32207,ptovrint:False,ptlb:Value,ptin:_Value,varname:_MainTexBrightness,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Tex2d,id:3488,x:32275,y:32793,ptovrint:False,ptlb:NiuQu_RongJie,ptin:_NiuQu_RongJie,varname:_NormalTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:False|UVIN-1145-OUT;n:type:ShaderForge.SFN_Multiply,id:6613,x:32500,y:32737,varname:node_6613,prsc:2|A-301-W,B-3488-R;n:type:ShaderForge.SFN_TexCoord,id:775,x:31855,y:32663,varname:node_775,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:232,x:31855,y:32816,varname:node_232,prsc:2|A-6886-OUT,B-7882-T;n:type:ShaderForge.SFN_Time,id:7882,x:31575,y:32816,varname:node_7882,prsc:2;n:type:ShaderForge.SFN_Append,id:6886,x:31575,y:32666,varname:node_6886,prsc:2|A-2727-OUT,B-8873-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2727,x:31331,y:32616,ptovrint:False,ptlb:X,ptin:_X,varname:_NormalTexPannerX,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:8873,x:31331,y:32687,ptovrint:False,ptlb:Y,ptin:_Y,varname:_NormalTexPannerY,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Add,id:1145,x:32072,y:32793,varname:node_1145,prsc:2|A-775-UVOUT,B-232-OUT;n:type:ShaderForge.SFN_TexCoord,id:301,x:32275,y:32575,varname:node_301,prsc:2,uv:1,uaff:True;n:type:ShaderForge.SFN_Color,id:1550,x:33082,y:32291,ptovrint:False,ptlb:Main Color,ptin:_MainColor,varname:node_1550,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Append,id:9450,x:32500,y:32596,varname:node_9450,prsc:2|A-301-U,B-301-V;n:type:ShaderForge.SFN_Power,id:6642,x:33082,y:32434,varname:node_6642,prsc:2|VAL-7833-RGB,EXP-2723-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2723,x:32893,y:32613,ptovrint:False,ptlb:Cuve,ptin:_Cuve,varname:node_2723,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_TexCoord,id:9060,x:31617,y:32190,varname:node_9060,prsc:2,uv:2,uaff:True;n:type:ShaderForge.SFN_Append,id:5974,x:31812,y:32213,varname:node_5974,prsc:2|A-9060-U,B-9060-V;n:type:ShaderForge.SFN_TexCoord,id:4332,x:31812,y:32055,varname:node_4332,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:9631,x:32238,y:32163,varname:node_9631,prsc:2|A-4332-UVOUT,B-2357-OUT;n:type:ShaderForge.SFN_Vector1,id:6756,x:31812,y:32364,varname:node_6756,prsc:2,v1:-1;n:type:ShaderForge.SFN_Vector1,id:7451,x:31812,y:32428,varname:node_7451,prsc:2,v1:-0.5;n:type:ShaderForge.SFN_Multiply,id:3559,x:32238,y:32343,varname:node_3559,prsc:2|A-2357-OUT,B-7451-OUT;n:type:ShaderForge.SFN_Add,id:5916,x:32500,y:32327,varname:node_5916,prsc:2|A-9631-OUT,B-3559-OUT;n:type:ShaderForge.SFN_Add,id:2623,x:32714,y:32434,varname:node_2623,prsc:2|A-5916-OUT,B-8076-UVOUT,C-9450-OUT,D-6613-OUT;n:type:ShaderForge.SFN_Add,id:2357,x:32004,y:32213,varname:node_2357,prsc:2|A-5974-OUT,B-6756-OUT;n:type:ShaderForge.SFN_Add,id:8652,x:33240,y:33047,varname:node_8652,prsc:2|A-3488-R,B-1598-OUT;n:type:ShaderForge.SFN_Clamp01,id:7858,x:33453,y:33047,varname:node_7858,prsc:2|IN-8652-OUT;n:type:ShaderForge.SFN_Smoothstep,id:4145,x:33668,y:32924,varname:node_4145,prsc:2|A-6566-OUT,B-7767-OUT,V-7858-OUT;n:type:ShaderForge.SFN_Slider,id:7767,x:33327,y:32944,ptovrint:False,ptlb:Max,ptin:_Max,varname:node_7518,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Vector1,id:3208,x:32631,y:33227,varname:node_3208,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:1598,x:32909,y:33067,varname:node_1598,prsc:2|A-9850-OUT,B-3208-OUT;n:type:ShaderForge.SFN_Add,id:9850,x:32641,y:33074,varname:node_9850,prsc:2|A-301-Z,B-3155-OUT;n:type:ShaderForge.SFN_Vector1,id:3155,x:32402,y:33093,varname:node_3155,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:9545,x:33817,y:32553,varname:node_9545,prsc:2|A-4525-OUT,B-1266-OUT,C-4145-OUT;n:type:ShaderForge.SFN_Slider,id:6566,x:33327,y:32856,ptovrint:False,ptlb:Min,ptin:_Min,varname:node_6566,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;proporder:2723-7833-1550-9434-3488-2727-8873-9985-6566-7767;pass:END;sub:END;*/

Shader "IXS_Effect/B_RongJie_Add"
{
    Properties 
	{
        _Cuve ("Cuve", Float ) = 1
        _Texture ("Texture", 2D) = "white" {}
        _MainColor ("Main Color", Color) = (1,1,1,1)
        _Value ("Value", Float ) = 1
        _NiuQu_RongJie ("NiuQu_RongJie", 2D) = "bump" {}
        _X ("X", Float ) = 0
        _Y ("Y", Float ) = 0
        _Mask ("Mask", 2D) = "white" {}
        _Min ("Min", Range(0, 1)) = 0
        _Max ("Max", Range(0, 1)) = 0

		_ZOffset("Z Offset", Float) = 0

		[Toggle(_Z_OFFSET)] _EnableZOffset("Enable Z Offset", Float) = 0

		/*[Enum(UnityEngine.Rendering.BlendMode)] _SourceBlend("Source Blend Mode", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)] _DestBlend("Dest Blend Mode", Float) = 1		*/
		[Enum(UnityEngine.Rendering.BlendMode)] _AlphaChannelSrcBlend("Alpha Channel Src Blend Mode", Float) = 3
		[Enum(UnityEngine.Rendering.BlendMode)] _AlphaChannelDestDestBlend("Alpha Channel Dest Blend Mode", Float) = 6
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest", Float) = 4
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull Mode", Float) = 0

		_StencilRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilCompare("Stencil Compare", Float) = 0
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
			ZTest[_ZTest]
			Cull[_Cull]

			Stencil
			{
				Ref[_StencilRef]
				Comp[_StencilCompare]
			}

            Blend One One, [_AlphaChannelSrcBlend][_AlphaChannelDestDestBlend]
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

			#pragma multi_compile __ _Z_OFFSET

            #include "UnityCG.cginc"

            uniform sampler2D _Texture; 
			uniform float4 _Texture_ST;
            uniform sampler2D _Mask; 
			uniform float4 _Mask_ST;
            uniform float _Value;
            uniform sampler2D _NiuQu_RongJie; 
			uniform float4 _NiuQu_RongJie_ST;
            uniform float _X;
            uniform float _Y;
            uniform float4 _MainColor;
            uniform float _Cuve;
            uniform float _Max;
            uniform float _Min;

            struct VertexInput 
			{
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
                float4 texcoord2 : TEXCOORD2;
                float4 vertexColor : COLOR;
            };

            struct VertexOutput 
			{
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 uv2 : TEXCOORD2;
                float4 vertexColor : COLOR;
            };

			float _ZOffset;

            VertexOutput vert (VertexInput v) 
			{
                VertexOutput o = (VertexOutput)0;

                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;

                //o.pos = UnityObjectToClipPos( v.vertex );
#if defined (_Z_OFFSET)
				float3 viewPos = UnityObjectToViewPos(v.vertex);
				viewPos.z -= _ZOffset;

				o.pos = mul(UNITY_MATRIX_P, float4(viewPos, 1.0));
#else

				o.pos = UnityObjectToClipPos(v.vertex);
#endif
                return o;
            }

            half4 frag(VertexOutput i/*, float facing : VFACE*/) : COLOR 
			{
                /*float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );*/
////// Lighting:
////// Emissive:
                float2 node_2357 = (float2(i.uv2.r,i.uv2.g)+(-1.0));
                //float4 node_7882 = _Time;
                float2 node_1145 = (i.uv0+(float2(_X,_Y)*_Time.g));
                half4 _NiuQu_RongJie_var = tex2D(_NiuQu_RongJie,TRANSFORM_TEX(node_1145, _NiuQu_RongJie));
                float2 node_2623 = (((i.uv0*node_2357)+(node_2357*(-0.5)))+i.uv0+float2(i.uv1.r,i.uv1.g)+(i.uv1.a*_NiuQu_RongJie_var.r));
                half4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(node_2623, _Texture));
                half4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(i.uv0, _Mask));
                half3 finalColor = ((_Value*_MainColor.rgb*pow(_Texture_var.rgb,_Cuve)*i.vertexColor.rgb*_Mask_var.rgb)*(_Texture_var.a*_Mask_var.r*_MainColor.a*i.vertexColor.a)*smoothstep( _Min, _Max, saturate((_NiuQu_RongJie_var.r+((i.uv1.b+(-1.0))*(-1.0)))) ));
                //float3 finalColor = emissive;
                return half4(finalColor,1);
            }
            ENDCG
        }        
    }

    FallBack "IXS_Effect/P_Additive"
    //CustomEditor "ShaderForgeMaterialInspector"
}
