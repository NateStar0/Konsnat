/// @description 

if(camera_get_view_x(CAMERA) != VW_WIDTH) exit;

for(var i = 0; i < sprite_get_number(sprite_index); i++)
{
	draw_sprite(sprite_index, i, x + wave(-2, 2, 4 + i, 1), y);	
}
