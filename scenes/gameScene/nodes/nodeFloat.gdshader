shader_type canvas_item;

uniform vec2 rand_seed;

uniform vec2 jitter_offset;

float random (vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

void vertex() {
    VERTEX += jitter_offset;  // Apply jitter to the vertex position
}