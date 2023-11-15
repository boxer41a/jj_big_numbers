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
			until i >= 10
			loop
				io.new_line
				i := i + 1
			end
				-- Create the `tester' object
--			create tester_8
			create tester_32
--			tester := tester_8
			io.put_string ("  Begin Demo/Tester for JJ_BIG_NATURAL numbers: %N")

			tester_32.run_all
--			tester.run_all
			io.put_string ("end test %N")
		end

feature -- Constants

	test_count: INTEGER = 10
			-- Number of time to run each test

feature -- Access

--	tester: BIG_NATURAL_TESTS
			-- The set of tests currently being executed

--	tester_8: BIG_NATURAL_8_TESTS
			-- To test big numbers.

	tester_32: BIG_NATURAL_32_TESTS
			-- To test 32-bit big numbers


end
