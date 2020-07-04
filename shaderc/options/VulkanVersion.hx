package shaderc.options;

/**
	Vulkan version.
**/
enum abstract VulkanVersion(UInt) {
	/** Vulkan version 1.0. **/
	var Vulkan1_0 = 1 << 22;

	/** Vulkan version 1.1. **/
	var Vulkan1_1 = (1 << 22) | (1 << 12);

	/** Vulkan version 1.2. **/
	var Vulkan1_2 = (1 << 22) | (2 << 12);
}
