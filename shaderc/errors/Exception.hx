package shaderc.errors;

class Exception {
	public var message(default, null):String;

	function new(message:String) {
		this.message = message;
	}
}
