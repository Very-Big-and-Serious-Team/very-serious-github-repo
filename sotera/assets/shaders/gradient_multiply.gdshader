shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform vec2 pivot;
uniform vec4 color_pivot: source_color;
uniform vec4 color_edge: source_color;
uniform float max_distance;

vec4 gradient(vec2 uv){
    float dist = distance(uv, pivot);
    float a = min(dist / max_distance, 1.);
    return mix(color_pivot, color_edge, a);
}

vec3 inkspace_multiply(vec2 uv){
	vec4 grad = gradient(uv);
	vec3 base = texture(SCREEN_TEXTURE, uv).rgb;
	return grad.rgb * base;
}

void fragment() {
	vec3 color = inkspace_multiply(UV);
    COLOR = vec4(color, 1.0);
}