note
	description: "[
		Class to demonstrate the {JJ_BIG_NATURAL} class.  It creates and uses
		a {JJ_BIG_NATURAL_TEST} object and lets that object print the
		demo values as it runs assert statements.
	]"
	author: "Jimmy J.Johnson"
	date: "$Date$"
	revision: "$Revision$"

class JJ_BIG_NUMBER_TIMER

create
	make

feature {NONE} -- Initialization

	make
			-- Run the tests
		local
			i: INTEGER
		do
			create jj_timer
			create gmp_timer
				-- Clearn console
			from i := 1
			until i >= 20
			loop
				io.new_line
				i := i + 1
			end
				-- Test implementation features.
			io.put_string ("------------- Implementation ----------------- %N")

--			time_multiplication
			time_division

			io.put_string ("end test %N")
		end

feature -- Basic operations

	time_multiplication
			-- Collect statistics to compare multiplication functions
		local
			a, b, c: JJ_BIG_NATURAL_8
			x, y, z: GMP_INTEGER
			i, j, n: INTEGER
			tup: like make_one_number
			jj_avg, gmp_avg: REAL_64
			cnt: INTEGER
			bit_cnt: JJ_BIG_NATURAL_8
		do
			io.put_string (generating_type + ".time_multiplication: %N")
			create bit_cnt
			from i := 1
			until i > distribution.count
			loop
				jj_timer.reset
				gmp_timer.reset
				n := distribution [i]
				from j := 1
				until j > batch_size
				loop
					{MEMORY}.collection_on
--					{MEMORY}.full_coalesce
					{MEMORY}.full_collect
					{MEMORY}.collection_off
					random.set_range (1, n + 1)
--					tup := make_one_number (n)
					tup := make_one_number (random.next)
					a := tup.jj_n
					x := tup.gmp_n
					random.set_range (1, n + 1)
					tup := make_one_number (random.next)
--					tup := make_one_number (n)
					b := tup.jj_n
					y := tup.gmp_n
						-- Time the multiplicaton operation.
					jj_timer.run
					c := a * b
					jj_timer.stop
					gmp_timer.run
					z := x * y
					gmp_timer.stop
						-- Show results that differ.
					cnt := a.count
					bit_cnt := c.bit_count
					io.put_string (n.out + " decimal digits, j = : "+ j.out + ":  " + a.count.out + " digits * ")
					io.put_string (b.count.out + " = " + c.count.out + " digits %N")
					if not (c.out ~ z.out) then
--						io.put_string ("Error:  " + a.out + " * " + b.out + " = " + c.out + "   ")
						io.put_string ("   ERROR on:  " + x.out + " * " + y.out + " = " + z.out + " %N")
					else
--						io.put_string ("j = " + j.out + ":  " + x.out + " * " + y.out + " = " + z.out + " %N")
--						io.put_string ("  " + j.out)
					end
					j := j + 1
				end
				io.put_string ("%N")
				jj_avg := jj_timer.duration.as_seconds / batch_size
				gmp_avg := gmp_timer.duration.as_seconds / batch_size
				io.put_string (n.out + " decimal digits, " + cnt.out + " digits, " + bit_cnt.out + " bits: ")
				io.put_string ("jj_avg = " + jj_avg.out + "   gmp_avg = " + gmp_avg.out + "%N")
--				results.extend ([jj_avg, gmp_avg], n)
				i := i + 1
			end
		end

	time_division
			-- Collect statistics to compare division functions
		local
			a, b, c: JJ_BIG_NATURAL_8
			x, y, z: GMP_INTEGER
			i, j, n: INTEGER
			tup: like make_one_number
			jj_avg, gmp_avg: REAL_64
		do
			io.put_string (generating_type + ".time_division: %N")
			from i := 1
			until i > distribution.count
			loop
				jj_timer.reset
				gmp_timer.reset
				n := distribution [i]
					-- test special, failing case.
--				create a.make_with_array (<<56,198,138,87,234,87,97,219,151,41,4,201,237>>)
--				create b.make_with_array (<<40,105,231,138,105>>)
--				c := a // b

--				create a.make_with_array (<<219,241,152,233,187,59,169,120>>)
--				create b.make_with_array (<<177,208,224,141,216,240>>)
--				c := a // b

--				create a.make_with_array (<<4,151,73,144>>)
--				create b.make_with_array (<<2,75>>)
--				c := a // b

--				create a.make_with_array (<<148,16,122>>)
--				create b.make_with_array (<<74>>)
--				c := a // b

				from j := 1
				until j > batch_size
				loop
					{MEMORY}.collection_on
--					{MEMORY}.full_coalesce
					{MEMORY}.full_collect
					{MEMORY}.collection_off
					random.set_range (1, n + 1)
					tup := make_one_number (random.next)
					a := tup.jj_n
					x := tup.gmp_n
					random.set_range (1, n + 1)
					tup := make_one_number (random.next)
					b := tup.jj_n
					y := tup.gmp_n
--					io.put_string ("Error:  " + a.out + " // " + b.out + "%N")
						-- Time the multiplicaton operation.
					jj_timer.run
					c := a // b
					jj_timer.stop
					gmp_timer.run
					z := x // y;
--					(create {EXECUTION_ENVIRONMENT}).sleep (200_000_000)
					gmp_timer.stop
						-- Show results that differ.
					io.put_string (n.out + " decimal digits, j = : "+ j.out + ":  " + a.count.out + " digits / ")
					io.put_string (b.count.out + " = " + c.count.out + " digits %N")
					if not (c.out ~ z.out) then
						io.put_string ("%N   ERROR on:  " + x.out + " / " + y.out + " = " + z.out + " %N")
						io.put_string ("a // b:  " + a.out_formatted + " // " + b.out_formatted + " = " + c.out_formatted + "   ")
						io.put_string ("[" + a.out_as_stored + "] // [" + b.out_as_stored + "]")
						io.read_line
							-- Run same number again for debugging.
						c := a // b
					else
--						io.put_string (a.out + " // " + b.out + " = " + c.out + "%N")
					end
					j := j + 1
				end
				jj_avg := jj_timer.cumulative.as_milliseconds / batch_size
				gmp_avg := gmp_timer.cumulative.as_milliseconds / batch_size
				io.put_string (n.out + " decimal digits:  ")
				io.put_string ("jj_avg = " + fd.formatted (jj_avg) + " ms")
				io.put_string ("   gmp_avg = " + fd.formatted (gmp_avg) + " ms %N")
--				results.extend ([jj_avg, gmp_avg], n)
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	make_one_number (a_count: INTEGER): TUPLE [jj_n: JJ_BIG_NATURAL_8; gmp_n: GMP_INTEGER]
			-- Create a tuple containing a random number in the two representations
			-- where each number contains `a_count' number of decimal digits.
		require
			count_big_enough: a_count >= 1
		local
			s: STRING_8
			i: INTEGER
			jj_n: JJ_BIG_NATURAL_8
			gmp_n: GMP_INTEGER
		do
				-- Ensure the left-most digit is not zero.
			random.set_range (1, 10)
			s := random.next.out
			random.set_range (0, 10)
			from i := 2
			until i > a_count
			loop
				s.append (random.next.out)
				i := i + 1
			end
			create jj_n.from_string (s)
			create gmp_n.make_string (s)
--			io.put_string ("make_one_number:  count = " + jj_n.count.out + "  bit_count = " + jj_n.bit_count.out + "%N")
			Result := [jj_n, gmp_n]
		end

	random: JJ_RANDOM
			-- Random number generator
		once
			create Result.make
			Result.set_range (0, 9)
		end

	jj_timer: HMS_TIMER
			-- For timing execution times for {JJ_BIG_NATURAL} functions.

	gmp_timer: HMS_TIMER
			-- For timing execution times for gmp functions.

	temp: detachable SIMPLE_TIMER


	results: HASH_TABLE [TUPLE [jj_time, gmp_time: REAL_64], INTEGER]
			-- Results of running a particular function, indexed by the
			-- number of digits in the arguments.
		once
			create Result.make (10)
		end

	batch_size: INTEGER = 1_000
			-- The number of samples of each digit of a particular length.

	distribution: ARRAY [INTEGER]
			-- Tells the counts to use when creating the distribution
			-- of big numbers.
		once
			Result := <<8, 20, 50>>
		end

	fd: FORMAT_DOUBLE
			-- For formatting floating point values.
		once
			create Result.make (10, 6)
		end
end
