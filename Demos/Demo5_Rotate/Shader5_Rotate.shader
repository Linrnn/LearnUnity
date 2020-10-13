Shader "Demo/Rotate"
{
    Properties
    {
        _Speed ("Speed", Range(-10 ,10)) = 1
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
            sampler2D _MainTex;

            struct a2v
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(a2v input)
            {
                float2 sub = float2(0.5, 0.5);
                float td = _Time.y * _Speed;
                float2 delta = float2(cos(td), sin(td));
                float2 theta = input.uv - sub;
                float2 vec;
                vec.x = theta.x * delta.x - theta.y * delta.y;//cos(θ + Δ) = cosθ * cosΔ - sinθ * sinΔ
                vec.y = theta.y * delta.x + theta.x * delta.y;//sin(θ + Δ) = sinθ * cosΔ + cosθ * sinΔ
                float2 uv = vec + sub;

                v2f output;
                output.vertex = UnityObjectToClipPos(input.vertex);
                output.uv = uv;
                return output;
            }
            fixed4 frag(v2f input) : SV_Target
            {
                return tex2D(_MainTex, input.uv);
            }

            ENDCG
        }
    }
}