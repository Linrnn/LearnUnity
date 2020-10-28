Shader "Demo/Wave"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Height ("Height", Range(0.01, 100)) = 1
        _Speed ("Speed", Range(0.01, 100)) = 1
        _Color ("Color", Color) = (1, 1, 1, 1)
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            
            sampler2D _MainTex;
            float _Height;
            float _Speed;
            fixed4 _Color;

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
                v2f output;
                float4 pos = input.vertex;
                float dis = pos.x;
                float dSin = sin(dis + _Time.y * _Speed);
                pos.y = dSin * _Height;
                output.vertex = UnityObjectToClipPos(pos);
                output.uv = input.uv;
                return output;
            }
            fixed4 frag(v2f input) : SV_Target
            {
                return _Color * tex2D(_MainTex, input.uv);
            }

            ENDCG
        }
    }
}