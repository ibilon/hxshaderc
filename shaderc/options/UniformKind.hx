package shaderc.options;

/**
	Uniform resource kinds.

	In Vulkan, uniform resources are bound to the pipeline via descriptors with numbered bindings and sets.
**/
enum abstract UniformKind(Int) {
	/** Image and image buffer. **/
	var Image = 0;

	/** Pure sampler. **/
	var Sampler = 1;

	/** Sampled texture in GLSL, and Shader Resource View in HLSL. **/
	var Texture = 2;

	/** Uniform Buffer Object (UBO) in GLSL. Cbuffer in HLSL. **/
	var Buffer = 3;

	/** Shader Storage Buffer Object (SSBO) in GLSL. **/
	var StorageBuffer = 4;

	/** Unordered Access View, in HLSL. (Writable storage image or storage buffer.) **/
	var UnorderedAccessView = 5;
}
