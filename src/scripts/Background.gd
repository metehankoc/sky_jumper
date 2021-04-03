extends ParallaxBackground

const backspeed = 0.1
const middlespeed = 0.2
const frontspeed = 0.3

func _process(_delta):
	$ParallaxLayerBack.motion_offset.x -= backspeed
	$ParallaxLayerMid.motion_offset.x -= middlespeed
	$ParallaxLayerFront.motion_offset.x -= frontspeed
