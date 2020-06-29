package shaderc.options;

enum abstract SpirvVersion(UInt) {
	var V1_0 = 0x010000;
	var V1_1 = 0x010100;
	var V1_2 = 0x010200;
	var V1_3 = 0x010300;
	var V1_4 = 0x010400;
	var V1_5 = 0x010500;
}
