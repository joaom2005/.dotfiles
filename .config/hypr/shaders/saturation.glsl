precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 color = texture2D(tex, v_texcoord);

    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    float saturation = 1.5; // increase this value

    vec3 result = mix(vec3(gray), color.rgb, saturation);
    gl_FragColor = vec4(result, color.a);
}
