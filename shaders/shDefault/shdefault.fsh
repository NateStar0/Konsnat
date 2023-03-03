//
// Simple passthrough fragment shader
//

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 colourReplacementBlack;
uniform vec4 colourReplacementDarkest;
uniform vec4 colourReplacementDarker;
uniform vec4 colourReplacementBrighter;
uniform vec4 colourReplacementBrighest;
uniform vec4 colourReplacementWhite;

uniform vec4 colourBlack;
uniform vec4 colourDarkest;
uniform vec4 colourDarker;
uniform vec4 colourBrighter;
uniform vec4 colourBrighest;
uniform vec4 colourWhite;

void main()
{
	vec4 unmodifiedColour = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord);
	
	if(unmodifiedColour.a > 0.0)
	{
		if(unmodifiedColour.rgb == colourBlack.rgb) 
		{
			unmodifiedColour.rgb = colourReplacementBlack.rgb;
			
			gl_FragColor = unmodifiedColour; 
			return;
		}
		
		if(unmodifiedColour.rgb == colourDarkest.rgb)
		{
			unmodifiedColour.rgb = colourReplacementDarkest.rgb;
			gl_FragColor = unmodifiedColour;
			return;
		}
		
		if(unmodifiedColour.rgb == colourDarker.rgb)
		{
			unmodifiedColour.rgb = colourReplacementDarker.rgb;
			gl_FragColor = unmodifiedColour;
			return;
		}
		
		if(unmodifiedColour.rgb == colourBrighter.rgb)
		{
			unmodifiedColour.rgb = colourReplacementBrighter.rgb;
			gl_FragColor = unmodifiedColour;
			return;
		}
		
		if(unmodifiedColour.rgb == colourBrighest.rgb) 
		{
			unmodifiedColour.rgb = colourReplacementBrighest.rgb;
			gl_FragColor = unmodifiedColour;
			return;
		}
		
		if(unmodifiedColour.rgb == colourWhite.rgb) 
		{
			unmodifiedColour.rgb = colourReplacementWhite.rgb;
			
			gl_FragColor = unmodifiedColour;
			return;
		}
	}
	
	gl_FragColor = unmodifiedColour;
}
