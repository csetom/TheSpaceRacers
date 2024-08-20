extends Node2D
#@export var player_scene:PackedScene
const Player = preload("res://Scenes/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.player_loaded.rpc_id(1)
	#Lobby.player_connected.connect(Lobby.load_game(self))
	Lobby.player_disconnected.connect(destroy_player)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_game():
	for id in Lobby.players.keys():
		create_player(id)

func create_player(id):
	# Instantiate a new player for this client.
	var p = Player.instantiate()
	# Sets the player name (only sent during spawn).
	p.player_name = "Player %d" % id
	# Set a random position (sent on every replicator update).
	# Add it to the "Players" node.
	# We give the new Node a name for easy retrieval, but that's not necessary.
	p.name = str(id)
	add_child(p)
	
func destroy_player(id):
	# Delete this peer's node.
	get_node(str(id)).queue_free()
