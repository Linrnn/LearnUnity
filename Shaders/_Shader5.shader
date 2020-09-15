Shader "Custom/_Shader5"
{
    Properties
    {
        _Speed ("Speed", Range(-10 ,10)) = 1
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

            float _Speed;
            fixed4 _Color;
            sampler2D _MainTex;

            struct a2v
            {
                float4 _vertex : POSITION;
                float2 _uv1 : TEXCOORD0;
            };
            struct v2f
            {
                float4 _vertex : SV_POSITION;
                float2 _uv1 : TEXCOORD0;
            };

            v2f vert(a2v input)
            {
                float2 sub = float2(0.5, 0.5);
                float td = _Time.y * _Speed;
                float2 delta = float2(cos(td), sin(td));
                float2 theta = input._uv1 - sub;
                float2 vec;
                vec.x = theta.x * delta.x - theta.y * delta.y;//cos(θ + Δ) = cosθ * cosΔ - sinθ * sinΔ
                vec.y = theta.y * delta.x + theta.x * delta.y;//sin(θ + Δ) = sinθ * cosΔ + cosθ * sinΔ
                float2 uv = vec + sub;

                v2f output;
                output._vertex = UnityObjectToClipPos(input._vertex);
                output._uv1 = uv;
                return output;
            }
            fixed4 frag(v2f input) : SV_Target
            {
                fixed4 main_color = tex2D(_MainTex, input._uv1);
                return main_color;
            }

            ENDCG
        }
    }
}