shader_type canvas_item;

uniform vec4 base_color : source_color = vec4(0.2, 0.5, 0.8, 1.0);
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float outline_width : hint_range(0, 10) = 0.04;

void fragment() {
    vec4 color = base_color;
    
    // Get texture coordinates (UV)
    vec2 uv = UV;
    
    // Calculate outline - check if we're near the edges
    float left = step(uv.x, outline_width / TEXTURE_PIXEL_SIZE.x);
    float right = step(1.0 - uv.x, outline_width / TEXTURE_PIXEL_SIZE.x);
    float top = step(uv.y, outline_width / TEXTURE_PIXEL_SIZE.y);
    float bottom = step(1.0 - uv.y, outline_width / TEXTURE_PIXEL_SIZE.y);
    
    float outline = max(max(left, right), max(top, bottom));
    
    // Mix colors based on outline
    COLOR = mix(color, outline_color, outline);
}