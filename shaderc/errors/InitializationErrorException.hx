package shaderc.errors;

/**
	An error occurred during initialization.
**/
@:allow(shaderc)
class InitializationErrorException extends Exception {
	function new() {
		super("An error occurred during initialization");
	}
}
