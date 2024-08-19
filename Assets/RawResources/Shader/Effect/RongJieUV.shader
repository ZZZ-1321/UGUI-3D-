// Upgrade NOTE: replaced 'defined _NO_ALPHA_CHANNEL' with 'defined (_NO_ALPHA_CHANNEL)'

// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:0,qpre:4,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9063,x:33316,y:32605,varname:node_9063,prsc:2|normal-7204-OUT,emission-7110-OUT,alpha-2816-OUT,refract-3947-OUT;n:type:ShaderForge.SFN_Tex2d,id:850,x:31919,y:32852,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_850,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-3921-OUT;n:type:ShaderForge.SFN_If,id:459,x:31919,y:33064,varname:node_459,prsc:2|A-1342-OUT,B-5856-R,GT-1623-OUT,EQ-1623-OUT,LT-7299-OUT;n:type:ShaderForge.SFN_Tex2d,id:5856,x:31487,y:33156,ptovrint:False,ptlb:Noise,ptin:_Noise,varname:node_5856,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Vector1,id:1623,x:31487,y:33324,varname:node_1623,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:7299,x:31487,y:33386,varname:node_7299,prsc:2,v1:0;n:type:ShaderForge.SFN_Multiply,id:8707,x:32582,y:32828,varname:node_8707,prsc:2|A-850-A,B-4959-OUT,C-850-RGB;n:type:ShaderForge.SFN_VertexColor,id:8858,x:31487,y:33475,varname:node_8858,prsc:2;n:type:ShaderForge.SFN_If,id:2124,x:31919,y:33246,varname:node_2124,prsc:2|A-8858-R,B-5856-R,GT-1623-OUT,EQ-1623-OUT,LT-7299-OUT;n:type:ShaderForge.SFN_Add,id:1342,x:31712,y:33001,varname:node_1342,prsc:2|A-2095-OUT,B-8858-R;n:type:ShaderForge.SFN_ValueProperty,id:2095,x:31487,y:33001,ptovrint:False,ptlb:0_勾边大小,ptin:_0_,varname:node_2095,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Subtract,id:3805,x:32143,y:33105,varname:node_3805,prsc:2|A-459-OUT,B-2124-OUT;n:type:ShaderForge.SFN_Multiply,id:3683,x:32362,y:33105,varname:node_3683,prsc:2|A-3805-OUT,B-7276-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7276,x:32143,y:33301,ptovrint:False,ptlb:1_勾边亮度,ptin:_1_,varname:node_7276,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:100;n:type:ShaderForge.SFN_Add,id:4959,x:32582,y:33085,varname:node_4959,prsc:2|A-459-OUT,B-3683-OUT;n:type:ShaderForge.SFN_Multiply,id:378,x:32360,y:32668,varname:node_378,prsc:2|A-5389-RGB,B-850-RGB;n:type:ShaderForge.SFN_Multiply,id:779,x:32582,y:32650,varname:node_779,prsc:2|A-7493-OUT,B-378-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7493,x:32360,y:32597,ptovrint:False,ptlb:2_diffuse强度,ptin:_2_diffuse,varname:node_7493,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:10;n:type:ShaderForge.SFN_Multiply,id:7110,x:32802,y:32651,varname:node_7110,prsc:2|A-779-OUT,B-850-R;n:type:ShaderForge.SFN_Multiply,id:2816,x:32802,y:32809,varname:node_2816,prsc:2|A-8858-A,B-8707-OUT;n:type:ShaderForge.SFN_Color,id:5389,x:31919,y:32672,ptovrint:False,ptlb:3_color,ptin:_3_color,varname:node_5389,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.8,c2:0.3,c3:0.1,c4:1;n:type:ShaderForge.SFN_Lerp,id:7204,x:32908,y:33000,varname:node_7204,prsc:2|A-3224-OUT,B-850-A,T-2822-OUT;n:type:ShaderForge.SFN_Vector3,id:3224,x:32670,y:33000,varname:node_3224,prsc:2,v1:0,v2:0,v3:1;n:type:ShaderForge.SFN_Slider,id:2822,x:32143,y:33442,ptovrint:False,ptlb:4_扭曲强度,ptin:_4_,varname:node_2822,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2,max:1;n:type:ShaderForge.SFN_Multiply,id:1502,x:32607,y:33424,varname:node_1502,prsc:2|A-2822-OUT,B-7199-OUT;n:type:ShaderForge.SFN_Vector1,id:7199,x:32153,y:33519,varname:node_7199,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Multiply,id:3947,x:32839,y:33257,varname:node_3947,prsc:2|A-70-OUT,B-1502-OUT;n:type:ShaderForge.SFN_Multiply,id:70,x:32607,y:33257,varname:node_70,prsc:2|A-4724-OUT,B-8858-A;n:type:ShaderForge.SFN_ComponentMask,id:4724,x:32362,y:33257,varname:node_4724,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-850-RGB;n:type:ShaderForge.SFN_ValueProperty,id:6612,x:30847,y:33041,ptovrint:False,ptlb:V,ptin:_V,varname:node_6612,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_TexCoord,id:2182,x:31252,y:32362,varname:node_2182,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:3446,x:31223,y:32698,varname:node_3446,prsc:2|A-5483-T,B-6475-OUT;n:type:ShaderForge.SFN_Time,id:5483,x:30829,y:32585,varname:node_5483,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:3529,x:30842,y:32776,ptovrint:False,ptlb:U,ptin:_U,varname:node_3529,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Add,id:3921,x:31668,y:32630,varname:node_3921,prsc:2|A-2182-UVOUT,B-3446-OUT;n:type:ShaderForge.SFN_Append,id:6475,x:31107,y:32808,varname:node_6475,prsc:2|A-3529-OUT,B-6612-OUT;proporder:850-5856-2095-7276-7493-5389-2822-6612-3529;pass:END;sub:END;*/

Shader "IXS_Effect/D_RongJieUV"
{
    Properties
	{
        _Diffuse ("Diffuse", 2D) = "white" {}
        _Noise ("Noise", 2D) = "white" {}		
        _0_ ("0_勾边大小", Float ) = 0.1
        _1_ ("1_勾边亮度", Float ) = 100
        _2_diffuse ("2_diffuse强度", Float ) = 10
        _3_color ("3_color", Color) = (0.8,0.3,0.1,1)
        _4_ ("4_扭曲强度", Range(0, 1)) = 0.2
        _V ("V", Float ) = 0
        _U ("U", Float ) = 0    

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
            "Queue"="Transparent+100"
            "RenderType"="Transparent"
        }

        //GrabPass{ "_IX_GrabTex" }
		GrabPass{ }

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
			Lighting Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            //#pragma multi_compile_fwdbase
            //#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            //#pragma target 3.0
            //uniform sampler2D _IX_GrabTex;
			sampler2D _GrabTexture;//使用前重新声明一下
			//float4 _GrabTexture_ST;			
            uniform sampler2D _Diffuse; 
			uniform float4 _Diffuse_ST;
			//uniform float4 _Diffuse_TexelSize;
            uniform sampler2D _Noise; 
			uniform float4 _Noise_ST;
            uniform float _0_;
            uniform float _1_;
            uniform float _2_diffuse;
            uniform float4 _3_color;
            uniform float _4_;
            uniform float _V;
            uniform float _U;

            struct VertexInput
			{
                float4 vertex : POSITION;
                //float3 normal : NORMAL;
                //float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };

            struct VertexOutput
			{
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
				float2 uv_noise : TEXCOORD1;
                //float4 posWorld : TEXCOORD2;
                //float3 normalDir : TEXCOORD2;
                //float3 tangentDir : TEXCOORD3;
                //float3 bitangentDir : TEXCOORD4;
				float4 projPos : TEXCOORD2;
                float4 vertexColor : COLOR;                
            };

            VertexOutput vert (VertexInput v)
			{
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
				o.uv_noise = TRANSFORM_TEX(v.texcoord0, _Noise);
                o.vertexColor = v.vertexColor;
                //o.normalDir = UnityObjectToWorldNormal(v.normal);
                //o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                //o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                //o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);	

                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }			

            half4 frag(VertexOutput i, float facing : VFACE) : COLOR 
			{
                //float isFrontFace = ( facing >= 0 ? 1 : 0 );
                //float faceSign = ( facing >= 0 ? 1 : -1 );
                //i.normalDir = normalize(i.normalDir);
                //i.normalDir *= faceSign;
                //float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                //float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                //float4 node_5483 = _Time;
                float2 node_3921 = (i.uv0+(_Time.g*float2(_U,_V)));
                half4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(node_3921, _Diffuse));

                //float3 normalLocal = lerp(float3(0,0,1),float3(_Diffuse_var.a,_Diffuse_var.a,_Diffuse_var.a),_4_);
                //float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float2 sceneUVs = (i.projPos.xy / i.projPos.w) + ((_Diffuse_var.rgb*i.vertexColor.a)*(_4_*0.1));

#if UNITY_UV_STARTS_AT_TOP	
				if (_ProjectionParams.x > 0.0)
				{
					sceneUVs.y = 1.0 - sceneUVs.y;
				}
#endif

				half4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
////// Emissive:
                half3 finalColor = ((_2_diffuse*(_3_color.rgb*_Diffuse_var.rgb))*_Diffuse_var.r);
                //float3 finalColor = emissive;
                half4 _Noise_var = tex2D(_Noise,i.uv_noise);
                float node_459_if_leA = step((_0_+i.vertexColor.r),_Noise_var.r);
                float node_459_if_leB = step(_Noise_var.r,(_0_+i.vertexColor.r));
                //float node_7299 = 0.0;
                //float node_1623 = 1.0;
                float node_459 = lerp(node_459_if_leB,1.0,node_459_if_leA*node_459_if_leB);
                float node_2124_if_leA = step(i.vertexColor.r,_Noise_var.r);
                float node_2124_if_leB = step(_Noise_var.r,i.vertexColor.r);
				//return _Noise_var;
                return half4(lerp(sceneColor.rgb, finalColor,(i.vertexColor.a*(_Diffuse_var.a*(node_459+((node_459-lerp(node_2124_if_leB,1.0,node_2124_if_leA*node_2124_if_leB))*_1_))*_Diffuse_var.rgb))),1);
            }
            ENDCG
        }
    }

    Fallback "IXS_Effect/P_AlphaBlend"        
}
