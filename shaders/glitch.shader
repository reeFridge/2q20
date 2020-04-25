shader_type canvas_item;

uniform bool apply = true;
uniform float amount = 1.0;
uniform sampler2D offset_texture : hint_white;

void fragment() {
	vec4 texture_color = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0);
	vec4 color = texture_color;
	
	if (apply == true) {
		float adjusted_amount = amount * texture(offset_texture, SCREEN_UV).r / 100.0;
		color.r = textureLod(SCREEN_TEXTURE, vec2(SCREEN_UV.x + adjusted_amount, SCREEN_UV.y), 0.0).r;
		color.g = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).g;
		color.b = textureLod(SCREEN_TEXTURE, vec2(SCREEN_UV.x - adjusted_amount, SCREEN_UV.y), 0.0).b;
	}
	COLOR = color;
}