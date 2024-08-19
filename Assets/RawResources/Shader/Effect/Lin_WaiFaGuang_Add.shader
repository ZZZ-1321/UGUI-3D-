// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5450981,fgcg:0.3233266,fgcb:0.1529412,fgca:1,fgde:0.015,fgrn:25,fgrf:85,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:32653,y:33007,varname:node_4013,prsc:2|emission-6217-OUT;n:type:ShaderForge.SFN_Fresnel,id:909,x:31985,y:33403,varname:node_909,prsc:2|NRM-9249-OUT,EXP-1965-OUT;n:type:ShaderForge.SFN_Tex2d,id:5219,x:31985,y:33108,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_5219,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4939-OUT;n:type:ShaderForge.SFN_Color,id:446,x:31985,y:32957,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_446,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:5004,x:32236,y:33108,varname:node_5004,prsc:2|A-3812-OUT,B-446-RGB,C-5219-RGB,D-8194-RGB,E-8194-A;n:type:ShaderForge.SFN_TexCoord,id:7974,x:30787,y:32982,varname:node_7974,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:6217,x:32467,y:33108,varname:node_6217,prsc:2|A-5004-OUT,B-909-OUT;n:type:ShaderForge.SFN_Add,id:4939,x:31794,y:33108,varname:node_4939,prsc:2|A-7974-UVOUT,B-4219-OUT;n:type:ShaderForge.SFN_Tex2d,id:75,x:31412,y:33127,ptovrint:False,ptlb:NiuQu,ptin:_NiuQu,varname:node_75,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-3400-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1965,x:31795,y:33334,ptovrint:False,ptlb:BianYuan,ptin:_BianYuan,varname:node_1965,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3.5;n:type:ShaderForge.SFN_VertexColor,id:8194,x:31985,y:33265,varname:node_8194,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:9249,x:31795,y:33403,prsc:2,pt:False;n:type:ShaderForge.SFN_Time,id:2755,x:30787,y:33128,varname:node_2755,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:4664,x:30572,y:33348,ptovrint:False,ptlb:Y,ptin:_Y,varname:node_4664,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:6950,x:30572,y:33275,ptovrint:False,ptlb:X,ptin:_X,varname:node_6950,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:5922,x:30787,y:33275,varname:node_5922,prsc:2|A-6950-OUT,B-4664-OUT;n:type:ShaderForge.SFN_Multiply,id:4501,x:31025,y:33147,varname:node_4501,prsc:2|A-2755-T,B-5922-OUT;n:type:ShaderForge.SFN_Add,id:3400,x:31219,y:33127,varname:node_3400,prsc:2|A-7974-UVOUT,B-4501-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3812,x:31985,y:32883,ptovrint:False,ptlb:Color_MAx,ptin:_Color_MAx,varname:node_3812,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:735,x:31412,y:33312,ptovrint:False,ptlb:NiuQu_QiangDu,ptin:_NiuQu_QiangDu,varname:node_735,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:4219,x:31622,y:33127,varname:node_4219,prsc:2|A-75-RGB,B-735-OUT;proporder:5219-446-3812-1965-75-735-6950-4664;pass:END;sub:END;*/

Shader "IXS_Effect/B_WaiFaGuang_Add"
{
    Properties
	{
        _Texture ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (0.5,0.5,0.5,1)
        _Color_MAx ("Color_MAx", Float ) = 0
        _BianYuan ("BianYuan", Float ) = 3.5
        _NiuQu ("NiuQu", 2D) = "white" {}
        _NiuQu_QiangDu ("NiuQu_QiangDu", Float ) = 0
        _X ("X", Float ) = 0
        _Y ("Y", Float ) = 0

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

            Blend One One, Zero One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            
            uniform sampler2D _Texture;
			uniform float4 _Texture_ST;
            uniform float4 _Color;
            uniform sampler2D _NiuQu; 
			uniform float4 _NiuQu_ST;
            uniform float _BianYuan;
            uniform float _Y;
            uniform float _X;
            uniform float _Color_MAx;
            uniform float _NiuQu_QiangDu;

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
                //i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = normalize(i.normalDir);
////// Lighting:
////// Emissive:
                //float4 node_2755 = _Time;
                float2 node_3400 = (i.uv0+(_Time.g*float2(_X,_Y)));
                half4 _NiuQu_var = tex2D(_NiuQu,TRANSFORM_TEX(node_3400, _NiuQu));
                float3 node_4939 = (float3(i.uv0,0.0)+(_NiuQu_var.rgb*_NiuQu_QiangDu));
                half4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(node_4939, _Texture));
                half3 finalColor = ((_Color_MAx*_Color.rgb*_Texture_var.rgb*i.vertexColor.rgb*i.vertexColor.a)*pow(1.0-max(0,dot(i.normalDir, viewDirection)),_BianYuan));
                //float3 finalColor = emissive;
                return half4(finalColor,1);
            }
            ENDCG
        }
    }

    FallBack "IXS_Effect/P_Additive"
    //CustomEditor "ShaderForgeMaterialInspector"
}
