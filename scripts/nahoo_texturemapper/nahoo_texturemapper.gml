
/**
@desc Generates a texture map texture to be saved in the working directory with a specified width, height and filename

@param {real}		width 
@param {real}		height 
@param {string}		filename 

@return {undefined}

*/

function nh_generate_texturemap(width = 32, height = 32, filename = "texturemap.png")
{
	if((clamp(width, 0, 255) != width) || (clamp(height, 0, 255) != height))
	{
		show_message("The provided WIDTH or HEIGHT is either too large or too small!")
		return;	
	}
	
	var surf = surface_create(width, height);
	var shd = shader_current();
	
	shader_reset();
	surface_set_target(surf);
	
	for(var i = 0; i < width; i++)
	{
		for(var j = 0; j < height; j++)
		{
			log(i, j)
			//draw_set_colour(make_colour_rgb((255 / width) * i, (255 / height) * j, 0))
			draw_set_colour(make_colour_rgb(i, j, 0))
			draw_point(i, j);
		}
	}
	
	surface_reset_target();
	shader_set(shd);
	
	surface_save(surf, filename);
}
