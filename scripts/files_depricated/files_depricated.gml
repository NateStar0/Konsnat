
/*
//		--- File management ---

#macro SAVEGAME_FILENAME "KonsSave"
#macro SAVEGAME_DIRNAME working_directory + "/Saves/"
#macro SAVEGAME_EXTNAME ".nss"

#macro CONFIGNAME_FILENAME "KonsConfig"
#macro CONFIGNAME_DIRNAME working_directory
#macro CONFIGNAME_EXTNAME ".nsc"

function gamesave(f) constructor
{
	file = f;
	
	static save = function ()
	{
		log("Gaming")
	}
	
	static load = function ()
	{
		log("gaming (load)")
	}
}

function configuration(f) constructor
{
	file = f;
	
	static save = function()
	{
		var buffer = buffer_create(1, buffer_grow, 1);
	
		var data = 
		{
			audio :
			{
				muted : global.mute
			},
		
			display :
			{
				fullscreen : global.fullscreen	
			}
		
		}
	
		buffer_write(buffer, buffer_string, json_stringify(data));
	
		if(file_exists(file))
		{
			file_delete(file)	
		}
	
		buffer_save(buffer, file);
	}
	
	static load = function()
	{
		
		if(file_exists(file))
		{
			var buffer = buffer_load(file);
			var data = buffer_read(buffer, buffer_string);
		
			buffer_delete(buffer);
		
			// File handling can occur here
		
			data = json_parse(data);
		
			global.mute = data.audio.muted;
			global.fullscreen = data.display.fullscreen;
		
			apply()
		}
		else
		{
			self.save();
			log("Prepared configuration file!")
		}
	}
	
	static apply = function()
	{
		window_set_fullscreen(global.fullscreen);	
	}
	
	static clear = function()
	{
		file_delete(file)	
	}
}

if(os_browser == browser_not_a_browser)
{
	if(!directory_exists(SAVEGAME_DIRNAME)) directory_create(SAVEGAME_DIRNAME);
	if(!directory_exists(CONFIGNAME_DIRNAME)) directory_create(CONFIGNAME_DIRNAME);
	
	save = new gamesave(SAVEGAME_DIRNAME + SAVEGAME_FILENAME + SAVEGAME_EXTNAME);
	config = new configuration(CONFIGNAME_DIRNAME + CONFIGNAME_FILENAME + CONFIGNAME_EXTNAME);

	config.clear();

	config.load(); //Its fine, on a failed load it creates a new config?
}
else
{
	log("Detected BROWSER, file mgmt disabled!")	
}
*/
