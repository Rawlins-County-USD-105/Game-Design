extends Node3D

var peer = ENetMultiplayerPeer.new()

@export var player_scene : PackedScene

func _on_host_pressed() -> void:
	peer.create_server(1027)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	add_player()
	$CanvasLayer.hide()
	
func _on_join_pressed() -> void:
	peer.create_client("localhost", 1027)
	multiplayer.multiplayer_peer = peer
	$CanvasLayer.hide()

func add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	print(player.name)
	call_deferred("add_child", player)
	

func del_player(id):
	rpc("_del_player", id)
	
@rpc("any_peer", "call_local")

func _del_player(id):
	get_node(str(id)).queue_free()
	
func exit_game(id):
	multiplayer.peer_disconnected.connect(del_player)
	del_player(id)
