package shaderc;

/**
	Shader kind.

	* The <stage> enumerants are forced shader kinds, which force the compiler to compile the source code as the specified kind of shader, regardless of #pragma directives in the source code.
	* The Default<stage> enumerants are default shader kinds, which allow the compiler to fall back to compile the source code as the specified kind of shader when #pragma is not found in the source code.
**/
enum abstract Kind(Int) {
	var Vertex = 0;
	var Fragment = 1;
	var Compute = 2;
	var Geometry = 3;
	var TessellationControl = 4;
	var TessellationEvaluation = 5;
	var InferFromSource = 6;
	var DefaultVertex = 7;
	var DefaultFragment = 8;
	var DefaultCompute = 9;
	var DefaultGeometry = 10;
	var DefaultTessellationControl = 11;
	var DefaultTessellationEvaluation = 12;
	var SpirvAssembly = 13;
	var RayGeneration = 14;
	var AnyHit = 15;
	var ClosestHit = 16;
	var Miss = 17;
	var Intersection = 18;
	var Callable = 19;
	var DefaultRayGeneration = 20;
	var DefaultAnyHit = 21;
	var DefaultClosestHit = 22;
	var DefaultMiss = 23;
	var DefaultIntersection = 24;
	var DefaultCallable = 25;
	var Task = 26;
	var Mesh = 27;
	var DefaultTask = 28;
	var DefaultMesh = 29;
}
