extends CharacterBody2D

var platforms = []  # Array to store references to platforms
var snapped_to_platform = false  # Ensure this runs only once

func _ready():
	# Access platforms using absolute paths
	platforms = [
		get_node("/root/Main/PadPlatform"),
		get_node("/root/Main/LogPlatform"),
		get_node("/root/Main/TwigPlatform")
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
