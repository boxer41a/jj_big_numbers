note
	description: "[
		Root class to test the JJ_BIG_NATURAL_xxx classes.
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


--			test_32_conversions

--			test_minus

--			test_8_as_base


				-- Run tests
--			create test_32
--				
			create test_8
			test_8.digits_multiplied
			test_8.test_default_create
			test_8.from_string
			test_8.plus
			test_8.minus
			test_8.scalar_multiply
			test_8.star


--			test_8.scalar_divide
--			test_8.knuth_divide

--			test_8.from_array
--			test_8.divide_two_by_one


--			test_8.test_default_create
--			test_8.make_with_base
--			test_8.make_with_value
--			test_8.make_with_base_and_value
--			test_8.from_string

--			test_8.digits_multiplied
--			test_8.scalar_multiply_single
--			t.star

--			t.test_conversion_1
--			t.test_conversion_2
--			t.test_conversion_3
--			t.test_conversion_4
--			t.plus
--			t.star

--			t.star_2

--			test_efficiency

			io.put_string ("end test %N")
		end

feature -- Access

	test_8: JJ_BIG_NATURAL_8_TESTS
			-- To test eight-bit big numbers

--	test_32: JJ_BIG_NATURAL_32_TESTS
			-- To test 32-bit big numbers

feature -- Basic operations

	test_minus
			-- A problem case
		local
			n, n1, n2: JJ_BIG_NATURAL_8
		do
			create n1.make_with_value_and_base (10, 10)
			create n2.make_with_value_and_base (128, 10)
			n := n1 - n2
			print ("n1 = " + n1.out + "%T " + n1.out_as_stored + "%N")
			print ("n2 = " + n2.out + "%T " + n2.out_as_stored + "%N")
			print ("n = " + n.out + "%T " + n.out_as_stored + "%N")
			print ("%N%N")
		end

	test_8_as_base
			-- Test a troublesome case
		local
			n, n2, n_base_ten: JJ_BIG_NATURAL_8
			i: INTEGER
		do
			print (generator + ".test_8_as_base %N")
			create n
			print ("max base = " + n.max_base.out + "%N")
			from i := 1
			until i > 204
			loop
				create n_base_ten.make_with_value_and_base (i.as_natural_8, 10)
				create n.make_with_value_and_base (i.as_natural_8, n.max_base)
				print ("i = " + i.out +  "   base (" + n.base.out + ") = " + n.out_as_stored +
						"     n.as_base (10) = " + n.as_base (10).out_as_stored +
						"     n.as_base (max_base) = " + n.as_base (10).as_base (n.max_base).out_as_bits +
						"     n.as_base (10) " + n.as_base (n.max_base).as_base (10).out_as_stored +
						"%N")
--				create n.make_with_base_and_value (10, (i).as_natural_8)
--				print ("n (base " + n.base.out + ") = " + n.out_as_stored +
--						"     n.as_base (128) = " + n.as_base (n.max_base).out_as_stored +
--						"     n.as_base (128).as_base (10)" + n.as_base (n.max_base).as_base (10).out_as_bits +
--						"     " + n.as_base (n.max_base).as_base (10).out_as_stored +
--						"%N")
				n2 := n.as_base (10)
				if n2.out_as_stored /~ n_base_ten.out_as_stored then
					print ("   -- error going to base 10    " + n2.out_as_stored + " /~ " + n_base_ten.out_as_stored + "%N")
				end
				n2 := n2.as_base (n.max_base)
				if n2.out_as_stored /~ n.out_as_stored then
					print ("   -- errog going back to max_base   " + n2.out_as_stored + " /~ " + n.out_as_stored + "%N")
				end
--				check
--					n2.out_as_bits ~ n.out_as_bits
--				end
				i := i + 1
			end
--			create n.make_with_base_and_value (128, 199)
--			n := n.as_base (10)
--			create n.make_with_base_and_value (10, 199)
--			n := n.as_base (128)
--			create n.make_with_base_and_value (10, 200)
--			n := n.as_base (128)
--			print ("n = " + n.out_as_stored + "%N")
----			n := n.as_base (128)
--			print ("n = " + n.out_as_stored + "%N")
		end

	test_32_conversions
		local
			n: JJ_BIG_NATURAL_32
		do
			create n.make_with_value_and_base (3852, 10)
			print ("n = " + n.out + "%T " + n.out_as_stored + "%N")
			n := n.as_base (9)
			print ("n = " + n.out + "%T " + n.out_as_stored + "%N")
			n := n.as_base (10)
			print ("n = " + n.out + "%T " + n.out_as_stored + "%N")
--			n.set_base_and_value (10, 3749)
--			n := n.as_base (-10)
--			print ("n = " + n.out_as_stored + "%N")
		end

feature {NONE} -- Anchors

	digit_type: NATURAL_8
			-- Anchor for type used by the SHA calculations; 32 or 64 bits.
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require else
			not_callable: False
		do
			check
				do_not_call: False then
					-- Because gives no info; simply used as anchor.
			end
		end

feature -- Basic operations

--	test_efficiency
--			-- Run some test to collect timing data on the various functions
--		local
--			t: BIG_NUMBER_TIMER
--		do
--			create t.make
--			t.run
--		end

end
