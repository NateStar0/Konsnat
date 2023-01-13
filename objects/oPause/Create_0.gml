/// @description Init

paused = false;

paused_surface = -1;
paused_buffer = -1;

text = "Game Paused"

gui = function()
{
	if(paused)
	{
		draw_set_colour(c_white)
		draw_text(8, 8, text);
	}
}

render = function()
{
	gpu_set_blendenable(false);
	
	if(paused)
	{
		surface_set_target(application_surface);
		
		if(surface_exists(paused_surface))
		{
			draw_surface(paused_surface, 0, 0);
		}
		else
		{
			paused_surface = surface_create(WIN_WIDTH, WIN_HEIGHT);
			buffer_set_surface(paused_buffer, paused_surface, 0);
		}
		
		surface_reset_target()
	}
	
	if(keyboard_check_pressed(vk_escape) && global.pausable == true)
	{
		if(paused)
		{
			instance_activate_all();
			
			clean();
		}
		else
		{
			instance_deactivate_all(true);
			
			paused_surface = surface_create(WIN_WIDTH, WIN_HEIGHT);
			
			surface_set_target(paused_surface);
			draw_surface(application_surface, 0, 0);
		
			surface_reset_target();
			
			if(buffer_exists(paused_buffer)) buffer_delete(paused_buffer);
			paused_buffer = buffer_create(WIN_WIDTH * WIN_HEIGHT * 4, buffer_fixed, 1);
			buffer_get_surface(paused_buffer, paused_surface, 0);
		}
		
		paused = !paused;	
	}
	
	gpu_set_blendenable(true);
}

clean = function ()
{
	if(surface_exists(paused_surface)) surface_free(paused_surface);
	if(buffer_exists(paused_buffer)) buffer_delete(paused_buffer);
}
