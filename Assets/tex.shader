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

            // Ư�� �ȼ��� ���, �� ��(��Ⱚ)�� �����Ϸ���, �ش� �ȼ��� r, b, g ����� ��հ��� ���ϸ� ��.
            // �׸���, �� ��հ��� float3(��հ�, ��հ�, ��հ�) ���� ���� �� �ֵ��� ������ �������ָ� ��.
            // �ֳĸ�, 
            // 1. ����� r, g, b �� ��� ����, 
            // 2. �� ��� r, g, b �� ��հ��� �ش� ������ ��(��Ⱚ)�� ���� ����! 
            o.Albedo = (c.r + c.g + c.b) / 3;
            
            // �����, 'RGB to YIQ ��ȯ ��Ʈ����' ��� �׷��̽����� ���� �˰����� ����� �Ʒ��� �������ε� ��� ��ȯ�� �����ϴٰ� ��.
            // o.Albedo = 0.2989 * c.r + 0.5870 * c.g + 0.1140 * c.b;

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
