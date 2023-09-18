extends Node

@export var tiles:Array[PackedScene];

@onready var player := get_owner();
@export var view_distance:int = 5;

var chunker;
var inst_chunks = {};
var prev_chunk_pos:Vector2i = Vector2i(2^63 - 1,2^63 - 1);
var queue:Array[Vector2i] = [];

func _ready():
	chunker = Chunker.new(16);
	loadChunks(player.position);

func instantiateChunk(chunk:Chunk):
	var chunkNode = Node3D.new();
	for x in range(chunk.chunk_data.size()):
		for y in range(chunk.chunk_data.size()):
			var obj = tiles[chunk.chunk_data[x][y]].instantiate();
			obj.position = Vector3(x,0,y);
			chunkNode.add_child(obj);
	chunkNode.position = Vector3(chunk.chunk_pos.x,0,chunk.chunk_pos.y);
	var idMesh = MeshInstance3D.new();
	var mat = StandardMaterial3D.new();
	mat.albedo_color = Color(0,1,1);
	idMesh.material_override = mat;
	add_child(idMesh);
	var vec = Vector3(chunk.chunk_pos.x,0,chunk.chunk_pos.y);
	add_child(chunkNode);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for pos in inst_chunks.keys(): 
		DebugDraw.draw_line(Vector3(pos.x,0,pos.y)*16, Vector3(pos.x,10,pos.y)*16, Color(1, 1, 0));

func loadChunks(ppos:Vector3):
	var chunk_pos = chunker.worldToChunk(ppos);
	if chunk_pos != prev_chunk_pos:
		renderAround(chunk_pos);
		prev_chunk_pos = chunk_pos;

func _physics_process(delta):
	loadChunks(player.position);
	if queue.size()>0:
		var chunk_spawn_pos = queue.pop_front();
		var chunk = chunker.getChunk(chunk_spawn_pos);
		inst_chunks.merge({chunk_spawn_pos:true});
		instantiateChunk(chunk);
	
func renderAround(chunk_pos:Vector2i):
	for x in range(-view_distance,view_distance):
		print(x)
		for y in range(-view_distance,view_distance):
			if pow(view_distance,2) < pow(x,2)+pow(y,2):
				
				continue;
			var shifted_chunk_pos = chunk_pos + Vector2i(x,y);
			if(inst_chunks.has(shifted_chunk_pos)):
				continue;
			queue.append(shifted_chunk_pos);
			
