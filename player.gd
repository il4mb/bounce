extends KinematicBody2D

const GRAVITY = 350.0
const WALK_SPEED = 250
const JUMP = 400

const velocity = Vector2()
var is_runn = false

func _physics_process(delta):
	
	if ! is_on_floor():
		velocity.y += delta * GRAVITY
	
	if is_runn : 
		if velocity.x > 0 :
			velocity.x -= 2
		elif velocity.x < 0 :
			velocity.x += 2
		else :
			is_runn = false
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
		is_runn = true
		
	elif Input.is_action_pressed("ui_right"):
		velocity.x = WALK_SPEED
		is_runn = true
	
	if Input.is_action_just_pressed("ui_up") :
		# jump
		if velocity.y <= 10 && velocity.y > -10 :
			velocity.y = -JUMP
		
	elif Input.is_action_just_pressed("ui_down") :
		# down
		print("nothing")
	else: 
		if is_on_floor():
			velocity.y = (velocity.y/2) - velocity.y # efek memantul
	
	if is_on_ceiling() :
		print((velocity.y/200)*velocity.y)
		velocity.y = (velocity.y/200)*velocity.y
		
	print(velocity.y)
	move_and_slide(velocity, Vector2(0, -1))

		
	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
