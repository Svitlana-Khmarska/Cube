/**
@brief A constant buffer that stores the three basic column-major matrices for composing geometry.
*/
cbuffer ModelViewProjectionConstantBuffer : register(b0)
{
	matrix model;
	matrix view;
	matrix projection;
	float4 vec_light;
	float4 viewPos;
	matrix WorldInverseTranspose;
};

/**
@brief Per-vertex data used as input to the vertex shader.
*/
struct VertexShaderInput
{
	float3 pos : POSITION;
	float2 uv : UV;
	float3 normal : NORMAL;
	float3 bitangent : BITANGENT;
};

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

/**
@brief Simple shader to do vertex processing on the GPU.
*/
PixelShaderInput main(VertexShaderInput input)
{
	PixelShaderInput output;
	
	float4 pos = float4(input.pos, 1.0f);
	// Transform the vertex position into projected space.
	float4x4 transform = mul(model, view);
	transform = mul(transform, projection);
	output.viewPos = viewPos.xyz;
	pos = mul(pos, transform);
	output.pos = pos;
	output.pos1 = pos;

	output.light = vec_light;
	output.normal = mul(input.normal, transform);
	// Pass the color through without modification.
	output.color = float3(1.0f, 1.0f, 1.0f);		// Color of figure
	output.lightColor = float3(0.7f, 0.3f, 0.7f);	//light color
	
	return output;
}
