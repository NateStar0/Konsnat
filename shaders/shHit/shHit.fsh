//
// Simple passthrough fragment shader
//

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 unmodifiedColour = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord);
	
	if(unmodifiedColour.a > 0.0)
	{
		gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
		return;
	}
	
	gl_FragColor = unmodifiedColour;
}
