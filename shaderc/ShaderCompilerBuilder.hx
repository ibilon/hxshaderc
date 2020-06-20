package shaderc;

#if macro
import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;
#end

@:dox(hide)
@:noCompletion
class ShaderCompilerBuilder {
	/**
		Build macro for shaderc, adds a @:buildXml meta with the correct path to the built static library.
	**/
	public static macro function build():Array<Field> {
		var path = switch (Context.getType("shaderc.ShaderCompilerBuilder")) {
			case TInst(_.get() => t, _):
				FileSystem.absolutePath(Path.join([Path.directory(Context.getPosInfos(t.pos).file), ".."]));

			default:
				throw "can't find the shaderc.ShaderCompilerBuilder type";
		}

		Context.getLocalClass().get().meta.add(":buildXml", [
			{
				expr: EConst(CString('
					<files id="haxe">
						<compilerflag value="-I$path/shaderc-native/libshaderc/include" />
					</files>
					<target id="haxe">
						<flag value="-L$path/build" />
						<lib name="-lshaderc_combined" />
						<lib name="-lpthread" />
					</target>
				')),
				pos: Context.currentPos()
			}
		], Context.currentPos());

		return Context.getBuildFields();
	}
}
