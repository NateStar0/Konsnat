/// Store all cool general functions

#macro elif else if

/**
@desc Sets the current drawing alignment and colour for text

@param {Constant.Color}		colour 
@param {Constant.HAlign}	Halignment 
@param {Constant.VAlign}	Valignment

@return {undefined}

*/

function draw_set_text(colour, Halignment, Valignment) 
{
	draw_set_colour(colour);
	draw_set_halign(Halignment);
	draw_set_valign(Valignment);
}

/**
@desc Returns an array of instances at a specified point

@param {Real}				x
@param {Real}				y
@param {Asset.GMObject}		object

@return {Array<Any*>}

*/

function instance_place_array(x, y, object)
{
	var list = ds_list_create();
	var num = instance_place_list(x, y, object, list, false);
	var arr = [];
	
	if(num > 0)
	{
		for(var i = 0; i < num; i++)
		{
			array_push(arr, list[| i]);
		}
	}

	ds_list_destroy(list);
	return arr;
}

/**
@desc Returns an real equal to the start +/- the shift value towards the final value

@param {Real}		start
@param {Real}		final
@param {Real}		shift

@return {Real}

*/

function approach(start, final, shift) 
{
	return (start != final) ? ((start < final) ? min(start + shift, final) : max(start - shift, final)) : start;
}

/**
@desc Returns a boolean for whether the weighted chance event occurs

@param {Real}	weight
@return {Bool}

*/

function chance(weight) 
{
	return weight > random(1)
}

/**
	@param	{Real} low
	@param	{Real} high
	@param	{Real} duration
	@param	{Real} offset
	
	@return {Real}
*/

function wave(low, high, duration, offset) 
{
	var waveV = (high - low) * 0.5;
	return low + waveV + sin((((current_time * 0.001) + duration * offset) / duration) * (pi * 2)) * waveV;
}

/**
	@param {Real} frames
	@return {Real} seconds
*/

function seconds(frames) {
	return frames * FPS_LOCKED;
}


function log() 
{
	var str = "";
	for(var i = 0; i < argument_count; i++)
	{
	  str += string(argument[i]) + " ";
	}
	show_debug_message(str);
}


function shake_cam(time, mag) 
{
	with(oCamera)
	{
		if(time > shakeRem)
		{
			shakeLen = time;
			shakeRem = time;
			shakeMag = mag;
		}
	}
}

function pick_weighted(arr)
{
	
	var itemN = 0;
	var itemCount = array_length(arr);
	var items = array_create(itemCount);
	var cmf = array_create(itemCount);
	var total = 0;
	var i = 0;
		
	repeat (itemCount) 
	{
		items[itemN] = arr[i][0];
		total += arr[i][1];
		cmf[itemN] = total;
		itemN++;
		i++
	}
	
	var rand = random(total);
	
	for (var j = 0; j < itemCount; j++) 
	{
		if (rand < cmf[j]) 
		{
			return items[j];
		}
	}
	
	return items[itemCount - 1];
}

