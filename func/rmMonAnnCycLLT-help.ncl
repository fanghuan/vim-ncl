THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/rmMonAnnCycLLT.shtml
THE_TITLE:rmMonAnnCycLLT

rmMonAnnCycLLT

   Removes the annual cycle from "monthly" data.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function rmMonAnnCycLLT (
                x [*][*][*] : numeric
        )

        return_val [dimsizes(x)] :  typeof(x)

Arguments

   x

   A three-dimensional array of monthly values, dimensioned lat x lon x time. The time dimension must be a multiple of 12.

Return value

   The results are returned in an array of the same type and dimensionality as x. If the input data contains metadata, these
   will be retained.

Description

   This function removes the annual cycle from month (number of months = 12) data and subtracts the long term means from
   each month.

See Also

   rmMonAnnCycLLT, rmMonAnnCycTLL, rmMonAnnCycLLLT


   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:19:54 +0800
# vim:set fdm=indent foldlevel=0:
