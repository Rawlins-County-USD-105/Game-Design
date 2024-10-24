extends Node3D

var peer = ENetMultiplayerPeer.new()

@export var player_scene : PackedScene
@onready var line_edit: LineEdit = $CanvasLayer/BoxContainer/LineEdit

const PORT = 9999 

func _on_host_pressed() -> void:
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	add_player(multiplayer.get_unique_id())
	$CanvasLayer.hide()
	
func _on_join_pressed() -> void:
	peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = peer
	$CanvasLayer.hide()

func add_player(peer_id):
	var player = player_scene.instantiate()
	player.name = str(peer_id)
	add_child(player)
	

func del_player(id):
	rpc("_del_player", id)
	
@rpc("any_peer", "call_local")

func _del_player(id):
	get_node(str(id)).queue_free()
	
func exit_game(id):
	multiplayer.peer_disconnected.connect(del_player)
	del_player(id)

func _on_line_edit_text_submitted(new_text: String) -> void:
	pass # Replace with function body.
