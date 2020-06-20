package sample;

import shaderc.*;

class Main {
	static function main() {
		var compiler = new ShaderCompiler();
		compiler.release();
	}
}
