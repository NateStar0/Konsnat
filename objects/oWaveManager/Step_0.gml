/// @description 

var exists = false;

for(var i = 0; i < array_length(enemies); i++)
{
	if(instance_exists(enemies[i]))
	{
		exists = true;
		i = array_length(enemies);
	}
}

if(!exists)
{
	countdown = max(countdown - 1, 0);
	
	if(!countdown)
	{
		currentWave ++;	
		countdown = seconds(oKons.hp);
	
		// Generate the enemies
	
		var materialBalance = currentWave + 2;
	
		while(materialBalance > 0)
		{
			log(materialBalance, enemies)
		
			for(var i = 0; i < array_length(enemyWeightings); i++)
			{
				if(enemyWeightings[i][0] <= materialBalance)
				{
					materialBalance -= 	enemyWeightings[i][0];
				
					var inst = instance_create_layer(choose(708, 836), 108, "Instances_1", enemyWeightings[i][1]);
			
					array_push(enemies, inst);
			
					i = array_length(enemyWeightings);
				}
			}
		}
	}
}
