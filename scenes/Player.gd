extends CharacterBody2D

@export var gravity = 800.0
@export var walk_speed = 400
@export var jump_speed = -400
@export var dash_speed = 800  # Kecepatan dash
@export var dash_duration = 0.4  # Durasi dash
@export var dash_cooldown = 0.3  # Cooldown sebelum bisa dash lagi
@export var max_jumps = 2  # Maksimal lompatan (double jump)

@onready var sprite = $AnimatedSprite2D 

var last_input_time = {}
var is_dashing = false
var dash_direction = 0  # Arah dash (-1 = kiri, 1 = kanan)
var dash_timer = 0
var jump_count = 0 
var is_crouching = false 

func _physics_process(delta):
	velocity.y += delta * gravity

	# Reset jumlah jump kalau sudah di ground lagi
	if is_on_floor():
		jump_count = 0

	# Cek Input Jongkok
	if is_on_floor() and Input.is_action_pressed("ui_down"):
		is_crouching = true
	else:
		is_crouching = false

	# Double Jump
	if Input.is_action_just_pressed("ui_up") and jump_count < max_jumps and not is_crouching:
		velocity.y = jump_speed
		if jump_count == 0:
			sprite.play("jump")
		else:
			sprite.play("double_jump")
		jump_count += 1

	# Cek Double Tap untuk Dash (Bisa Dash juga di Udara)
	if Input.is_action_just_pressed("ui_left"):
		check_double_tap("ui_left", -1)
	elif Input.is_action_just_pressed("ui_right"):
		check_double_tap("ui_right", 1)

	# Dash Control
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false  # Dash stopped saat durasi habis

	# Gerakan hanya jika tidak dalam dash dan tidak jongkok
	if not is_dashing and not is_crouching:
		if Input.is_action_pressed("ui_left"):
			velocity.x = -walk_speed
			sprite.flip_h = true
		elif Input.is_action_pressed("ui_right"):
			velocity.x = walk_speed
			sprite.flip_h = false
		else:
			velocity.x = 0
	elif is_crouching:
		velocity.x = 0  # Saat jongkok, karakter diam

	# Animasi sesuai status karakter
	if is_crouching:
		sprite.play("crouch")  # jongkok
	elif is_dashing:
		sprite.play("dash")  # Dash
	elif not is_on_floor():
		if velocity.y < 0:
			if jump_count == 2:
				sprite.play("double_jump")  # Double jump
			else:
				sprite.play("jump")  # Jump
		else:
			sprite.play("fall")  # Fall
	elif velocity.x != 0:
		sprite.play("walk") # Walk
	else:
		sprite.play("stand") # Stand

	move_and_slide()

# Double tap to Dash
func check_double_tap(action, direction):
	var current_time = Time.get_ticks_msec() / 1000.0  
	if action in last_input_time and current_time - last_input_time[action] < 0.3:  # Jika ditekan dua kali dalam 0.3 detik
		start_dash(direction)
	last_input_time[action] = current_time 

func start_dash(direction):
	if not is_dashing:
		is_dashing = true
		dash_direction = direction
		dash_timer = dash_duration
		velocity.x = dash_speed * direction 
