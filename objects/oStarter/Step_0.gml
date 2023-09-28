/// @description 

if(array_equals(global.colourMap, compArr))
{
	timer --;
	
	if(!timer)
	{
		instance_destroy();
		oCamera.colour_state = colour_states.normal;
		oKons.visible = true;
		oKons.actionState = "mobile";
		camera_set_view_pos(CAMERA, VW_WIDTH * 2, 0);
		
		layer_set_visible(layer_get_id("Paralax_1"), true);
		
		instance_create_layer(0, 0, "Controllers", oWaveManager)
	}
}

