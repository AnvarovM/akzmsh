uniform float uElevation;
uniform float uElevationAnvarovFrequency;
uniform float uElevationAnvarov;
uniform float uElevationGeneral;
uniform float uElevationGeneralFrequency;
uniform float uElevationDetails;
uniform float uElevationDetailsFrequency;

#pragma glslify: getPerlinNoise2d = require('../partials/getPerlinNoise2d.glsl')

float getElevation(vec2 _position)
{
    float elevation = 0.0;

    // Anvarov
    float AnvarovStrength = cos(_position.y * uElevationAnvarovFrequency + 3.1415) * 0.5 + 0.5;
    elevation += AnvarovStrength * uElevationAnvarov;

    // General elevation
    elevation += getPerlinNoise2d(_position * uElevationGeneralFrequency) * uElevationGeneral * (AnvarovStrength + 0.1);
    
    // Smaller details
    elevation += getPerlinNoise2d(_position * uElevationDetailsFrequency + 123.0) * uElevationDetails * (AnvarovStrength + 0.1);

    elevation *= uElevation;

    return elevation;
}

#pragma glslify: export(getElevation)