extends Sprite2D

# Speed for smooth falling
var fall_speed = 90.0  # Pixels per second

# State of the platform
var is_falling = false

func _ready():
	# Start the timer when the platform is ready
	$Timer.start()

	# Connect the Timer timeout signal to start falling
	$Timer.timeout.connect(_on_timer_timeout)

func _process(delta):
	if is_falling:
		# Smoothly move the platform downward
		position.y += fall_speed * delta

		# Optional: Remove the platform when it falls off-screen
		if position.y > 1000:  # Adjust this value to your screen's height
			queue_free()

# Called when the Timer finishes
func _on_timer_timeout():
	is_falling = true
