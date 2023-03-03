/// @description Run everything

//hasControl = true;

image_xscale = 1;
image_speed = 1;

x = xstart;
y = ystart;

spd = 
{
	hsp : 
	{
		val : 0,
		acc : 1,
		mx : 4,
		jmp: 4,
		fric : 
		{
			onground : 0.5,
			offground : 0.15
		},
		
		frc : 0
	},
	
	vsp :
	{
		val : 0,
		grav : 
		{
			onwall : 0.1,
			offwall : 0.3
		},
		
		mx : 
		{
			offwall: 10,
			onwall : 4
		},
		
		boost :
		{
			offwall: -6,
			onwall: -5,
		},
		
		frc : 0
	}
}

ability_data = 
{
	shard :
	{
		has_shard : false,
		has_silence : false,
		has_damage : false,
		
		angle : 0,
		rotspd : 4,
		spd : 8,
		peek : 64,
		
		x : 0, 
		y : 0,
		
		dist : 16,
		resetdist : 16,
		
		thrown : false
	}
	
}

jumpbuffer = 0;
jumpdelay = 0;
jumpdelaymx = 12;

throwing = false;

onground = false;
onwall = 0;

abilities = function ()
{
	var in = global.input;
	
	// Shard
	ability_data.shard.has_shard |= place_meeting(x, y, oOrb);
	
	if(ability_data.shard.has_shard)
	{
		if(ability_data.shard.thrown)
		{
			ability_data.shard.dist += ability_data.shard.spd;
			ability_data.shard.thrown = (ability_data.shard.dist < VW_WIDTH * 2)
			
			if(ability_data.shard.has_damage && place_meeting(ability_data.shard.x + lengthdir_x(ability_data.shard.dist, ability_data.shard.angle), ability_data.shard.y + lengthdir_y(ability_data.shard.dist, ability_data.shard.angle), pEnemy))
			{
				instance_place(ability_data.shard.x + lengthdir_x(ability_data.shard.dist, ability_data.shard.angle), ability_data.shard.y + lengthdir_y(ability_data.shard.dist, ability_data.shard.angle), pEnemy).hp -= 1;
				ability_data.shard.thrown = false;
			}
			
			if(place_meeting(ability_data.shard.x + lengthdir_x(ability_data.shard.dist, ability_data.shard.angle), ability_data.shard.y + lengthdir_y(ability_data.shard.dist, ability_data.shard.angle), pWall))
			{
				while(place_meeting(ability_data.shard.x + lengthdir_x(ability_data.shard.dist, ability_data.shard.angle), ability_data.shard.y + lengthdir_y(ability_data.shard.dist, ability_data.shard.angle), pWall))	
				{
					ability_data.shard.dist--;	
				}
				
				x = ability_data.shard.x + lengthdir_x(ability_data.shard.dist, ability_data.shard.angle);
				y = ability_data.shard.y + lengthdir_y(ability_data.shard.dist, ability_data.shard.angle);
				
				ability_data.shard.thrown = false;
				
				if(!ability_data.shard.has_silence)
				{
					create_shockwave(x, y, VW_WIDTH, 4);
					shake_cam(2, 2)
				}
			}
			
			if(!ability_data.shard.thrown)
			{
				ability_data.shard.dist = ability_data.shard.resetdist;	
				ability_data.shard.x = x;
				ability_data.shard.y = y;
			}
		}
		else
		{
			ability_data.shard.angle += (throwing) ?  (in[3][INPUTTYPE.HOLD] - in[2][INPUTTYPE.HOLD]) * -ability_data.shard.rotspd : ability_data.shard.rotspd;
			ability_data.shard.x = x;
			ability_data.shard.y = y;
			
			oCamera.offset_x = (throwing) ? lengthdir_x(ability_data.shard.peek, ability_data.shard.angle) : 0;
			oCamera.offset_y = (throwing) ? clamp(lengthdir_y(ability_data.shard.peek, ability_data.shard.angle), -ability_data.shard.peek, 0) : 0;
			
			if(ability_data.shard.angle > 360) ability_data.shard.angle -= 360;
			if(ability_data.shard.angle < 0) ability_data.shard.angle += 360;
			
			oCamera.state = (throwing) ? camera_state.free : oCamera.restore_state;
		}
		
		if((in[1][INPUTTYPE.RELEASE]))
		{
			ability_data.shard.thrown = true;
			shake_cam(3, 5);
		}
	}
}

run = function ()
{
	if(!hasControl) exit;
	
	var in = global.input;
	var dir = (in[3][INPUTTYPE.HOLD] - in[2][INPUTTYPE.HOLD]);
	
	onground = place_meeting(x, y + 1, pWall);
	onwall = place_meeting(x + 1, y, pWall) - place_meeting(x - 1, y, pWall);
	
	throwing = in[1][INPUTTYPE.HOLD];
	
	jumpdelay = max(0, jumpdelay - 1);
	if(jumpdelay == 0)
	{
		var hmx = (onwall == 0) ? spd.hsp.mx : spd.hsp.jmp;
		
		spd.hsp.val += (!throwing) ? dir * spd.hsp.acc : 0;
		spd.hsp.val = clamp((dir == 0) ? approach(spd.hsp.val, 0, (onground) ? spd.hsp.fric.onground : spd.hsp.fric.offground) : spd.hsp.val, -hmx, hmx);
	}
	
	if(onwall != 0 && !onground && (in[0][INPUTTYPE.HOLD]))
	{
		spd.hsp.val = -onwall * spd.hsp.jmp;
		spd.vsp.val = spd.vsp.boost.onwall
	
		spd.hsp.frc = 0;
		spd.vsp.frc = 0;
		
		jumpdelay = jumpdelaymx
	}
	
	spd.vsp.val += (!onground) ? ((onwall == 0) ? spd.vsp.grav.offwall : spd.vsp.grav.offwall) : 0;
	
	if(jumpbuffer > 0)
	{
		jumpbuffer--;
		
		if(in[0][INPUTTYPE.HOLD])
		{
			jumpbuffer = 0;
			spd.vsp.val = spd.vsp.boost.offwall;
			spd.vsp.frc = 0;
		}
	}
	
	var vmx = (onwall == 0) ? spd.vsp.mx.offwall : spd.vsp.mx.onwall;
	spd.vsp.val = clamp(spd.vsp.val, -vmx, vmx);
	
	spd.hsp.val += spd.hsp.frc;
	spd.vsp.val += spd.vsp.frc;
	spd.hsp.frc = frac(spd.hsp.val);
	spd.vsp.frc = frac(spd.vsp.val);
	spd.hsp.val -= spd.hsp.frc;
	spd.vsp.val -= spd.vsp.frc;
	
	image_xscale = (spd.hsp.val != 0) ? sign(spd.hsp.val) : image_xscale;
	image_speed = abs(sign(spd.hsp.val));
	
	if(place_meeting(x + spd.hsp.val, y, pWall))
	{
		while(!place_meeting(x + sign(spd.hsp.val), y, pWall))
		{
			x += sign(spd.hsp.val)	
		}
		
		spd.hsp.val = 0;
		spd.hsp.frc = 0;
	}
	
	x += spd.hsp.val;
	
	if(place_meeting(x, y + spd.vsp.val, pWall))
	{
		while(!place_meeting(x, y + sign(spd.vsp.val), pWall))
		{
			y += sign(spd.vsp.val);
		}
		
		spd.vsp.val = 0;
		spd.vsp.frc = 0;
		
		shake_cam(3, 5);
	}
	
	y += spd.vsp.val;
	
	if(onground) jumpbuffer = 6;
	
	abilities();
}

draw = function ()
{
	draw_self();
	
	if(ability_data.shard.has_shard) draw_sprite(sOrb, 0, ability_data.shard.x + lengthdir_x(ability_data.shard.dist, ability_data.shard.angle), ability_data.shard.y + lengthdir_y(ability_data.shard.dist, ability_data.shard.angle));
}
