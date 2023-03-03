
function wfc (base, w, h)
{
	randomise()
	
	var cols = [];
	var temp = surface_create(sprite_get_width(base), sprite_get_height(base));
	
	var N = 2;
	
	var map = array_create_2d(sprite_get_width(base), sprite_get_height(base), -1);
	
	var patterns = [];
	
	surface_set_target(temp);
	
	draw_sprite(base, 0, 0, 0);
	
	// Collapse the sprite into an array of indicies, and a colour array
	
	for(var i = 0; i < sprite_get_width(base); i++)
	{
		for(var j = 0; j < sprite_get_height(base); j++)
		{
			var pixel = surface_getpixel(temp, i, j);
			
			var r = colour_get_red(pixel);
			var g = colour_get_green(pixel);
			var b = colour_get_blue(pixel);
			
			var access = string(r) + "," + string(g) + "," + string(b);
			
			var includes = false;
			var index = -1;
			
			for(var n = 0; n < array_length(cols); n++)
			{
				if(cols[n] == access)
				{
					includes = true;	
					index = n;
					break;
				}
			}
			
			if(!includes)
			{
				array_push(cols, access);
				index = array_length(cols) - 1;
			}
			
			map[i][j] = index
		}
	}
	
	surface_reset_target()
	
	
	// Gather all patterns (uncompressed)
	
	for(var i = 0; i < array_length(map) - 1; i++)
	{
		for(var j = 0; j < array_length(map[i]) - 1; j++)
		{
			var pattern = [];
			
			// Normal
			pattern = [map[i][j], map[i + 1][j], map[i][j + 1], map[i + 1][j + 1]]
			array_push(patterns, pattern);
			
			// Rot 1
			pattern = [map[i][j + 1], map[i][j], map[i + 1][j + 1], map[i + 1][j]]
			array_push(patterns, pattern);
			
			// Rot 2
			pattern = [map[i + 1][j + 1], map[i][j + 1], map[i + 1][j], map[i][j]]
			array_push(patterns, pattern);
			
			// Rot 3
			pattern = [map[i + 1][j], map[i + 1][j + 1], map[i][j], map[i][j + 1]]
			array_push(patterns, pattern);
		}
	}
	
	// Restructure patterns to { pattern, weight, probability }
	var tempPatterns = [];
	
	for(var i = 0; i < array_length(patterns); i++)
	{
		var pattern = patterns[i];
		
		var contains = false;
		for(var j = 0; j < array_length(tempPatterns); j++)
		{
			if(array_equals(pattern, tempPatterns[j].pat))
			{
				contains = true;
				
				tempPatterns[j].weight ++;
				tempPatterns[j].probability += (1 / array_length(patterns))
			
				break;
			}
		}
		
		if(!contains)
		{
			array_push(tempPatterns, 
				{
					pat : pattern,
					weight : 1,
					probability : (1 / array_length(patterns))
				})	
		}
	}
	
	patterns = tempPatterns;
	
	var entropy = function(patterns, superposition)
	{
		var en = (random(1) / 100);
		var count = 0;
		
		for(var i = 0; i < array_length(superposition); i++)
		{
			if(superposition[i])
			{
				count ++;
				en -= patterns[i].probability * log2(patterns[i].probability)	
			}
		}
		
		return (count <= 1) ? 0 : en;
	}
	
	var waveMap = array_create_2d(w, h, 0);
	for(var i = 0; i < w; i++)
	{
		for(var j = 0; j < h; j++)
		{
			waveMap[i][j] = array_create(array_length(patterns), true)
		}
	}
	
	var entropyMap = array_create_2d(w, h, 0);
	for(var i = 0; i < w; i++)
	{
		for(var j = 0; j < h; j++)
		{
			entropyMap[i][j] = entropy(patterns, waveMap[i][j]);
		}
	}
	
	var lowestEntropy = function(map)
	{
		var lowest = infinity;
		var lowPos = [-1, -1];
		
		var w = array_length(map);
		var h = array_length(map[0]);
		
		for(var i = 0; i < w; i++)
		{
			for(var j = 0; j < h; j++)
			{
				var old = lowest;
				lowest = min(lowest, map[i][j]);
				
				if(old != lowest) lowPos = [i, j];
			}
		}
		
		return { pos : lowPos, val : lowest };
	}
	
	var lowest = lowestEntropy(entropyMap);

	log(lowest, entropyMap)
}

function wfcDump(arr, col)
{
	var w = array_length(arr);
	var h = array_length(arr[0]);
	
	var shd = shader_current();
	shader_reset();
	
	var surf = surface_create(w, h);
	
	surface_set_target(surf)
	
	for(var i = 0; i < w; i++)
	{
		for(var j = 0; j < h; j++)
		{
			var colArr = string_split(col[arr[i][j]], ",");
			draw_set_colour(make_color_rgb(colArr[0], colArr[1], colArr[2]))
			draw_point(i, j);	
		}
	}
	
	surface_reset_target();
	shader_set(shd);
	
	surface_save(surf, "sfcDump.png")
}


function array_create_2d(w, h, fill)
{
	var arr = array_create(w, 0);
	
	for(var i = 0; i < w; i++)
	{
		arr[i] = array_create(h, fill);	
	}
	
	return arr;
}

//wfc(sMenuTrain, 48, 5);

randomise()
wfc(sWFCTest2, 16, 16);
