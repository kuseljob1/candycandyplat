extends KinematicBody2D

const GRAVITY = 10
const ACCELERATION = 50
const MOVE_SPEED = 100
const JUMP_POWER = 230
const ANGLE = 90


onready var particles = $Particles2D


onready var sprite = $player 
onready var animation = $AnimationPlayer

var velocity: Vector2 = Vector2.ZERO

var isJump = false

func _physics_process(delta) -> void:
	move_player()
	if Input.is_action_pressed("ui_up"):
		particles.emitting = false
		animation.play("jump")
		jump()
		
	self.velocity.y += GRAVITY
	
	self.velocity = self.move_and_slide(self.velocity, Vector2.UP)




func jump() -> void:
	if self.is_on_floor():
		self.velocity.y -= JUMP_POWER

		

func move_player():
	if !isJump:
		var direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		if direction != 0:
			particles.emitting = true
			
			velocity.x += direction * ACCELERATION
			velocity.x = clamp(velocity.x, -MOVE_SPEED, MOVE_SPEED)
			
			sprite.flip_h = direction < 0
			
			if direction < 0:
				particles.rotation_degrees = ANGLE + 180
				
			else:
				particles.rotation_degrees = ANGLE
			animation.play("run")
		else:
			particles.emitting = false
			velocity.x *= 0
			animation.play("calm")
			
			

