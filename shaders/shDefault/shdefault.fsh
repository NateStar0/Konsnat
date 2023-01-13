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
	
	if(unmodifiedColour.rgb == colourBlack.rgb) unmodifiedColour.rgb = colourReplacementBlack.rgb;
	if(unmodifiedColour.rgb == colourDarkest.rgb) unmodifiedColour.rgb = colourReplacementDarkest.rgb;
	if(unmodifiedColour.rgb == colourDarker.rgb) unmodifiedColour.rgb = colourReplacementDarker.rgb;
	if(unmodifiedColour.rgb == colourBrighter.rgb) unmodifiedColour.rgb = colourReplacementBrighter.rgb;
	if(unmodifiedColour.rgb == colourBrighest.rgb) unmodifiedColour.rgb = colourReplacementBrighest.rgb;
	if(unmodifiedColour.rgb == colourWhite.rgb) unmodifiedColour.rgb = colourReplacementWhite.rgb;
	
	gl_FragColor = unmodifiedColour;
}
