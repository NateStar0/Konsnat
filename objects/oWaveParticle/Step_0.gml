/// @description 

dist = max(0, dist - 1);

if(!dist || place_meeting(x, y, pWall))
{
	instance_destroy();	
}

