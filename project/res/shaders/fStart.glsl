varying vec4 color;
varying vec2 texCoord;  // The third coordinate is always 0.0 and is discarded
uniform float texScale;
uniform sampler2D texture;


// PART I
// Light Object 2
uniform vec4 LightPosition2;
uniform vec3 LightColor2;
uniform float LightBrightness2;


// PART G
varying vec3 fN; //normal's eye  coordinates
varying vec3 fV; //Vertex's eye coordinates
varying vec3 fL; //Vector to the light from the vertex

uniform vec3 AmbientProduct, DiffuseProduct, SpecularProduct;
uniform mat4 ModelView;
uniform vec4 LightPosition;
uniform float Shininess;

void main()
{
	
   vec3 N = normalize(fN);   
    vec3 V = normalize(-fV); 
    vec3 L = normalize(fL);

    vec3 H = normalize(L + V);
    vec3 ambient = AmbientProduct;

    float Kd = max(dot(L,N), 0.0);
    vec3 diffuse = Kd* DiffuseProduct;

    float Ks = pow(max(dot(N,H), 0.0), Shininess);
    vec3 specular = Ks *SpecularProduct;

      if (dot(L, N) < 0.0 ) {
	specular = vec3(0.0, 0.0, 0.0);
    } 
    //TODO play with quadratic coefficients
    float distance = length(fL);
    float a = 0.0;
    float b = 0.5;
    float c = 4.2;
    float attenuation = 1.0/(a + b*distance + c * distance * distance);
    vec3 globalAmbient = vec3(0.1, 0.1, 0.1);
    gl_FragColor.rgb = globalAmbient + (ambient + diffuse ) * attenuation;
    gl_FragColor.a = 1.0;
    gl_FragColor = gl_FragColor * texture2D( texture, texCoord * texScale ) + vec4(attenuation * specular,1);
    //adding specular component ontop of texture PART H

    // Initialize the vertex position attributes
}