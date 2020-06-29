package shaderc.errors;

@:allow(shaderc)
class InitializationErrorException extends Exception {
	function new() {
		super("Error during initialization");
	}
}
