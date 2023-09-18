class_name Generator

var rng = RandomNumberGenerator.new();;
var chunk_size:int;

func _init(chunk_size):
	self.chunk_size = chunk_size;
	self.rng.randomize();
	
func genchunk(chunk_pos:Vector2i):
	var chunk = Chunk.new(chunk_pos);
	var chunk_data = []
	for x in range(self.chunk_size):
		chunk_data.append([]);
		for y in range(self.chunk_size):
			chunk_data[x].append(self.rng.randi_range(0,2));
	chunk.setChunkData(chunk_data);
	return chunk;
