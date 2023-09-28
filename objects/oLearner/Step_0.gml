/// @description 

net.parse([(oKons.x - x) / VW_WIDTH, (y - oKons.y) / 24]);

var calculant = net.getLayer(net.layerCount - 1);

hsp = calculant[0] * spd;
log(hsp)

if(!hp)
{
	instance_destroy();	
}

var onground = place_meeting(x, y + 1, pWall);

vsp += (onground) ? 0 : grav;
vsp = clamp(vsp, -10, 10);

var fr = frac(hsp);
hsp -= fr;

if(keyboard_check_pressed(ord("L")))
{
	net = new network(layerLengths)	
}

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
