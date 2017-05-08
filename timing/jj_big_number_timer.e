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
			io.put_string ("------------- Running timing tests ----------------- %N")


			run_tests

--			time_multiplication
--			time_division

			io.put_string ("end test %N")
		end

feature -- Basic operations

	run_tests
			-- Run all tests.
		local
			s, type_s: STRING_8
			f: PLAIN_TEXT_FILE
			n: INTEGER
			arr: like time_it
			i, j: INTEGER
		do
			type_s := (create {like anchor}).generating_type
			from n := 1 until n > Max_values.count loop
				s := "{" + type_s + "}.multiply -- max = " + max_values[n].out
				create f.make_open_write (s)
				arr := time_it (agent {like anchor}.product, Max_values[n])
				from i := 1 until i > arr.width loop
					from j := 1 until j > arr.height loop
						s := fd.formatted (arr.item (i,j).jjj)
						io.put_string (s)
						f.put_string (s)
						j := j + 1
					end
					io.new_line
					f.put_string ("%N")
					i := i + 1
				end
				io.new_line
				f.close
				n := n + 1
			end
		end

feature {NONE} -- Implementation

	fd: FORMAT_DOUBLE
			-- For formatting floating point values.
		once
			create Result.make (12, 2)
		end

	jj_timer: HMS_TIMER
			-- For timing execution times for {JJ_BIG_NATURAL} functions.

	gmp_timer: HMS_TIMER
			-- For timing execution times for gmp functions.

feature {NONE} -- Basic operations

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
			create jj_n.make_random_with_digit_count (a_count)
			s := jj_n.out
			create gmp_n.make_string (s)
--			io.put_string ("make_one_number:  count = " + jj_n.count.out + "  bit_count = " + jj_n.bit_count.out + "%N")
			Result := [jj_n, gmp_n]
		end

	time_it (a_function: FUNCTION [like anchor, like anchor, like anchor];
				a_max: INTEGER): ARRAY2 [TUPLE [jjj, gmp: REAL_64]]
			-- Run `a_function' `batch_size' times on numbers that grow
			-- `a_step' amount on each loop.  Place results of each call
			-- in Result.
		local
			n, inc: INTEGER
			b: INTEGER
			i, j: INTEGER
			jj_avg, gmp_avg: REAL_64
			p, q: like anchor
		do
			inc := a_max // steps
			n := a_max // inc
			create Result.make_filled ([0.0, 0.0], n, n)
			from i := 1
			until i > n
			loop
				from j := 1
				until j > n
				loop
					jj_timer.reset
					gmp_timer.reset
					from b := 1
					until b > batch_size
					loop
						io.put_string (".")
						create p.make_random_with_digit_count (i * inc)
						create q.make_random_with_digit_count (j * inc)
						jj_timer.run
						a_function.call ([p, q])		-- don't need the result of the call.
						jj_timer.stop
						b := b + 1
					end
					jj_avg := jj_timer.cumulative.as_milliseconds / batch_size
					Result.put ([jj_avg, gmp_avg], i, j)
					j := j + 1
				end
				i := i + 1
			end
			io.new_line
		end

	results: ARRAYED_LIST [TUPLE [jj_time, gmp_time: REAL_64]]
			-- Results of running a particular function, indexed by the
			-- number of digits in the arguments.
		once
			create Result.make (10)
		end

	batch_size: INTEGER = 2
			-- The number of samples of each digit of a particular length.

	max_values: ARRAY [INTEGER]
			-- The maximum number of words/digits during a test.
		once
			Result := <<50, 60>>
		end

	steps: INTEGER = 5
			-- Number of intervals to test going up to one of `max_values'.

--	steps: ARRAY [INTEGER]
--			-- The amount to increase values during a run.
--		once
--			Result := <<1, 5, 10>>
--		end

	anchor: JJ_BIG_NATURAL_8
			-- Anchor.  Do not call
		once
			check
				do_not_call: false then
			end
		end

invariant


end
