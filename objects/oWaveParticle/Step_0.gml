/// @description Move the particle closer to the target distance

// Countdown distance to target

dist = max(0, dist - 1);

// Destroy particle when the distance is met

if(!dist || place_meeting(x, y, pWall))
{
	instance_destroy();	
}

