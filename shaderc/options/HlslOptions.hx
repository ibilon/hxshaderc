package shaderc.options;

/**
	HLSL specific options.

	These are ignored if the source language is GLSL.
**/
@:structInit
class HlslOptions {
	/**
		Whether the compiler should enable extension `SPV_GOOGLE_hlsl_functionality1`.

		Defaults to `false`.
	**/
	@:optional public var functionality1:Null<Bool>;

	/**
		Whether the compiler should use HLSL IO mapping rules for bindings.

		Defaults to `false`.
	**/
	@:optional public var ioMapping:Null<Bool>;

	/**
		Sets a descriptor set and binding for an HLSL register in the given stage.
	**/
	@:optional public var registerSetAndBinding:Null<Map<String, {set:String, binding:String}>>;

	/**
		Sets a descriptor set and binding for an HLSL register for all stages.
	**/
	@:optional public var registerSetAndBindingForStage:Null<Map<Kind, Map<String, {set:String, binding:String}>>>;
}
