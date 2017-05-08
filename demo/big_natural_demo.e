note
	description: "[
		Class to demonstrate the {JJ_BIG_NATURAL} class.  It creates and uses
		a {JJ_BIG_NATURAL_TEST} object and lets that object print the
		demo values as it runs assert statements.
	]"
	author: "Jimmy J.Johnson"
	date: "$Date$"
	revision: "$Revision$"

class BIG_NATURAL_DEMO

create
	make

feature {NONE} -- Initialization

	make
			-- Run the tests
		local
			i: INTEGER
		do
				-- Clearn console
			from i := 1
			until i >= 50
			loop
				io.new_line
				i := i + 1
			end
				-- Create the `tester' object
			create tester
				-- Test implementation features.
			io.put_string ("------------- Implementation ----------------- %N")
--			tester.from_array
--			tester.from_string

--			tester.set_with_array
--			tester.set_with_string
			tester.set_random_with_digit_count

--			tester.new_sub_number
--			tester.power_of_ten_table
--			tester.ten_to_the_power
--			tester.bits_utilized

--			tester.is_zero

--			tester.as_full_digit
--			tester.divide_two_digits_by_one
--
--			tester.simple_subtract

--			tester.scalar_multiply
--			tester.digits_multiplied
--			tester.multiply

			tester.quotient

--			tester.digits_added
--			tester.base
--			tester.scalar_add
			tester.scalar_sum

--			tester.to_base
--			tester.scalar_add

--			tester.set_base
--			tester.set_base_failing

--			tester.bit_shift_left
--			tester.simple_add
			tester.add

				-- Test initialization features.
--			io.put_string ("------------- Initization -------------------- %N")
--			tester.set_verbose
--			tester.test_default_create
--			tester.from_string
--			tester.set_terse
--				-- Test element-change features.
--			io.put_string ("------------- Element change ----------------- %N")
--			tester.set_value

--			io.put_string ("------------- Conversion --------------------- %N")

--				-- Test basic-operations featurs.
--			io.put_string ("------------- Basic operations --------------- %N")
--			tester.scalar_add
--			tester.scalar_multiply

--			tester.add
--			tester.minus

--			tester.divide_two_digits_by_one

--			tester.from_array

--			tester.simple_product
			tester.multiply

--			tester.bit_shift_left
--			tester.normalize


--			tester.scalar_divide

--			test_efficiency

			io.put_string ("end test %N")
		end

feature -- Access

	tester: BIG_NATURAL_8_TESTS
			-- To test big numbers.


feature -- Basic operations

--	test_efficiency
--			-- Run some test to collect timing data on the various functions.
--		local
--			t: BIG_NUMBER_TIMER
--		do
--			create t.make
--			t.run
--		end

end
