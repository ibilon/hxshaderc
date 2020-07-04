package shaderc.options;

/**
	Optimization level.
**/
enum abstract OptimizationLevel(Int) {
	/** No optimization. **/
	var Zero = 0;

	/** Optimize towards reducing code size. **/
	var Size = 1;

	/** Optimize towards performance. **/
	var Performance = 2;
}
