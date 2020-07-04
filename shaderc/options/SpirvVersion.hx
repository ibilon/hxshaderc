package shaderc.options;

/**
	SPIR-V version.
**/
enum abstract SpirvVersion(Int) {
	/** SPIR-V version 1.0. **/
	var V1_0 = 0x010000;

	/** SPIR-V version 1.1. **/
	var V1_1 = 0x010100;

	/** SPIR-V version 1.2. **/
	var V1_2 = 0x010200;

	/** SPIR-V version 1.3. **/
	var V1_3 = 0x010300;

	/** SPIR-V version 1.4. **/
	var V1_4 = 0x010400;

	/** SPIR-V version 1.5. **/
	var V1_5 = 0x010500;
}
