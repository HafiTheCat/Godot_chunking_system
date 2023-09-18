extends Node3D

class TILE:
	var mesh;
	func _init(color):
		self.mesh = preload("res://tile.tscn");
		var mat_gray = StandardMaterial3D.new();
		mat_gray.albedo_color = 
		tile.instantiate();
		obj.get_child(0).material_override = mat_gray
		




var tile:PackedScene = preload("res://tile.tscn")
var grid = [];
var spacing = 1;
var lb = 0;
var ub = 0.8;

var rng = RandomNumberGenerator.new();

func _ready():
	rng.randomize();
	var my_random_number = rng.randf_range(-10.0, 10.0);
	spawn(5,3);

func biased(val:int, _lb:int,_ub:int):
	return val+rng.randi_range(_lb, _ub);

func spawn(x_size:int,y_size:int):
	var mat_gray = StandardMaterial3D.new();
	mat_gray.albedo_color = Color(biased(0,lb,ub),biased(0,lb,ub),biased(0,lb,ub));
	var mat_yellow = StandardMaterial3D.new();
	mat_yellow.albedo_color = Color(1,1,0);
	for x in range(x_size):
		grid.append([]);
		for y in range(y_size):
			var obj = tile.instantiate();
			if (x+y+1)%2==0:
				obj.get_child(0).material_override = mat_gray;
			else:
				obj.get_child(0).material_override = mat_yellow;
			var x_size_idx = x_size-1;
			var y_size_idx = y_size-1;
			var newX = ((x_size_idx)*spacing)/2;
			var newY = ((y_size_idx)*spacing)/2;
			obj.position = Vector3(x*spacing-newX,0,y*spacing-newY);
			add_child(obj);
			grid[x].append(TILE.new(obj));

