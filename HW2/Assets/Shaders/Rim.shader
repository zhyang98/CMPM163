﻿Shader "Custom/Rim"
{
    Properties
    {
		_Emissiveness("Emmissiveness", Range(0,10)) = 0
		_Stroke("Threshold", Range(0,1)) = 0.5
		_Color1 ("Main Color", Color) = (1,1,1,1)
        _Color2 ("Stroke Color", Color) = (0,0,0,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
				float4 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
				float4 normal : NORMAL;
				float3 viewDir : TEXCOORD1;
            };

			float4 _Color1;
			float4 _Color2;
			float _Stroke;
			uniform float _Emissiveness;

            v2f vert (appdata v)
            {
				v2f o;
				
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal.xyz = UnityObjectToWorldNormal(v.normal);
				o.viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld, v.vertex).xyz);
				o.uv = v.uv;

				return o;
            }

			fixed4 frag(v2f i) : SV_Target
			{
				float ndotv = dot(i.normal, i.viewDir);
				if (abs(ndotv) < _Stroke)
					return _Color2 * _Emissiveness;
				else
					return _Color1;
            }
            ENDCG
        }

		
    }
}