package sample;

import shaderc.*;
import shaderc.errors.CompilationFailureException;

class Main {
	static function main() {
		trace(Compiler.spirvVersion);
		trace(Compiler.parseVersionProfile("450core").profile == Core);
		trace(Compiler.parseVersionProfile("320").profile == None);
		trace(Compiler.parseVersionProfile("error") == null);

		var compiler = new Compiler();

		function compile(source:String, kind:Kind, filename:String, entryPoint:String) {
			try {
				var result = compiler.compile(source, kind, filename, entryPoint);

				if (result.warnings.length > 0) {
					trace(filename, result.warnings);
				}

				trace(filename, result.data.length);
			} catch (e:CompilationFailureException) {
				trace(e.reason);
			}
		}

		compile("#version 450core\nint main() {}", Vertex, "test1.vs", "main");
		compile("#version 450core\nvoid main() {}", Vertex, "test2.vs", "main");

		compiler.release();
	}
}
