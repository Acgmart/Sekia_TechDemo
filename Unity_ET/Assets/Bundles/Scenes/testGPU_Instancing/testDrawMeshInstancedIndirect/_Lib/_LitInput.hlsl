
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

CBUFFER_START(UnityPerMaterial)
CBUFFER_END

struct BoidData
{
	float3 velocity; // 速度
	float3 position; // 位置
};

StructuredBuffer<BoidData> _BoidDataBuffer;
float3      _ObjectScale;

float4x4 EulerAnglesToRotationMatrix(float3 eulerAngle)
{
	float cosA = cos(eulerAngle.x); float sinA = sin(eulerAngle.x);
	float cosB = cos(eulerAngle.y); float sinB = sin(eulerAngle.y);

	//float cosC = cos(eulerAngle.z); float sinC = sin(eulerAngle.z); //欧拉角的Z轴固定为0
	//float cosC = 1.0; float sinC = 0.0;
	//return float4x4(
	//	cosB * cosC + sinB * sinA * sinC,		-cosB * sinC + sinB * sinA * cosC,		sinB * cosA,	0,
	//	cosA * sinC,							cosA * cosC,							-sinA,			0,
	//	-sinB * cosC + cosB * sinA * sinC,		sinB * sinC + cosB * sinA * cosC,		cosB * cosA,	0,
	//	0,										0,										0,				1);
	
	//mul(My, mul(Mx, Mz))
	//									X轴旋转矩阵
	//									1		0				0
	//									0		cosA			-sinA
	//									0		sinA			cosA
	//Y轴旋转矩阵
	// cosB		0		sinB			cosB	sinA * sinB		cosA * sinB
	// 0		1		0				0		cosA			-sinA
	// -sinB	0		cosB			-sinB	sinA * cosB		cosA * cosB


	return float4x4(
		cosB,		sinB * sinA,	sinB * cosA,	0,
		0.0,	cosA,			-sinA,		0,
		-sinB,	cosB * sinA,	cosB * cosA,	0,
		0,		0,			0,			1);
}

float4x4 ComputeObjectToWorldTransform(uint unity_InstanceID)
{
	//取出逐实例数据
	BoidData boidData = _BoidDataBuffer[unity_InstanceID]; 

	//缩放矩阵
	float4x4 object2world = (float4x4)0;
	object2world._11_22_33_44 = float4(_ObjectScale.xyz, 1.0);
	
	//向量转欧拉角
	float rotY = atan2(boidData.velocity.x, boidData.velocity.z);
	float rotX = -asin(boidData.velocity.y / (length(boidData.velocity.xyz) + 1e-8));

	//欧拉角转矩阵
	float4x4 rotMatrix = EulerAnglesToRotationMatrix(float3(rotX, rotY, 0));

	//mul(偏移, mul(旋转, 缩放))
	object2world = mul(rotMatrix, object2world);
	object2world._14_24_34 += boidData.position.xyz;

    return object2world;
}
