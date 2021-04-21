extends ParallaxBackground

export(Vector2) var back_layer_speed = Vector2(-10, -4)
export(Vector2) var mid_layer_speed = Vector2(-20, -4)
export(Vector2) var front_layer_speed = Vector2(-30, -4)


const backspeed = 0.1
const middlespeed = 0.2
const frontspeed = 0.3

func _process(delta):
	$ParallaxLayerBack.motion_offset += back_layer_speed * delta
	$ParallaxLayerMid.motion_offset += mid_layer_speed * delta
	$ParallaxLayerFront.motion_offset += front_layer_speed * delta
