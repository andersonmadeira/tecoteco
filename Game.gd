extends Node2D

export(PackedScene) var terrain_scene
export(int) var terrain_width

var last_terrain

func _ready():
	last_terrain = get_node("Terrain")
	last_terrain.connect("spawn_point_reached", self, "_on_Terrain_spawn_point_reached")

func _on_Terrain_spawn_point_reached():
	spawn_terrain()
	
func spawn_terrain():
	print("Spawning new terrain!")
	var terrain_location = last_terrain.position + Vector2(terrain_width, 0)
	var next_terrain = terrain_scene.instance()
	next_terrain.position = terrain_location
	next_terrain.connect("spawn_point_reached", self, "_on_Terrain_spawn_point_reached")
	add_child(next_terrain, true)
	last_terrain = next_terrain
