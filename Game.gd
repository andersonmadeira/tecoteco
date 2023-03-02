extends Node2D

export(PackedScene) var terrain_scene
export(int) var terrain_width

var last_terrain
var is_playing = true
var score = 0
var highscore = 0

func _ready():
	last_terrain = get_node("Terrain")
	last_terrain.connect("spawn_point_reached", self, "_on_Terrain_spawn_point_reached")
	highscore = load_highscore()
	$HUD/HighscoreControl/HighscoreLabel.text = "Highscore: " + str(highscore)

func _on_Terrain_spawn_point_reached():
	spawn_terrain()

func spawn_terrain():
	print("Spawning new terrain!")
	var terrain_location = Vector2(last_terrain.position.x + terrain_width, 0)
	print("Spawned at")
	print(terrain_location)
	var next_terrain = terrain_scene.instance()
	next_terrain.position = terrain_location
	next_terrain.connect("spawn_point_reached", self, "_on_Terrain_spawn_point_reached")
	add_child(next_terrain)
	next_terrain.resume()
	last_terrain = next_terrain
	
func stop():
	is_playing = false
	get_tree().call_group("Terrain", "stop")
	
func restart():
	$HUD/RestartButton.hide()
	$HUD/GameOverText.hide()
	get_tree().reload_current_scene()

func _on_Player_crashed():
	stop()
	display_game_over()
	
	if score > highscore:
		highscore = score
		$HUD/HighscoreControl/HighscoreLabel.text = "Highscore: " + str(highscore)
		save_highscore(score)

func _on_RestartButton_pressed():
	restart()

func display_game_over():
	$HUD/RestartButton.show()
	$HUD/GameOverText.show()
	$SoundBackground.stop()
	yield(get_tree().create_timer(0.5), "timeout")
	$SoundGameOver.play()

func _on_Player_start_game():
	$HUD/TapLeft.hide()
	$HUD/TapRight.hide()
	$HUD/TapAnimatedSprite.hide()
	$Player.resume()
	$Terrain.resume()
	$SoundBackground.play()

func _on_Player_collected_star():
	score += 1
	$HUD/ScoreControl/ScoreLabel.text = "Score: " + str(score * -1)
	
func save_highscore(score: int):
	var file = File.new()
	file.open_encrypted_with_pass("user://game.save", File.WRITE, "strongpass")
	file.store_line(to_json({ "highscore": score }))
	file.close()

func load_highscore() -> int:
	var file = File.new()
	
	if not file.file_exists("user://game.save"):
		return 0
		
	file.open_encrypted_with_pass("user://game.save", File.READ, "strongpass")
	
	var data = parse_json(file.get_line())
	return data["highscore"]
	
