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
	return (start < final) ? min(start + shift, final) : max(start - shift, final);
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

function wave(argument0, argument1, argument2, argument3) 
{
	var a4 = (argument1 - argument0)* 0.5
	return argument0 + a4 + sin((((current_time * 0.001)+ argument2 * argument3)/ argument2)* (pi*2))+a4
}

function seconds(argument0) {
	return argument0 * game_get_speed(gamespeed_fps);
}

function camera_set_target(argument0) {
	with(oCamera)
	{
		follow = argument0
	}
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

/// @function split(substr, str, ignoreEmptyStrings)
/// @param {string} substr The substring to cut on
/// @param {string} str The whole string
/// @param {bool} ignoreEmptyStrings Ignore empty elements (true) or (false)
///
/// @description	Splits the str on the given substring and returns an array
/// @date			2021-01-17
/// @copyright		Appsurd
function split(substr, str, ignoreEmptyStrings) {

	var substrl = string_length(substr);
	var slot = 0;
	var d_pos = 0; // Position for loop
	var array_sample = []; // Initialise total array
	var d_count = string_count(substr, str); // How many values within string

	str += substr; // Add the substr extra to the end of str

	for(var i=0; i<=d_count; i++)
	{
	    d_pos = string_pos(substr, str)+(substrl-1); // End position of current value
	    var copy = string_copy(str, 1, d_pos-substrl); 
	    if copy != "" || ignoreEmptyStrings = false then array_sample[i-slot] = copy; // Copy string section to array
	    else slot++; // Except if ignoreEmptyStrings was set to true
	    str = string_delete(str, 1, d_pos); // Delete string section from original sample
	}
	
	return array_sample;
}

/**
@desc Returns the provided string with a capital letter in the first index.
@param {String} str
@returns {String}
*/

function upperfirst(str)
{
    return string_upper(string_char_at(str, 1)) + string_copy(str, 2, string_length(str) - 1);
}



