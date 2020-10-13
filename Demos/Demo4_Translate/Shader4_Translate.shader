Shader "Demo/Translate"
{
    Properties
    {
        _Speed ("Speed", Range(0.01 ,100)) = 1
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _SubTex("Albedo (RGB)", 2D) = "white" {}
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM
     
            #pragma vertex vert
            #pragma fragment frag

            float _Speed;
            fixed4 _Color;
            sampler2D _MainTex;
            sampler2D _SubTex;

            struct a2v
            {
                float4 _vertex : POSITION;
                float2 _uv1 : TEXCOORD0;
                float2 _uv2 : TEXCOORD1;
            };
            struct v2f
            {
                float4 _vertex : SV_POSITION;
                float2 _uv1 : TEXCOORD0;
                float2 _uv2 : TEXCOORD1;
            };

            v2f vert(a2v input)
            {
                v2f output;
                output._vertex = UnityObjectToClipPos(input._vertex);
                output._uv1 = input._uv1;
                output._uv2 = input._uv2;
                return output;
            }
            fixed4 frag(v2f input) : SV_Target
            {
                float2 delta = float2(0, _Time.y * _Speed);
                fixed4 main_color = tex2D(_MainTex, input._uv1);
                fixed4 sub_color = tex2D(_SubTex, input._uv2 + delta);
                fixed4 sum = main_color + sub_color;
                return _Color * sum;
            }

            ENDCG
        }
    }
}