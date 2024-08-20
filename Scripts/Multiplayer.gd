# multiplayer.gd
extends Node

func _ready():
	pass

func _on_host_pressed() -> void:
	Lobby.create_game()
	print_debug("LOBBY");
	$UI/VBoxContainer/Start.show()
	$UI/VBoxContainer/HBoxContainer.hide()


func _on_connect_pressed() -> void:
	Lobby.join_game()
	$UI.hide()


func _on_start_pressed() -> void:
	Lobby.load_game.rpc("res://Scenes/mainScene.tscn")
