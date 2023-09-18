class_name Chunker

var chunk_size:int;
var gen:Generator;
var grid = {};

func _init(chunk_size):
	self.chunk_size = chunk_size;
	self.gen = Generator.new(chunk_size)
	
func getChunk(pos:Vector2i) -> Chunk:
	var id:String = str(pos.x)+"#"+str(pos.y);
	if(grid.has(id)):
		return grid.get(id);
	var gend_chunk = self.gen.genchunk(self.chunkToWorld(pos));
	grid.merge({id:gend_chunk});
	return gend_chunk;

func chunkToWorld(chunk_pos:Vector2i) -> Vector2i:
	return chunk_pos * self.chunk_size;

func worldToChunk(pos:Vector3) -> Vector2i:
	var vec = Vector2i(pos.x,pos.z) / self.chunk_size;
	vec.x -= 1 if pos.x<=0 else 0;
	vec.y -= 1 if pos.z<=0 else 0;
	return vec;
	
class ExtPos:
	var chunkpos:Vector2i;
	var pos:Vector2i;
