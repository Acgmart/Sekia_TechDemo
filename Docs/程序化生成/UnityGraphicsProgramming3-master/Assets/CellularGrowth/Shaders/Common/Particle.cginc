#ifndef __PARTICLE_INCLUDED__
#define __PARTICLE_INCLUDED__

struct Particle
{
    float2 position;
    float2 velocity;
    float radius;
    float threshold;
    int links;
    bool alive;
};

#endif // __PARTICLE_INCLUDED__
