
function sigmoid(t)
{
	return (1 / (1 + exp(-t)));
}

function exsig(t)
{
	return sigmoid(t) * 2 - 1;	
}

function network(layerS) constructor
{
	layerCount = array_length(layerS);
	layerSizes = layerS;

	layers = [];
	biases = [];
	weights = [];

	for(var i = 0; i < array_length(layerSizes); i++)
	{
		layers[i] = array_create(layerSizes[i], 0);		
		
		biases[i] = (i == 0) ? array_create(layerSizes[i], 0) : [];
		
		if(i != 0)
		{
			for(var j = 0; j < layerSizes[i]; j++)
			{
				biases[i][j] = random(2) - 1;	
			}
		}
		
		if(i < array_length(layerSizes) - 1)
		{
			weights[i] = array_create(layerSizes[i], 0);	
			
			for(var j = 0; j < layerSizes[i]; j++)
			{
				weights[i][j] = [];
				
				for(var k = 0; k < layerSizes[i + 1]; k++)
				{
					weights[i][j][k] = random(2) - 1;	
				}
			}
		}
	}
	
	parse = function(input)
	{
		layers[0] = input;
		
		for(var i = 1; i < layerCount; i++)
		{
			for(var j = 0; j < layerSizes[i]; j++)
			{
				// Our node is at i (layer), j (index)	
				var z = biases[i][j];
				
				for(var k = 0; k < array_length(weights[i - 1]); k++)
				{
					z += weights[i - 1][k][j] * layers[i - 1][k];	
				}
				
				layers[i][j] = exsig(z);
			}
		}
	}
	
	getFundamentals = function()
	{
		return [layers, weights, biases]	
	}
	
	getLayer = function(n)
	{
		log(layers)
		log(weights)
		log(biases)
		
		return layers[n];	
	}
	
	parse(array_create(layerSizes[0], 0));
}
