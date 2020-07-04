package shaderc;

import cpp.NativeString;
import cpp.Pointer;
import haxe.ds.ReadOnlyArray;

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
			const char *native_data = shaderc_result_get_bytes(result);
			for (unsigned int i = 0; i < shaderc_result_get_length(result) / 4; i += 4) {
				data->push((native_data[i * 4] << 24) | (native_data[i * 4 + 1] << 16) | (native_data[i * 4 + 2] << 8) | native_data[i * 4 + 3]);
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

	public var data(default, null):T;

	public var warnings(default, null):String;

	function new(data:T, warnings:String) {
		this.data = data;
		this.warnings = warnings;
	}
}
