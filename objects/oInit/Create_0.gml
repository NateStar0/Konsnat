/// @description Init

#macro GAMENAME "Konsnat"

#macro FPS_LOCKED 60

game_set_speed(FPS_LOCKED, gamespeed_fps);

//show_debug_overlay(1);

randomize();

global.stage = 0;

//		--- Colours ---

colours();

//		---	Display Management	---

global.pausable = true;

#macro WIN_WIDTH 960
#macro WIN_HEIGHT 540

#macro VW_WIDTH 320
#macro VW_HEIGHT 180

#macro CAMERA view_camera[0]

global.fullscreen = false;

window_set_size(WIN_WIDTH, WIN_HEIGHT);
display_set_gui_size(VW_WIDTH, VW_HEIGHT);

window_set_caption(GAMENAME);

//		--- Audio Management ---

global.mute = false;

//		--- Font management ---

font = font_add_sprite_ext(sFont, " !\"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^'_\{|}~abcdefghijklmnopqrstuvwxyz", false, false);
draw_set_font(font);

//		--- Input management ---

global.input = array_create(8, 0);
for(var i = 0; i < 8; i++) global.input[i] = array_create(2, false);

keys = [ord("W"), ord("S"), ord("A"), ord("D"), ord("E"), ord("Q"), vk_escape, vk_tab];
keyCount = array_length(keys);

enum INPUTTYPE
{
	PRESS, 
	HOLD,
}

//		--- Misc ---

enum weather
{
	clear, 
	raining
}

global.weather = weather.clear;
global.rainoffset = 20 // Flowing to the right
global.raindir = 270 + global.rainoffset

//		--- Exit Init	---

#macro GUI_BUFFER 12
#macro GUI_TOPOFFSET_LEFT GUI_BUFFER
#macro GUI_TOPOFFSET_TOP GUI_BUFFER
#macro GUI_TOPOFFSET_BOTTOM (30 - GUI_BUFFER)
#macro GUI_TOPOFFSET_RIGHT (VW_WIDTH - GUI_BUFFER)

#macro GUI_BOTTOMOFFSET_LEFT GUI_BUFFER
#macro GUI_BOTTOMOFFSET_TOP ((VW_HEIGHT - 30) + GUI_BUFFER)
#macro GUI_BOTTOMOFFSET_BOTTOM (VW_HEIGHT - GUI_BUFFER)
#macro GUI_BOTTOMOFFSET_RIGHT (VW_WIDTH - GUI_BUFFER)

room_goto_next();
