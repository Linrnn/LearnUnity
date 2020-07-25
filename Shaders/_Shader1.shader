Shader "Custom/_Shader1"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM
     
            #pragma vertex vert
            #pragma fragment frag
            //#include "UnityCG.cginc"

            fixed4 _Color;
            sampler2D _MainTex;

            struct a2v
            {
                float4 _vertex : POSITION;
                float2 _uv : TEXCOORD0;
                
            };
            struct v2f
            {
                float4 _vertex : SV_POSITION;
                float2 _uv : TEXCOORD0;
            };

            v2f vert(a2v input)
            {
                v2f output;
                output._vertex = UnityObjectToClipPos(input._vertex);
                output._uv = input._uv;
                return output;
            }
            fixed4 frag(v2f input) : SV_Target
            {
                return _Color * tex2D(_MainTex, input._uv);
            }

            ENDCG
        }
    }
}