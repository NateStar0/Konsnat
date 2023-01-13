/// @description Render all the shit

//if(1)exit;

var surf = surface_create(room_width, room_height);
var def = bm_normal;
var water_sprite = sWaterfall;

x = camera_get_view_x(oCamera.cam);
y = camera_get_view_y(oCamera.cam);

surface_set_target(surf);


with(oWaterfall)
{
	var benders = instance_place_array(x, y, pWall);
	
	draw_sprite_ext(water_sprite, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);
	
	log(benders)
	
	gpu_set_blendmode(bm_subtract);
	
	log(((image_xscale * 16) - 2) / 16, ((image_yscale * 16) - 2) / 16, image_xscale, image_yscale)
	
	draw_sprite_ext(water_sprite, 1, x + 1, y + 1, ((image_xscale * 16) - 2) / 16, ((image_yscale * 16) - 2) / 16, 0, c_white, 1);
	
	for(var i = 0; i < array_length(benders); i++)
	{
		gpu_set_blendmode(def);
		draw_sprite_ext(water_sprite, 0, benders[i].bbox_left - 1, benders[i].y - 1, ((benders[i].image_xscale * 16) + 2) / 16, image_yscale * 16, 0, c_white, 1);
		
		gpu_set_blendmode(bm_subtract);
		draw_sprite_ext(water_sprite, 1, benders[i].bbox_left, benders[i].y, benders[i].image_xscale, image_yscale * 16, 0, c_white, 1)
	}	
	
	gpu_set_blendmode(def);
}


surface_reset_target();

draw_surface(surf, 0, 0);

surface_free(surf);


