
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Sekia
{
    internal sealed class SwapBufferSystem
    {
        struct SwapBuffer
        {
            public RTHandle rt;
            public string name;
        }
        SwapBuffer m_A, m_B;

        /// <summary>
        /// A是backBuffer B是frontBuffer
        /// </summary>
        static bool m_AisBackBuffer = true;

        static RenderTextureDescriptor m_Desc;
        FilterMode m_FilterMode;

        ref SwapBuffer backBuffer { get { return ref m_AisBackBuffer ? ref m_A : ref m_B; } }
        ref SwapBuffer frontBuffer { get { return ref m_AisBackBuffer ? ref m_B : ref m_A; } }

        public SwapBufferSystem(string name)
        {
            m_A.name = name + "A";
            m_B.name = name + "B";
        }

        public void Dispose()
        {
            m_A.rt?.Release();
            m_B.rt?.Release();
        }

        /// <summary>
        /// 根据swap状态 返回backBuffer
        /// </summary>
        public RTHandle PeekBackBuffer()
        {
            return backBuffer.rt;
        }

        /// <summary>
        /// 初始化两个RT 并返回backBuffer
        /// </summary>
        public RTHandle GetBackBuffer(CommandBuffer cmd)
        {
            ReAllocate(cmd);
            return PeekBackBuffer();
        }

        /// <summary>
        /// 初始化两个RT 并返回frontBuffer
        /// </summary>
        public RTHandle GetFrontBuffer(CommandBuffer cmd)
        {
            ReAllocate(cmd);
            return frontBuffer.rt;
        }

        public void Swap()
        {
            m_AisBackBuffer = !m_AisBackBuffer;
        }

        void ReAllocate(CommandBuffer cmd)
        {
            var desc = m_Desc;
            RenderingUtils.ReAllocateIfNeeded(ref m_A.rt, desc, m_FilterMode, TextureWrapMode.Clamp, name: m_A.name);
            RenderingUtils.ReAllocateIfNeeded(ref m_B.rt, desc, m_FilterMode, TextureWrapMode.Clamp, name: m_B.name);
            cmd.SetGlobalTexture(m_A.name, m_A.rt);
            cmd.SetGlobalTexture(m_B.name, m_B.rt);
        }

        public void Clear()
        {
            m_AisBackBuffer = true;
        }

        public void SetCameraSettings(RenderTextureDescriptor desc, FilterMode filterMode)
        {
            m_Desc = desc;
            m_Desc.depthBufferBits = 0;
            m_Desc.msaaSamples = 1;
            m_FilterMode = filterMode;
        }
    }
}
