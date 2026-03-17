// CRT Post-Processing Shader for Ghostty
// Effects: barrel distortion, chromatic aberration, scanlines, phosphor flicker

// --- Tuning knobs ---
#define CURVATURE       0.03   // Barrel distortion strength (0.0 = flat, 0.3+ = extreme)
#define ZOOM            0.99   // Slight zoom-in to compensate for barrel shrink (1.0 = none)
#define CHROM_ABERR     0.0008 // Chromatic aberration RGB split width
#define SCANLINE_WEIGHT 0.25   // Scanline darkening intensity (0.0 = off, 0.3 = heavy)
#define FLICKER_AMP     0.03   // Phosphor flicker amplitude
#define FLICKER_FREQ    60.0   // Phosphor flicker frequency (Hz)

vec2 distort(vec2 uv) {
    vec2 cc = uv - 0.5;
    float dist = dot(cc, cc);
    return uv + cc * dist * CURVATURE;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;

    // Zoom in slightly to compensate for barrel distortion shrink
    uv = (uv - 0.5) * ZOOM + 0.5;

    // Apply barrel distortion, clamp to edge (mirrors border pixels)
    vec2 duv = clamp(distort(uv), 0.0, 1.0);

    // Chromatic aberration (RGB channel split)
    float r = texture(iChannel0, clamp(duv + vec2(CHROM_ABERR, 0.0), 0.0, 1.0)).r;
    float g = texture(iChannel0, duv).g;
    float b = texture(iChannel0, clamp(duv - vec2(CHROM_ABERR, 0.0), 0.0, 1.0)).b;
    vec3 col = vec3(r, g, b);

    // Horizontal scanlines (every ~2px)
    float scan = sin(duv.y * iResolution.y * 0.5 * 3.14159) * 0.5 + 0.5;
    col *= (1.0 - SCANLINE_WEIGHT) + SCANLINE_WEIGHT * scan;

    // Phosphor flicker
    col *= 1.0 - FLICKER_AMP * 0.5 * (1.0 + sin(iTime * FLICKER_FREQ));

    fragColor = vec4(col, 1.0);
}
