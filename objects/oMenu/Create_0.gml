/// @description INIT AND SHIT

render = function()
{
	var in = global.input;
	
	if(state != states.idle)
	{
		oCamera.state = camera_state.lock;
		oCamera.y = 0;
	}
	
	state(in);
}

timer = seconds(3);

state = undefined;

states = 
{
	intro:	 function (input)
	{
		
	},
	
	primary : function ( input )
	{
		static commit = -1;
		
		operations = 
		[
			function () 
			{
				oMenu.state = self.preload;
			},
			
			game_end,
			
			function () 
			{
				oMenu.state = self.leaderboard;
			},
			
			function () 
			{
				oMenu.state = self.options;
			},
		]
		
		for(var i = 0; i < 4; i++)
		{
			if(input[i][inp.press])
			{
				if(commit != i)
				{
					commit = i;
				}
				else
				{
					operations[i]();
				}
			}
		}
		
		oCamera.x = 240;
		
		// Rendering
	},
	
	leaderboard : function ( input )
	{
		if(input[1][inp.press])
		{
			oMenu.state = self.primary;	
		}
		
		oCamera.x = 240;
		
		// Rendering
		
		draw_set_alpha(0.5)
		draw_set_colour(c_black)
		draw_rectangle(0, 0, 256, 256, 0);
		draw_set_colour(c_white)
		draw_set_alpha(1)
		
		draw_text(8, 8, "Leaderboard : ")
		
		log("Render all other HighScores!")
		
	},
	
	options : function ( input )
	{
		// Rendering	
		
		oCamera.x = 240;
		
		log("There is no present logic for options!")
	},
	
	preload : function ()
	{
		
		if(instance_exists(oKons))
		{
			oKons.has_control = true;
			oKons.x = 1024;
			oKons.y = 112;
		}
		
		oCamera.x = 960;
		
		oMenu.timer = max(0, oMenu.timer - 1);

		
		if(!oMenu.timer)
		{
			oMenu.state = self.idle;	
			oCamera.state = camera_state.free;
			oCamera.follow = oKons;
			
			generate.init();
		}
				
		//oCamera.state = camera_state.free;
		
		display_set_gui_size(VW_WIDTH, VW_HEIGHT);
		
		draw_set_colour(cc_purple);
		
		draw_text(8, 16, "Now Loading : \n[MY BALLS] Station . . .")
		
		draw_line_width(-2, VW_HEIGHT / 2 + 8, VW_WIDTH, VW_HEIGHT / 2 + 8, 3);
		
		draw_set_colour(c_white);
		
		display_set_gui_size(VW_WIDTH, VW_HEIGHT);
				
		//instance_destroy(oMenu);
	},
	
	idle : function()
	{
		var w = array_length(global.level_grid);
		var h = array_length(global.level_grid[0]);
		
		shader_reset();
		
		for(var i = 0; i < w; i++)
		{
			for(var j = 0; j < h; j++)
			{
				if(global.level_grid[i][j] != -1)
				{
					draw_set_colour(make_colour_rgb(global.level_grid[i][j][0] * 16, global.level_grid[i][j][1] * 16, 32));
					draw_rectangle(i * 2, j * 2, i * 2 + 2, j * 2 + 2, 0);	
				}
			}
		}
		
		if(keyboard_check_pressed(ord("K")))
		{
			generate.init();	
		}
	}
}

state = states.intro;


