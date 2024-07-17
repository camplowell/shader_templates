#if !defined(UTIL_SPACE)
#define UTIL_SPACE

// MARK: Transformation components

// A slightly more efficient affine transformation
vec3 affineTransform(const mat4 matrix, const vec3 position) {
    return mat3(matrix) * position + matrix[3].xyz;
}

vec3 projectAndDivide(mat4 matrix, vec3 position) {
    vec4 homogeneousPos = matrix * vec4(position, 1);
    return homogeneousPos.xyz / homogeneousPos.w;
}

vec3 projectAndDivide(mat4 matrix, vec4 position) {
    vec4 homogeneousPos = matrix * position;
    return homogeneousPos.xyz / homogeneousPos.w;
}

// MARK: Depth conversions

// Fast, approximate depth conversions
// Assumes far is much larger than near

float linearizeDepthf(float depthNL, float near) { 
    return near / (1 - depthNL);
}

float delinearizeDepthf(float depth, float near) {
    return 1.0 - (near / depth);
}

// Precise depth conversions

float linearizeDepth(float depthNL, float near, float far) {
    return (2 * near * far) / (far + near - (depthNL * 2 -  1) * far);
}

float delinearizeDepth(float depth, float near, float far) {
    return 1.0 - (near / depth) + (near / (2 * far));
}


// MARK: Space conversion shorthand

#define model_texcoord() (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy
#define model_lmcoord() (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy
#define model_light() ((gl_TextureMatrix[1] * gl_MultiTexCoord1).xy * (16.0 / 15.0) - (16.0/15.0/32.0))
#define model2view() (gl_ModelViewMatrix * gl_Vertex).xyz

#define screen2ndc(screenPos) ((screenPos)* 2 - 1)
#define ndc2screen(ndcPos) ((ndcPos) * 0.5 + 0.5)

#define ndc2view(ndcPos) projectAndDivide(gbufferProjectionInverse, ndcPos)
#define view2ndc(viewPos) projectAndDivide(gbufferProjection, viewPos)

#define view2clip(viewPos) (projectionMatrix * vec4(viewPos, 1.0))
#define view2clip_g(viewPos) (gbufferProjection * vec4(viewPos, 1.0))
#define clip2view(clipPos) (gbufferProjectionInverse * clipPos).xyz

#define view2eye(viewPos) (mat3(gbufferModelViewInverse) * (viewPos))
#define eye2view(eyePos) (mat3(gbufferModelView) * (eyePos))

#ifdef INVERSE_ONLY // Allow fewer uniforms if specified
#define feet2eye(feetPos) ((feetPos) - gbufferModelViewInverse[3].xyz)
#else
#define feet2eye(feetPos) ((feetPos) + gbufferModelView[3].xyz)
#endif

#ifdef MODELVIEW_ONLY // Allow fewer uniforms if specified
#define eye2feet(eyePos) ((eyePos) - gbufferModelView[3].xyz)
#else
#define eye2feet(eyePos) ((eyePos) + gbufferModelViewInverse[3].xyz)
#endif

#define feet2world(feetPos) (feetPos + cameraPosition)
#define world2feet(worldPos) (worldPos - cameraPosition)

#define view2feet(viewPos) affineTransform(gbufferModelViewInverse, viewPos)
#define feet2view(feetPos) affineTransform(gbufferModelView, feetPos)

// MARK: Common multi-transition steps

#define eye2world(eyePos) feet2world(eye2feet(eyePos))
#define world2eye(worldPos) feet2eye(world2feet(worldPos))

#define view2world(viewPos) feet2world(view2feet(viewPos))
#define world2view(worldPos) feet2view(world2feet(worldPos))

#define screen2view(screenPos) ndc2view(screen2ndc(screenPos))

#endif // EOF