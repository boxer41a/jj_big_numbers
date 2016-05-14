note
	description: "[
		Effected version because AutoTest will not execute features from deferred
		or generic classes.
		]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"

class
	JJ_BIG_NATURAL_8_TESTS

inherit

	JJ_BIG_NATURAL_TESTS [JJ_BIG_NATURAL_8]
		redefine
			test_default_create,
			digits_multiplied,
			from_string
		end

feature -- Basic operations

	test_default_create
		local
			n: like number
			e: STRING_8
		do
			create n
			e := "0"
			report_properties (".default_create", n, e,
				(0b10000000).as_natural_8, (0b10000000).as_natural_8,
				(0b01111111).as_natural_8, 4)
		end

	make_with_base
		local
			n: like number
			e: STRING_8
		do
			create n.make_with_base (100)
			e := "0"
			report_properties (".make_with_base", n, e,
				(100).as_natural_8, (0b10000000).as_natural_8,
				(99).as_natural_8, 4)
		end

	make_with_value
		local
			n: like number
			e: STRING_8
		do
			create n.make_with_value (106)
			e := "106"
			report_properties (".make_with_value", n, e,
				(128).as_natural_8, (0b10000000).as_natural_8,
				(127).as_natural_8, 4)
		end

	make_with_value_and_base
		local
			n: like number
			e: STRING_8
		do
			create n.make_with_value_and_base (33, 16)
			e := "33"
			report_properties (".make_with_base_and_value", n, e,
				(16).as_natural_8, (0b10000000).as_natural_8,
				(15).as_natural_8, 4)
		end

	from_array
		local
			n: like number
		do
			f_name := ".from_array"
			create n.from_array (<<>>)
			report_terse (n, "0")
			create n.from_array (<<0>>)
			report_terse (n, "0")
			create n.from_array (<<0, 0, 0>>)
			report_terse (n, "0")
			create n.from_array (<<1>>)
			report_terse (n, "1")
			create n.from_array (<<0, 0, 1>>)
			report_terse (n, "1")
			create n.from_array (<<1, 2, 3, 4, 0>>)
			report_terse (n, "1,2,3,4,0")
		end


	from_string
		do
			Precursor
		end

feature -- Basic operations

	knuth_divide
		local
			a, b: like number
			tup: like {JJ_BIG_NATURAL_8}.knuth_divide
		do
			create a.from_array (<<2,5>>)
			create b.from_array (<<8>>)
			tup := a.knuth_divide (b)
		end

	divide_two_by_one
		local
			a: like number
			tup: TUPLE [quot, rem: like digit_type]
		do
			create a
			tup := a.divide_two_by_one (2, 4, 8)
			assert ("24 // 8", tup ~ [3, 0])
		end

	scalar_divide
		local
			a: like number
			tup: like digit_tuple_type
		do
				-- Divide zero by a number
--			f_name := "scalar_divide"
--			create a.from_array (<<0>>)
--			tup := a.scalar_divide (1)
--			report_digit_tuple_terse (tup, ["0", "0"])
--				-- Divide by one
--			create a.from_array (<<127>>)
--			tup := a.scalar_divide (1)
--			report_digit_tuple_terse (tup, ["127", "0"])
--				-- Divide by bigger number
--			create a.from_array (<<99>>)
--			tup := a.scalar_divide (100)
--			report_digit_tuple_terse (tup, ["0", "99"])
--				-- Divide with remainder
--			create a.from_array (<<9>>)
--			tup := a.scalar_divide (4)
--			report_digit_tuple_terse (tup, ["2", "1"])
				--
			create a.from_array (<<1, 13, 4>>)
			tup := a.scalar_divide (3)
			report_digit_tuple_terse (tup, ["1,13,4", "0"])
		end


	digits_multiplied
		do
			Precursor
		end

end
