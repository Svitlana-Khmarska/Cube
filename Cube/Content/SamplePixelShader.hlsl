/**
@brief Per-pixel color data passed through the pixel shader.
*/
struct PixelShaderInput
{
	float4 pos : SV_POSITION;
	float4 pos1 : POSITION;
	float3 color : COLOR0;
	float4 light : TEXCOORD0;
	float3 normal : TEXCOORD1;
	float3 viewPos : TEXCOORD2;
	float3 lightColor : COLOR1;
};

float cossin(float3 A, float3 B)
{
	float cos = dot(A, B) / (length(A) * length(B));
	return cos;
}

/**
@brief A pass-through function for the (interpolated) color data.
*/
float4 main(PixelShaderInput input) : SV_TARGET
{
	//Ambient
	float Ka = 0.5f;
	float ambient = Ka;

	//Diffuse
	float Kd = 0.8f;
	float3 N = -normalize(input.normal);
	float3 L = -normalize(input.light.xyz - input.pos1.xyz);
	float diffuse = Kd * (cossin(N, L));
	
	//Specular
	float Ks = 0.7f;
	float Ns = 1.0f;
	float3 R = normalize(reflect(L, N));
	float3 V = normalize(float3(input.viewPos.xyz - input.pos1.xyz));
	float specular = Ks * pow(cossin(R, V), Ns);

	float amp = 0.5f;
	float intensity = ambient + amp * (diffuse + specular);

	float3 result = input.color * intensity * input.lightColor;
	return float4(result, 1.0f);
}
