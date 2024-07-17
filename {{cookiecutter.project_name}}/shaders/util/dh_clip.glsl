#if !defined(UTIL_DH_CLIPPING)
#define UTIL_DH_CLIPPING

#define DH_GAP_PROTECTION 1 // [0 1 2 3 4 5 6 7 8]

#define DH_BLEND_START mix(max(far - 12.0 - 16 * DH_GAP_PROTECTION, dhNearPlane), dhNearPlane, 0.5 * DH_GAP_PROTECTION)

#endif // EOF