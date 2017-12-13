#pragma once

namespace Cube
{
	/**
	@brief Constant buffer used to send MVP matrices to the vertex shader.
	*/
	struct ModelViewProjectionConstantBuffer
	{
		DirectX::XMFLOAT4X4 model;
		DirectX::XMFLOAT4X4 view;
		DirectX::XMFLOAT4X4 projection;
		DirectX::XMFLOAT4 vec_light;
		DirectX::XMFLOAT4 viewPos;
		DirectX::XMFLOAT4X4 WorldInverseTranspose;
	};

	/**
	@brief Used to send per-vertex data to the vertex shader.
	*/
	struct VertexPositionColor
	{
		DirectX::XMFLOAT3 pos;
		DirectX::XMFLOAT2 uv;
		DirectX::XMFLOAT3 normal;	// Добавили вектор нормалі до вхідних даних шейдера
		DirectX::XMFLOAT3 bitangent;
	};
}