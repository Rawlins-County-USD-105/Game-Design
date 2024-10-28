extends Node3D

var peer = ENetMultiplayerPeer.new()

@export var player_scene : PackedScene
@onready var line_edit: LineEdit = $CanvasLayer/BoxContainer/LineEdit

const PORT = 9999 

func _on_host_pressed() -> void:
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)
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
	

func del_player(peer_id):
	var player = get_node_or_null(str(peer_id))
	if player:
		player.queue_free()

func _on_line_edit_text_submitted(new_text: String) -> void:
	pass # Replace with function body.
