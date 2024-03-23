extends CharacterBody2D


var FLIGHT_SPEED = 150.0
const JUMP_VELOCITY = -400.0
var fuel = 5000
var horizontalSpeed = 200
var health = 3
var targetPosition = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if fuel == 0:
		velocity.y += gravity * delta
	else:
		velocity.y = -1* FLIGHT_SPEED
		fuel -= 5

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * horizontalSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, horizontalSpeed)

	move_and_slide()
	
	
	if get_last_slide_collision() != null:	
		var collision = get_last_slide_collision()
		print("Collided with: ", collision.get_collider().name)
		if collision.get_collider().name == "TileMap":
			print("passed")
			health -= 1
			if health == -1:
				get_tree().quit()
			get_node("CollisionShape2D").disabled = true
			position.y -= 200
			get_node("CollisionShape2D").disabled = false
			
	
	
	

	
func increaseHorizontalSpeed():
	horizontalSpeed += 20
		
func increaseFuel():
	fuel += 1000
	print(fuel)
		
func increaseHealth():
	if health < 3:
		health += 1
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
