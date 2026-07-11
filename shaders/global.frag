#pragma header

uniform float time;

uniform float bloom;

uniform float r;
uniform float g;
uniform float b;

void main()
{
    vec2 uv = openfl_TextureCoordv;
    
    vec4 color = flixel_texture2D(bitmap, uv);
    
    color.rgb *= vec3(r, g, b);
    
    color.rgb *= bloom;
    
    gl_FragColor = color;
}