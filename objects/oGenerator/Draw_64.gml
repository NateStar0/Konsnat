/// @description 

var j = sprite_get_number(sMenuTrainChunk);
for(var i = 0; i < j; i++)
{
	draw_sprite(sMenuTrainChunk, i, 12, VW_HEIGHT - 12 - (round(((mx - timer) / mx) * j) == i))
}

if(global.levelGrid == undefined) exit;

var w = array_length(global.levelGrid);
var h = array_length(global.levelGrid[0]);
		
shader_reset();

draw_set_colour(cc_light)
		
for(var i = 0; i < w; i++)
{
	for(var j = 0; j < h; j++)
	{
		if(global.levelGrid[i][j] != -1)
		{
			draw_rectangle(i * 2, j * 2, i * 2 + 1, j * 2 + 1, 0);	
		}
	}
}

shader_set(shDefault);
