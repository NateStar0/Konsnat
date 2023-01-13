

#macro generate global.generation
global.level_grid = undefined;

global.generation = 
{
	dump : function(arr, file)
	{
		var w = array_length(arr);
		var h = array_length(arr[0]);
		var surf = surface_create(w, h);
		var shd = shader_current();
		
		shader_reset();
		surface_set_target(surf);
		
		for(var i = 0; i < w; i++)
		{
			for(var j = 0; j < h; j++)
			{
				if(arr[i][j] != -1)
				{
					draw_set_colour(make_colour_rgb(arr[i][j][0] * 16, arr[i][j][1] * 16, arr[i][j][2] * 255));
					draw_point(i, j);	
				}
			}
		}
		
		surface_reset_target();
		shader_set(shd);
		
		surface_save(surf, file)
	},
	
	init : function()
	{
		
		global.pausable = true;
		
		oKons.has_control = true;
		//oKons.y = 300;
		oKons.visible = true;
			
		oCamera.state = camera_state.free;
		oCamera.follow = oKons;
		
		var width = 11
		var height = 22
		
		var count = 0;
		
		global.level_grid = array_create(width);
		
		for(var i = 0; i < width; i++)
		{
			global.level_grid[i] = array_create(height, -1);	
		}
		
		// Create Level Layout
		
		function trim_structure(x, y, width, height)
		{
			// Create Risk bias & Reward Bias
			global.level_grid[x][y] = [max(0, y + irandom_range(-2, 2)), choose(1, 1, 1, 1, 2, 2, 2, 3), 0];
			
			// Will wall left/right
			if(chance(0.8))
			{
				if(chance(0.45) && (x - 1 >= 0) && global.level_grid[x - 1][y] == -1) trim_structure(x - 1, y, width, height);	
				if(chance(0.45) && (x + 1 < width) && global.level_grid[x + 1][y] == -1) trim_structure(x + 1, y, width, height);	
			}
			
			if(chance(0.5) && (y - 1 >= 0) && global.level_grid[x][y - 1] == -1) trim_structure(x, y - 1, width, height);	
			
			return;
		}
		
		trim_structure(width / 2 - 0.5, height - 1, width, height);
		
		var heights = array_create(width, 0);
		var picked_start = false;
		
		for(var j = 0; j < height; j++)	
		{
			for(var i = 0; i < width; i++)
			{
				if(global.level_grid[i][j] != -1)
				{
					count++;
					
					heights[i]++;
					
					if(!picked_start && chance(0.2))
					{
						log(i, j, picked_start)
						global.level_grid[i][j] = [16, 16, 1, true];
						picked_start = true;	
					}
				}
			}
		}
		
		var longest = 0;
		for(var i = 0; i < width; i++)
		{
			if(heights[i] > heights[longest])
			{
				longest = i;	
			}
		}
		
		for(var i = 0; i < height; i++)
		{
			if(global.level_grid[longest][i] != -1)
			{
				global.level_grid[longest][i][2] = 1;
			}
		}
		
		
		if(count < 25 || !picked_start)
		{
			self.init();
			return;
		}
		
		log(global.level_grid)
		
		self.dump(global.level_grid, "new.png");
		
		self.build(width, height);
	},
	
	build : function(w, h)
	{
		//For every filled tile in the grid
		
		for(var i = 0; i < w; i++)
		{
			for(var j = 0; j < h; j++)
			{
				if(global.level_grid[i][j] != -1)
				{
					var tile_data = 
					{
						risk : global.level_grid[i][j][0],
						reward : global.level_grid[i][j][1],
						isboss : array_length(global.level_grid[i][j]) > 3,
						
						x : i,
						y : j,
						
						neighbours :
						{
							below : false,
							above : false, 
							left : false,
							right : false
						}
					}
					
					if(tile_data.isboss) log(tile_data)	
				}
			}
		}
	},
	
	reset : function()
	{
		// With all objects, destroy,
		
		// Recreate menu with preload state
	}
}

