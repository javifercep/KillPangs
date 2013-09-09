#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER

uniform vec2 resolution;
uniform sampler2D mask;


void main( void ) {
vec2 position = ( gl_FragCoord.xy / resolution.xy );

vec4 me = texture2D(mask, position );

if((me.x+(1/255.))>1.) me.x= (me.x+(1/255.))-1.;
else me.x=(me.x+(1/255.));

if((me.y+(2/255.))>1.) me.y= (me.y+(2/255.))-1.;
else me.y=(me.y+(2/255.));

if((me.z+(3/255.))>1.) me.z= (me.z+(3/255.))-1.;
else me.z=(me.z+(3/255.));

gl_FragColor = vec4(me.x,me.y,me.z,me.w);

}