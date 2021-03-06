THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/wgt_runave_n_Wrap.shtml
THE_TITLE:wgt_runave_n_Wrap

wgt_runave_n_Wrap

   Calculates a weighted running average on the given dimension and retains metadata.

   [new.gif] Available in version 5.2.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function wgt_runave_n_Wrap (
                x       : numeric,
                wgt     : numeric,
                opt     : integer,
                dim [1] : integer
        )

        return_val  :  float or double

Arguments

   x

   An array with one or more dimensions. The dim-th dimension will be the dimension on which the weighted running average is
   performed. Missing values should be indicated by x@_FillValue. If x@_FillValue is not set, then the NCL default
   (appropriate to the type of x) is assumed.
   wgt

   A one-dimensional vector containing all the weights. Most commonly, the number of weights is an odd number).
   opt

   End-point option (opt = 0 is the most common option)

   In the following assume the weights add to 1.0 and

     N = {last point in the series}
     xi = {input series}
     xo = {output series}
     nwgt = {number of wgts}

opt < 0 : utilize cyclic conditions
      e.g., nave = 2
             xo(0) = w(0) * xi(0) + w(1) * xi(1)
             xo(N) = w(0) * xi(N) + w(1) * xi(0)
      e.g., nwgt = 3
             xo(0) = w(0) * xi(N) + w(1) * xi(0) + w(2) * xi(1)
             xo(N) = w(0) * xi(N - 1) + w(1) * xi(N) + w(2) * xi(0)
      e.g., nwgt = 4
             xo(0) = w(0) * xi(N) + w(1) * xi(0) + w(2) * xi(1) + w(3) * xi(2)
             xo(N) = w(0) * xi(N - 1) + w(1) * xi(N) + w(2) * xi(1) + w(3) * xi(2)

opt = 0 : set unsmoothed beginning and end pts to x@_FillValue (most common)
      e.g., nave = 2
             xo(0) = w(0) * xi(0) + w(1) * xi(1)
             xo(N) = xi@_FillValue
      e.g., nave = 3
             xo(0) = xi@_FillValue
             xo(1) = w(0) * xi(0) + w(1) * xi(1) + w(2) * xi(2)
             xi(N) = xi@_FillValue
      e.g., nave = 4
             xo(0)     = xi@_FillValue
             xo(1)     = w(0) * xi(0) + w(1) * xi(1) + w(2) * xi(2) + w(3) * xi(3)
             xo(N - 2) = w(0) * xi(N - 3) + w(1) * xi(N - 2) + w(2) * xi(N - 1) + w(3) * xi(N)
             xo(N - 1) = xi@_FillValue
             xo(N)     = xi@_FillValue

opt > 0 : utilize reflective (symmetric) conditions
      e.g., nave = 2
             xo(0) = w(0) * xi(0) + w(1) * xi(1)
             xo(N) = w(0) * xi(N) + w(0) * xi(0)
      e.g., nwgt = 3
             xo(0) = w(0) * xi(1) + w(1) * xi(0) + w(2) * xi(1)
             xo(N) = w(0) * xi(N - 1) + w(1) * xi(N) + w(2) * xi(N - 1)
      e.g., nwgt = 4
             xo(0) = w(0) * xi(1) + w(1) * xi(0) + w(2) * xi(1) + w(3) * xi(2)
             xo(N) = w(0) * xi(N - 1) + w(1) * xi(N) + w(2) * xi(0) + w(3) * xi(2)

   dim

   A scalar integer indicating which dimension of x to do the calculation on. Dimension numbering starts at 0.

Return value

   Returns an array of the same dimensionality as x with the dim-th dimension smoothed.

   The return type is a floating point array if the input is floating point, and double if if the input is of type double.

Description

   This function computes a weighted running average on the given dimension and retains metadata.

   The running average is a special case of a filter. The filter is applied to the i-th time of the requested series as
   follows:

    F(i) = SUM{w(j) * UF(i - (nwgt / 2) + j - 1)} from j = 0, nwgt - 1

   where F is the filtered field, UF is the unfiltered field, w(j) is the j-th filter weight, and nwgt is the number of
   weights.

   With the proper choice of weights, this "filter" can also be used to compute time differences and derivatives.

   If the number of weights is even, the filter's center falls between series elements; in this case the center is shifted
   one-half of a time increment towards the latter element.

   This function is identical to the built-in function wgt_runave_n, except it retains metadata.

See Also

   wgt_runave, wgt_runave_Wrap, wgt_areaave_Wrap, wgt_areaave, wgt_areaave2, wgt_arearmse, wgt_arearmse2, wgt_areasum2,
   wgt_volave, wgt_volave_ccm, wgt_volrmse, wgt_volrmse_ccm

Examples

   Example 1

   Let x be dimensioned nlat x mlon x ktimes where nlat = 64, mlon = 128, and ktimes = 1000. Perform a 3 point (1-2-1)
   average and use opt = 0. Return the nlat x mlon smoothed series to the original x array:

    x = wgt_runave_n_Wrap(x, (/0.25, 0.50, 0.25/), 0, 2)

   Example 2

   Let x be dimensioned ntim x nlat x mlon with named dimensions "time," "lat," and "lon." (Assume the "time" dimension
   contains monthly data.) Use the 11-point Trenberth filter on the monthly data. The Trenberth filter effectively removes
   fluctuations with periods of less than 8 months but includes all others. At 24 months 80% of the variance is retained.
   The cited filter is:

     Author: K. E. Trenberth
     Journal: UCAR/NCAR/MMM Monthly Weather Review, February, 1984.

    opt = 0
    wgt  = (/0.0270, 0.05856, 0.09030, 0.11742, 0.13567, \
              0.1421, 0.13567, 0.11742, 0.09030, 0.05856, 0.027/)
    y    = wgt_runave_n_Wrap (x, wgt, opt, 0)

   y will be a 3-dimensional array of length ntim x nlat x mlon.

   Example 3

   Let x be dimensioned ntim x klev x nlat x mlon with named dimensions "time," "lev," "lat," and "lon." (Assume the "time"
   dimension contains twice daily data.) Use the low, medium and high pass 31-point Blackmon filters on the twice daily
   data. The low-pass filter allows most of the variance from fluctuations of 10 days or more; the medium pass filter allows
   variance of 2.5 to 6 days; and the high pass filter allows variance 1 to 2 days. The cited filters are:

     Author: M. B. Blackmon
     Journal: Journal of Atmospheric Science, August, 1976, , pg. 1609.

    opt   = 0
    wlow  = (/-0.0059591606, -0.0074864031, -0.0081766107, -0.0074769889, \
              -0.0048789007,  0.0         ,  0.0073407153,  0.0170670479, \
               0.0288191067,  0.0419626250,  0.0556356004,  0.0688283154, \
               0.0804876892,  0.0896329731,  0.0954676702, \
               0.0974726419, \                              ; central wgt
               0.0954676702,  0.0896329731,  0.0804876892, \
               0.0688283154,  0.0556356004,  0.0419626250,  0.0288191067, \
               0.0170670479,  0.0073407153,  0.0         , -0.0048789007, \
              -0.0074769889,  -0.0081766107,-0.0074864031, -0.0059591606/)
    ylow  = wgt_runave_n_Wrap(x, wlow, opt, 0)

    wmed  = (/-0.0030384857, -0.0001341773, -0.0096723016, -0.0191709641, \
              -0.0020017146,  0.0304306715,  0.0328072034,  0.0041075557, \
               0.0033466748,  0.0419335015,  0.0283041151, -0.0923257264, \
              -0.1947701551, -0.1020097578,  0.1433496840, \
               0.2776877534, \                              ; central weight
               0.1433496840, -0.1020097578, -0.1947701551, \
              -0.0923257264,  0.0283041151,  0.0419335015,  0.0033466748, \
               0.0041075557,  0.0328072034,  0.0304306715, -0.0020017146, \
              -0.0191709641, -0.0096723016, -0.0001341773, -0.0030384857/)
    ymed  = wgt_runave_n_Wrap (x, wmed, opt, 0)

    whigh = (/0.0036193743,  0.0062672457, -0.0071490567, -0.0089978990, \
              0.0125704103,  0.0117924147, -0.0207251125, -0.0144542141, \
              0.0333056699,  0.0167834343, -0.0546750050, -0.0185972473, \
              0.1009810886,  0.0197489990, -0.3186000638, \
              0.4762599236, \                              ; central weight
             -0.3186000638,  0.0197489990,  0.1009810886, \
             -0.0185972473, -0.0546750050,  0.0167834343,  0.0333056699, \
             -0.0144542141, -0.0207251125,  0.0117924147,  0.0125704103, \
             -0.0089978990, -0.0071490567,  0.0062672457,  0.0036193743/)
    yhigh = wgt_runave_n_Wrap(x, whigh, opt, 0)

   y will be a 4-dimensional array of length ntim x klev x nlat x mlon.

   Example 4

   Consider the 2x-daily data in example 3. Now use the weights of a slightly broader 2-8 day band pass filter. The cited
   filter is:

     Author: K. E. Trenberth
     Journal: Journal of Atmospheric Science, October, 1991, pg. 2162.

  wgt = (/-0.003, -0.033, -0.037, -0.013, -0.132, -0.188, 0.172, 0.468, \
           0.172, -0.188, -0.132, -0.013, -0.037, -0.033, -0.003/)

  y   = wgt_runave_n_Wrap(x, wgt, opt, 0)

   y will be a 4-dimensional array of length ntim x klev x nlat x mlon.

   Example 5

   Let x be dimensioned ntim x klev x nlat x mlon. Perform a 5 point running average using the cyclic option in the
   longitude direction:

     opt = -1
     wgt  = (/1.0, 3.0, 5.0, 3.0, 1.0/)
     wgt  = wgt/sum(wgt)             ; normalize
     x    = wgt_runave_n_Wrap(x, wgt, opt, 3)


   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:38 +0800
# vim:set fdm=indent foldlevel=0:
