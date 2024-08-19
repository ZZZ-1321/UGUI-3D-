
#ifndef DEFINE_CG_INCLUDE
#define DEFINE_CG_INCLUDE

#if defined (_LIGHTING_NORMAL) || defined(_LIGHTING_HIGH)
#define _IX_LIGHTING
#endif

#if defined (_IX_LIGHTING) && ((_EXTRALIGHT_ONE) || defined(_EXTRALIGHT_TWO))
#define _IX_EXTRALIGHT
#endif

#endif