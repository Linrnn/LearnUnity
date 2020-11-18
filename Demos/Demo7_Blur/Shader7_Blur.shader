Shader "Demo/Blur"
{
    Properties
    {
       _MainTex ("Albedo (RGB)", 2D) = "white" {}
       _Offset("Offset", Float) = 0.01
       _Color("Color", Color) = (0, 0, 0, 1)
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            sampler2D _MainTex;
            float _Offset;
            fixed4 _Color;

            struct a2v
            {
                float2 uv : TEXCOORD0;
            };
            struct v2f
            {
                float2 uv : TEXCOORD0;
            };

            v2f vert(a2v input)
            {
                v2f output;
                output.uv = input.uv;
                return output;
            }
            fixed4 frag(v2f input) : SV_Target
            {
                float2 uv = input.uv;
                fixed4 col0 = tex2D(_MainTex, uv);
                fixed4 col1 = tex2D(_MainTex, uv + float2(_Offset, 0));
                fixed4 col2 = tex2D(_MainTex, uv + float2(0, -_Offset));
                fixed4 col3 = tex2D(_MainTex, uv + float2(-_Offset, 0));
                fixed4 col4 = tex2D(_MainTex, uv + float2(0, _Offset));
                fixed4 col = (col0 + col1 + col2 + col3 + col4) / 5;
                return _Color * col;
            }
            ENDCG
        }
    }
}