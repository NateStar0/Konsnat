/// @description Wave The orb

// Move the orb up and down upon the y-axis, with an offset of -4 to 4 from the ystart

y = ystart + wave(-4, 4, 0.5, 2);


// Destroy the orb if we're touching the player

if(place_meeting(x, y, oKons))
{
	instance_destroy();	
}
