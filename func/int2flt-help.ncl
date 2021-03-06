THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/int2flt.shtml
THE_TITLE:int2flt

int2flt

   Converts values of type integer to values of type float and preserves metadata.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function int2flt (
                x  : integer
        )

        return_val [dimsizes(x)] :  float

Arguments

   x

   An array of any dimensionality and of type integer.

Return value

   An array of the same size as x and of type float.

Description

   This function converts values of type integer to values of type float and preserves metadata.

   Note: This function is slightly different than the built-in set of conversion functions (like floattointeger and
   shorttobyte), because it requires loading the "contributed.ncl" script and it preserves metadata. It has a slightly
   different naming style than the built-in functions, just to set it apart from these other functions.

See Also

   short2flt, flt2dble

Examples

   Example 1

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
begin
   i = ispan(1,10,1)

   i@long_name = "sample"      ; attribute
   i!0         = "foo"         ; name dimension
   i&foo       = ispan (35,350,35) ; create bogus coordinate array

   iFlt        = int2flt( i )

   print( iFlt )
end

   The returned variable will be of type float and will retain all meta data.

Variable: iFlt
Type: float
Total Size: 40 bytes
            10 values
Number of Dimensions: 1
Dimensions and sizes:   [foo | 10]       <== retains dimension name
Coordinates:
            foo: [35..350]               <== retains coordinate information
Number Of Attributes: 1
  long_name :   sample
(0)      1
(1)      2
(2)      3
(3)      4
(4)      5
(5)      6
(6)      7
(7)      8
(8)      9
(9)     10



   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:18:30 +0800
# vim:set fdm=indent foldlevel=0:
