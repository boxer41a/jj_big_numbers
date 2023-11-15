# jj\_big_numbers
Eiffel library for manipulating arbitrarily large numbers.  It implements addition, subtraction,  multiplication and division.

It depends on the [JJ\_NATURAL classes](http://github.com/boxer41a/jj_naturals).

To used the example ecf files, checkout the library to a location identified by the envirnment variable "JJ_GITHUB".

### Demo/Test/Timing
The demo program and the timeing tests use the Eiffel_GMP library, which depends on [The GNU Multiple Precision Arithmetic Library](https://gmplib.org), in order to compare results.  The timing tests also depend on [JJ\_TEMPORAL classes](http://github.com/boxer41a/jj_temporal).

### Non-generic version
Directory "nongeneric" contains a 32-bit implementation that does not depend on JJ_NATURAL classes.

### Timing Tests
Directory "timing" contains a class that compares execution times for this library to the execution times of corresponding routines in "eiffel_gmp" (an Eiffel binding to the GNU Multiple Precision Arithmetic Library).

In my ecf files I used environment variable "JJ_OTHER" to identify the file-system location for non-eiffel libraries or eiffel libraries that depend on non-eiffel libraries.