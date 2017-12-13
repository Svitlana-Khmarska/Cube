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
@brief A pass-through function for the (interpolated) color data.
*/
float4 main(PixelShaderInput input) : SV_TARGET
{
	//Ambient
	float ambientStrength = 0.6f;	// ���� �������� ���������
	float3 ambient = ambientStrength * input.lightColor;
	
	//Diffuse
	float3 norm = normalize(input.normal);	//������� ������������
	float3 lightDir = normalize(input.light - input.pos1);	//�������� �����
	float diff = max(dot(norm, lightDir), 0.0);	//���������� ���������
	float3 diffuse = 0.5f * diff * input.lightColor;

	//Specular
	float specularStrength = 0.1f;	//���� ��������
	float3 viewDir = normalize(input.viewPos);	//������ �������
	float3 reflectDir = reflect(-lightDir, norm);
	float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);	// 32 - ������ "��������" ����� ��������
	float3 specular = specularStrength * spec * input.lightColor;
	
	float3 result = input.color * (ambient + diffuse + specular);
	return float4(result, 1.0f);
}
