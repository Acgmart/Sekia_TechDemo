﻿#ifndef NOISE_INCLUDED
#define NOISE_INCLUDED
//
// Description : Array and textureless GLSL 2D simplex noise function.
//      Author : Ian McEwan, Ashima Arts.
//  Maintainer : ijm
//     Lastmod : 20110822 (ijm)
//     License : Copyright (C) 2011 Ashima Arts. All rights reserved.
//               Distributed under the MIT License. See LICENSE file.
//               https://github.com/ashima/webgl-noise
// 
float4 mod289(float4 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}
float3 mod289(float3 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

float2 mod289(float2 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

float mod289(float x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0; 
 }

float permute(float x) {
     return mod289(((x*34.0)+1.0)*x);
}

float3 permute(float3 x) {
  return mod289(((x*34.0)+1.0)*x);
}

float4 permute(float4 x) {
     return mod289(((x*34.0)+1.0)*x);
}

float4 taylorInvSqrt(float4 r)
{
  return 1.79284291400159 - 0.85373472095314 * r;
}

float taylorInvSqrt(float r)
{
  return 1.79284291400159 - 0.85373472095314 * r;
}

float4 grad4(float j, float4 ip)
  {
  const float4 ones = float4(1.0, 1.0, 1.0, -1.0);
  float4 p,s;

  p.xyz = floor( frac (float3(j,j,j) * ip.xyz) * 7.0) * ip.z - 1.0;
  p.w = 1.5 - dot(abs(p.xyz), ones.xyz);
  //s = p;//float4(lessThan(p, float4(0.0)));
  if(p.x<0)
  	s.x = 1;
  else
  	s.x = 0;
  if(p.y<0)
  	s.y = 1;
  else
  	s.y = 0;
  if(p.z<0)
  	s.z = 1;
  else
  	s.z = 0;
  if(p.w<0)
  	s.w = 1;
  else
  	s.w = 0;
  p.xyz = p.xyz + (s.xyz*2.0 - 1.0) * s.www; 

  return p;
  }

float snoise(float2 v)
  {
  const float4 C = float4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
                      0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
                     -0.577350269189626,  // -1.0 + 2.0 * C.x
                      0.024390243902439); // 1.0 / 41.0
// First corner
  float2 i  = floor(v + dot(v, C.yy) );
  float2 x0 = v -   i + dot(i, C.xx);

// Other corners
  float2 i1;
  //i1.x = step( x0.y, x0.x ); // x0.x > x0.y ? 1.0 : 0.0
  //i1.y = 1.0 - i1.x;
  i1 = (x0.x > x0.y) ? float2(1.0, 0.0) : float2(0.0, 1.0);
  // x0 = x0 - 0.0 + 0.0 * C.xx ;
  // x1 = x0 - i1 + 1.0 * C.xx ;
  // x2 = x0 - 1.0 + 2.0 * C.xx ;
  float4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;

// Permutations
  i = mod289(i); // Avoid truncation effects in permutation
  float3 p = permute( permute( i.y + float3(0.0, i1.y, 1.0 ))
		+ i.x + float3(0.0, i1.x, 1.0 ));

  float3 m = max(0.5 - float3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;

// Gradients: 41 points uniformly over a line, mapped onto a diamond.
// The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)

  float3 x = 2.0 * frac(p * C.www) - 1.0;
  float3 h = abs(x) - 0.5;
  float3 ox = floor(x + 0.5);
  float3 a0 = x - ox;

// Normalise gradients implicitly by scaling m
// Approximation of: m *= inversesqrt( a0*a0 + h*h );
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );

// Compute final noise value at P
  float3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}

float snoise(float3 v)
  { 
  const float2  C = float2(1.0/6.0, 1.0/3.0) ;
  const float4  D = float4(0.0, 0.5, 1.0, 2.0);

// First corner
  float3 i  = floor(v + dot(v, C.yyy) );
  float3 x0 =   v - i + dot(i, C.xxx) ;

// Other corners
  float3 g = step(x0.yzx, x0.xyz);
  float3 l = 1.0 - g;
  float3 i1 = min( g.xyz, l.zxy );
  float3 i2 = max( g.xyz, l.zxy );

  //   x0 = x0 - 0.0 + 0.0 * C.xxx;
  //   x1 = x0 - i1  + 1.0 * C.xxx;
  //   x2 = x0 - i2  + 2.0 * C.xxx;
  //   x3 = x0 - 1.0 + 3.0 * C.xxx;
  float3 x1 = x0 - i1 + C.xxx;
  float3 x2 = x0 - i2 + C.yyy; // 2.0*C.x = 1/3 = C.y
  float3 x3 = x0 - D.yyy;      // -1.0+3.0*C.x = -0.5 = -D.y

// Permutations
  i = mod289(i); 
  float4 p = permute( permute( permute( 
             i.z + float4(0.0, i1.z, i2.z, 1.0 ))
           + i.y + float4(0.0, i1.y, i2.y, 1.0 )) 
           + i.x + float4(0.0, i1.x, i2.x, 1.0 ));

// Gradients: 7x7 points over a square, mapped onto an octahedron.
// The ring size 17*17 = 289 is close to a multiple of 49 (49*6 = 294)
  float n_ = 0.142857142857; // 1.0/7.0
  float3  ns = n_ * D.wyz - D.xzx;

  float4 j = p - 49.0 * floor(p * ns.z * ns.z);  //  mod(p,7*7)

  float4 x_ = floor(j * ns.z);
  float4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)

  float4 x = x_ *ns.x + ns.yyyy;
  float4 y = y_ *ns.x + ns.yyyy;
  float4 h = 1.0 - abs(x) - abs(y);

  float4 b0 = float4( x.xy, y.xy );
  float4 b1 = float4( x.zw, y.zw );

  //float4 s0 = float4(lessThan(b0,0.0))*2.0 - 1.0;
  //float4 s1 = float4(lessThan(b1,0.0))*2.0 - 1.0;
  float4 s0 = floor(b0)*2.0 + 1.0;
  float4 s1 = floor(b1)*2.0 + 1.0;
  float4 sh = -step(h, float4(0,0,0,0));

  float4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
  float4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;

  float3 p0 = float3(a0.xy,h.x);
  float3 p1 = float3(a0.zw,h.y);
  float3 p2 = float3(a1.xy,h.z);
  float3 p3 = float3(a1.zw,h.w);

//Normalise gradients
  float4 norm = taylorInvSqrt(float4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;

// Mix final noise value
  float4 m = max(0.6 - float4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
  m = m * m;
  return 42.0 * dot( m*m, float4( dot(p0,x0), dot(p1,x1), 
                                dot(p2,x2), dot(p3,x3) ) );
  }

// (sqrt(5) - 1)/4 = F4, used once below
#define F4 0.309016994374947451

float snoise(float4 v)
  {
  const float4  C = float4( 0.138196601125011,  // (5 - sqrt(5))/20  G4
                        0.276393202250021,  // 2 * G4
                        0.414589803375032,  // 3 * G4
                       -0.447213595499958); // -1 + 4 * G4

// First corner
  float4 i  = floor(v + dot(v, float4(F4,F4,F4,F4)) );
  float4 x0 = v -   i + dot(i, C.xxxx);

// Other corners

// Rank sorting originally contributed by Bill Licea-Kane, AMD (formerly ATI)
  float4 i0;
  float3 isX = step( x0.yzw, x0.xxx );
  float3 isYZ = step( x0.zww, x0.yyz );
//  i0.x = dot( isX, float3( 1.0 ) );
  i0.x = isX.x + isX.y + isX.z;
  i0.yzw = 1.0 - isX;
//  i0.y += dot( isYZ.xy, float2( 1.0 ) );
  i0.y += isYZ.x + isYZ.y;
  i0.zw += 1.0 - isYZ.xy;
  i0.z += isYZ.z;
  i0.w += 1.0 - isYZ.z;

  // i0 now contains the unique values 0,1,2,3 in each channel
  float4 i3 = clamp( i0, 0.0, 1.0 );
  float4 i2 = clamp( i0-1.0, 0.0, 1.0 );
  float4 i1 = clamp( i0-2.0, 0.0, 1.0 );

  //  x0 = x0 - 0.0 + 0.0 * C.xxxx
  //  x1 = x0 - i1  + 1.0 * C.xxxx
  //  x2 = x0 - i2  + 2.0 * C.xxxx
  //  x3 = x0 - i3  + 3.0 * C.xxxx
  //  x4 = x0 - 1.0 + 4.0 * C.xxxx
  float4 x1 = x0 - i1 + C.xxxx;
  float4 x2 = x0 - i2 + C.yyyy;
  float4 x3 = x0 - i3 + C.zzzz;
  float4 x4 = x0 + C.wwww;

// Permutations
  i = mod289(i); 
  float j0 = permute( permute( permute( permute(i.w) + i.z) + i.y) + i.x);
  float4 j1 = permute( permute( permute( permute (
             i.w + float4(i1.w, i2.w, i3.w, 1.0 ))
           + i.z + float4(i1.z, i2.z, i3.z, 1.0 ))
           + i.y + float4(i1.y, i2.y, i3.y, 1.0 ))
           + i.x + float4(i1.x, i2.x, i3.x, 1.0 ));

// Gradients: 7x7x6 points over a cube, mapped onto a 4-cross polytope
// 7*7*6 = 294, which is close to the ring size 17*17 = 289.
  float4 ip = float4(1.0/294.0, 1.0/49.0, 1.0/7.0, 0.0) ;

  float4 p0 = grad4(j0,   ip);
  float4 p1 = grad4(j1.x, ip);
  float4 p2 = grad4(j1.y, ip);
  float4 p3 = grad4(j1.z, ip);
  float4 p4 = grad4(j1.w, ip);

// Normalise gradients
  float4 norm = taylorInvSqrt(float4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;
  p4 *= taylorInvSqrt(dot(p4,p4));

// Mix contributions from the five corners
  float3 m0 = max(0.6 - float3(dot(x0,x0), dot(x1,x1), dot(x2,x2)), 0.0);
  float2 m1 = max(0.6 - float2(dot(x3,x3), dot(x4,x4)            ), 0.0);
  m0 = m0 * m0;
  m1 = m1 * m1;
  return 49.0 * ( dot(m0*m0, float3( dot( p0, x0 ), dot( p1, x1 ), dot( p2, x2 )))
               + dot(m1*m1, float2( dot( p3, x3 ), dot( p4, x4 ) ) ) ) ;

  }
  
  float3 snoise3D(float3 v){
  	float3 n = float3(
  		snoise(float2(v.x, v.y)),
  		snoise(float2(v.y, v.z)),
  		snoise(float2(v.z, v.x))
  	);
  	return n;
  }
  
  float curlX(float3 v, float d){
  	return (
  			(snoise3D(float3(v.x,v.y+d,v.z)).z - snoise3D(float3(v.x,v.y-d,v.z)).z)
  			-(snoise3D(float3(v.x,v.y,v.z+d)).y - snoise3D(float3(v.x,v.y,v.z-d)).y)
  		) /2/d;
  }
  
  float curlY(float3 v, float d){
  	return (
  			(snoise3D(float3(v.x,v.y,v.z+d)).x - snoise3D(float3(v.x,v.y,v.z-d)).x)
  			-(snoise3D(float3(v.x+d,v.y,v.z)).z - snoise3D(float3(v.x-d,v.y,v.z)).z)
  		) /2/d;
  }
  
  float curlZ(float3 v, float d){
  	return (
  			(snoise3D(float3(v.x+d,v.y,v.z)).y - snoise3D(float3(v.x-d,v.y,v.z)).y)
  			-(snoise3D(float3(v.x,v.y+d,v.z)).x - snoise3D(float3(v.x,v.y-d,v.z)).x)
  		) /2/d;
  }
#endif // NOISE_INCLUDED