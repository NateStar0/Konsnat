/// @description 

y = ystart + wave(-4, 4, 0.5, 2);

if(place_meeting(x, y, oKons))
{
	instance_destroy();	
}

/*
var in = global.input;

if(collected)
{
	if(!thrown)
	{
		mask_index = sOrb
		
		lx = oKons.x
		ly = oKons.y
		
		dist = startdist

		angle += (in[1][inp.hold]) ? (in[3][inp.hold] - in[2][inp.hold]) * rotspd : rotspd
		
		if(in[1][inp.hold])
		{
			oCamera.offset_x = lengthdir_x(48, angle)	
			oCamera.offset_y = lengthdir_y(48, angle)	
		}
		else
		{
			oCamera.offset_x = 0	
			oCamera.offset_y = 0
		}
		
		image_xscale = 1;
	}
	else
	{
		mask_index = oKons.mask_index
		dist += spd;
		
		thrown = (dist < VW_WIDTH * 1.5)
		
		if(place_meeting(x, y, pWall))
		{
			while(place_meeting(lx + lengthdir_x(dist + 8, angle), ly + lengthdir_y(dist + 8, angle), pWall))
			{
				dist--;
			}
			
			oKons.x = lx + lengthdir_x(dist, angle);
			oKons.y = ly + lengthdir_y(dist, angle);
			
			thrown = false;
			
			repeat(6)
			{
				//lx + lengthdir_x(dist, angle), ly + lengthdir_y(dist, angle)
				with(instance_create_depth(oKons.x, oKons.y, -999999, oHitParticle))
				{
					sprite_index = sHitWall;
					image_angle = random(360)
					image_speed = 0.0005;
					fric = 0.8;
					
					motion_add(other.image_angle + random_range(-70, 70), random_range(-4, -9))
				}
			}
		}
		
		image_xscale = max(spd / sprite_width, 1)
	}
	
	x = lx + lengthdir_x(dist, angle);
	y = ly + lengthdir_y(dist, angle);
	
	if((in[1][inp.release]))
	{
		thrown = true;
		
		lx = x;
		ly = y;
	}
}
else
{
	if(place_meeting(x, y, oKons))
	{
		collected = true;	
	}
	
	
	y = ystart + wave(-4, 4, 0.5, 2)
}

