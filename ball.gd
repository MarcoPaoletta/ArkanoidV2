extends RigidBody2D

export var prob_gift : float = 0.3

onready var break_s : AudioStreamPlayer2D = get_node("break")
onready var start_s : AudioStreamPlayer2D = get_node("start")
onready var you_win_s : AudioStreamPlayer2D = get_node("you_win")
onready var lose_s : AudioStreamPlayer2D = get_node("lose")
onready var hit_s : AudioStreamPlayer2D = get_node("hit")

const SPEED_X = 70
const SPEED_Y = -300

var game_started : bool = false


func _input(event):
	if event.is_action_pressed("iniciar") and not game_started:
		linear_velocity = Vector2(SPEED_X,SPEED_Y)
		game_started = true
		start_s.play()
		set_as_toplevel(true)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for body in get_colliding_bodies():
		if body.is_in_group("gr_blocks"):
			hit_block(body)
		else:
			hit_regular(body)

func generate_gift(pos : Vector2) -> void:
	var prob0 : float = randf()
	if prob0 < prob_gift:
		var gift_scn : PackedScene = load("res://gift.tscn")
		var gift_node : RigidBody2D = gift_scn.instance()
		gift_node.position = pos
		var world_node = get_node("/root/world")
		world_node.add_child(gift_node)

func hit_block(body):
	generate_gift(body.position)
	body.queue_free()
	break_s.play()
	
	if body.get_parent().get_child_count() == 1:
		print("GANA")
		you_win_s.play()
		get_tree().paused = true
		yield(you_win_s,"finished")
		queue_free()
		var replay_scn = load("res://title/replay.tscn")
		get_parent().add_child(replay_scn.instance())

	
func hit_regular(body):
	hit_s.play()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	print("PIERDE")
	get_tree().paused = true
	lose_s.play()
	yield(lose_s,"finished")
	queue_free()
	var replay_scn = load("res://title/replay.tscn")
	get_parent().add_child(replay_scn.instance())
	
