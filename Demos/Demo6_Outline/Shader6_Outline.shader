Shader "Demo/Outline"
{
    Properties
    {
       _MainTex ("Albedo (RGB)", 2D) = "white" {}
       _OutLineWidth("Width", Float) = 1.1
       _Color("Color", Color) = (0, 0, 0, 1)
    }

    SubShader
    {  
        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
  
            float _OutLineWidth;
            fixed4 _Color;
  
            struct a2v
            {
                float4 vertex : POSITION;
            };
            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            v2f vert(a2v input)
            {
                v2f output;
                output.vertex = UnityObjectToClipPos(input.vertex * _OutLineWidth);
                return output;
            }
            fixed4 frag() : SV_Target
            {
                return _Color;
            }
            ENDCG
        }

        Pass
        {
            ZTest Always
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

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
                v2f output;
                output.vertex = UnityObjectToClipPos(input.vertex);
                output.uv = input.uv;
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