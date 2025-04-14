shader_type canvas_item;

uniform vec2 rand_seed;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void vertex() {
	VERTEX += vec2(sin(TIME * random(rand_seed))*5., 
				   cos(TIME * random(vec2(rand_seed.y, rand_seed.x)))*5.);
}
