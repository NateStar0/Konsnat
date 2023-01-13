//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D replacement_texture;
uniform float uv_x;
uniform float uv_y;

//THE VEC2 FOR UVs WONT PASS CORRECTLY!!!!!!!!!!!!!!!!!!
//uniform float size;

void main()
{	
	// hHy do we halve it? the texturepage isn't square (thanks GM!)!
	
	vec4 og_pixel = texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 replaced_pixel = texture2D( replacement_texture, vec2(uv_x + og_pixel.r, uv_y + og_pixel.g / 2.0));
	
    gl_FragColor = replaced_pixel;
}
