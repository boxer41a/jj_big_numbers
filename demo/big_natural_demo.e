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
--			tester.multiply

			tester.bit_shift_left
			tester.normalize

			tester.divide_two_digits_by_one

--			tester.scalar_divide

--			test_efficiency

			io.put_string ("end test %N")
		end

feature -- Access

	tester: BIG_NATURAL_TESTS
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
