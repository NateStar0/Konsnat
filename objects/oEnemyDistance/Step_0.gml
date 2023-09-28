/// @description 

if(!hp)
{
	instance_destroy();	
}

var distance = point_distance(x, y, oKons.x, oKons.y);

if(distance < 24 || distance > 40)
{
	hsp = sign(oKons.x - x) * spd;	
}

var onground = place_meeting(x, y + 1, pWall);

vsp += (onground) ? 0 : grav;

vsp = clamp(vsp, -10, 10);

hsp *= 0.9;

var fr = frac(hsp);
hsp -= fr;

if(place_meeting(x + hsp, y, pWall))
{
	while(!place_meeting(x + sign(hsp), y, pWall))
	{
		x += sign(hsp)	
	}
	
	hsp = 0;
}
	
x += hsp;
hsp += fr;

if(place_meeting(x, y + vsp, pWall))
{
	while(!place_meeting(x, y + sign(vsp), pWall))
	{
		y += sign(vsp)	
	}
	
	vsp = 0;
}

y += vsp;
