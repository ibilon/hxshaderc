package shaderc;

import cpp.NativeString;
import cpp.Pointer;
import haxe.ds.ReadOnlyArray;

/**
	The result of a compilation.
**/
@:allow(shaderc)
@:headerInclude('shaderc/shaderc.h')
class Result<T> {
	/**
		[Internal] This releases the `shaderc_compilation_result_t`.
	**/
	static function createBinary(ptr:Pointer<cpp.Void>):Result<ReadOnlyArray<Int>> {
		untyped __cpp__('shaderc_compilation_result_t result = (shaderc_compilation_result_t)((void*)ptr)');

		var warnings = NativeString.fromPointer(untyped __cpp__('shaderc_result_get_error_message(result)'));
		var data = new Array<Int>();

		untyped __cpp__('
			const uint32_t *native_data = (uint32_t*)shaderc_result_get_bytes(result);
			unsigned int length = shaderc_result_get_length(result) / 4;
			for (unsigned int i = 0; i < length; ++i) {
				data->push(native_data[i]);
			}

			shaderc_result_release(result);
		');

		return new Result(data, warnings);
	}

	/**
		[Internal] This releases the `shaderc_compilation_result_t`.
	**/
	static function createText(ptr:Pointer<cpp.Void>):Result<String> {
		untyped __cpp__('shaderc_compilation_result_t result = (shaderc_compilation_result_t)((void*)ptr)');

		var warnings = NativeString.fromPointer(untyped __cpp__('shaderc_result_get_error_message(result)'));
		var data = NativeString.fromPointer(untyped __cpp__('shaderc_result_get_bytes(result)'));

		untyped __cpp__('shaderc_result_release(result)');

		return new Result(data, warnings);
	}

	/** The compilation's output. **/
	public var data(default, null):T;

	/** The compilation's warnings. **/
	public var warnings(default, null):String;

	function new(data:T, warnings:String) {
		this.data = data;
		this.warnings = warnings;
	}
}
