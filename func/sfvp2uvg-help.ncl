THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/sfvp2uvg.shtml
THE_TITLE:sfvp2uvg

sfvp2uvg

   Computes the wind components given stream function and velocity potential (on a gaussian grid) via spherical harmonics.

Prototype

        procedure sfvp2uvg (
                sf  : numeric,
                vp  : numeric,
                u   : float,    ; or double
                v   : float     ; or double
        )

Arguments

   sf

   stream function array (input, array with two or more dimensions, last two dimensions must be nlat x nlon)
     * input values must be in ascending latitude order
     * input array must be on a global grid

   vp

   velocity potential array (input, same dimensions as sf)
     * input values must be in ascending latitude order
     * input array must be on a global grid

   u
   v

   wind components (output, same dimensions as sf and vp, values will be in ascending latitude order)

Description

   sfvp2uvg computes the wind components given stream function and divergent arrays sf and vp, and stores the results in the
   arrays u and v. sfvp2uvg operates on a gaussian grid. If the input arrays sf and vp are on a fixed grid, sfvp2uvf should
   be used.

   This procedure does not handle missing values. If any missing values are encountered in a particular 2D input grid, then
   all of the values in the corresponding output grids will be set to the missing value defined by the output grids'
   _FillValue attributes.

   Note: For the arrays whose last two dimensions are nlat x nlon, the rest of the dimensions (if any) are collectively
   referred to as N. If the input/output arrays are just two dimensions, then N can either be considered equal to 1 or
   nothing at all.

   Arrays which have dimensions N x nlat x nlon should not include the cyclic (wraparound) points when invoking the
   procedures and functions which use spherical harmonics (Spherepack).

See Also

   sfvp2uvf

Examples

   Example 1

  u     = sf                    ; create arrays for u and v
  v     = sf
  sfvp2uvg (sf,vp, u,v)         ; sf,vp > reconstruct original wind

  u@long_name = "Zonal Wind component"
  v@long_name = "Meridional Wind component"

  u@units     = "m/s"
  v@units     = "m/s"

Errors

   If jer or ker is equal to:

     1 : error in the specification of nlat
     2 : error in the specification of nlon
     4 : error in the specification of N (jer only)


   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:55 +0800
# vim:set fdm=indent foldlevel=0:
