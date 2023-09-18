class_name Chunk

var chunk_pos:Vector2i;
var chunk_data;
func _init(chunk_pos):
	self.chunk_pos = chunk_pos;
func setChunkData(chunk_data):
	self.chunk_data = chunk_data;
