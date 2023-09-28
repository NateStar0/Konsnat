/*

		=== -- oKons -- ===
		
		Primary Player Object
		
		
		
		
		
		-- Methods -- 
		
		Abilities : Manages the orb when collected 
		
		Run : Manages movements and collisions
		
		Draw : Draws the character with their appropriate animation sprites

*/

// Reset basic variables													
																			
image_speed = 1;															
																			
x = xstart;																	
y = ystart;	


																			
// Cutscene control															
																			
hasControl = true;												//	(Boolean) Indicator of whether player can move/use player
	
// Speed														
																
hsp = 0;														//	(Real) Horizontal speed
																
hspMaximum = 2;													//	(Real) Absolute maximum horizontal speed
hspJump = 2;													//	(Real) Absolute speed as player is ejected from wall
hspAcceleration = 1;											//	(Real) Acceleration constant
hspFrictionOnground = 0.5;										//	(Real) Friction constant while walking
hspFrictionOffground = 0.15;									//	(Real) Friction constant while jumping
																
hspFraction = 0;												//	(Real) Fraction for collisions
																														
vsp = 0;														//	(Real) vertical speed
																
vspGravityOffWall = 0.3;										//	(Real) Absolute acceleration due to gravity in air
vspMaximumOffwall = 10;											//	(Real) Absolute maximum speed while sliding on the wall
vspBoostOffwall = -3;											//	(Real) ΔSpeed from jumping off the floor
																
vspFraction = 0;												//	(Real) Fraction for collisions
	
// Jump stuff 													
																
jumpBuffer = 0;													//	(Real) fuck
jumpDelay = 0;													//	(Real) i 
jumpDelayMaximum = 12;											//	(Real) dont remember

// Render stuff;

hittable = true;

// Dash stuff

dashTimer = seconds(0.2);
dashTimerReset = dashTimer;
dashSpeed = hspMaximum * (3 / 2);

// Attack stuff

attackTimer = seconds(0.3);
attackTimerReset = attackTimer;
attackPossibilities = 3;
attackState = 0;

hp = 5;

// FSM

actionState = "idle";
	
// Other Stuff ig												
																
onground = false;												//	(Boolean) Is the player touching the ground

run = function ()
{
	if(!hasControl) exit;
	
	onground = place_meeting(x, y + 1, pWall);
	
	switch(actionState)
	{
		case "mobile":
			hittable = true;
		
			jumpDelay = max(0, jumpDelay - 1);
			if(jumpDelay == 0)
			{
				var dir = (global.input[3][INPUTTYPE.HOLD] - global.input[2][INPUTTYPE.HOLD]);
		
				hsp += dir * hspAcceleration
				hsp = clamp((dir == 0) ? approach(hsp, 0, (onground) ? hspFrictionOnground : hspFrictionOffground) : hsp, -hspMaximum, hspMaximum);
			}
	
			if(jumpBuffer > 0)
			{
				jumpBuffer--;
		
				if(global.input[0][INPUTTYPE.HOLD])
				{
					jumpBuffer = 0;
					vsp = vspBoostOffwall;
					vspFraction = 0;
				}
			}
		
			if(global.input[4][INPUTTYPE.PRESS])
			{
				actionState = "attack";
				attackTimer = attackTimerReset;
			}
			
			attackTimer = max(0, attackTimer - 1);
			
			if(!attackTimer)
			{
				attackState = max(0, attackState - 1);
				attackTimer = attackTimerReset;
			}
			
			if(global.input[1][INPUTTYPE.PRESS])
			{
				actionState = "dash";
				vsp = 0;
				hsp = sign(image_xscale) * dashSpeed;
				hittable = false;
				dashTimer = dashTimerReset;
			}
	
	
			vsp += (!onground) ? vspGravityOffWall : 0;
	
			var vmx = vspMaximumOffwall;
			vsp = clamp(vsp, -vmx, vmx);
	
			image_xscale = (hsp != 0) ? sign(hsp) * abs(image_xscale) : image_xscale;
			image_speed = abs(sign(hsp));
		break;
		
		case "dash":
			dashTimer = max(0, dashTimer - 1);
		
			if(!dashTimer)
			{
				actionState = "mobile";	
			}
		break;
		
		case "attack":
			attackState = min(attackPossibilities, attackState + 1);
			actionState = "mobile";
			
			instance_create_layer(x + sign(image_xscale) * sprite_get_width(sprite_index), y, layer, oMeleeKons);
		break;
		
		default:
		case "idle":
		break;
	}
	
	// Damage
	
	if(hittable)
	{
		if(instance_exists(oMeleeEnemy))
		{
			if(place_meeting(x, y, oMeleeEnemy))
			{
				with(instance_place(x, y, oMeleeEnemy))
				{
					instance_destroy();	
				}
				
				hp --;
			}
		}
		
		if(!hp)
		{
			room_restart();	
		}
	}
	
	// Collisions
	// This should always run, evem when idle.
	
	hsp += hspFraction;
	vsp += vspFraction;
	hspFraction = frac(hsp);
	vspFraction = frac(vsp);
	hsp -= hspFraction;
	vsp -= vspFraction;
	
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
}

draw = function ()
{
	shader_set((hittable) ? shDefault : shHit)
	draw_self();
	shader_set(shDefault);
}
