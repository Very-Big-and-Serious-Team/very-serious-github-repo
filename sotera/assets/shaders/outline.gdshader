shader_type canvas_item;

uniform vec4 color: source_color = vec4(1.0, 0.5, 0.5, 1.0);
uniform float thickness: hint_range(1.0, 100.0, 0.1) = 8.0;
uniform float glow: hint_range(0.0, 100.0, 1.0) = 1.0;

void fragment() {
	float max_distance = thickness + glow;
	float max_offset = ceil(max_distance);
	float closest_outline_distance = max_distance;
	
	for(float x = -max_offset; x <= max_offset; x += 1.0)
		for(float y = -max_offset; y <= max_offset; y += 1.0){
			vec2 offset = vec2(x, y);
			float dist = length(offset);
			
			if(dist > max_distance) continue;
			
			float alpha = texture(TEXTURE, UV + offset * TEXTURE_PIXEL_SIZE).a;
			if(alpha > 0.0)
				closest_outline_distance = min(closest_outline_distance, dist);
		}

	vec4 current = texture(TEXTURE, UV);
	float alpha = current.a * color.a;
	if(alpha > 0.0) {
		alpha = 1.0;
		//current.rgb = vec3(1.0);
		}
	float mask = 1.0 - smoothstep(thickness - glow, thickness + glow, closest_outline_distance);
	float da = alpha + mask * (1.0 - alpha);
	
	vec3 blend = current.rgb * alpha + color.rgb * mask * (1.0 - alpha);
	COLOR = vec4(blend, da);
}