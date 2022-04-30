Shader "Custom/tex"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);

            // 특정 픽셀의 흑백, 즉 명도(밝기값)을 결정하려면, 해당 픽셀의 r, b, g 요소의 평균값을 구하면 됨.
            // 그리고, 그 평균값을 float3(평균값, 평균값, 평균값) 으로 받을 수 있도록 색상값을 지정해주면 됨.
            // 왜냐면, 
            // 1. 흑백은 r, g, b 가 모두 같고, 
            // 2. 각 요소 r, g, b 의 평균값이 해당 색상의 명도(밝기값)와 같기 때문! 
            o.Albedo = (c.r + c.g + c.b) / 3;
            
            // 참고로, 'RGB to YIQ 변환 매트릭스' 라는 그레이스케일 구현 알고리즘을 사용한 아래의 공식으로도 흑백 변환이 가능하다고 함.
            // o.Albedo = 0.2989 * c.r + 0.5870 * c.g + 0.1140 * c.b;

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
