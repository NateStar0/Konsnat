/// @description Set up the camera

enum camera_state
{
	free,
	slide,
	scroll,
	lock
}

enum colour_states
{
	toBlack,
	normal,
	toWhite,
	reset
}

colour_state = colour_states.normal;

state = camera_state.free;
restore_state = state;

cam = view_camera[0];
view_enabled = true

view_set_visible(0, true);
window_set_size(WIN_WIDTH, WIN_HEIGHT);

follow = oKons;

shake_mag = 0
shake_len = 0
shake_rem = 0
buff = 0//16

// Free
view_w_half = camera_get_view_width(cam) * 0.5;
view_h_half = camera_get_view_height(cam) * 0.5;
xTo = xstart;
yTo = ystart;

offset_x = 0;
offset_y = 0;

// Scroll
slidespd = 4

follow_xview = (follow.x div VW_WIDTH) * VW_WIDTH
follow_yview = (follow.y div VW_HEIGHT) * VW_HEIGHT 

x = follow_xview;
y = follow_yview;

layer_id = layer_get_id("Instances_1");

states = 
[
	function()
	{
		if(instance_exists(follow))
		{
			xTo = follow.x + offset_x
			yTo = follow.y + offset_y
		}
		
		x += ((xTo - x) / 6) + random_range(-shake_rem, shake_rem);
		y += ((yTo - y) / 6) + random_range(-shake_rem, shake_rem);
		
		shake_rem = max(0, shake_rem  - ((1 / shake_len) * shake_mag));

		//x = clamp(x, view_w_half + buff, room_width - view_w_half - buff)
		//y = clamp(y, view_h_half + buff, room_height - view_h_half - buff)

		camera_set_view_pos(cam, floor(x - view_w_half), floor(y - view_h_half));
	},
	
	function()
	{
		if(instance_exists(follow))
		{
			xTo = follow.x + offset_x
			follow_yview = (follow.y div VW_HEIGHT) * VW_HEIGHT
		}
		
		
		
		x += ((xTo - x) / 6) + random_range(-shake_rem, shake_rem);
		y = approach(y, follow_yview, slidespd) + random_range(-shake_rem, shake_rem);
		
		y = clamp(y, 0, room_height - VW_HEIGHT);
		
		shake_rem = max(0, shake_rem  - ((1 / shake_len) * shake_mag));

		//x = clamp(x, view_w_half + buff, room_width - view_w_half - buff)
		//y = clamp(y, view_h_half + buff, room_height - view_h_half - buff)

		camera_set_view_pos(cam, floor(x - view_w_half), y);
	},
	
	function()
	{
		// Using div looks quite strange, doesnt it? That's actually for integer rounding

		follow_xview = (follow.x div VW_WIDTH) * VW_WIDTH
		follow_yview = (follow.y div VW_HEIGHT) * VW_HEIGHT

		x = approach(x, follow_xview, slidespd) + random_range(-shake_rem, shake_rem);
		y = approach(y, follow_yview, slidespd) + random_range(-shake_rem, shake_rem);
		
		x = clamp(x, 0, room_width - VW_WIDTH);
		y = clamp(y, 0, room_height - VW_HEIGHT);

		shake_rem = max(0, shake_rem  - ((1 / shake_len) * shake_mag));
		camera_set_view_pos(cam,x, y);
	},
	
	function()
	{
		//It's locked, isn't it?
		
		camera_set_view_pos(cam, x, y);
	}
]

colourTransition = function(colState)
{
	var reset = 10;
	static timer = 10;	
	
	timer = max(timer - 1, 0);
	
	if(!timer)
	{
		for(var i = 0; i < array_length(global.colourMap); i++)
		{
			switch(colState)
			{
				case colour_states.toBlack:
					global.colourMap[i]--// = max(global.colourMap[i] - 1, 0);
				break;
			
				case colour_states.toWhite:
					// Broken???????
					global.colourMap[i]++// = min(global.colourMap[i] + 1, array_length(global.colourMap) - 1)
				break;
			
				case colour_states.normal:
					global.colourMap[i] = approach(global.colourMap[i], i, 1)
				break;
				
				case colour_states.reset:
					global.colourMap[i] = i;
					oCamera.colour_state = colour_states.reset;
				break;
			}
			
			global.colourMap[i] = clamp(global.colourMap[i], 0, array_length(global.colourMap) - 1)
		}
		
		timer = reset;	
	}
}

/**
@description manages activation and deactivation of objects for optimisation
*/

activation = function()
{
	var reset = seconds(1);
	static timer = seconds(1);
	
	timer = max(0, timer - 1);
	
	if(!timer)
	{
		if(state != camera_state.lock)
		{
			instance_deactivate_layer(layer_id);
			instance_activate_region(camera_get_view_x(cam) - WIN_WIDTH * 2, camera_get_view_y(cam) - WIN_HEIGHT * 2, camera_get_view_x(cam) + camera_get_view_width(cam) + WIN_WIDTH * 2, camera_get_view_y(cam) + camera_get_view_height(cam) + WIN_HEIGHT * 2, true);
		}
		
		timer = reset;
	}
}

