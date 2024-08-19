// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.1280277,fgcg:0.1953466,fgcb:0.2352941,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:33174,y:32846,varname:node_4013,prsc:2|custl-8924-OUT;n:type:ShaderForge.SFN_Fresnel,id:909,x:32467,y:32940,varname:node_909,prsc:2|NRM-9249-OUT,EXP-1965-OUT;n:type:ShaderForge.SFN_Multiply,id:5218,x:32703,y:33088,varname:node_5218,prsc:2|A-909-OUT,B-6217-OUT;n:type:ShaderForge.SFN_Tex2d,id:5219,x:31985,y:33108,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_5219,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4939-OUT;n:type:ShaderForge.SFN_Color,id:446,x:31985,y:33357,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_446,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:5004,x:32236,y:33108,varname:node_5004,prsc:2|A-5219-RGB,B-446-RGB;n:type:ShaderForge.SFN_Panner,id:2830,x:31542,y:33108,varname:node_2830,prsc:2,spu:0.1,spv:0|UVIN-7974-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:7974,x:31363,y:33108,varname:node_7974,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Slider,id:7327,x:32080,y:33576,ptovrint:False,ptlb:Color_MAx,ptin:_Color_MAx,varname:node_7327,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:20;n:type:ShaderForge.SFN_Multiply,id:6217,x:32467,y:33108,varname:node_6217,prsc:2|A-5004-OUT,B-7327-OUT;n:type:ShaderForge.SFN_TexCoord,id:4206,x:31172,y:33316,varname:node_4206,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:622,x:31363,y:33316,varname:node_622,prsc:2,spu:0,spv:0.05|UVIN-4206-UVOUT;n:type:ShaderForge.SFN_Add,id:4939,x:31794,y:33108,varname:node_4939,prsc:2|A-2830-UVOUT,B-75-RGB;n:type:ShaderForge.SFN_Tex2d,id:75,x:31542,y:33316,ptovrint:False,ptlb:niuqu,ptin:_niuqu,varname:node_75,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-622-UVOUT;n:type:ShaderForge.SFN_ValueProperty,id:1965,x:32236,y:32871,ptovrint:False,ptlb:bianyuan,ptin:_bianyuan,varname:node_1965,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3.5;n:type:ShaderForge.SFN_VertexColor,id:8194,x:32703,y:33273,varname:node_8194,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8924,x:32942,y:33088,varname:node_8924,prsc:2|A-5218-OUT,B-8194-RGB,C-8194-A;n:type:ShaderForge.SFN_NormalVector,id:9249,x:32236,y:32940,prsc:2,pt:False;proporder:5219-446-7327-75-1965;pass:END;sub:END;*/

Shader "IXS_Effect/B_WaiFaGuang" 
{
    Properties 
	{
        _Texture ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (0.5,0.5,0.5,1)
        _Color_MAx ("Color_MAx", Range(0, 20)) = 1
        _niuqu ("niuqu", 2D) = "white" {}
        _bianyuan ("bianyuan", Float ) = 3.5

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

            Blend One One, Zero One
            ZWrite Off			
			Lighting Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            //#pragma multi_compile_fwdbase
            //#pragma only_renderers d3d9 d3d11 glcore gles n3ds wiiu 
            //#pragma target 3.0
            uniform sampler2D _Texture; 
			uniform float4 _Texture_ST;
            uniform float4 _Color;
            uniform float _Color_MAx;
            uniform sampler2D _niuqu; 
			uniform float4 _niuqu_ST;
            uniform float _bianyuan;

            struct VertexInput 
			{
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };

            struct VertexOutput 
			{
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
            };

            VertexOutput vert (VertexInput v)
			{
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }

            half4 frag(VertexOutput i) : COLOR 
			{
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
                //float4 node_3424 = _Time;
                float2 node_622 = (i.uv0+ _Time.g*float2(0,0.05));
                half4 _niuqu_var = tex2D(_niuqu,TRANSFORM_TEX(node_622, _niuqu));
                float3 node_4939 = (float3((i.uv0+ _Time.g*float2(0.1,0)),0.0)+_niuqu_var.rgb);
                half4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(node_4939, _Texture));
                half3 finalColor = ((pow(1.0-max(0,dot(i.normalDir, viewDirection)),_bianyuan)*((_Texture_var.rgb*_Color.rgb)*_Color_MAx))*i.vertexColor.rgb*i.vertexColor.a);
                return half4(finalColor,1);
            }
            ENDCG
        }
    }

    FallBack Off    
}
