

#macro generate global.generation
global.levelGrid = undefined;

global.levelElevator = -1;

global.generation = 
{
	dump : function(arr, file)
	{
		var w = array_length(arr);
		var h = array_length(arr[0]);
		var surf = surface_create(w * 3, h * 3);
		var altSurf = surface_create(w, h);
		var shd = shader_current();
		
		shader_reset();
		surface_set_target(surf);
		
		for(var i = 0; i < w; i++)
		{
			for(var j = 0; j < h; j++)
			{
				if(arr[i][j] != -1 && arr[i][j] != undefined)
				{
					draw_set_colour(make_colour_rgb(arr[i][j].conditions.risk * 16, arr[i][j].conditions.reward * 16, arr[i][j].conditions.mobility * 16));
					
					if(arr[i][j].neighbours.left) draw_point(i * 3, j * 3 + 1);	
					if(arr[i][j].neighbours.right) draw_point(i * 3 + 2, j * 3 + 1);	
					if(arr[i][j].neighbours.up) draw_point(i * 3 + 1, j * 3);	
					if(arr[i][j].neighbours.down) draw_point(i * 3 + 1, j * 3 + 2);	
					
					draw_point(i * 3 + 1, j * 3 + 1);	
				}
			}
		}
		
		surface_reset_target();
		shader_set(shd);
		
		
		shader_reset();
		surface_set_target(altSurf);
		
		for(var i = 0; i < w; i++)
		{
			for(var j = 0; j < h; j++)
			{
				if(arr[i][j] != -1 && arr[i][j] != undefined)
				{
					draw_set_colour(make_colour_rgb(arr[i][j].conditions.risk * 16, arr[i][j].conditions.reward * 16, arr[i][j].conditions.mobility * 16));
					
					draw_point(i, j);	
				}
			}
		}
		
		surface_reset_target();
		shader_set(shd);
		
		surface_save(altSurf, "ALT" + file); //*/
		
		surface_save(surf, file)
	},
	
	clear : function()
	{
		for(var i = 0; i < array_length(global.levelGrid); i++)
		{
			for(var j = 0; j < array_length(global.levelGrid[i]); j++)
			{
				if(global.levelGrid[i][j] != -1)
				{
					global.levelGrid[i][j].clearInstances();	
				}
			}
		}
		
		global.levelGrid = undefined;
	},
	
	init : function()
	{
		// Misc EXT stuff
		global.pausable = true;
		
		oKons.hasControl = true;
		oKons.x = 1104;
		oKons.visible = true;
			
		oCamera.x = 960;

		// Configuration		
		var width = 11
		var height = 22
		
		var count = 0;
		
		if(!is_undefined(global.levelGrid))
		{
			self.clear();	
		}
		
		// Create grid
		global.levelGrid = array_create(width);
		
		for(var i = 0; i < width; i++)
		{
			global.levelGrid[i] = array_create(height, -1);	
		}
		
		// Define a cell
		
		/**
		@param {Struct} _neighbours 
		@param {Struct} _conditions 
		@param {Bool} _isBoss
		
		@return {Struct}
		*/
		
		function gridCell(_neighbours, _conditions) constructor
		{
			neighbours = _neighbours;
			conditions = _conditions;
			isBoss = false;
			isStart = false;
			isOrb = false
			
			instances = [];
			
			static clearInstances = function()
			{
				for(var n = 0; n < array_length(instances); n++)
				{
					with(instances[n])
					{
						instance_destroy();	
					}
				}
			}
		}
		
		// Define the conditions constructor
		
		/**
		@param {Real}	_risk;
		@param {Real}	_reward;
		@param {Real}	_mobility
		
		@return {Struct}
		*/
		
		function cellConditions(_risk, _reward, _mobility) constructor
		{
			risk = _risk;
			reward = _reward;
			mobility = _mobility
		}
		
		// Define the neighbours constructor
		
		/**
		@param {Real} _up
		@param {Real} _down
		@param {Real} _left
		@param {Real} _right
		
		@return {Struct}
		*/
		
		function cellNeighbours(_up, _down, _left, _right) constructor
		{
			up = _up;
			down = _down;
			left = _left;
			right = _right;
		}
		
		// Create connection structure
		
		/**
		@desc Recursive structural generation

		@param {Real}		x 
		@param {Real}		y
		@param {Real}		width
		@param {Real}		height
		@param {Struct}		n

		@return {undefined}

		*/
		
		function structureRec(x, y, width, height, n)
		{
			// Create Risk bias & Reward Bias
			var risk = max(0, height - y + irandom_range(-4, 4));
			var reward = (y > ((5 / 8) * height)) ? irandom_range(0, 5) : irandom_range(6, 15);
			var mobility = 0;
			
			var neighbours = n;
			
			global.levelGrid[x][y] = new gridCell(neighbours, new cellConditions(risk, reward, mobility));
												
			// Will wall left/right
			if(chance(0.95))
			{
				if(chance(0.5) && (x - 1 >= 0) && global.levelGrid[x - 1][y] == -1)
				{	
					var b = choose(1, 2);
					global.levelGrid[x][y].neighbours.left = b;
					structureRec(x - 1, y, width, height, new cellNeighbours(0, 0, 0, b));	
				}
				
				if(chance(0.5) && (x + 1 < width) && global.levelGrid[x + 1][y] == -1)
				{
					var b = choose(1, 2);
					global.levelGrid[x][y].neighbours.right = b;
					structureRec(x + 1, y, width, height, new cellNeighbours(0, 0, b, 0));	
				}
			}
			
			if(chance(0.30) && (y - 1 >= 0) && global.levelGrid[x][y - 1] == -1)
			{
				var b = choose(1, 2);
				global.levelGrid[x][y].neighbours.up = b;
				structureRec(x, y - 1, width, height, new cellNeighbours(0, b, 0, 0));
			}
			
			return;
		}
		
		// Run structure generator
		
		structureRec(width / 2 - 0.5, height - 1, width, height, new cellNeighbours(0, 0, 0, 0));
		
		global.levelGrid[width / 2 - 0.5][height - 1].conditions = new cellConditions(0, 0, 14);
		global.levelGrid[width / 2 - 0.5][height - 1].isStart = true;
		
		// Go further
		
		var heights = array_create(width, 0);
		var pickedBoss = false;
		var pickedOrb = false;
		
		for(var j = 0; j < height; j++)	
		{
			for(var i = 0; i < width; i++)
			{
				if(global.levelGrid[i][j] != -1)
				{
					count++;
					
					heights[i]++;
					
					if(!pickedBoss && chance(0.5) && !global.levelGrid[i][j].neighbours.up && !global.levelGrid[i][j].neighbours.down)
					{
						global.levelGrid[i][j].isBoss = true;
						global.levelGrid[i][j].conditions = new cellConditions(15, 15, 15);
						pickedBoss = true;	
						break;
					}
				}
			}
		}
		
		for(var j = height - 1; j >= 0; j--)	
		{
			for(var i = 0; i < width; i++)
			{
				if(global.levelGrid[i][j] != -1)
				{				
					if(!pickedOrb && chance(0.5) && !global.levelGrid[i][j].isStart)
					{
						global.levelGrid[i][j].isOrb = true;
						global.levelGrid[i][j].conditions = new cellConditions(0, 15, 14);
						pickedOrb = true;	
						break;
					}
				}
			}
		}
		
		var longest = 0;
		for(var i = 0; i < width; i++)
		{
			if(heights[i] > heights[longest] && i != (width / 2 - 0.5))
			{
				longest = i;	
			}
		}
		
		global.levelElevator = longest;
		
		var go = false;
		
		for(var i = 0; i < height; i++)
		{
			if(global.levelGrid[longest][i] != -1)
			{
				if(global.levelGrid[longest][i].isBoss)
				{
					self.init();
					return;
				}
				
				global.levelGrid[longest][i].conditions.mobility = 15;
				global.levelGrid[longest][i].neighbours.up = go;
				global.levelGrid[longest][i].neighbours.down = !(i == height - 1);
				
				go = true;
			}
			else
			{
				if(go)
				{
					var risk = max(0, height - i + irandom_range(-4, 4));
					var reward = (i > ((5 / 8) * height)) ? irandom_range(0, 5) : irandom_range(6, 15);
					var mobility = 15;
			
					var neighbours = new cellNeighbours(1, (i != height - 1), 0, 0)
			
					global.levelGrid[longest][i] = new gridCell(neighbours, new cellConditions(risk, reward, mobility));
				}
			}
		}
		
		
		if(count < 30 || !pickedBoss || !pickedOrb)
		{
			self.init();
			return;
		}
		
		self.dump(global.levelGrid, "new.png");
		
		self.build(width, height);
	},
	
	build : function(w, h)
	{
		//For every filled tile in the grid
		
		global.stage++;
		
		for(var i = 0; i < w; i++)
		{
			for(var j = 0; j < h; j++)
			{
				var tile = global.levelGrid[i][j];
				
				if(tile != -1)
				{
					var wall = undefined;
					
					var minX = i * VW_WIDTH;
					var maxX = i * VW_WIDTH + VW_WIDTH;
					
					var minY = (j + 1) * VW_HEIGHT;
					var maxY = (j + 1) * VW_HEIGHT + VW_HEIGHT;
					
					var neighbours = tile.neighbours;
					
					// This is not an empty tile.

					array_push(tile.instances, instance_create_layer(minX, minY, "Instances_1", oCameraBounder));
					
					// Top wall
					array_push(tile.instances, instance_create_layer(minX, minY, "Instances_1", oWall, { image_xscale : VW_WIDTH / 16, image_yscale : 2 }));
					
					// Floor wall
					array_push(tile.instances, instance_create_layer(minX, maxY - (16 * 2), "Instances_1", oWall, { image_xscale : VW_WIDTH / 16, image_yscale : 2 }));
					
					// Left wall/door
					
					switch(neighbours.left)
					{
						case 2: break;
						case 1: array_push(tile.instances, instance_create_layer(minX, minY, "Instances_1", oWall, { image_xscale : 1, image_yscale : 6 })); break;
						case 0: array_push(tile.instances, instance_create_layer(minX, minY, "Instances_1", oWall, { image_xscale : 1, image_yscale : VW_HEIGHT / 16 })); break;
					}
					
					// Right wall/door
					
					switch(neighbours.right)
					{
						case 2: break;
						case 1: array_push(tile.instances, instance_create_layer(maxX - 16, minY, "Instances_1", oWall, { image_xscale : 1, image_yscale : 6 })); break;
						case 0: array_push(tile.instances, instance_create_layer(maxX - 16, minY, "Instances_1", oWall, { image_xscale : 1, image_yscale : VW_HEIGHT / 16 })); break;
					}
					
					// Strairwell
					
					if(neighbours.up || neighbours.down)
					{
						if(tile.conditions.mobility == 15)
						{
							array_push(tile.instances, instance_create_layer(minX + (maxX - minX) / 4, maxY - (16 * 5), "Instances_1", oStairwell, { canUp : neighbours.up, canDown : neighbours.down, elevator : true }));	
							array_push(tile.instances, instance_create_layer(maxX - (maxX - minX) / 4, maxY - (16 * 5), "Instances_1", oStairwell, { canUp : neighbours.up, canDown : neighbours.down, elevator : true }))
						}
						else
						{
							array_push(tile.instances, instance_create_layer(minX + (maxX - minX) / 2, maxY - (16 * 5), "Instances_1", oStairwell, { canUp : neighbours.up, canDown : neighbours.down, elevator : false }));	
						}
					}
					
					// Orb
					
					if(tile.isOrb)
					{
						instance_create_layer(maxX + (maxX - minX) / 4, maxY - (16 * 5), "Instances_1", oOrb);
					}
					
					// Fancy generation
					
					// Pretty pictures
				}
			}
		}
		
		oKons.x = 5 * VW_WIDTH + (VW_WIDTH / 2);
		oKons.y = 22 * VW_HEIGHT + 64;
		
		log(VW_HEIGHT)
		
		oCamera.state = camera_state.slide;
		oCamera.follow_yview = (oCamera.follow.y div VW_HEIGHT) * VW_HEIGHT
		oCamera.y = oCamera.follow_yview;
	},
	
	reset : function()
	{
		// With all objects, destroy,
		
		// Recreate menu with preload state
	}
}
