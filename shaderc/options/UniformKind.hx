package shaderc.options;

enum abstract UniformKind(Int) {
	var Image = 0;
	var Sampler = 1;
	var Texture = 2;
	var Buffer = 3;
	var StorageBuffer = 4;
	var UnorderedAccessView = 5;
}
