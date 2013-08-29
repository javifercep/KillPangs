#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER

uniform vec2 resolution;

uniform sampler2D LeftTex;
uniform sampler2D RightTex;

void main(){
vec2 position = ( gl_FragCoord.xy / resolution.xy );

 vec4 leftFrag = texture2D(LeftTex, position);
 leftFrag = vec4(1.0, leftFrag.g, leftFrag.b, 1.0);

 vec4 rightFrag = texture2D(RightTex, position);
 rightFrag = vec4(rightFrag.r, 1.0, 1.0, 1.0);

 gl_FragColor = vec4(leftFrag.rgb * rightFrag.rgb, 1.0);
}