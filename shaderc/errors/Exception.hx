package shaderc.errors;

/**
	Base exception class of shaderc.
**/
class Exception {
	/** Description of the error. **/
	public var message(default, null):String;

	function new(message:String) {
		this.message = message;
	}
}
