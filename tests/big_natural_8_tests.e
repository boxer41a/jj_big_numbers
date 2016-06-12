note
	description: "[

	]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"

class
	BIG_NATURAL_8_TESTS

inherit

	BIG_NATURAL_TESTS
		redefine
			digit_anchor,
			number_anchor,
			testable_number_anchor
		end

feature -- Access

--	new_number_from_array (a_array: ARRAY [NATURAL_8];
--							a_base: NATURAL_8): JJ_BIG_NATURAL_8
--			-- Get a new {JJ_BIG_NUMBER}, selecting the type to create
--			-- based on the value of `number_type' and setting its
--			-- from the items in `a_array'.
--		do
--			create Result.from_array (a_array, a_base)
--		end

feature -- Basic operations (initialization tests)

	default_create_test
		local
			str, s: STRING_8
			n: like number_anchor
		do
			str := ".test_default_create:  "
			create n
			report_properties (str, n)
			assert (str + "base_big_enough", n.base.as_integer_32 >= 2)
			assert (str + "base_at_max", n.base = n.max_base)
			assert (str + "count_is_one", n.count = 1)
			assert (str + "is_zero", n.is_zero)
			assert (str + "value = 0", n.out ~ "0")
		end

	make_with_base
		local
			str, s: STRING_8
			n: like number_anchor
		do
			str := ".make_with_base:  "
			create n.make_with_base (number.seven_value)
			io.put_string (str + "number = " + n.out + "  base = " + n.base.out + "%N")
			assert (str, n.base.out ~ "7")
		end

	make_with_value
		local
			str, s: STRING_8
			n: like number_anchor
		do
			str := ".make_with_value:  "
			create n.make_with_value (number.sixteen_value * number.seven_value)
			s := str + "value = 112"
			io.put_string (s + "  n.out = " + n.out + "%N")
			assert (s, n.out ~ "112")
		end

	make_with_value_and_base
		local
			str, s: STRING_8
			n: like number_anchor
		do
			str := ".make_with_value_and_base:  "
			create n.make_with_value_and_base (number.max_representable_value, number.sixteen_value)
			s := str + "(" + number.max_representable_value.out + ", " + "16)"
			io.put_string (s + "  n = " + n.out)
			io.put_string ("  as_stored = " + n.out_as_stored)
			io.put_string ("  base = " + n.base.out + "%N")
			assert (s + " out", n.out ~ "255")
			assert (s + " out_as_stored", n.out_as_stored ~ "15,15")
			assert (s + " base", n.base.out ~ "16")
		end

	from_string
			-- Test the `from_string' feature;
		local
			str, s: STRING_8
			bn: like number_anchor
			e: STRING_8
			i: INTEGER
		do
			str := ".from_string:  "
				-- Base 10 number
			create bn.from_string ("3852")
			s := str + "3852 max_base"
			report (s, bn)
			assert (s + " base", bn.base.out ~ bn.max_base.out)
			assert (s + " out ", bn.out ~ "3852")
			assert (s + " out_fomatted ", bn.out_formatted ~ "3,852")
				-- Convert to base 9
			bn.to_base (bn.nine_value)
			s := str + "3852 base nine"
			report (s, bn)
			assert (s + " base", bn.base.out ~ "9")
			assert (s + " out ", bn.out ~ "3852")
			assert (s + " out_fomatted ", bn.out_formatted ~ "3,852")
				-- Number 852
			create bn.from_string ("852")
			s := str + "852 max_base"
			report (s, bn)
			assert (s + " base", bn.base.out ~ bn.max_base.out)
			assert (s + " out ", bn.out ~ "852")
			assert (s + " out_fomatted ", bn.out_formatted ~ "852")
				-- Negative number
			create bn.from_string ("-1325839")
			s := str + "-1325839 max_base"
			report (s, bn)
			assert (s + " base", bn.base.out ~ bn.max_base.out)
			assert (s + " out ", bn.out ~ "-1325839")
			assert (s + " out_fomatted ", bn.out_formatted ~ "-1,325,839")
			io.new_line
		end

	from_array
		local
			str, s: STRING_8
			n: like number_anchor
			a: ARRAY [like digit_anchor]
		do
			str := ".from_array:  "
			s := str + "<1, 2, 3, 4>>"
			a := <<1, 2, 3, 4>>
			create n
			create n.from_array (a)
			io.put_string ("n.from_array (<<1,2,3,4>>) = " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "1,2,3,4")
		end

	make_random
			-- Tests corresponding feature from {JJ_BIG_NATURAL_8}.
		local
			str, s: STRING_8
			n: like number_anchor
		do
			str := ".make_from_other:  "
			s := str + "not implemented"
			assert (s, false)
		end

feature -- Basic operations (constants tests)

	zero_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".zero_value:  "
			create n
			v := n.zero_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "0")
		end

	one_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".one_value:  "
			create n
			v := n.one_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "1")
		end

	two_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".two_value:  "
			create n
			v := n.two_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "2")
		end

	three_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".three_value:  "
			create n
			v := n.three_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "3")
		end

	four_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".four_value:  "
			create n
			v := n.four_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "4")
		end

	five_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".five_value:  "
			create n
			v := n.five_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "5")
		end

	six_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".six_value:  "
			create n
			v := n.six_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "6")
		end

	seven_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".seven_value:  "
			create n
			v := n.seven_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "7")
		end

	eight_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".eight_value:  "
			create n
			v := n.eight_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "8")
		end

	nine_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".nine_value:  "
			create n
			v := n.nine_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "9")
		end

	ten_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".ten_value:  "
			create n
			v := n.ten_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "10")
		end

	sixteen_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".sixteen_value:  "
			create n
			v := n.sixteen_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "16")
		end

	max_digit_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".max_digit_value:  "
			create n
			v := n.max_digit_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ (n.base - n.one_value).out)
		end

	max_representable_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".max_representable_value:  "
			create n
			v := n.max_representable_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ v.max_value.out)
		end

	max_base
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			str := ".ten_value:  "
			create n
			v := n.ten_value
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "10")
		end

	default_karatsuba_threshold
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			i: INTEGER_32
		do
			str := ".default_karatsuba_threshold:  "
			create n
			i := n.default_karatsuba_threshold
			io.put_string (str + i.out + "%N")
			assert (str, i.out ~ "4")
		end

feature -- Basic operations (Access)

	base
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			b: like digit_anchor
		do
			str := ".base:  "
			create n
			b := n.base
			io.put_string (str + b.out + "%N")
			assert (str, b.out ~ n.max_base.out)
				-- Another test
			n.set_base (33)
			b := n.base
			io.put_string (str + b.out + "%N")
			assert (str, b.out ~ "33")
		end


	base_minus_one_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number_anchor
			b: like digit_anchor
		do
			str := ".base_minus_one_value:  "
			create n
			b := n.base_minus_one_value
			s := str + "n.base = " + n.base.out + "   minus one = "
			io.put_string (s + b.out + "%N")
			assert (s, b.out ~ (n.max_base - n.one_value).out)
				-- Another test
			n.set_base (33)
			b := n.base_minus_one_value
			s := str + "n.base = " + n.base.out + "   minus one = "
			io.put_string (s + b.out + "%N")
			assert (s, b.out ~ "32")
		end

	min_base
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
			b: like digit_anchor
		do
			str := ".min_base:  "
			create n
			b := n.min_base
			io.put_string (str + b.out + "%N")
			assert (str, b.out ~ "2")
		end

	zero
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
		do
			str := ".zero:  "
			create n
			n := n.zero
			io.put_string (str + n.out + "%N")
			assert (str, n.out ~ "0")
		end

	one
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like number_anchor
		do
			str := ".zero:  "
			create n
			n := n.one
			io.put_string (str + n.out + "%N")
			assert (str, n.out ~ "1")
		end

	karatsuba_threshold
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number_anchor
			k: INTEGER_32
		do
			str := ".karatsuba_threshold:  "
			create n
			k := n.karatsuba_threshold
			s := str + "default = "
			io.put_string (s + k.out + "%N")
			assert (s, k.out ~ n.default_karatsuba_threshold.out)
		end

feature -- Basic operations (element change tests)

	set_karatsuba_threshold
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number_anchor
			k: INTEGER_32
		do
			str := ".set_karatsuba_threshold:  "
			create n
				-- Set to 20
			n.set_karatsuba_threshold (20)
			k := n.karatsuba_threshold
			s := str + "(20)"
			io.put_string (s + "  karatsuba_threshold = " + k.out + "%N")
			assert (s, k.out ~ "20")
				-- Set to 555
			n.set_karatsuba_threshold (555)
			k := n.karatsuba_threshold
			s := str + "(555)"
			io.put_string (s + "  karatsuba_threshold = " + k.out + "%N")
			assert (s, k.out ~ "555")
		end

	set_value
			-- Test the `set_value' feature.
			-- The argument to the `set_value' feature must be the
			-- same type as the elements in the {JJ_BIG_NATURAL}, so
			-- we use the xxx_value features from the big number.
		local
			str, s: STRING_8
			n: like number_anchor
		do
			str := ".set_value:  "
				-- zero
			create n
			n.set_value (n.zero_value)
			s := str + "zero_value"
			report (s, n)
			assert (s, n.out ~ "0")
			assert (s, n.base = n.max_base)
				-- max_value
			n.set_value (n.base_minus_one_value)
			s := str + "max value"
			report (s, n)
			assert (s, n.out ~ n.base_minus_one_value.out)
			assert (s, n.base = n.max_base)
				-- 112, base 16
			create n
			n.set_base (n.sixteen_value)
			n.set_value (n.sixteen_value * n.seven_value)
			s := str + "112 base 16"
			report (s, n)
			assert (s, n.base.out ~ "16")
			assert (s, n.out ~ "112")
			io.new_line
		end

	set_with_string
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number_anchor
		do
			str := ".set_with_string:  "
				-- First test
			create n
			n.set_with_string ("1,2,3,4,5,6,7,8,9")
			s := str + "set_with_string (%"1,2,3,4,5,6,7,8,9%")"
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "1,2,3,4,5,6,7,8,9")
				-- Second test
			create n
			n.set_with_string ("0,0,0,0,0,9,8,7,6,5,4,3,2,1")
			s := str + "set_with_string (%"0,0,0,0,0,9,8,7,6,5,4,3,2,1%")"
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "9,8,7,6,5,4,3,2,1")
				-- Negative test
			create n
			n.set_with_string ("-11,2,3,4,5,6,7,8,99")
			s := str + "set_with_string (%"-11,2,3,4,5,6,7,8,99%")"
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "-11,2,3,4,5,6,7,8,99")
			assert (s, n.is_negative)
		end

	set_base
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number_anchor
		do
			str := ".set_base:  "
			create n.from_string ("123456789")
			assert (str + "default_base", n.out ~ "123456789")
				-- Set base to 10
			n.set_base (n.ten_value)
			s := str + (n.out) + ".set_base (10) = "
			io.put_string (s + n.out_as_stored + "%N")
			assert (s, n.out ~ "123456789")
			assert (s, n.out_as_stored ~ "1")
		end

	set_value_and_base
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number_anchor
		do
			str := ".set_with_value_and_base:  "
			create n
			n.set_value_and_base (number.max_representable_value, number.ten_value)
			s := str + "(" + number.max_representable_value.out
			s := s + ", " + number.ten_value.out + ")"
			io.put_string (s + "  n = " + n.out)
			io.put_string ("  as_stored = " + n.out_as_stored)
			io.put_string ("  base = " + n.base.out + "%N")
			assert (s + " out", n.out ~ "255")
			assert (s + " out_as_stored", n.out_as_stored ~ "2,5,5")
			assert (s + " base", n.base.out ~ "10")
				-- 252 base 5
			n.set_value_and_base (number.max_representable_value - number.two_value, number.five_value)
			s := str + "(" + (number.max_representable_value - number.two_value).out
			s := s + ", " + number.five_value.out + ")"
			io.put_string (s + "  n = " + n.out)
			io.put_string ("  as_stored = " + n.out_as_stored)
			io.put_string ("  base = " + n.base.out + "%N")
			assert (s + " out", n.out ~ "253")
			assert (s + " out_as_stored", n.out_as_stored ~ "2,0,0,3")
			assert (s + " base", n.base.out ~ "5")

		end

	set_with_array
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number_anchor
			a: ARRAY [like digit_anchor]
		do
			str := ".set_with_array:  "
			s := str + "(<<10, 20, 30, 40, 50, 60, 70, 80, 90>>)"
			a := <<10, 20, 30, 40, 50, 60, 70, 80, 90>>
			create n.from_array (a)
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "10,20,30,40,50,60,70,80,90")
		end

feature -- Basic operations (conversion tests)

	to_base
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number
		do
			str := ".to_base:  "
			io.put_string ("test not yet implemented %N")
			assert (str + "not implemented", false)
		end

	as_base
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number
		do
			str := ".as_base:  "
			io.put_string ("test not yet implemented %N")
			assert (str + "not implemented", false)
		end

feature -- Basic operations (Status setting tests)

	set_is_negative
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number
		do
			str := ".set_is_negative:  "
			create n
			n.set_is_negative (true)
			s := str + "(" + n.out + ").set_is_negative (true)"
			io.put_string (s + " = " + n.is_negative.out + "%N")
			assert (s, not n.is_negative)
				-- (max_digit_value).set_is_negative (true)
			n.set_value (n.max_digit_value)
			assert (str + "not negated", not n.is_negative)
			s := str + "(" + n.out + ").set_is_negative (true)"
			n.set_is_negative (true)
			io.put_string (s + " = " + n.is_negative.out + "%N")
			assert (s, n.is_negative)
				-- Set to false
			s := str + "(" + n.out + ").set_is_negative (false)"
			n.set_is_negative (false)
			io.put_string (s + " = " + n.is_negative.out + "%N")
			assert (s, not n.is_negative)
		end

feature -- Basic operations (status report tests)

	is_zero
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number
		do
			str := ".is_zero:  "
				-- Default create
			create n
			s := str + "(" + n.out + ").is_zero"
			io.put_string (s + " = " + n.is_zero.out + "%N")
			assert (s, n.is_zero)
				-- Make it positive
			n.set_value (n.one_value)
			s := str + "(" + n.out + ").is_zero"
			io.put_string (s + " = " + n.is_zero.out + "%N")
			assert (s, not n.is_zero)
				-- Make it negative
			n.set_is_negative (true)
			s := str + "(" + n.out + ").is_zero"
			io.put_string (s + " = " + n.is_zero.out + "%N")
			assert (s, not n.is_zero)
		end

	is_one
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number
		do
			str := ".is_one:  "
				-- Default create
			create n
			s := str + "(" + n.out + ").is_one"
			io.put_string (s + " = " + n.is_one.out + "%N")
			assert (s, not n.is_one)
				-- Make it one
			n.set_value (n.one_value)
			s := str + "(" + n.out + ").is_one"
			io.put_string (s + " = " + n.is_one.out + "%N")
			assert (s, n.is_one)
				-- Add leading zeros
			n.set_with_array (<<0,0,0,1>>)
			s := str + "(" + n.out_as_stored + ").is_one"
			io.put_string (s + " = " + n.is_one.out + "%N")
			assert (s, n.is_one)
		end

	is_base
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number
		do
			str := ".is_base:  "
				-- Not base
			create n.from_array (<<1,2,3>>)
			s := str + "(" + n.out_as_stored + ").is_base"
			io.put_string (s + " = " + n.is_base.out + "%N")
			assert (s, not n.is_base)
				-- Is base
			create n.from_array (<<1,0>>)
			s := str + "(" + n.out_as_stored + ").is_base"
			io.put_string (s + " = " + n.is_base.out + " base = " + n.base.out + "%N")
			assert (s, n.is_base)
				-- Is base, leading zeroes
			n.set_with_array (<<0,0,0,1,0>>)
			s := str + "(" + n.out_as_stored + ").is_base"
			io.put_string (s + " = " + n.is_base.out + "%N")
			assert (s, n.is_base)
		end

	is_negative
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number
		do
			str := ".is_negative:  "
				-- Not is_negative
			create n.from_array (<<1,2,3>>)
			s := str + "(" + n.out_as_stored + ").is_negative"
			io.put_string (s + " = " + n.is_negative.out + "%N")
			assert (s, not n.is_negative)
				-- is_negative
			n.set_is_negative (true)
			s := str + "(" + n.out_as_stored + ").is_negative"
			io.put_string (s + " = " + n.is_negative.out + "%N")
			assert (s, n.is_negative)
				-- zero
			create n
			s := str + "(" + n.out_as_stored + ").is_negative"
			io.put_string (s + " = " + n.is_negative.out + "%N")
			assert (s, not n.is_negative)
		end

	is_same_sign
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, n2: like number
		do
			str := ".is_same_sign:  "
				-- Is same sign
			create n.from_array (<<1,2,3>>)
			create n2.from_array (<<4,5,6>>)
			s := str + "(" + n.out_as_stored + ").is_same_sign (" + n2.out_as_stored + ")"
			io.put_string (s + " = " + n.is_same_sign (n2).out + "%N")
			assert (s, n.is_same_sign (n2))
				-- Not is same sign
			n.set_is_negative (true)
			s := str + "(" + n.out_as_stored + ").is_same_sign (" + n2.out_as_stored + ")"
			io.put_string (s + " = " + n.is_same_sign (n2).out + "%N")
			assert (s, not n.is_same_sign (n2))
				-- Is same sign, negative
			n2.set_is_negative (true)
			s := str + "(" + n.out_as_stored + ").is_same_sign (" + n2.out_as_stored + ")"
			io.put_string (s + " = " + n.is_same_sign (n2).out + "%N")
			assert (s, n.is_same_sign (n2))
		end

	divisible
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, n2: like number
		do
			str := ".divisible:  "
				-- Yes, non-zero divisor
			create n
			create n2.from_array (<<1,2,3>>)
			s := str + "(" + n.out_as_stored + ").divisible (" + n2.out_as_stored + ")"
			io.put_string (s + " = " + n.divisible (n2).out + "%N")
			assert (s, n.divisible (n2))
				-- No, divisor is zero
			create n
			create n2.from_array (<<1,2,3>>)
			s := str + "(" + n2.out_as_stored + ").divisible (" + n.out_as_stored + ")"
			io.put_string (s + " = " + n2.divisible (n).out + "%N")
			assert (s, not n2.divisible (n))
		end

feature -- Basic operations (basic operations tests)


start here
	scalar_add
			-- Test/demo the `scalar_add' and `scalar_sum' functions
			-- from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, p: like number_anchor
		do
			str := ".scalar_add:  "
			create n
				-- add seven
			s := str + "scalar_add (7)"
			n.scalar_add (number.seven_value)
			io.put_string (s + " = " + n.out + "%N")
			assert (s, n.out ~ "7")
				-- add max_digit
			s := str + "scalar_add (" + number.max_digit_value.out + ")"
			n.scalar_add (n.max_digit_value)
			io.put_string (s + " = " + n.out + "%N")
			assert (s, n.out ~ "134")
				-- add 111
			s := str + "scalar_add (" + (n.base_minus_one_value - n.sixteen_value).out + ")"
			n.scalar_add (n.base_minus_one_value - n.sixteen_value)
			io.put_string (s + " = " + n.out + "%N")
			assert (s, n.out ~ "245")
				-- Change the base to 8 and add 119
			n.set_base (n.eight_value)
			s := str + "scalar_add (119)"
			n.scalar_add (n.sixteen_value * n.seven_value)
			io.put_string (s + " = " + n.out + "%N")
			assert (s, n.out ~ "357")
			assert (s + " base", n.base.out ~ "8")
				-- Negate and add 50
			s := str + "(-357).scalar_add (50)"
			n.negate
			p := n.scalar_sum (n.ten_value * n.five_value)
			io.put_string (s + " = " + p.out + "%N")
			assert (s, n.is_negative)
			assert (s + "  n unchanged", n.out ~ "-357")
			assert (s + "  p ", p.out ~ "-307")
			io.new_line
		end

	scalar_multiply
			-- Test/demo the `scalar_multiply' and `scalar_product' functions
			-- from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, p: like number_anchor
		do
			str := ".scalar_multiply:  "
			create n
				-- Multiply zero by anything
			s := str + "(0).scalar_multiply (16)"
			n.scalar_multiply (n.sixteen_value)
			report (s, n)
			assert (s, n.out ~ "0")
				-- Multiply by zero
			s := str + "(7935).scalar_multiply (0)"
			create n.from_string ("7935")
			n.scalar_multiply (n.zero_value)
			report (s, n)
			assert (s, n.out ~ "0")
				-- Multiply 7935 by 96
			s := str + "(7935).scalar_multiply (96)"
			create n.from_string ("7935")
			n.scalar_multiply (n.sixteen_value * n.six_value)
			report (s, n)
			assert (s, n.out_formatted ~ "761,760")
				-- Negate and multiply by 112
			n.negate
			p := n.scalar_product (n.sixteen_value * n.seven_value)
			s := str + "p := (-761,760).scalar_product (112)"
			report (s, p)
			assert (s, p.out_formatted ~ "-85,317,120")
			s := str + "n unchanged"
			assert (s, n.out_formatted ~ "-761,760")
			io.new_line
		end

	add
			-- Test and demonstrate features `add', `plus', and `+' from
			-- {JJ_BIG_NATURAL}.  I checked the calculations at
			-- "https://defuse.ca/big-number-calculator.htm".
		local
			str, s: STRING_8
			a, b: like number_anchor
			n: like number_anchor
		do
			str := ".add:  "
			create n.from_string ("99")
			create a.from_string ("101")
			n.add (a)
			s := str + "(99).add (101)"
			report (s, n)
			assert (s, n.out ~ "200")
				--  check "+" alias
			create a.from_string ("83492018876")
			create b.from_string ("99584738599403878")
			n := a + b
			s := str + a.out + " + " + b.out
			report (s, n)
			assert (s, n.out_formatted ~ "99,584,822,091,422,754")
			assert (s + "  a unchaged", a.out ~ "83492018876")
				-- negate a and call plus
			a.negate
			create b.from_string ("83492018856")
			s := str + a.out + " + " + b.out
			n := a.plus (b)
			report (s, n)
			assert (s, n.out_formatted ~ "-20")
			assert (s + "  a unchaged", a.out ~ "-83492018876")
			io.new_line
		end


	minus
			-- Test and demonstrate features `subtract', `minus', and `-'
			-- from {JJ_BIG_NATURAL}.  I checked the calculations at
			-- "https://defuse.ca/big-number-calculator.htm".
		local
			str, s: STRING_8
			a, b: like number_anchor
			n: like number_anchor
		do
			str := ".minus:  "
				-- minus test number one
			create n.from_string ("1000")
			create b.from_string ("99")
			s := str + "(" + n.out + ").subtract (" + b.out + ")"
			n.subtract (b)
			report (s, n)
			assert (s, n.out ~ "901")
				-- Minus test number two
			create a.from_string ("578372618996743892774658921536")
			create b.from_string ("578372618990119377281937921536")
			s := str + "(" + a.out + ").minus (" + b.out + ")"
			n := a.minus (b)
			report (s, n)
			assert (s, n.out ~ "6624515492721000000")
				-- Munus test number three
			a.negate
			n := a - b
			s := str + "(" + a.out + " - " + b.out + ")"
			report (s, n)
			assert (s, n.out ~ "-1156745237986863270056596843072")

			io.new_line
		end

	multiply
			-- Test and demonstrate the `multiply', `product', and `*' features
			-- from {JJ_BIG_NATURAL}.  I checked the calculations at
			-- "https://defuse.ca/big-number-calculator.htm".
		local
			str, s: STRING_8
			a, b, n: like number_anchor
		do
			str := ".multiply:  "
				-- test multiply
			create n.from_string ("5")
			create b.from_string ("9")
			s := str + "(" + n.out + ").multiply (" + b.out + ")"
			n.multiply (b)
			report (s, n)
			assert (s, n.out ~ "45")
			assert (s + "  b unchanged", b.out ~ "9")
				-- test product
			create a.from_string ("38374651928376")
			create b.from_string ("99573650866570")
			s := str + "(" + a.out + ").product (" + b.out + ")"
			n := a.product (b)
			report (s, n)
			assert (s, n.out ~ "3821104193242259013972790320")
			assert (s + "  a unchanged", a.out ~ "38374651928376")
			assert (s + "  b unchanged", b.out ~ "99573650866570")
				-- star test with big values
			create a.from_string ("-84736487483757564869490010293")
			create b.from_string ("57849399340004949681221")
			s := str + a.out + " * " + b.out
			n := a * b
			report (s, n)
			assert (s, n.out ~ "-4901954903117222552481914443941818610639794358807753")
			assert (s + "  a unchanged", a.out ~ "-84736487483757564869490010293")
			assert (s + "  b unchanged", b.out ~ "57849399340004949681221")
				-- test multiply by one
			s := str + a.out + " * " + a.one.out
			n := a * a.one
			report (s, n)
			assert (s, n.out ~ "-84736487483757564869490010293")
			assert (s + "  a unchanged", a.out ~ "-84736487483757564869490010293")
				-- test multiply by zero
			s := str + b.zero.out + " * " + b.out
			n := b.zero * b
			report (s, n)
			assert (s, n.out ~ "0")
			assert (s + "  b unchanged", b.out ~ "57849399340004949681221")
				-- Add some whitespace to screen
			io.new_line
		end

feature -- Basic operations (selectively exported)

	bit_shift_left
			-- Test and demonstrate feature `bit_shift_left' from
			-- {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number_anchor
			sft: INTEGER_32
		do
			set_verbose
			str := ".bit_shift_left:  "
				-- First test
--			n := new_number_from_string ("5")
--			n.set_unstable
--			sft := 2
--			s := str + "(" + n.out_as_bits + ").bit_shift_left (" + sft.out + ")"
--			n.bit_shift_left (sft)
--			report (s, n)
--			assert (s, n.out ~ "20")
				-- Now with smaller base
--			create n
--			n.set_base (n.eight_value)
--			n.set_value (n.five_value)
--			sft := 2
--			s := str + "(" + n.out_as_bits + ").bit_shift_left (" + sft.out + ")"
--			report (s, n)
--			n.set_unstable
--			n.bit_shift_left (sft)
--			report (s, n)
--			assert (s, n.out_as_bits ~ "00010100")
				-- Now with base_minus_one_value
			create n
			n.set_base (n.eight_value)
			n.set_value (n.base_minus_one_value)
			sft := 2
			s := str + n.out + "  (" + n.out_as_bits + ").bit_shift_left (" + sft.out + ")"
			n.set_unstable
			n.bit_shift_left (sft)
			report (s, n)
			assert (s, n.out_as_bits ~ "00011100")
				-- Now with max_digit_value, base 16
			create n
			n.set_base (n.sixteen_value)
			n.set_value (n.max_digit_value)
			sft := 2
			s := str + n.out + "  (" + n.out_as_bits + ").bit_shift_left (" + sft.out + ")"
			n.set_unstable
			n.bit_shift_left (sft)
			report (s, n)
			assert (s, n.out_as_bits ~ "00011100,00111100")
				-- Now with max_digit_value, max base
			create n
			n.set_base (n.max_base)
			n.set_value (n.max_digit_value)
			sft := 1
			s := str + n.out + "  (" + n.out_as_bits + ").bit_shift_left (" + sft.out + ")"
			n.set_unstable
			n.bit_shift_left (sft)
			report (s, n)
			assert (s, n.out_as_bits ~ "11111110")
				-- Now with max_digit_value, max base
			create n
			n.set_base (n.max_base)
			n.set_value (n.max_digit_value)
			sft := 2
			s := str + n.out + "  (" + n.out_as_bits + ").bit_shift_left (" + sft.out + ")"
			n.set_unstable
			n.bit_shift_left (sft)
			report (s, n)
			assert (s, n.out_as_bits ~ "00000001,11111100")
		end

	normalize
			-- Test and demonstrate feature `normalize' from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number_anchor
			i: INTEGER_32
		do
			str := generating_type + ".normalize:  "
			create n
			n.set_unstable
				-- Normalize 5 base 16
			n.set_value_and_base (n.five_value, n.sixteen_value)
			s := str + n.out + ", base " + n.base.out + "  (" + n.out_as_bits + ").normalize"
			i := n.normalize
			io.put_string (s +  " = " + n.out_as_bits + "%N")
			assert (s, n.out_as_bits ~ "00001010")
				-- Normalize `max_digit_value + 5, max_base
			create n
			n.set_unstable
			n.set_value_and_base (n.max_digit_value + n.five_value, n.base)
			s := str + n.out + ", base " + n.base.out + "  (" + n.out_as_bits + ").normalize"
			i := n.normalize
			io.put_string (s +  " = " + n.out_as_bits + "%N")
			assert (s, n.out_as_bits ~ "01000001,00000000")
		end

	divide_two_digits_by_one
			-- Test and demonstrate feature `divide_two_digits_by_one' from
			-- {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number_anchor
			denom: like number_anchor
			i: INTEGER_32
			tup: like digit_tuple_anchor
		do
			str := ".divide_two_digits_by_one:  "
				-- Must handle each `number_type' (i.e. bit-representation) differently
				-- in order to ensure we have two digits only.)
				-- This case has two digits.
			create n.from_string ("29")
			n.set_base (n.sixteen_value)
			create denom.from_string ("3")
			denom.set_base (n.sixteen_value)
			if not denom.is_normalized then
				denom.set_unstable
				n.set_unstable
				i := denom.normalize
				n.bit_shift_left (i)
				check
					denom_is_noramlized: denom.is_normalized
				end
			end
			s := str + "29/5  -- (" + n.i_th (2).out + ", " + n.i_th (1).out + ", " + denom.out + ")"
			tup := n.divide_two_digits_by_one (n, denom)
			report_digit_tuple (s, tup)
			assert (s + "quot", tup.quot.out ~ "5")
			assert (s + "rem", tup.rem.out ~ "4")
--					-- This case has only one digit even in eight bits.
--				n := new_number_from_string ("98")
--				div := n.ten_value
--				low_d := n.i_th (1)
--				high_d := n.zero_value
--				s := str + "98/10  -- (" + high_d.out + ", " + low_d.out + ", " + div.out + ")"
--				tup := n.divide_two_digits_by_one (high_d, low_d, div)
--				report_digit_tuple (s, tup)
--				assert (s + "quot", tup.quot.out ~ "9")
--				assert (s + "rem", tup.rem.out ~ "8")
--					-- This case has only one digit even in eight bits.
--				n := new_number_from_string ("119")
--				div := n.ten_value
--				low_d := n.i_th (1)
--				high_d := n.zero_value
--				s := str + "119/10  -- (" + high_d.out + ", " + low_d.out + ", " + div.out + ")"
--				tup := n.divide_two_digits_by_one (high_d, low_d, div)
--				report_digit_tuple (s, tup)
--				assert (s + "quot", tup.quot.out ~ "11")
--				assert (s + "rem", tup.rem.out ~ "9")
		end

--	scalar_divide
--			-- Test and demonstrate feature `scalar_divide' from {JJ_BIG_NATURAL}.
--			-- I checked the calculations at
--			-- "https://defuse.ca/big-number-calculator.htm".
--		local
--			str, s: STRING_8
--			n: like new_number
--			d: like new_number.digit
--			tup: like new_number.scalar_divide
--		do
--			str := ".scalar_divide:  "
--				-- test number one
--			n := new_number_from_string ("8")
--			d := n.eight_value
--			s := str + "(" + n.out + ").scalar_divide (" + d.out + ")"
--			tup := n.scalar_divide (d)
--			report_tuple (s, tup)
--			assert (s + "  quot", tup.quot.out ~ "1")
--			assert (s + "  rem", tup.rem.out ~ "0")
--				-- test number two
--			n := new_number_from_string ("49")
--			d := n.three_value
--			s := str + "(" + n.out + ").scalar_divide (" + d.out + ")"
--			tup := n.scalar_divide (d)
--			report_tuple (s, tup)
--			assert (s, tup.quot.out ~ "18")
--			assert (s, tup.rem.out ~ "1")
--				-- test number three
--			n := new_number_from_string ("84746229876")
--			d := n.sixteen_value
--			s := str + "(" + n.out + ").scalar_divide (" + d.out + ")"
--			tup := n.scalar_divide (d)
--			report_tuple (s, tup)
--			assert (s, tup.quot.out ~ "5296639367")
--			assert (s, tup.rem.out ~ "4")
--		end

	knuth_divide
		do
		end

feature -- Test conversion

--	is_less
--		local
--			a, b: like number
--			e: BOOLEAN
--			n: INTEGER_32
--		do
--			f_name := ".is_less"
--			a := new_number_from_string ("28")
--			b := new_number_from_string ("10")
--			e := false
--			print (class_name + f_name + "%N")
--			print ("%T           a = " + a.out + " < " + b.out + "%N")
--			print ("%T a base = " + a.base.out + "  b.base = " + b.base.out + "%N")
--			print ("%T    expected = " + e.out + "%N")
--			print ("%T         out = " + (a < b).out + "%N")
--			assert (f_name, (a < b) ~ e)
--			print ("%N")
--		end



--	test_conversion_1
--		local
--			n: JJ_BIG_NATURAL_8
--			e: STRING_8
--		do
--			n := "98765"
--			e := "9,8,7,6,5"
--			f_name := ".test_conversion_1"
--			n.set_base (8)
--			print (class_name + f_name + "%N")
--			print ("%T expected = " + e + "%N")
--			print ("%T actual =   " + n.out_as_base (10) + "%N")
--			assert (f_name, n.out_as_base (10) ~ e)
--		end

--	test_conversion_2
--		local
--			n: JJ_BIG_NATURAL_8
--			e: STRING_8
--		do
--			n := "-7"
--			e := "-7"
--			f_name := ".test_conversion_2"
--			n.set_base (3)
--			print (class_name + f_name + "%N")
--			print ("%T expected = " + e + "%N")
--			print ("%T actual =   " + n.out_as_base (10) + "%N")
--			assert (f_name, n.out_as_base (10) ~ e)
--		end

--	test_conversion_3
--		local
--			n: JJ_BIG_NATURAL_8
--			e: STRING_8
--		do
--			n := "32"
--			e := "32"
--			f_name := ".test_conversion_3"
--			n.set_base (8)
--			n.set_base (7)
--			n.set_base (2)
--			print (class_name + f_name + "%N")
--			print ("%T expected = " + e + "%N")
--			print ("%T actual =   " + n.out_as_base (10) + "%N")
--			assert ("f_name", n ~ e)
--		end

--	test_conversion_4
--		local
--			n: JJ_BIG_NATURAL_8
--			e: STRING_8
--		do
--			n := "99"
--			e := "99"
--			f_name := ".test_conversion_4"
--			n.set_base (8)
--			print (class_name + f_name + "%N")
--			print ("%T expected = " + e + "%N")
--			print ("%T actual =   " + n.out_as_base (10) + "%N")
--			assert ("f_name", n ~ e)
--		end

--	test_conversion_5
--		local
--			a, e: JJ_BIG_NATURAL_8
--		do
--			a := "99"
--			e := "99"
--			a.set_base (3)
--			assert ("after conversion", a ~ e)
--		end

--	test_conversion_6
--		local
--			a, e: JJ_BIG_NATURAL_8
--		do
--			a := "99"
--			e := "99"
--			a.set_base (8)
--			a.set_base (3)
--			assert ("after conversion", a ~ e)
--		end

--	test_conversion_9
--		local
--			a, e: JJ_BIG_NATURAL_8
--		do
--			a := "98765"
--			a.set_base (8)
--			a.set_base (2)
--			a.set_base (100)
--			assert ("a after conversions", a.out_as_base (10) ~ "9,8,7,6,5")
--		end

--	digits_multiplied
--		local
--			str, s: STRING_8
--			n: like number
--			tup: like {like number}.digits_multiplied
--			a, b: like number.base
--		do
--			str := generating_type + ".digits_multiplied:  "
--			create n
--				-- 10 * 100
--			a := n.ten_value
--			b := n.ten_value * n.ten_value
--			tup := n.digits_multiplied (a, b)
--			s := str + "10 * 100"
--			io.put_string (s + "10 * 100 -- [" + tup.high.out + ", " + tup.low.out + "] %N")
--			assert (s, "[" + tup.high.out + ", " + tup.low.out + "]" ~ "[7, 104]")
--				-- 11 * 100
--			a := a + n.one_value
--			tup := n.digits_multiplied (a, b)
--				-- 11 * 101
--			b := b + n.one_value
--			tup := n.digits_multiplied (a, b)
--				-- 20 * 101
--			a := a + n.nine_value
--			tup := n.digits_multiplied (a, b)
--				-- 29 * 110
--			a := a + n.nine_value
--			b := b + n.nine_value
--			tup := n.digits_multiplied (a, b)
--				-- 30 * 110
--			a := a + n.one_value
--			tup := n.digits_multiplied (a, b)
--				-- 36 * 107 = 3852  (see Radix conversion paper, example)
--			a := a + n.six_value
--			b := b - n.three_value
--			tup := n.digits_multiplied (a, b)
--				-- 127 * 127
--			a := n.max_digit
--			b := n.max_digit
--			tup := n.digits_multiplied (a, b)

--			io.new_line
--		end

feature -- Basic operations (implementation tests)

	power_of_ten_table
			-- Tests the existence of the `power_of_ten_table'.
			-- This test feature must be called before any math operations
			-- that access the `power_of_ten_table'.
		local
			str, s: STRING_8
			n: like testable_number_anchor
			t: like {like number_anchor}.power_of_ten_table
		do
			create n
			t := n.power_of_ten_table
			str := ".power_of_ten_table:  "
			io.put_string (str + "capacity = " + t.capacity.out + "%N")
			io.put_string (str + "   count = " + t.count.out + "%N")
			assert (str + "capacity", t.capacity >= n.default_table_size)
			assert (str + "count", t.count = 0)
		end

	ten_to_the_power
			-- Tests the intended once-ness of the `power_of_ten_table'
			-- somewhat tests its memoization usage.
			-- This test feature must be called before any math operations
			-- that access the `power_of_ten_table'.
		local
			str, s: STRING_8
			n: like testable_number_anchor
			t: like {like number_anchor}.power_of_ten_table
			c: INTEGER
			p: like number_anchor
		do
			str := ".ten_to_the_power:  "
			create n
			t := n.power_of_ten_table
			c := n.power_of_ten_table.count
			s := str + "count = "
			io.put_string (s + t.count.out + "%N")
			assert (s, t.count = 0)
				-- 10 to one-th power
			n.set_value (n.one_value)
			p := n.ten_to_the_power (n)
			s := str + "ten_to_the_power (" + n.out_formatted + ") = "
			io.put_string (s  +  p.out_formatted)
			io.put_string ("  count = " + t.count.out + "%N")
			assert (s, p.out_formatted ~ "10")
			assert (s + "  count", t.count = 2)
				-- 10 to 8th power
			n.set_value (n.eight_value)
			p := n.ten_to_the_power (n)
			s := str + "ten_to_the_power (" + n.out_formatted + ") = "
			io.put_string (s  +  p.out_formatted)
			io.put_string ("  count = " + t.count.out + "%N")
			assert (s, p.out_formatted ~ "100,000,000")
			assert (s + "  count", t.count = 9)
				-- 10 to 4th power
			n.set_value (n.four_value)
			p := n.ten_to_the_power (n)
			s := str + "ten_to_the_power (" + n.out_formatted + ") = "
			io.put_string (s  +  p.out_formatted)
			io.put_string ("  count = " + t.count.out + "%N")
			assert (s, p.out_formatted ~ "10,000")
			assert (s + "  count", t.count = 9)
		end

	new_value_from_character
			-- Tests the `new_value_from_character' feature.
		local
			str, s: STRING_8
			n: like testable_number_anchor
			r: like digit_anchor
			c: CHARACTER_8
		do
			str := ".new_value_from_character "
			create n
				-- Zero
			c := '0'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "0")
				-- One
			c := '1'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "1")
				-- Two
			c := '2'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "2")
				-- Three
			c := '3'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "3")
				-- Four
			c := '4'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "4")
				-- Five
			c := '5'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "5")
				-- Six
			c := '6'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "6")
				-- Seven
			c := '7'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "7")
				-- Eight
			c := '8'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "8")
				-- Nine
			c := '9'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "9")
				-- Ten (lower case)
			c := 'a'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "10")
				-- Eleven (lower case)
			c := 'b'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "11")
				-- Twelve (lower case)
			c := 'c'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "12")
				-- Thirteen (lower case)
			c := 'd'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "13")
				-- Fourteen (lower case)
			c := 'e'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "14")
				-- Fifteen (lower case)
			c := 'f'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "15")
				-- Ten (upper case)
			c := 'A'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "10")
				-- Eleven (upper case)
			c := 'B'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "11")
				-- Twelve (upper case)
			c := 'C'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "12")
				-- Thirteen (upper case)
			c := 'D'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "13")
				-- Fourteen (upper case)
			c := 'E'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "14")
				-- Fifteen (upper case)
			c := 'F'
			r := n.new_value_from_character (c)
			s := str + "(" + c.out + ")"
			io.put_string (s + " = " + r.out + "%N")
			assert (s, r.out ~ "15")
		end

	bits_utilized
			-- Tests the `bits_utilized' feature, which gives the
			-- number of bits used for representing numbers given
			-- a specific `base'.

		local
			str, s: STRING_8
			n: like testable_number_anchor
			i: INTEGER
		do
			create n
			str := n.base.generating_type + ".bits_utilized:  "
				-- Default base (i.e. 128)
			i := n.bits_utilized
			s := str + "base = " + n.base.out + "   "
			io.put_string (s + i.out + " of " + n.base.bit_count.out + " bits used %N")
			assert (s, i = 7)
				-- Base 16
			n.set_base (n.sixteen_value)
			i := n.bits_utilized
			s := str + "base = " + n.base.out + "   "
			io.put_string (s + i.out + " of " + n.base.bit_count.out + " bits used %N")
			assert (s, i = 4)
				-- Base 15
			n.set_base (n.ten_value + n.five_value)
			i := n.bits_utilized
			s := str + "base = " + n.base.out + "   "
			io.put_string (s + i.out + " of " + n.base.bit_count.out + " bits used %N")
			assert (s, i = 4)
				-- Base 53
			n.set_base (n.ten_value * n.five_value + n.three_value)
			i := n.bits_utilized
			s := str + "base = " + n.base.out + "   "
			io.put_string (s + i.out + " of " + n.base.bit_count.out + " bits used %N")
			assert (s, i = 6)
		end

	new_big_number
			-- Tests the `new_big_number' feature.
		local
			str, s: STRING_8
			n: like testable_number_anchor
			i: INTEGER
		do
			set_verbose
			create n
			str := ".new_big_number:  "
			s := str + "new_big_number (16, max_base)"
			n := n.new_big_number (n.sixteen_value, n.max_base)
			report (s, n)
			assert (s + " base", n.base = n.max_base)
			assert (s + " value", n.out_formatted ~ "16")
				-- , base 7
			s := str + "new_big_number (16 * 9 = 144, base 7)"
			n := n.new_big_number (n.sixteen_value * n.nine_value, n.seven_value)
			report (s, n)
			assert (s + " value", n.out_formatted ~ "144")
			assert (s + " base", n.base.out ~ "7")
		end

	new_sub_number
			-- Test the `new_sub_number' feature.
		local
			str, s: STRING_8
			n, sn: like testable_number_anchor
			a: ARRAY [like digit_anchor]
			i: INTEGER
		do
			set_verbose
			str := ".new_sub_number:  "
			a := <<1, 2, 3, 4, 5, 6, 7, 8, 9>>
			create n.from_array (a)
				-- Get the low three bits.
			s := str + "new_sub_number (1, 3) of " + n.out_as_stored
			sn := n.new_sub_number (1, 3, n)
			io.put_string (s + " = " + sn.out_as_stored + "%N")
			assert (s, sn.out_as_stored ~ "7,8,9")
				-- Get some other bits.
			s := str + "new_sub_number (4, 8) of " + n.out_as_stored
			sn := n.new_sub_number (4, 8, n)
			io.put_string (s + " = " + sn.out_as_stored + "%N")
			assert (s, sn.out_as_stored ~ "2,3,4,5,6")
		end


feature {NONE} -- Anchors

	number: like number_anchor
			-- Used as handle to obtain values, etc.
			-- Redefine as once.
		attribute
			create Result
		end

	digit_anchor: NATURAL_8
			-- Anchor for declaring an entity to representi a digit.
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require else
			never_called: false
		do
			check
				do_not_call: false then
					-- Because gives no info; simply used as anchor.
			end
		end

	number_anchor: JJ_BIG_NATURAL_8
			-- Anchor when declaring numbers in descendants.
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require else
			never_called: false
		do
			check
				do_not_call: false then
					-- Because gives no info; simply used as anchor.
			end
		end

	testable_number_anchor: TESTABLE_BIG_NATURAL_8
			-- Anchor when declaring numbers for which access to
			-- all features is needed.
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require else
			never_called: false
		do
			check
				do_not_call: false then
					-- Because gives no info; simply used as anchor.
			end
		end


end
