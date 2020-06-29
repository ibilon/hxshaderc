package shaderc.options;

enum TargetEnvironment {
	Vulkan(version:VulkanVersion);
	OpenGL;
	OpenGLCompat;
	WebGPU;
}
