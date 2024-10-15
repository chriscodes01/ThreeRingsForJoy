extends Node2D

const COMPLETIONMUSICSTREAM = "res://assets/audio/CompletionMusic.mp3"
const CREDITSMUSICSTREAM = "res://assets/audio/credits_music.mp3"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	playCompletionMusic()
	var rootScene = get_tree().get_current_scene()
	var scene_transition_animation = rootScene.find_child("CompletionTransition")
	var animationPlayer = scene_transition_animation.find_child("AnimationPlayer")
	#animationPlayer.play("fade_in")
	#await get_tree().create_timer(2).timeout
	#var default_items = get_tree().get_current_scene().find_child("CompletionMap/DefaultItems")
	#var items = default_items.get_children()
	#for item in items:
		#item.visible = true
	animationPlayer.play("fade_out")
	print("fade out")
	await get_tree().create_timer(1).timeout
	Input.action_press("jump")
	await get_tree().create_timer(2).timeout
	var thanks = get_tree().get_current_scene().find_child("Thanks")
	thanks.visible = true

func _on_timer_timeout():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	playCreditsMusic()
	var margin_container = get_tree().get_current_scene().find_child("Control")
	margin_container.visible = true
	var timer = get_tree().get_current_scene().find_child("Timer")
	timer.queue_free()
	
func playCompletionMusic():
	var musicPlayer = get_tree().get_current_scene().find_child("MusicPlayer")
	var completionMusic = load(COMPLETIONMUSICSTREAM)
	musicPlayer.stream = completionMusic
	musicPlayer.play()
	
func playCreditsMusic():
	var musicPlayer = get_tree().get_current_scene().find_child("MusicPlayer")
	var completionMusic = load(CREDITSMUSICSTREAM)
	musicPlayer.stream = completionMusic
	musicPlayer.play()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_return_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/MainMenu.tscn")
