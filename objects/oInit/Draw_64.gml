/// @description 

if(global.level_grid == undefined) exit;

	if(keyboard_check_pressed(ord("H"))) generate.init();

var w = array_length(global.level_grid);
		var h = array_length(global.level_grid[0]);
		
		shader_reset();
		
		for(var i = 0; i < w; i++)
		{
			for(var j = 0; j < h; j++)
			{
				if(global.level_grid[i][j] != -1)
				{
					draw_set_colour(make_colour_rgb(global.level_grid[i][j][0] * 15, global.level_grid[i][j][1] * 15, global.level_grid[i][j][2] * 255));
					draw_rectangle(i * 2, j * 2, i * 2 + 1, j * 2 + 1, 0);	
				}
			}
		}
