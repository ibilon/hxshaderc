package shaderc.options;

/**
	Target environment.
**/
enum TargetEnvironment {
	/** Compile under Vulkan semantics. **/
	Vulkan(version:VulkanVersion);

	/** Compile under OpenGL semantics. **/
	OpenGL;

	/**
		Compile under OpenGL semantics, including compatibility profile functions.

		NOTE: SPIR-V code generation is not supported for shaders under OpenGL compatibility profile.
	**/
	OpenGLCompat;

	/** Compile under WebGPU semantics. **/
	WebGPU;
}
