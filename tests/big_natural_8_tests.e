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
			n: like number_anchor
		do
			str := ".from_string:  "
				-- Base 10 number
			create n.from_string ("3852")
			s := str + "(%"3852%")"
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s + " base", n.base = n.ten_value )
			assert (s + " out_as_stored ", n.out_as_stored ~ "3,8,5,2")
				-- Number 852
			create n.from_string ("10,987,654,321")
			s := str + "(%"10,987,654,321%")"
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s + " base", n.base = n.ten_value )
			assert (s + " out_as_stored ", n.out_as_stored ~ "1,0,9,8,7,6,5,4,3,2,1")
				-- Negative number
			create n.from_string ("-00012,34")
			s := str + "(%"-00012,34%")"
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s + " base", n.base = n.ten_value )
			assert (s + " out_as_stored ", n.out_as_stored ~ "-1,2,3,4")
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
			str, fn: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			fn := ".max_base"
			create n
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			io.put_string (str)
			v := n.max_base
			io.put_string (" = " + v.out + "%N")
			assert (str, v ~ n.max_base.out)
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
			str, fn: STRING_8
			n: like number_anchor
			b: like digit_anchor
		do
			fn := ".base:  "
			create n
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			io.put_string (str + " = ")
			b := n.base
			io.put_string (b.out + "%N")
			assert (str, b.out ~ n.max_base.out)
		end


	base_minus_one_value
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str, fn: STRING_8
			n: like number_anchor
			b: like digit_anchor
		do
			fn := ".base_minus_one_value"
			create n
			b := n.base_minus_one_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			io.put_string (str + " = ")
			b := n.base_minus_one_value
			io.put_string (b.out + "%N")
			assert (str, b ~ (n.max_base - n.one_value))
				-- Does not matter what the `base' is.
			create n.make_with_value_and_base (n.nine_value, n.sixteen_value)
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			io.put_string (str + " = ")
			b := n.base_minus_one_value
			io.put_string (b.out + "%N")
			assert (str, b ~ (n.sixteen_value - n.one_value))
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
			str := ".karatsuba_threshold "
			create n
			n.set_karatsuba_threshold (50)
			k := n.karatsuba_threshold
			s := str + " = "
			io.put_string (s + k.out + "%N")
			assert (s, k.out ~ "50")
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
			n.set_with_string ("123456789")
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
			s := str + "set_with_string (%"-11,2345,678,9,9%")"
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "-1,1,2,3,4,5,6,7,8,9,9")
			assert (s, n.is_negative)
		end

	set_base
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			n: like number_anchor
			b: like digit_anchor
		do
			fn := ".set_base "
				-- Max_base
			create n
			b := n.max_base
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + b.out + ")"
			io.put_string (str)
			n.set_base (b)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "0")
			assert (str + " base", n.base ~ n.max_base)
				-- (16 base 128).set_base (17) = 1,1 base 15
			create n.make_with_value (n.sixteen_value)
			b := n.sixteen_value - 1
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + b.out + ")"
			io.put_string (str)
			n.set_base (b)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "1,1")
			assert (str + " base", n.base ~ b)
				-- (1,1 base 100).set_base (10)
			create n.make_with_base (n.ten_value * n.ten_value)
			b := n.ten_value
			n.set_value (n.ten_value * n.ten_value + n.one_value)
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + b.out + ")"
			io.put_string (str)
			n.set_base (b)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "1,0,1")
			assert (str + " base", n.base = b)
				-- (1,1,2 base 10).set_base (9)
			create n.make_with_value_and_base (n.sixteen_value * n.seven_value, n.ten_value)
			b := n.nine_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + b.out + ")"
			io.put_string (str)
			n.set_base (b)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str + " base", n.base.out ~ "9")
			assert (str, n.out_as_stored ~ "1,3,4")
				-- (1,3,4 base 9).set_base (10)
			create n.make_with_base (n.nine_value)
			n.set_with_array (<<1,3,4>>)
			b := n.ten_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + b.out + ")"
			io.put_string (str)
			n.set_base (b)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str + " base", n.base.out ~ "10")
			assert (str, n.out_as_stored ~ "1,1,2")
				-- (3,2 base 10).set_base (100)
			create n.make_with_value_and_base (n.sixteen_value + n.sixteen_value, n.ten_value)
			b := n.ten_value * n.ten_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + b.out + ")"
			io.put_string (str)
			n.set_base (b)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str + " base", n.base.out ~ "100")
			assert (str, n.out ~ "32")
				-- (1,1,2 base 10).set_base (100)
			create n.make_with_value_and_base (n.sixteen_value * n.seven_value, n.ten_value)
			b := n.ten_value * n.ten_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + b.out + ")"
			io.put_string (str)
			n.set_base (b)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str + " base", n.base.out ~ "100")
			assert (str, n.out_as_stored ~ "1,12")
		end

	set_base_failing
			-- Some values that need fixing
		local
			fn, str: STRING_8
			n, on: like number_anchor
			b, ob: like digit_anchor
			v: like digit_anchor
			right, wrong: INTEGER
		do
			fn := ".set_base_failing "
			io.put_string (fn + "%N")
			create n
--			from ob := n.two_value
--			until ob > n.max_base
--			loop
--				from b := n.two_value
--				until b > n.max_base
--				loop
--					from v := n.zero_value
--					until v > n.max_digit_value
--					loop
--						create n.make_with_value_and_base (v, ob)
--						create on.make_with_value_and_base (v, b)
--						str := "v = " + v.out + "  (" + n.out_as_stored + " base " + n.base.out + ")" + fn
--						str := str + "(" + b.out + ")"
--						n.set_base (b)
--						if n.out ~ on.out then
--							right := right + 1
--						else
--							wrong := wrong + 1
--							io.put_string (str)
--							io.put_string (":%T '" + n.out_as_stored + "'")-- + " base " + n.base.out)-- + " %N")
--							io.put_string ("%T%T expected:  '" + on.out_as_stored + "'%N")--" base " + on.base.out + "%N")
--						end
--						v := v + n.one_value
--					end
--					b := b + n.one_value
--				end
--				ob := ob + n.one_value
--			end
--			io.put_string ("  correct count = " + right.out + "  wrong count = " + wrong.out + "%N")
--			io.new_line
--			io.new_line
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
			fn: STRING_8
			n: like number_anchor
			b: like digit_anchor
		do
			fn := ".to_base"
			str := ".to_base:  "
				-- As in document
			create n
			create n.make_with_array_and_base (<<5,2,5,0>>, n.nine_value)
			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base (" + n.ten_value.out + ")"
			n.to_base (n.ten_value)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s, n.out_as_stored ~ "3,8,5,2")
				-- to_base (15)
			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base ("
			s := s + (n.ten_value + n.five_value).out + ")"
			n.to_base (n.ten_value + n.five_value)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s, n.out_as_stored ~ "1,2,1,12")
				-- back to base ten
			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base ("
			s := s + (n.ten_value).out + ")"
			n.to_base (n.ten_value)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s, n.out_as_stored ~ "3,8,5,2")
				-- back to base nine
			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base ("
			s := s + (n.nine_value).out + ")"
			n.to_base (n.nine_value)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s, n.out_as_stored ~ "5,2,5,0")
				-- Zero
			create n
			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base (" + n.nine_value.out + ")"
			n.to_base (n.nine_value)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s, n.out_as_stored ~ "0")
				-- (128).to_base (100)
			create n
			create n.make_with_value_and_base (n.max_digit_value, n.ten_value * n.ten_value)
			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base (" + n.eight_value.out + ")"
			n.to_base (n.eight_value)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s, n.out_as_stored ~ "1,7,7")
				-- to base 10
			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base (" + n.ten_value.out + ")"
			n.to_base (n.ten_value)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s, n.out_as_stored ~ "1,2,7")
				-- to binary
			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base (" + n.two_value.out + ")"
			n.to_base (n.two_value)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s, n.out_as_stored ~ "1,1,1,1,1,1,1")
				-- (<<1,1,1,1,1,1,1>> base 2).to_base (100)
			create n.make_with_base (n.two_value)
			n.set_with_array (<<1,1,1,1,1,1,1>>)
			b := n.ten_value * n.ten_value
			s := str + "(" + n.out_as_stored + " base " + n.base.out
			s := s + ").to_base (" + (n.ten_value * n.ten_value).out + ")"
			n.to_base (b)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s + " value", n.out_as_stored ~ "1,27")
			assert (s + " base", n.base.out ~ "100")
				-- (<<1,2,3>> base 30).to_base (10)
			create n.make_with_base (n.ten_value * n.three_value)
			n.set_with_array (<<1,2,3>>)
			b := n.ten_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + ".as_base" --fn
			str := str + "(" + b.out + ")"
			io.put_string (str)
			n.to_base (b)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "9,6,3")
			assert (str + " base", n.base ~ n.ten_value)
				-- (<<1,2,3,4>> base 30).to_base (10)
			create n.make_with_base (n.ten_value * n.three_value)
			n.set_with_array (<<1,2,3,4>>)
			b := n.ten_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")"
			str := str + fn + " (" + b.out + ")"
			io.put_string (str)
			n.to_base (b)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "1,2,7,13,2,10")
			assert (str + " base", n.base ~ n.sixteen_value)
		end

	as_base
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, a: like number_anchor
			b: like digit_anchor
		do
			str := ".as_base:  "
			create n
				-- (1,2,3,4,5).as_base (10)
			create n.make_with_array_and_base (<<1,2,3,4,5>>, n.ten_value)
			b := n.ten_value
			s := str + "(" + n.out_as_stored + " base " + n.base.out
			s := s + ").as_base (" + b.out + ")"
			io.put_string (s)
			a := n.as_base (b)
			io.put_string (" = " + a.out_as_stored + " base " + a.base.out + "%N")
			assert (s + " value", a.out_as_stored ~ "1,2,3,4,5")
			assert (s + " unchanged", n.out_as_stored ~ "1,2,3,4,5")
			assert (s + " base unchanged", n.base.out ~ b.out)
				-- (1,2).as_base (9)
			create n.make_with_array_and_base (<<1,2>>, n.ten_value)
			b := n.nine_value
			s := str + "(" + n.out_as_stored + " base " + n.base.out
			s := s + ").as_base (" + b.out + ")"
			io.put_string (s)
			a := n.as_base (b)
			io.put_string (" = " + a.out_as_stored + " base " + a.base.out + "%N")
			assert (s + " value", a.out_as_stored ~ "1,3")
			assert (s + " unchanged", n.out_as_stored ~ "1,2")
			assert (s + " base unchanged", n.base.out ~ "10")
				-- (1,2,3).as_base (9)
			create n.make_with_array_and_base (<<1,2,3>>, n.ten_value)
			b := n.nine_value
			s := str + "(" + n.out_as_stored + " base " + n.base.out
			s := s + ").as_base (" + b.out + ")"
			io.put_string (s)
			a := n.as_base (b)
			io.put_string (" = " + a.out_as_stored + " base " + a.base.out + "%N")
			assert (s + " value", a.out_as_stored ~ "1,4,6")
			assert (s + " unchanged", n.out_as_stored ~ "1,2,3")
			assert (s + " base unchanged", n.base.out ~ "10")
				-- (1,2,3,4).as_base (9)
			create n.make_with_array_and_base (<<1,2,3,4>>, n.ten_value)
			b := n.nine_value
			s := str + "(" + n.out_as_stored + " base " + n.base.out
			s := s + ").as_base (" + b.out + ")"
			io.put_string (s)
			a := n.as_base (b)
			io.put_string (" = " + a.out_as_stored + " base " + a.base.out + "%N")
			assert (s + " value", a.out_as_stored ~ "1,6,2,1")
			assert (s + " unchanged", n.out_as_stored ~ "1,2,3,4")
			assert (s + " base unchanged", n.base.out ~"10")
				-- Convert back to base 10
			b := n.ten_value
			s := str + "(" + a.out_as_stored + " base " + a.base.out
			s := s + ").as_base (" + b.out + ")"
			io.put_string (s)
			a := a.as_base (b)
			io.put_string (" = " + a.out_as_stored + " base " + a.base.out + "%N")
			assert (s + " value", a.out_as_stored ~ "1,2,3,4")
		end

	as_base_failing
			-- Seperate run of a failing case for `as_base'
				-- (1,2,3,4,5).as_base (9)
		local
			str, s: STRING_8
			n, a: like number_anchor
			b: like digit_anchor
		do
			str := ".as_base:  "
			create n
			create n.make_with_array_and_base (<<1,2,3,4,5>>, n.ten_value)
			b := n.nine_value
			s := str + "(" + n.out_as_stored + " base " + n.base.out
			s := s + ").as_base (" + b.out + ")"
			io.put_string (s)
			a := n.as_base (b)
			io.put_string (" = " + a.out_as_stored + " base " + a.base.out + "%N")
			assert (s + " value", a.out_as_stored ~ "1,7,8,3,6")
			assert (s + " unchanged", n.out_as_stored ~ "5,6,2,3,2,1")
			assert (s + " base unchanged", n.base.out ~ b.out)
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

	negate
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like number_anchor
		do
			str := ".negate:  "
			create n
				-- (81).negate
			n.set_value (n.nine_value * n.nine_value)
			s := str + "(" + n.out + ").negate"
			n.negate
			io.put_string (s + " = " + n.out + "%N")
			assert (s, n.out ~ "-81")
				-- (-81).negate
			s := str + "(" + n.out + ").negate"
			n.negate
			io.put_string (s + " = " + n.out + "%N")
			assert (s, n.out ~ "81")
		end

	identity
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, a: like number_anchor
		do
			str := ".identity:  "
			create n
			n.set_value (n.nine_value)
			s := str + "(" + n.out + ").identity"
			a := n.identity
			io.put_string (s + " = " + a.out + "%N")
			assert (s + " values", n.out ~ a.out)
			assert (s + " bases", n.base = a.base)
			assert (s + " unchanged", n.out ~ "9")
				-- (-9).identity
			n.negate
			s := str + "(" + n.out + ").identity"
			a := n.identity
			io.put_string (s + " = " + a.out + "%N")
			assert (s + " values", n.out ~ a.out)
			assert (s + " bases", n.base = a.base)
			assert (s + " unchanged", n.out ~ "-9")
		end

	opposite
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, a: like number_anchor
		do
			str := ".opposite:  "
			create n
				-- (7).opposite
			n.set_value (n.seven_value)
			s := str + "(" + n.out + ").opposite"
			a := n.opposite
			io.put_string (s + " = " + a.out + "%N")
			assert (s + " values", a.out ~ "-7")
			assert (s + " bases", n.base = a.base)
			assert (s + " unchanged", n.out ~ "7")
				-- (-7).opposite
			n.copy (a)
			s := str + "(" + n.out + ").opposite"
			a := n.opposite
			io.put_string (s + " = " + a.out + "%N")
			assert (s + " values", a.out ~ "7")
			assert (s + " bases", n.base = a.base)
			assert (s + " unchanged", n.out ~ "-7")
		end

	scalar_add
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			fn := ".scalar_add"
				-- (0).scalar_add (7)
			create n
			v := n.seven_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")"
			str := str + fn + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out + "%N")
			assert (str, n.out_as_stored ~ "7")
				-- (9).scalar_add (max_digit_value)
			create n.make_with_value (n.nine_value)
			v := n.max_digit_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")"
			str := str + fn + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "1,8")
				-- (max_digit_value).scalar_add (1)
			create n.make_with_value (n.max_digit_value)
			v := n.one_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")"
			str := str + fn + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "1,0")
				-- (max_representable_digit).scalar_add (1)
			create n.make_with_value (n.max_representable_value)
			v := n.one_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")"
			str := str + fn + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "2,0")
				-- (max_representable_value).scalar_add (max_representable_value)
			create n.make_with_value (n.max_representable_value)
			v := n.max_representable_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")"
			str := str + fn + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "3,126")
			io.new_line
		end

	scalar_sum
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, a: like number_anchor
		do
			str := ".scalar_sum:  "
			create n
				-- add max
			s := str + "(" + n.out + ").scalar_sum (" + n.max_representable_value.out + ")"
			a := n.scalar_sum (n.max_representable_value)
			io.put_string (s + " = " + a.out + "%N")
			assert (s, a.out ~ "255")
			assert (s + "n unchanged", n.out ~ "0")
				-- add max_digit_value
			s := str + "(" + n.out + ").scalar_sum (" + n.max_digit_value.out + ")"
			a := n.scalar_sum (n.max_digit_value)
			io.put_string (s + " = " + a.out + "%N")
			assert (s, a.out ~ "127")
			assert (s + "n unchanged", n.out ~ "0")
				-- add 111
			create n.make_with_array_and_base (<<9,3,1>>, n.ten_value)
			s := str + "(" + n.out + ").scalar_sum ("
			s := s + (n.base_minus_one_value - n.sixteen_value).out + ") base " + n.base.out
			a := n.scalar_sum (n.base_minus_one_value - n.sixteen_value)
			io.put_string (s + " = " + a.out + "  base = " + a.base.out + "%N")
			assert (s, a.out ~ "1180")
			assert (s + "n unchanged", n.out ~ "931")
				-- Change the base to 13 and add 112
			n.set_base (n.ten_value + n.three_value)
			s := str + "(" + n.out + ").scalar_sum (" + (n.sixteen_value * n.seven_value).out
			s := s + ")" + "  base " + n.base.out
			a := n.scalar_sum (n.sixteen_value * n.seven_value)
			io.put_string (s + " = " + a.out + "  a.base = " + a.base.out + "%N")
			assert (s, a.out ~ "1043")
			assert (s + " base", a.base.out ~ "13")
			assert (s + "n unchanged", n.out ~ "931")
				-- Negate and add 50
			s := str + "(-357).scalar_add (50)"
			n.negate
			s := str + "(" + n.out + ").scalar_sum (" + (n.ten_value * n.five_value).out
			s := s + ")" + "  base " + n.base.out
			a := n.scalar_sum (n.ten_value * n.five_value)
			io.put_string (s + " = " + a.out + "  a.base = " + n.base.out +"%N")
			assert (s, a.out ~ "-881")
			assert (s + "n unchanged", n.out ~ "-931")
		end

	add
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
			-- Checked against "https://defuse.ca/big-number-calculator.htm".
		local
			fn, str: STRING_8
			n, x: like number_anchor
		do
			fn := ".add "
				-- (0).add (0)
			create n
			create x
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + x.out_as_stored + " base " + x.base.out + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "0")
				-- (1).add (0)
			create n.make_with_value (n.one_value)
			create x
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + x.out_as_stored + " base " + x.base.out + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "1")
				-- (0).add (1)
			create n
			create x.make_with_value (n.one_value)
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + x.out_as_stored + " base " + x.base.out + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "1")
				-- (99).add (101), default_base
			n.set_value ((n.ten_value + n.one_value) * n.nine_value)
			x.set_value (n.ten_value * n.ten_value + n.one_value)
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + x.out_as_stored + " base " + x.base.out + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "1,72")
				-- big numbers, base 10
			create n.make_with_base (n.ten_value)
			create x.make_with_base (n.ten_value)
			n.set_with_array (<<8,3,4,9,2,0,1,8,8,7,6>>)
			x.set_with_array (<<9,9,5,8,4,7,3,8,5,9,9,4,0,3,8,7,8>>)
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + x.out_as_stored + " base " + x.base.out + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "9,9,5,8,4,8,2,2,0,9,1,4,2,2,7,5,4")
				-- (<<5,4,3,2,1>> base 16).add (<<1,2,3,4,5>> base 30) = <<1,2,7,13,2,10>> base 16
				-- (344,865).add (866,825) = 1,211,690
			create n.make_with_base (n.sixteen_value)
			create x.make_with_base (n.ten_value * n.three_value)
			n.set_with_array (<<5,4,3,2,1>>)
			x.set_with_array (<<1,2,3,4,5>>)
			str := "(" + n.out + " base " + n.base.out + ")" + fn
			str := str + "(" + x.out + " base " + x.base.out + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "1,2,7,13,2,10")
			assert (str + " base", n.base ~ n.sixteen_value)
		end

	plus
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			n: like number_anchor
			x, y: like number_anchor
		do
				-- n := x.plus (y)
			fn := ".plus "
				-- n := (8).plus (9)
			create n
			create x.make_with_value (n.eight_value)
			create y.make_with_value (n.nine_value)
			str := "(" + x.out_as_stored + " base " + x.base.out + ")" + fn
			str := str + "(" + y.out_as_stored + " base " + y.base.out + ")"
			io.put_string (str)
			n := x.plus (y)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "17")
			assert (str + " x unchanged", x.out_as_stored ~ "8")
			assert (str + " y unchanged", y.out_as_stored ~ "9")
		end

	subtract
		local
			str, s: STRING_8
			a, b: like number_anchor
			n: like number_anchor
		do
			str := ".subtract:  "
			s := str + "Fix me!"
			io.put_string (s + "%N")
			assert (s, false)
		end

	minus
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
			-- Checked against "https://defuse.ca/big-number-calculator.htm".
		local
			str, s: STRING_8
			a, b: like number_anchor
			n: like number_anchor
		do
-- Fix me
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

	simple_add
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			a: like testable_number_anchor
			n: like testable_number_anchor
		do
			str := ".simple_add:  "
				-- (0).add (0)
			create n
			create a
			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").add "
			s := s + "(" + a.out_as_stored + " base " + a.base.out + ")"
			n.simple_add (a)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s, n.out_as_stored ~ "0")
				-- Same sign, same bases
			create n.from_array (<<1,2,3,4>>)
			create a.from_array (<<4,3,2,1>>)
			s := str + "(" + n.out_as_stored + " base " + n.base.out
			s := s + ").simple_add (" + a.out_as_stored + " base " + a.base.out + ")"
			n.simple_add (a)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s + " as_stored", n.out_as_stored ~ "5,5,5,5")
			assert (s + " base", n.base.out ~ "128")
		end

	simple_subtract
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			a: like testable_number_anchor
			n: like testable_number_anchor
		do
			str := ".simple_subtract:  "
				-- Same sign, same bases
			create n.from_array (<<1,2,3,4>>)
			create a.from_array (<<1,2,3,4>>)
			s := str + "(" + n.out_as_stored + " base " + n.base.out
			s := s + ").simple_subtract (" + a.out_as_stored + " base " + a.base.out + ")"
			n.simple_subtract (a)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s + " as_stored", n.out_as_stored ~ "0")
			assert (s + " base", n.base.out ~ "128")
				-- Same sign, same bases
			create n.make_with_base (n.sixteen_value)
			create a.make_with_base (n.sixteen_value)
			n.set_with_array (<<1,2,3,4,5>>)
			a.set_with_array (<<1,2,3,4>>)
			s := str + "(" + n.out_as_stored + " base " + n.base.out
			s := s + ").simple_subtract (" + a.out_as_stored + " base " + a.base.out + ")"
			n.simple_subtract (a)
			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
			assert (s + " as_stored", n.out_as_stored ~ "1,1,1,1,1")
			assert (s + " base", n.base.out ~ "16")
		end

	scalar_multiply
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			n: like number_anchor
			x: like digit_anchor
		do
				-- n.scalar_multiply (x)
			fn := ".scalar_multiply "
				-- (0).scalar_mulitply (0)
			create n
--			x := n.zero_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + "(" + x.out + ")"
--			io.put_string (str)
--			n.scalar_multiply (x)
--			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
--			assert (str, n.out_as_stored ~ "0")
--				-- by zero
--			n.set_with_array (<<7,9,3,5>>)
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + "(" + x.out + ")"
--			io.put_string (str)
--			n.scalar_multiply (x)
--			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
--			assert (str, n.out_as_stored ~ "0")
--				-- (7,9,3,5).scalar_multiply (6), default base
--				-- (14,827,909).scalar_multiply (6) = 88,967,454
--			n.set_with_array (<<7,9,3,5>>)
--			x := n.six_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + "(" + x.out + ")"
--			io.put_string (str)
--			n.scalar_multiply (x)
--			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
--			assert (str, n.out_as_stored ~ "42,54,18,30")
--				-- (-1,2,3,4,5,6,7,8,9 base 15).scalar_multiply (3)
--				-- (2,942,093,829).scalar_multiply (3) = 8,826,281,487
--			create n.make_with_base (n.sixteen_value - n.one_value)
--			n.set_with_array (<<1,2,3,4,5,6,7,8,9>>)
--			n.set_is_negative (true)
--			x := n.three_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + "(" + x.out + ")"
--			io.put_string (str)
--			n.scalar_multiply (x)
--			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
--			assert (str, n.out_as_stored ~ "-3,6,9,13,1,4,7,10,12")
				-- (963 base 10).scalar_multiply (30)
				-- (963).scalar_multiply (30) = 28,990
			create n.make_with_base (n.ten_value)
			n.set_with_array (<<9,6,3>>)
			x := n.ten_value * n.three_value
			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
			str := str + "(" + x.out + ")"
			io.put_string (str)
			n.scalar_multiply (x)
			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
			assert (str, n.out_as_stored ~ "2,8,9,9,0")
		end

	scalar_product
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, p: like number_anchor
			fac: like digit_anchor
		do
			str := ".scalar_product "
			create n
				-- Multiply zero by anything
			fac := n.seven_value
			s := "(" + n.out_as_stored + " base " + n.base.out + ")" + str
			s := s + "(" + fac.out + ")"
			io.put_string (s)
			p := n.scalar_product (fac)
			io.put_string (" = " + p.out_as_stored + " base " + n.base.out + "%N")
			assert (s, p.out_as_stored ~ "0")
				-- Multiply by zero
			fac := n.zero_value
			s := "(" + n.out_as_stored + " base " + n.base.out + ")" + str
			s := s + "(" + fac.out + ")"
			io.put_string (s)
			p := n.scalar_product (fac)
			io.put_string (" = " + p.out_as_stored + " base " + n.base.out + "%N")
			assert (s, p.out_as_stored ~ "0")
				-- (1,2,3) max_base).scalar_product (81) = 16,643 * 81 = 1,348,083
			n.set_with_array (<<1,2,3>>)
			fac := n.nine_value * n.nine_value
			s := "(" + n.out_as_stored + " base " + n.base.out + ")" + str
			s := s + "(" + fac.out + ")"
			io.put_string (s)
			p := n.scalar_product (fac)
			io.put_string (" = " + p.out_as_stored + " base " + n.base.out + "%N")
			assert (s, p.out_as_stored ~ "82,35,115")
		end

	multiply
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
			-- "https://defuse.ca/big-number-calculator.htm".
		local
			str, s: STRING_8
			n: like number_anchor
			fac: like number_anchor
		do
			str := ".multiply "
				-- (0).multiply (99)
			create n
			create fac.from_array (<<99>>)
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "0")
			assert (s + "  fac unchanged", fac.out_as_stored ~ "99")
				-- (99).multiply (0)
			create n.from_array (<<99>>)
			create fac
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "0")
			assert (s + "  fac unchanged", fac.out_as_stored ~ "0")
				-- (5).multiply (9)
			create n.from_array (<<5>>)
			create fac.from_array (<<9>>)
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "45")
			assert (s + "  fac unchanged", fac.out_as_stored ~ "9")
				-- (<<1,2,3>>).multiply (<<1,2>>), base 16
				-- (291).multiply (18) = 5,238
			create n.make_with_base (n.sixteen_value)
			create fac.make_with_base (n.sixteen_value)
			n.set_with_array (<<1,2,3>>)
			fac.set_with_array (<<1,2>>)
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "1,4,7,6")
			assert (s + "  fac unchanged", fac.out_as_stored ~ "1,2")
				-- (38374651928376).multiply (99573650866570) = 3821104193242259013972790320
			create n.make_with_base (n.ten_value)
			create fac.make_with_base (n.ten_value)
			n.set_with_array (<<3,8,3,7,4,6,5,1,9,2,8,3,7,6>>)
			fac.set_with_array (<<9,9,5,7,3,6,5,0,8,6,6,5,7,0>>)
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "3,8,2,1,1,0,4,1,9,3,2,4,2,2,5,9,0,1,3,9,7,2,7,9,0,3,2,0")
				-- (333) * (22) = 7326, length differs by one digit.
			create n.make_with_base (n.ten_value)
			create fac.make_with_base (n.ten_value)
			n.set_with_array (<<3,3,3>>)
			fac.set_with_array (<<2,2>>)
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "7,3,2,6")
				-- (7777777) * (4444) = 7326, length differs by one digit.
			create n.make_with_base (n.ten_value)
			create fac.make_with_base (n.ten_value)
			n.set_with_array (<<7,7,7,7,7,7,7>>)
			fac.set_with_array (<<4,4,4,4>>)
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "3,4,5,6,4,4,4,0,9,8,8")
				-- (4444) * (333) = 7326, length differs by one digit.
			create n.make_with_base (n.ten_value)
			create fac.make_with_base (n.ten_value)
			n.set_with_array (<<4,4,4,4>>)
			fac.set_with_array (<<3,3,3>>)
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "1,4,7,9,8,5,2")
				-- (55555) * (333) = 7326, length differs by one digit.
			create n.make_with_base (n.ten_value)
			create fac.make_with_base (n.ten_value)
			n.set_with_array (<<5,5,5,5,5>>)
			fac.set_with_array (<<3,3,3>>)
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "1,8,4,9,9,8,1,5")
				-- (1111) * (11) = 12,221, length differs by one digit.
			create n.make_with_base (n.ten_value)
			create fac.make_with_base (n.ten_value)
			n.set_with_array (<<1,1,1,1>>)
			fac.set_with_array (<<1,1>>)
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "1,2,2,2,1")
				-- (4444) * (22) = 7326, length differs by two digits.
			create n.make_with_base (n.ten_value)
			create fac.make_with_base (n.ten_value)
			n.set_with_array (<<4,4,4,4>>)
			fac.set_with_array (<<2,2>>)
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "9,7,7,6,8")
				-- (666666) * (4444) = 7326, length differs by two digits.
			create n.make_with_base (n.ten_value)
			create fac.make_with_base (n.ten_value)
			n.set_with_array (<<6,6,6,6,6,6>>)
			fac.set_with_array (<<4,4,4,4>>)
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "2,9,6,2,6,6,3,7,0,4")
				-- (-84736487483757564869490010293).multiply (57849399340004949681221)
				--      = -4901954903117222552481914443941818610639794358807753
			create n.make_with_base (n.ten_value)
			create fac.make_with_base (n.ten_value)
			n.set_with_array (<<8,4,7,3,6,4,8,7,4,8,3,7,5,7,5,6,4,8,6,9,4,9,0,0,1,0,2,9,3>>)
			n.set_is_negative (true)
			fac.set_with_array (<<5,7,8,4,9,3,9,9,3,4,0,0,0,4,9,4,9,6,8,1,2,2,1>>)
			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "-4,9,0,1,9,5,4,9,0,3,1,1,7,2,2,2,5,5,2,4,8,1,9,1,%
								%4,4,4,3,9,4,1,8,1,8,6,1,0,6,3,9,7,9,4,3,5,8,8,0,7,7,5,3")
		end

feature -- Basic operations (selectively exported)

	bit_shift_left
			-- Test and demonstrate feature `bit_shift_left' from
			-- {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like testable_number_anchor
		do
			str := ".bit_shift_left:  "
				-- (x0000000).bit_shift_left (7)
			create n
			s := str + "(" + n.out_as_bits + ").bit_shift_left (7) = "
			n.bit_shift_left (7)
			io.put_string (s + n.out_as_bits + "%N")
			assert (s, n.out_as_bits ~ "x0000000")
				-- (x0000111).bit_shift_left (2)
			create n.make_with_value (n.seven_value)
			s := str + "(" + n.out_as_bits + ").bit_shift_left (2) = "
			n.bit_shift_left (2)
			io.put_string (s + n.out_as_bits + "%N")
			assert (s, n.out_as_bits ~ "x0011100")
				-- (x0001111).bit_shift_left (4)
			create n.make_with_value (n.sixteen_value - n.one_value)
			s := str + "(" + n.out_as_bits + ").bit_shift_left (4) = "
			n.bit_shift_left (4)
			io.put_string (s + n.out_as_bits + "%N")
			assert (s, n.out_as_bits ~ "x0000001,x1110000")
				-- (x0000001,x1110000).bit_shift_left (4)
			s := str + "(" + n.out_as_bits + ").bit_shift_left (4) = "
			n.bit_shift_left (4)
			io.put_string (s + n.out_as_bits + "%N")
			assert (s, n.out_as_bits ~ "x0011110,x0000000")
				-- (xxxx1111).bit_shift_left (1)
			create n.make_with_base (n.sixteen_value)
			n.set_value (n.sixteen_value - n.one_value)
			s := str + "(" + n.out_as_bits + ").bit_shift_left (1) = "
			n.bit_shift_left (1)
			io.put_string (s + n.out_as_bits + "%N")
			assert (s, n.out_as_bits ~ "xxxx0001,xxxx1110")
				-- (xxxx0001,xxxx1110).bit_shift_left (4)
			s := str + "(" + n.out_as_bits + ").bit_shift_left (4) = "
			n.bit_shift_left (4)
			io.put_string (s + n.out_as_bits + "%N")
			assert (s, n.out_as_bits ~ "xxxx0001,xxxx1110,xxxx0000")
		end

	normalize
			-- Test and demonstrate feature `normalize' from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like testable_number_anchor
			i: INTEGER_32
		do
			str := generating_type + ".normalize:  "
			create n
				-- i := (x0000001).normalize
			create n.make_with_value (n.one_value)
			s := str + "(" + n.out_as_bits + ").normaize = "
			i := n.normalize
			io.put_string (s + n.out_as_bits + "  i = " + i.out + "%N")
			assert (s + " as_bits", n.out_as_bits ~ "x1000000")
			assert (s + " i", i = 6)
				-- i := (x0000111).normalize
			create n.make_with_value (n.seven_value)
			s := str + "(" + n.out_as_bits + ").normaize = "
			i := n.normalize
			io.put_string (s + n.out_as_bits + "  i = " + i.out + "%N")
			assert (s + " as_bits", n.out_as_bits ~ "x1110000")
			assert (s + " i", i = 4)
				-- i := (xxxx0101).normalize
			create n.make_with_value_and_base (n.five_value, n.sixteen_value)
			s := str + "(" + n.out_as_bits + ").normaize = "
			i := n.normalize
			io.put_string (s + n.out_as_bits + "  i = " + i.out + "%N")
			assert (s + " as_bits", n.out_as_bits ~ "xxxx1010")
			assert (s + " i", i = 1)
		end

	divide_two_digits_by_one
			-- Test and demonstrate feature `divide_two_digits_by_one' from
			-- {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like testable_number_anchor
			denom: like testable_number_anchor
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
