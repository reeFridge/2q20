shader_type canvas_item;
render_mode unshaded;

uniform float opacity: hint_range(0.0, 1.0);

void fragment() {
	COLOR = vec4(vec3(0.0), opacity);
}