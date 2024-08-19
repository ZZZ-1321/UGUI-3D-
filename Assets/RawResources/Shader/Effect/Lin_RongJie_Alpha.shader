// Upgrade NOTE: replaced 'defined _NO_ALPHA_CHANNEL' with 'defined (_NO_ALPHA_CHANNEL)'

// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:False,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.8088235,fgcg:0.7824097,fgcb:0.6720372,fgca:1,fgde:0.005,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:34014,y:32700,varname:node_3138,prsc:2|emission-217-OUT,alpha-5961-OUT;n:type:ShaderForge.SFN_Tex2d,id:7833,x:32553,y:32526,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8311-OUT;n:type:ShaderForge.SFN_TexCoord,id:8076,x:32052,y:32821,varname:node_8076,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2d,id:9985,x:32791,y:32842,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:_MaskTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-2745-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:2745,x:32618,y:32842,varname:node_2745,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_VertexColor,id:7552,x:32553,y:32382,varname:node_7552,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:9434,x:32553,y:32316,ptovrint:False,ptlb:Value,ptin:_Value,varname:_MainTexBrightness,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Tex2d,id:3488,x:31830,y:32677,ptovrint:False,ptlb:NiuQu_RongJie,ptin:_NiuQu_RongJie,varname:_NormalTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:False|UVIN-1145-OUT;n:type:ShaderForge.SFN_Multiply,id:6613,x:32052,y:32694,varname:node_6613,prsc:2|A-3488-R,B-301-W;n:type:ShaderForge.SFN_TexCoord,id:775,x:31327,y:32556,varname:node_775,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:232,x:31496,y:32697,varname:node_232,prsc:2|A-6886-OUT,B-7882-T;n:type:ShaderForge.SFN_Time,id:7882,x:31327,y:32836,varname:node_7882,prsc:2;n:type:ShaderForge.SFN_Append,id:6886,x:31327,y:32697,varname:node_6886,prsc:2|A-2727-OUT,B-8873-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2727,x:31160,y:32697,ptovrint:False,ptlb:X,ptin:_X,varname:_NormalTexPannerX,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:8873,x:31160,y:32768,ptovrint:False,ptlb:Y,ptin:_Y,varname:_NormalTexPannerY,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Add,id:1145,x:31664,y:32677,varname:node_1145,prsc:2|A-775-UVOUT,B-232-OUT;n:type:ShaderForge.SFN_TexCoord,id:301,x:31837,y:32940,varname:node_301,prsc:2,uv:1,uaff:True;n:type:ShaderForge.SFN_Multiply,id:1193,x:33342,y:32468,varname:node_1193,prsc:2|A-1550-RGB,B-9434-OUT,C-7552-RGB,D-6642-OUT,E-7552-A;n:type:ShaderForge.SFN_Color,id:1550,x:32553,y:32153,ptovrint:False,ptlb:Main Color,ptin:_MainColor,varname:node_1550,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:9782,x:33354,y:32669,varname:node_9782,prsc:2|A-1550-A,B-9434-OUT,C-7552-A,D-4657-OUT,E-9985-R;n:type:ShaderForge.SFN_Append,id:9450,x:32052,y:32963,varname:node_9450,prsc:2|A-301-U,B-301-V;n:type:ShaderForge.SFN_Power,id:6642,x:32781,y:32526,varname:node_6642,prsc:2|VAL-7833-RGB,EXP-2723-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2723,x:32553,y:32697,ptovrint:False,ptlb:Cuve,ptin:_Cuve,varname:node_2723,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Add,id:8311,x:32394,y:32526,varname:node_8311,prsc:2|A-728-OUT,B-6613-OUT,C-8076-UVOUT,D-9450-OUT;n:type:ShaderForge.SFN_TexCoord,id:5954,x:31213,y:32348,varname:node_5954,prsc:2,uv:2,uaff:True;n:type:ShaderForge.SFN_Append,id:2143,x:31411,y:32358,varname:node_2143,prsc:2|A-5954-U,B-5954-V;n:type:ShaderForge.SFN_TexCoord,id:6008,x:31649,y:32211,varname:node_6008,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:2043,x:31857,y:32338,varname:node_2043,prsc:2|A-6008-UVOUT,B-5238-OUT;n:type:ShaderForge.SFN_Vector1,id:9372,x:31649,y:32506,varname:node_9372,prsc:2,v1:-0.5;n:type:ShaderForge.SFN_Multiply,id:4386,x:31857,y:32472,varname:node_4386,prsc:2|A-5238-OUT,B-9372-OUT;n:type:ShaderForge.SFN_Add,id:728,x:32062,y:32338,varname:node_728,prsc:2|A-2043-OUT,B-4386-OUT;n:type:ShaderForge.SFN_Add,id:5238,x:31649,y:32358,varname:node_5238,prsc:2|A-2143-OUT,B-8197-OUT;n:type:ShaderForge.SFN_Vector1,id:8197,x:31411,y:32485,varname:node_8197,prsc:2,v1:-1;n:type:ShaderForge.SFN_Add,id:3781,x:33173,y:33021,varname:node_3781,prsc:2|A-3488-R,B-8877-OUT;n:type:ShaderForge.SFN_Clamp01,id:4829,x:33354,y:33021,varname:node_4829,prsc:2|IN-3781-OUT;n:type:ShaderForge.SFN_Smoothstep,id:7340,x:33565,y:32980,varname:node_7340,prsc:2|A-1159-OUT,B-7518-OUT,V-4829-OUT;n:type:ShaderForge.SFN_Slider,id:7518,x:33197,y:32947,ptovrint:False,ptlb:Max,ptin:_Max,varname:node_7518,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:5961,x:33738,y:32960,varname:node_5961,prsc:2|A-9782-OUT,B-7340-OUT;n:type:ShaderForge.SFN_Vector1,id:2670,x:32817,y:33176,varname:node_2670,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:8877,x:32999,y:33041,varname:node_8877,prsc:2|A-4343-OUT,B-2670-OUT;n:type:ShaderForge.SFN_Add,id:4343,x:32817,y:33041,varname:node_4343,prsc:2|A-301-Z,B-6994-OUT;n:type:ShaderForge.SFN_Vector1,id:6994,x:32653,y:33061,varname:node_6994,prsc:2,v1:-1;n:type:ShaderForge.SFN_Slider,id:1159,x:33197,y:32859,ptovrint:False,ptlb:Min,ptin:_Min,varname:node_1159,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.05,max:1;n:type:ShaderForge.SFN_SwitchProperty,id:4657,x:32781,y:32674,ptovrint:False,ptlb:Alpha R,ptin:_AlphaR,varname:node_4657,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-7833-A,B-7833-R;n:type:ShaderForge.SFN_Multiply,id:217,x:33738,y:32802,varname:node_217,prsc:2|A-1193-OUT,B-9985-RGB;proporder:2723-7833-1550-9434-4657-3488-2727-8873-9985-1159-7518;pass:END;sub:END;*/

Shader "IXS_Effect/B_RongJie_Alpha"
{
    Properties
	{
        _Cuve ("Cuve", Float ) = 1
        _Texture ("Texture", 2D) = "white" {}
        _MainColor ("Main Color", Color) = (1,1,1,1)
        _Value ("Value", Float ) = 1
        [MaterialToggle] _AlphaR ("Alpha R", Float ) = 0
        _NiuQu_RongJie ("NiuQu_RongJie", 2D) = "bump" {}
        _X ("X", Float ) = 0
        _Y ("Y", Float ) = 0
        _Mask ("Mask", 2D) = "white" {}
        _Min ("Min", Range(0, 1)) = 0.05
        _Max ("Max", Range(0, 1)) = 1        

		_ZOffset("Z Offset", Float) = 0

		[Toggle(_Z_OFFSET)] _EnableZOffset("Enable Z Offset", Float) = 0

		[Toggle(_NO_ALPHA_CHANNEL)] _NoAlphaChannel("No Alpha Channel", Float) = 0

		//[Enum(UnityEngine.Rendering.BlendMode)] _SourceBlend("Source Blend Mode", Float) = 5
		//[Enum(UnityEngine.Rendering.BlendMode)] _DestBlend("Dest Blend Mode", Float) = 1		
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

            Blend SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha            
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

			#pragma multi_compile __ _Z_OFFSET
			#pragma multi_compile __ _NO_ALPHA_CHANNEL			
            
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
            uniform fixed _AlphaR;

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
                //float isFrontFace = ( facing >= 0 ? 1 : 0 );
                //float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float2 node_5238 = (float2(i.uv2.r,i.uv2.g)+(-1.0));
                //float4 node_7882 = _Time;
                float2 node_1145 = (i.uv0+(float2(_X,_Y)*_Time.g));
                half4 _NiuQu_RongJie_var = tex2D(_NiuQu_RongJie,TRANSFORM_TEX(node_1145, _NiuQu_RongJie));
                float2 node_8311 = (((i.uv0*node_5238)+(node_5238*(-0.5)))+(_NiuQu_RongJie_var.r*i.uv1.a)+i.uv0+float2(i.uv1.r,i.uv1.g));
                half4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(node_8311, _Texture));

#if defined (_NO_ALPHA_CHANNEL)
				_Texture_var.a *= _Texture_var.r;
#endif

                half4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(i.uv0, _Mask));
                half3 finalColor = ((_MainColor.rgb*_Value*i.vertexColor.rgb*pow(_Texture_var.rgb,_Cuve)*i.vertexColor.a)*_Mask_var.rgb);
                //float3 finalColor = emissive;
                return half4(finalColor,((_MainColor.a*_Value*i.vertexColor.a*lerp( _Texture_var.a, _Texture_var.r, _AlphaR )*_Mask_var.r)*smoothstep( _Min, _Max, saturate((_NiuQu_RongJie_var.r+((i.uv1.b+(-1.0))*(-1.0)))) )));
            }
            ENDCG
        }        
    }

    FallBack "IXS_Effect/P_AlphaBlend"
    //CustomEditor "ShaderForgeMaterialInspector"
}
