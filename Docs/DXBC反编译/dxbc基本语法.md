参考地址：
https://docs.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-sm4-asm
https://docs.microsoft.com/en-us/windows/win32/direct3dhlsl/shader-model-5-assembly--directx-hlsl-

指令后面的数字表示变量index
如：mov r0, c0.x 写作 mov 0, 1

变量的定义：
dcl_$ 定义变量

指令：
mov 0, 1
    result = index1;

mul 0, 1, 2
    result = index1 * index2;

abs 0, 1
    result = abs(index1);

mad 0, 1, 2, 3
    result = index1 * index2 + index3;

texkill 0
    clip(index0);

add

f16tof32 0, 1
    result = index1;
    将half转换为float
utof 0, 1
    result = index1;
    将uint转换为float
itof 0, 1
    result = index1;
    将int转换为float
iadd int类型的add

shl 0, 1, 2
    result = index1 << index2;
shr 0, 1, 2
    result = index1 >> index2;
ushr 0, 1, 2
    result = index1 >> index2;

ushr

sample_l 0, 1, 2, 3, 4
    result = sample_lod(index2, index3, index0, index4);
    index1为Texture
    index2为Sampler
    index3为UV
    index4为LOD