/*

		=== -- oKons -- ===
		
		Primary Player Object
		
		
		
		
		
		-- Methods -- 
		
		Abilities : Manages the orb when collected 
		
		Run : Manages movements and collisions
		
		Draw : Draws the character with their appropriate animation sprites

*/

// Reset basic variables													
																			
image_xscale = 2;	
image_yscale = 2;
image_speed = 1;															
																			
x = xstart;																	
y = ystart;	


																			
// Cutscene control															
																			
hasControl = true;												//	(Boolean) Indicator of whether player can move/use player
	
	
	
// Speed														
																
hsp = 0;														//	(Real) Horizontal speed
																
hspMaximum = 4;													//	(Real) Absolute maximum horizontal speed
hspJump = 4;													//	(Real) Absolute speed as player is ejected from wall
hspAcceleration = 1;											//	(Real) Acceleration constant
hspFrictionOnground = 0.5;										//	(Real) Friction constant while walking
hspFrictionOffground = 0.15;									//	(Real) Friction constant while jumping
																
hspFraction = 0;												//	(Real) Fraction for collisions
																
																
vsp = 0;														//	(Real) vertical speed
																
vspGravityOnwall = 0.1;											//	(Real) Absolute acceleration due to gravity on wall
vspGravityOffWall = 0.3;										//	(Real) Absolute acceleration due to gravity in air
vspMaximumOnwall = 4;											//	(Real) Absolute maximum speed while falling mid air
vspMaximumOffwall = 10;											//	(Real) Absolute maximum speed while sliding on the wall
vspBoostOnwall = -5;											//	(Real) ΔSpeed from jumping off a wall
vspBoostOffwall = -6;											//	(Real) ΔSpeed from jumping off the floor
																
vspFraction = 0;												//	(Real) Fraction for collisions
				
				
				
// Orb data														
																
shardHasShard = false;											//	(Boolean) have we got the shard
shardHasSilence = false;										//	(Boolean) can the shard not produce noise
shardHasDamage = false;											//	(Boolean) can the shard deal dmg
																
shardAngle = 0;													//	(Real) Angle arround the player to draw / project the shard
shardRotationSpeed = 4;											//	(Real) change in angle per frame dA/dt
shardProjectionSpeed = 8;										//	(Real) change in distance per frame dD/dt
																
shardPeekOffset = 64;											//	(Real) camera offset while aiming the orb
																
shardX = 0;														//	(Real) x position of the shard
shardY = 0;														//	(Real) y position of the shard
																
shardDistance = 16;												//	(Real) offset of shard from center of player
shardResetDistance = 16;										//	(Real) reset distance, to fix previous variable after throwing.
																
shardThrown = false;											//	(Boolean) do we have the shard right now
throwing = false;												//	(Boolean) are we aiming the direction of the shard?

waveCount = 4;													//	(Real) Number of degrees between each wave's particle
	
	
	
// Jump stuff 													
																
jumpBuffer = 0;													//	(Real) fuck
jumpDelay = 0;													//	(Real) i 
jumpDelayMaximum = 12;											//	(Real) dont remember
																
	
	
// Other Stuff ig												
																
onground = false;												//	(Boolean) Is the player touching the ground
onwall = 0;														//	(Real) direction of any adjacent wall (-1 = left), 0 is none.
	
	

abilities = function ()
{
	// Shard
	shardHasShard |= place_meeting(x, y, oOrb);
	
	if(shardHasShard)
	{
		if(shardThrown)
		{
			shardDistance += shardProjectionSpeed;
			shardThrown = (shardDistance < VW_WIDTH * 2)
			
			if(shardHasDamage && place_meeting(shardX + lengthdir_x(shardDistance, shardAngle), shardY + lengthdir_y(shardDistance, shardAngle), pEnemy))
			{
				instance_place(shardX + lengthdir_x(shardDistance, shardAngle), shardY + lengthdir_y(shardDistance, shardAngle), pEnemy).hp -= 1;
				shardThrown = false;
			}
			
			if(place_meeting(shardX + lengthdir_x(shardDistance, shardAngle), shardY + lengthdir_y(shardDistance, shardAngle), pWall))
			{
				while(place_meeting(shardX + lengthdir_x(shardDistance, shardAngle), shardY + lengthdir_y(shardDistance, shardAngle), pWall))	
				{
					shardDistance--;	
				}
				
				x = shardX + lengthdir_x(shardDistance, shardAngle);
				y = shardY + lengthdir_y(shardDistance, shardAngle);
				
				shardThrown = false;
				
				if(!shardHasSilence)
				{
					for(var i = 0; i < 360; i += waveCount)
					{
						with(instance_create_layer(x, y, oKons.layer, oWaveParticle))
						{
							dist = VW_WIDTH * 2;
							speed = other.hspMaximum;
							direction = i;
						}
					}
					
					shake_cam(2, 2)
				}
			}
			
			if(!shardThrown)
			{
				shardDistance = shardResetDistance;	
				shardX = x;
				shardY = y;
			}
		}
		else
		{
			shardAngle += (throwing) ?  (global.input[3][INPUTTYPE.HOLD] - global.input[2][INPUTTYPE.HOLD]) * -shardRotationSpeed : shardRotationSpeed;
			shardX = x;
			shardY = y;
			
			oCamera.offset_x = (throwing) ? lengthdir_x(shardPeekOffset, shardAngle) : 0;
			oCamera.offset_y = (throwing) ? clamp(lengthdir_y(shardPeekOffset, shardAngle), -shardPeekOffset, 0) : 0;
			
			if(shardAngle > 360) shardAngle -= 360;
			if(shardAngle < 0) shardAngle += 360;
			
			//oCamera.state = (throwing) ? camera_state.free : oCamera.restore_state;
		}
		
		//if((global.input[1][INPUTTYPE.RELEASE]))
		{
			shardThrown = true;
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
	
	jumpDelay = max(0, jumpDelay - 1);
	if(jumpDelay == 0)
	{
		var hmx = (onwall == 0) ? hspMaximum : hspJump;
		
		hsp += (!throwing) ? dir * hspAcceleration : 0;
		hsp = clamp((dir == 0) ? approach(hsp, 0, (onground) ? hspFrictionOnground : hspFrictionOffground) : hsp, -hmx, hmx);
	}
	
	if(onwall != 0 && !onground && (in[0][INPUTTYPE.HOLD]))
	{
		hsp = -onwall * hspJump;
		vsp = vspBoostOnwall;
	
		hspFraction = 0;
		vspFraction = 0;
		
		jumpDelay = jumpDelayMaximum
	}
	
	if(jumpBuffer > 0)
	{
		jumpBuffer--;
		
		if(in[0][INPUTTYPE.HOLD])
		{
			jumpBuffer = 0;
			vsp = vspBoostOffwall;
			vspFraction = 0;
		}
	}
	
	vsp += (!onground) ? ((onwall == 0) ? vspGravityOffWall : vspGravityOnwall) : 0;
	
	var vmx = (onwall == 0) ? vspMaximumOffwall : vspMaximumOnwall;
	vsp = clamp(vsp, -vmx, vmx);
	
	hsp += hspFraction;
	vsp += vspFraction;
	hspFraction = frac(hsp);
	vspFraction = frac(vsp);
	hsp -= hspFraction;
	vsp -= vspFraction;
	
	image_xscale = (hsp != 0) ? sign(hsp) * abs(image_xscale) : image_xscale;
	image_speed = abs(sign(hsp));
	
	if(place_meeting(x + hsp, y, pWall))
	{
		while(!place_meeting(x + sign(hsp), y, pWall))
		{
			x += sign(hsp)	
		}
		
		hsp = 0;
		hspFraction = 0;
	}
	
	x += hsp;
	
	if(place_meeting(x, y + vsp, pWall))
	{
		while(!place_meeting(x, y + sign(vsp), pWall))
		{
			y += sign(vsp);
		}
		
		vsp = 0;
		vspFraction = 0;
		
		//shake_cam(3, 5);
	}
	
	y += vsp;
	
	if(onground) jumpBuffer = jumpDelayMaximum;
	
	abilities();
}

draw = function ()
{
	draw_self();
	
	if(shardHasShard) draw_sprite(sOrb, 0, shardX + lengthdir_x(shardDistance, shardAngle), shardY + lengthdir_y(shardDistance, shardAngle));
}
