extends Node2D

var game_paused = true # Keeps track of whether the game is paused
var player # Reference to the Player node

func _ready():
	# Get a reference to the Player node
	player = $Player # Adjust the path if needed
	# Pause the game when it starts
	get_tree().paused = true
	game_paused = true
	print("Game paused! Press A or D to start and jump.")

func _unhandled_input(event):
	if event.is_action_pressed("ui_left"):
		print("A key pressed (ui_left detected)")
		_resume_game()
		_jump($PadPlatform.position)
	elif event.is_action_pressed("ui_right"):
		print("D key pressed (ui_right detected)")
		_resume_game()
		_jump($LogPlatform.position)
	else:
		print("Unhandled input: ", event)


func _resume_game():
	# Unpause the game and set the flag
	get_tree().paused = false
	game_paused = false
	print("Game resumed!")

func _jump(target_position):
	# Move the player to the target position
	if player:
		player.position = target_position
		print("Player jumped to position: ", target_position)
	else:
		print("Player node not found!")
