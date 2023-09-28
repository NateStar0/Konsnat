/// @description Render all the shit

if(!instance_exists(oWaterfall)) exit;

var surf = surface_create(VW_WIDTH + 16, VW_HEIGHT + 16);
var def = bm_normal;
var water_sprite = sTransparentTemporary;

x = camera_get_view_x(CAMERA);
y = camera_get_view_y(CAMERA);

surface_set_target(surf);

var cameraX = camera_get_view_x(view_camera[0]);
var cameraY = camera_get_view_y(view_camera[0]);


with(oWaterfall)
{
	var benders = instance_place_array(x, y, pWall);
	
	draw_sprite_ext(water_sprite, 0, x - cameraX, y - cameraY, image_xscale, image_yscale, 0, c_white, 1);
	
	log(benders)
	
	//gpu_set_blendmode(bm_subtract);
	
	//draw_sprite_ext(water_sprite, 1, x - cameraX + 1, y - cameraY + 1, ((image_xscale * 16) - 2) / 16, ((image_yscale * 16) - 2) / 16, 0, c_white, 1);
	
	for(var i = 0; i < array_length(benders); i++)
	{
		//gpu_set_blendmode(def);
		//draw_sprite_ext(water_sprite, 0, benders[i].bbox_left - 1 - cameraX, benders[i].y - 1 - cameraY, ((benders[i].image_xscale * 16) + 2) / 16, benders[i].image_yscale * 16, 0, c_white, 1);
		
		gpu_set_blendmode(bm_subtract);
		draw_sprite_ext(water_sprite, 1, benders[i].bbox_left - cameraX, benders[i].y - cameraY, benders[i].image_xscale, benders[i].image_yscale * 16, 0, c_white, 1)
	}	
	
	gpu_set_blendmode(def);
}


surface_reset_target();

draw_surface(surf, cameraX, cameraY);

surface_free(surf);


