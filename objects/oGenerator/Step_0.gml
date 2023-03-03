/// @description 

if(array_equals(global.colourMap, compArr))
{
	timer --;
	
	if(!timer)
	{
		instance_destroy();
		
		generate.init();
		
		oCamera.colour_state = colour_states.normal;
	}
}

