package shaderc.options;

enum abstract VulkanVersion(UInt) {
	var Vulkan1_0 = 1 << 22;
	var Vulkan1_1 = (1 << 22) | (1 << 12);
	var Vulkan1_2 = (1 << 22) | (2 << 12);
}
