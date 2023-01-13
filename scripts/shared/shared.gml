
function create_shockwave(x, y, distance, spd)
{
	for(var i = 0; i < 360; i += 3)
	{
		with(instance_create_layer(x, y, oKons.layer, oWaveParticle))
		{
			dist = distance;
			speed = spd;
			direction = i;
		}
	}
}

function shake_cam(time, mag) 
{
	with(oCamera)
	{
		if(time > shake_rem)
		{
			shake_mag = time;
			shake_rem = time;
			shake_mag = mag;
		}
	}
}

