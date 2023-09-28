/// @description 

if(array_equals(global.colourMap, base))
{
	draw_set_valign(fa_top)
	draw_set_halign(fa_left)

	draw_text(GUI_TOPOFFSET_LEFT, avg, string(currentWave));

	var len = min(num, oKons.hp);
	for(var i = 0; i < len; i++)
	{
		draw_sprite(sMenuTrainChunk, i, VW_WIDTH / 2 - len * 4, avg - (round(((seconds(oKons.hp) - countdown) / seconds(oKons.hp)) * len) == i && countdown != seconds(oKons.hp)))
	}
}
