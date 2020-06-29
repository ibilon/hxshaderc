package shaderc.options;

@:structInit
class HlslOptions {
	@:optional public var functionality1:Null<Bool>;

	@:optional public var ioMapping:Null<Bool>;

	@:optional public var offsets:Null<Bool>;

	@:optional public var registerSetAndBinding:Null<Map<String, {descriptorSet:String, binding:String}>>;

	@:optional public var registerSetAndBindingForStage:Null<Map<ShaderKind, Map<String, {descriptorSet:String, binding:String}>>>;
}
