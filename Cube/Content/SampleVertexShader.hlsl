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
	float3 uv : UV;
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
	float4 light = float4(vec_light.xyz, 1.0f);
	output.viewPos = viewPos.xyz;
	// Transform the vertex position into projected space.
	pos = mul(pos, model);
	pos = mul(pos, view);
	pos = mul(pos, projection);
	output.pos = pos;
	output.pos1 = float4(0.0f, 0.0f, 0.0f, 1.0f);
	output.light = light;
	output.normal = input.normal;
	// Pass the color through without modification.
	output.color = float3(1.0f, 0.5f, 0.31f);	 // Color of cube
	output.lightColor = float3(1.0f, 1.0f, 1.0f);	//light color
	
	return output;
}
