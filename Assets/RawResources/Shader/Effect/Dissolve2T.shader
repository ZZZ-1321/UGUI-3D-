// Upgrade NOTE: replaced 'defined _NO_ALPHA_CHANNEL' with 'defined (_NO_ALPHA_CHANNEL)'

// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:33776,y:32888,varname:node_4013,prsc:2|emission-8019-OUT,clip-6381-OUT;n:type:ShaderForge.SFN_Tex2d,id:8139,x:31689,y:32944,ptovrint:False,ptlb:main_Tex(RGB),ptin:_main_TexRGB,varname:node_8139,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-6330-UVOUT;n:type:ShaderForge.SFN_Fresnel,id:8222,x:32522,y:32841,varname:node_8222,prsc:2|NRM-347-OUT,EXP-6438-OUT;n:type:ShaderForge.SFN_NormalVector,id:347,x:32172,y:32773,prsc:2,pt:False;n:type:ShaderForge.SFN_Multiply,id:5338,x:32795,y:32965,varname:node_5338,prsc:2|A-8139-RGB,B-8222-OUT,C-576-RGB,D-1100-OUT;n:type:ShaderForge.SFN_Slider,id:6438,x:32083,y:33003,ptovrint:False,ptlb:Falloff(Tex A),ptin:_FalloffTexA,varname:node_6438,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Slider,id:6573,x:31572,y:33374,ptovrint:False,ptlb:Disssolve Amout,ptin:_DisssolveAmout,varname:node_6573,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_TexCoord,id:6330,x:31516,y:32637,varname:node_6330,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Color,id:576,x:32472,y:33008,ptovrint:False,ptlb:_Color,ptin:__Color,varname:node_576,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.5,c3:0.3014705,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:1100,x:32472,y:33170,ptovrint:False,ptlb:Fall_Power,ptin:_Fall_Power,varname:node_1100,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_Tex2d,id:9338,x:32515,y:32590,ptovrint:False,ptlb:Emission,ptin:_Emission,varname:node_9338,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9542-OUT;n:type:ShaderForge.SFN_Power,id:2187,x:32841,y:32632,varname:node_2187,prsc:2|VAL-9338-RGB,EXP-9404-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9404,x:32522,y:32791,ptovrint:False,ptlb:Emission_Power,ptin:_Emission_Power,varname:node_9404,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:4346,x:33085,y:32612,varname:node_4346,prsc:2|A-9235-RGB,B-2187-OUT,C-6505-OUT;n:type:ShaderForge.SFN_Color,id:9235,x:32978,y:32356,ptovrint:False,ptlb:Emission_Color,ptin:_Emission_Color,varname:node_9235,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Add,id:8019,x:33407,y:32893,varname:node_8019,prsc:2|A-4181-OUT,B-5338-OUT,C-5129-OUT;n:type:ShaderForge.SFN_TexCoord,id:9847,x:31726,y:32384,varname:node_9847,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_SwitchProperty,id:2211,x:31969,y:32365,ptovrint:False,ptlb:uv2,ptin:_uv2,varname:node_2211,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-6330-UVOUT,B-9847-UVOUT;n:type:ShaderForge.SFN_OneMinus,id:3095,x:31905,y:33374,varname:node_3095,prsc:2|IN-6573-OUT;n:type:ShaderForge.SFN_RemapRange,id:4235,x:32080,y:33374,varname:node_4235,prsc:2,frmn:0,frmx:1,tomn:-0.6,tomx:0.6|IN-3095-OUT;n:type:ShaderForge.SFN_Add,id:6381,x:32364,y:33259,varname:node_6381,prsc:2|A-8139-A,B-4235-OUT;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:1293,x:32872,y:33371,varname:node_1293,prsc:2|IN-6381-OUT,IMIN-4453-OUT,IMAX-8251-OUT,OMIN-201-OUT,OMAX-6282-OUT;n:type:ShaderForge.SFN_Vector1,id:4453,x:32403,y:33378,varname:node_4453,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:8251,x:32403,y:33435,varname:node_8251,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:6282,x:32414,y:33627,ptovrint:False,ptlb:Size,ptin:_Size,varname:node_6282,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_Subtract,id:201,x:32586,y:33465,varname:node_201,prsc:2|A-4453-OUT,B-6282-OUT;n:type:ShaderForge.SFN_OneMinus,id:1308,x:32998,y:33486,varname:node_1308,prsc:2|IN-1293-OUT;n:type:ShaderForge.SFN_Color,id:7860,x:33033,y:33278,ptovrint:False,ptlb:Disssolve_Color,ptin:_Disssolve_Color,varname:node_7860,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:7445,x:33248,y:33348,varname:node_7445,prsc:2|A-7860-RGB,B-9077-OUT;n:type:ShaderForge.SFN_Clamp01,id:5129,x:33461,y:33348,varname:node_5129,prsc:2|IN-7445-OUT;n:type:ShaderForge.SFN_Tex2d,id:5481,x:32148,y:32386,ptovrint:False,ptlb:Distort_tex,ptin:_Distort_tex,varname:node_5481,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-2211-OUT;n:type:ShaderForge.SFN_Append,id:6883,x:32301,y:32416,varname:node_6883,prsc:2|A-5481-R,B-5481-G;n:type:ShaderForge.SFN_Lerp,id:5569,x:32515,y:32361,varname:node_5569,prsc:2|A-2211-OUT,B-6883-OUT,T-3339-OUT;n:type:ShaderForge.SFN_Slider,id:3339,x:32118,y:32656,ptovrint:False,ptlb:Distort,ptin:_Distort,varname:node_3339,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.260684,max:1;n:type:ShaderForge.SFN_Time,id:4090,x:32463,y:32219,varname:node_4090,prsc:2;n:type:ShaderForge.SFN_Multiply,id:9284,x:32685,y:32178,varname:node_9284,prsc:2|A-3194-OUT,B-4090-TSL;n:type:ShaderForge.SFN_ValueProperty,id:3194,x:32463,y:32152,ptovrint:False,ptlb:Distort_Speed,ptin:_Distort_Speed,varname:node_3194,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Add,id:9542,x:32752,y:32343,varname:node_9542,prsc:2|A-9284-OUT,B-5569-OUT;n:type:ShaderForge.SFN_Clamp01,id:4181,x:33256,y:32612,varname:node_4181,prsc:2|IN-4346-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6505,x:32828,y:32770,ptovrint:False,ptlb:Emission_Intencitt,ptin:_Emission_Intencitt,varname:node_6505,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Ceil,id:9077,x:33153,y:33520,varname:node_9077,prsc:2|IN-1308-OUT;proporder:8139-9338-5481-2211-576-9235-7860-6438-1100-9404-6505-6573-6282-3339-3194;pass:END;sub:END;*/

Shader "IXS_Effect/C_Dissolve2T" 
{
    Properties 
	{
        _main_TexRGB ("main_Tex(RGB)", 2D) = "white" {}
		_MaskTex("Mask Tex", 2D) = "white" {}
		_MaskChannelAdjust("Mask Channel Adjust", Vector) = (0.0, 0.0, 0.0, 0.0)
        _Emission ("Emission", 2D) = "white" {}
        _Distort_tex ("Distort_tex", 2D) = "white" {}
        //[MaterialToggle] _uv2 ("uv2", Float ) = 0
        __Color ("_Color", Color) = (0,0.5,0.3014705,1)
        _Emission_Color ("Emission_Color", Color) = (1,1,1,1)
        _Disssolve_Color ("Disssolve_Color", Color) = (0.5,0.5,0.5,1)
        _FalloffTexA ("Falloff(Tex A)", Range(0, 1)) = 1
        _Fall_Power ("Fall_Power", Float ) = 2
        _Emission_Power ("Emission_Power", Float ) = 1
        _Emission_Intencitt ("Emission_Intencitt", Float ) = 0
        _DisssolveAmout ("Disssolve Amout", Range(0, 1)) = 0
        _Size ("Size", Float ) = 2
        _Distort ("Distort", Range(0, 1)) = 0.260684
        _Distort_Speed ("Distort_Speed", Float ) = 1
        //[HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5

		[Toggle(_NO_ALPHA_CHANNEL)] _NoAlphaChannel("No Alpha Channel", Float) = 0

		//[Enum(UnityEngine.Rendering.BlendMode)] _SourceBlend("Source Blend Mode", Float) = 5
		//[Enum(UnityEngine.Rendering.BlendMode)] _DestBlend("Dest Blend Mode", Float) = 1		
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest", Float) = 4
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull Mode", Float) = 2

		_StencilRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilCompare("Stencil Compare", Float) = 0
    }

    SubShader 
	{
        Tags
		{
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
			"IgnoreProjector" = "True"
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

			Blend SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			ZWrite On
			Lighting Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

			#pragma multi_compile __ _NO_ALPHA_CHANNEL			
            
            #include "UnityCG.cginc"            

            uniform sampler2D _main_TexRGB; 
			uniform float4 _main_TexRGB_ST;
			uniform sampler2D _MaskTex;
            uniform float _FalloffTexA;
            uniform float _DisssolveAmout;
            uniform float4 __Color;
            uniform float _Fall_Power;
            uniform sampler2D _Emission; 
			uniform float4 _Emission_ST;
            uniform float _Emission_Power;
            uniform float4 _Emission_Color;
            //uniform fixed _uv2;
            uniform float _Size;
            uniform float4 _Disssolve_Color;
            uniform sampler2D _Distort_tex; 
			uniform float4 _Distort_tex_ST;
            uniform float _Distort;
            uniform float _Distort_Speed;
            uniform float _Emission_Intencitt;

            struct VertexInput 
			{
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                //float2 texcoord1 : TEXCOORD1;
            };

            struct VertexOutput 
			{
                float4 pos : SV_POSITION;
                half2 uv_main : TEXCOORD0;
				half2 uv_distort : TEXCOORD1;                
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
				//float2 uv0 : TEXCOORD4;
                //UNITY_FOG_COORDS(4)
            };

            VertexOutput vert (VertexInput v) 
			{
                VertexOutput o = (VertexOutput)0;
                o.uv_main = TRANSFORM_TEX(v.texcoord0, _main_TexRGB);
				o.uv_distort = TRANSFORM_TEX(v.texcoord0, _Distort_tex);
                //o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                //UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }

			uniform float4 _MaskChannelAdjust;

            half4 frag(VertexOutput i, float facing : VFACE) : COLOR 
			{
                //float isFrontFace = ( facing >= 0 ? 1 : 0 );
                half faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir) * faceSign;                
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                //float3 normalDirection = i.normalDir;
                fixed4 _main_TexRGB_var = tex2D(_main_TexRGB, i.uv_main);

#if defined (_NO_ALPHA_CHANNEL)
				_main_TexRGB_var.a *= _main_TexRGB_var.r;
#endif

				half4 maskColor = tex2D(_MaskTex, i.uv_main);
				maskColor.r = maskColor.r * _MaskChannelAdjust.x;
                float node_6381 = (_main_TexRGB_var.a+((1.0 - _DisssolveAmout)*1.2-0.6));
                clip(node_6381 - 0.5);
////// Lighting:
////// Emissive:
                //float4 node_4090 = _Time;
                //float2 _uv2_var = lerp( i.uv0, i.uv1, _uv2 );
				half4 _Distort_tex_var = tex2D(_Distort_tex, i.uv_distort);
                float2 node_9542 = (_Distort_Speed*_Time.r+lerp(0.0,_Distort_tex_var.rg,_Distort));
				half4 _Emission_var = tex2D(_Emission,TRANSFORM_TEX(node_9542, _Emission));
                //float node_4453 = 0.0;
                //float node_201 = -_Size;
				half3 emissive = (saturate((_Emission_Color.rgb*pow(_Emission_var.rgb,_Emission_Power)*_Emission_Intencitt))+(_main_TexRGB_var.rgb*pow(1.0-max(0,dot(i.normalDir, viewDirection)),_FalloffTexA)*__Color.rgb*_Fall_Power)+saturate((_Disssolve_Color.rgb*ceil((1.0 - (( 2.0 * node_6381 * _Size ) - _Size))))));
                //float3 finalColor = emissive;
                half4 finalRGBA = half4(emissive, maskColor.r);
                //UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }        
    }

    FallBack "IXS_Effect/P_AlphaBlend"    
}
