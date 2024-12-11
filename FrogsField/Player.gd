extends CharacterBody2D

var platforms = []  # Array to store references to platforms
var snapped_to_platform = false  # Ensure this runs only once

var Log_scene = preload("res://FrogsField/Platforms/Log.tscn")
var Pad_scene = preload("res://FrogsField/Platforms/Pad.tscn")
var Twig_scene = preload("res://FrogsField/Platforms/Twig.tscn")

var lanes = [310, 445]  # X positions of the two lanes
var active_platforms = []

func _ready():
	# Access platforms using absolute paths
	platforms = [
		get_node("/root/FrogsField/PadPlatformBeta"),
		get_node("/root/FrogsField/TwigPlatformBeta"),
		get_node("/root/FrogsField/LogPlatformBeta")
	]
	_snap_to_closest_platform()


func _snap_to_closest_platform():
	if snapped_to_platform:
		return  # Ensure this logic only runs once

	var closest_platform = null
	var closest_distance = INF  # Set to a very large number initially

	# Iterate through all platforms
	for platform in platforms:
		var distance = position.distance_to(platform.position)  # Calculate distance
		if distance < closest_distance:
			closest_distance = distance
			closest_platform = platform

	# Snap the player to the closest platform
	if closest_platform:
		position = closest_platform.position
		snapped_to_platform = true  # Mark as completed
		print("Player snapped to platform: ", closest_platform.name)

func get_random_platform():
	var platforms = [Log_scene, Pad_scene, Twig_scene]
	return platforms[randi() % platforms.size()]
	
func spawn_platforms():
	for lane_x in lanes:
		var platform_scene = get_random_platform()
		var platform_instance = platform_scene.instantiate()
		add_child(platform_instance)
		
		# Position the platform
		platform_instance.position = Vector2(lane_x, -50)  # -50 to spawn off-screen

func _on_Timer2_timeout():
	spawn_platforms()

func is_lane_available(lane_x):
	for platform in active_platforms:
		if abs(platform.position.x - lane_x) < 10 and abs(platform.position.y - 200) < 200: #Ajust thresholds
			return false
	return true
