attribute vec3 vPosition;
attribute vec3 vNormal;
attribute vec2 vTexCoord;

varying vec2 texCoord;
varying vec4 color;


uniform vec3 AmbientProduct, DiffuseProduct, SpecularProduct; 
uniform mat4 ModelView;
uniform mat4 Projection;
uniform vec4 LightPosition;
uniform float Shininess;

varying vec3 fN; //normal's eye  coordinates
varying vec3 fV; //Vertex's eye coordinates
varying vec3 fL; //Vector to the light from the vertex

void main()
{
    vec4 vpos = vec4(vPosition, 1.0);

    // Transform vertex position into eye coordinates
    vec3 pos = (ModelView * vpos).xyz;

	fN = (ModelView*vec4(vNormal,0.0)).xyz;
    fV= (ModelView *vec4(vPosition,1.0)).xyz;
    fL = LightPosition.xyz - fV;

	/*
    // The vector to the light from the vertex    
    vec3 Lvec = LightPosition.xyz - pos;

    // Unit direction vectors for Blinn-Phong shading calculation
    vec3 L = normalize( Lvec );   // Direction to the light source
    vec3 E = normalize( -pos );   // Direction to the eye/camera
    vec3 H = normalize( L + E );  // Halfway vector

    // Transform vertex normal into eye coordinates (assumes scaling
    // is uniform across dimensions)
    vec3 N = normalize( (ModelView*vec4(vNormal, 0.0)).xyz );
    // Compute terms in the illumination equation
    vec3 ambient = AmbientProduct;
    
    // PART F
    // Quadratic factor
    float a = 0.1;
    float b = 0.2;
    float c = 0.3;
    float distance = length(Lvec);
    float attenuation = 1.0/(a + b*distance + c * distance * distance);
    //float attenuation = 1.0;


    float Kd = max( dot(L, N), 0.0 );
    vec3  diffuse = Kd*DiffuseProduct;

    float Ks = pow( max(dot(N, H), 0.0), Shininess );
    vec3  specular = Ks * SpecularProduct;
    
    if (dot(L, N) < 0.0 ) {
	specular = vec3(0.0, 0.0, 0.0);
    } 


    // globalAmbient is independent of distance from the light source
    vec3 globalAmbient = vec3(0.1, 0.1, 0.1);
    color.rgb = globalAmbient  + ((ambient + diffuse)/lightDropoff)  * attenuation; // PART F
    color.a = 1.0;

	*/

    gl_Position = Projection * ModelView * vpos;
    texCoord = vTexCoord;
}