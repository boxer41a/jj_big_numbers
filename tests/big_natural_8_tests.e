note
	description: "[
		Test routines specific to {JJ_BIG_NATURAL_8} numbers.
		
		Features from {BIG_NATURAL_TESTS}, even though fully defined in
		the {BIG_NATURAL_TESTS} ancestor class, must be redefined here
		in order to be recognized by the automatic test system.
	]"
	author: "Jimmy J. Johnson"

class
	BIG_NATURAL_8_TESTS

inherit

	BIG_NATURAL_TESTS
		redefine
			zero_digit,
			one_digit,
			two_digit,
			three_digit,
			four_digit,
			five_digit,
			six_digit,
			seven_digit,
			eight_digit,
			nine_digit,
			ten_digit,
			sixteen_digit,
			max_digit,
			default_karatsuba_threshold,

			multiply_helper,
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
--			create Result.make_with_array (a_array, a_base)
--		end

feature -- Basic operations (initialization tests)

	default_create_test
		local
			fn: STRING_8
			n: like number_anchor
		do
			fn := ".test_default_create"
			io.put_string (fn)
			create n
			io.put_string (" = (" + n.out_as_stored + ")")
			assert (fn + " out_as_stored", n.out_as_stored ~ "0")
		end

--	make_with_base
--		local
--			fn, str: STRING_8
--			n: like number_anchor
--			b: like digit_anchor
--		do
--			fn := ".make_with_base"
--			create n
--			b := n.seven_digit
--			str := fn + " (" + b.out + ")"
--			io.put_string (str + " = ")
--			create n.make_with_base (b)
--			io.put_string ("(" + n.out_as_stored + " base " + n.base.out + ")")
--			assert (str, n.base.out ~ b.out)
--		end

	make_with_value
		local
			fn, str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			fn := ".make_with_value"
			n := new_number
				-- .make_with_value (16 * 7)
			v := n.sixteen_digit * n.seven_digit
			str := fn + " (" + v.out + ")"
			io.put_string (str + " = ")
			create n.make_with_value (v)
			assert (str, n.out_as_stored ~ "112")
		end

--	make_with_value_and_base
--		local
--			fn, str: STRING_8
--			n: like number_anchor
--			v: like digit_anchor
--			b: like digit_anchor
--		do
--			fn := ".make_with_value_and_base"
--			create n
--			v := n.max_representable_digit
--			b := n.sixteen_digit
--			str := fn + " (" + v.out + ", " + b.out + ")"
--			io.put_string (str + " = ")
--			create n.make_with_value_and_base (v, b)
--			io.put_string ("(" + n.out_as_stored + " base " + n.base.out + ")")
----			assert (str + " out", n.out_as_stored ~ "15,15")
--			assert (str + " out_as_stored", n.out_as_stored ~ "255")
--			assert (str + " base", n.base.out ~ "16")
--		end

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
			io.put_string (s + " = " + n.out + "%N")
			assert (s + " out_as_stored ", n.out_as_stored ~ "15,12")
				-- Number
			create n.from_string ("10,987,654,321")
			s := str + "(%"10,987,654,321%")"
			io.put_string (s + " out = " + n.out + "     as_stored:  "+ n.out_as_stored + "%N")
			assert (s + " out_as_stored ", n.out_as_stored ~ "2,142,234,76,177")
				-- Negative number
			create n.from_string ("-00012,34")
			s := str + "(%"-00012,34%")"
			io.put_string (s + " out = " + n.out + "     as_stored:  "+ n.out_as_stored + "%N")
			assert (s + " out_as_stored ", n.out_as_stored ~ "-4,210")
				-- Failing ? number
			create n.from_string ("33333")
			s := str + "(%"33333%")"
			io.put_string (s + " out = " + n.out + "     as_stored:  "+ n.out_as_stored + "%N")
			assert (s + " out_as_stored ", n.out_as_stored ~ "130,53")
				-- Number arrived at during failing simple_multiply?
			create n.from_string ("26,558,760")
			s := str + "(%"26,558,760%")"
			io.put_string (s + " out = " + n.out + "     as_stored:  "+ n.out_as_stored + "%N")
			assert (s + " out_as_stored ", n.out_as_stored ~ "1,149,65,40")
		end

	make_with_array
		local
			fn, str: STRING_8
			n: like number_anchor
			a: ARRAY [like digit_anchor]
		do
			fn := ".make_with_array"
			str := fn + " (<1, 2, 3, 4>>)"
			io.put_string (str + " = ")
			a := <<1, 2, 3, 4>>
			create n.make_with_array (a)
--			io.put_string (" " + n.out_as_stored + " base " + n.base.out + "%N")
--			assert (str, n.out_as_stored ~ "1,2,3,4")
--				-- test the out function (it was failing on this)
			a := <<1,8,187>>
			create n.make_with_array (a)
			io.put_string (" " + n.out_as_stored + "%N")
			io.put_string (" " + n.out + "%N")
			assert (str, n.out_as_stored ~ "1,8,187")
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

	zero_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	one_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	two_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	three_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	four_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	five_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	six_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	seven_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	eight_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	nine_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	ten_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	sixteen_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	max_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	default_karatsuba_threshold
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

feature -- Basic operations (Access)

--	base
--			-- Tests and demonstrates the corresponding feature
--			-- from {JJ_BIG_NATURAL}.
--		local
--			str, fn: STRING_8
--			n: like number_anchor
--			b: like digit_anchor
--		do
--			fn := ".base:  "
--			create n
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			io.put_string (str + " = ")
--			b := n.base
--			io.put_string (b.out + "%N")
--			assert (str, b.out ~ n.max_base.out)
--		end

--	min_base
--			-- Tests and demonstrates the corresponding feature
--			-- from {JJ_BIG_NATURAL}.
--		local
--			str: STRING_8
--			n: like number_anchor
--			b: like digit_anchor
--		do
--			str := ".min_base:  "
--			create n
--			b := n.min_base
--			io.put_string (str + b.out + "%N")
--			assert (str, b.out ~ "2")
--		end

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
			io.put_string (str + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "0")
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
			io.put_string (str + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "1")
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
			fn, str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			fn := ".set_value"
				-- zero
			create n
			v := n.zero_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + v.out + ")"
			io.put_string (str + " = ")
			n.set_value (v)
			io.put_string (n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "0")
				-- max_value
			create n
			v := n.max_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + v.out + ")"
			io.put_string (str + " = ")
			n.set_value (v)
			io.put_string (n.out_as_stored + " %N")
			assert (str, n.out_as_stored ~ n.max_digit.out)
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
			io.put_string (s + " = " + n.out + "%N")
			assert (s, n.out_as_stored ~ "7,91,205,21")
			assert (s, n.out ~ "123456789")
				-- Second test
			create n
			n.set_with_string ("321")
			s := str + "set_with_string (%"321%")"
			io.put_string (s + " = " + n.out + "%N")
			assert (s, n.out_as_stored ~ "1,65")
			assert (s, n.out ~ "321")
				-- Test
			create n
			n.set_with_string ("4152")
			s := str + "set_with_string (%"4152%")"
			io.put_string (s + " out_as_stored = " + n.out_as_stored + "%N")
			io.put_string (s + " out = " + n.out + "%N")
			assert (s, n.out_as_stored ~ "16,56")
			assert (s, n.out ~ "4152")
				-- Test
			create n
			n.set_with_string ("987")
			s := str + "set_with_string (%"987%")"
			io.put_string (s + " out_as_stored = " + n.out_as_stored + "%N")
			io.put_string (s + " out = " + n.out + "%N")
			assert (s, n.out_as_stored ~ "3,219")
			assert (s, n.out ~ "987")
				-- Test
			create n
			n.set_with_string ("9876")
			s := str + "set_with_string (%"9876%")"
			io.put_string (s + " out_as_stored = " + n.out_as_stored + "%N")
			io.put_string (s + " out = " + n.out + "%N")
			assert (s, n.out_as_stored ~ "38,148")
			assert (s, n.out ~ "9876")
				-- Test 98765 = [1,129,205]
			create n
			n.set_with_string ("98765")
			s := str + "set_with_string (%"98765%")"
			io.put_string (s + " out_as_stored = " + n.out_as_stored + "%N")
			io.put_string (s + " out = " + n.out + "%N")
			assert (s, n.out_as_stored ~ "1,129,205")
			assert (s, n.out ~ "98765")
				-- Test leading zeroes.
			create n
			n.set_with_string ("0,0,0,0,0,9,8,7,6,5,4,3,2,1")
			s := str + "set_with_string (%"0,0,0,0,0,9,8,7,6,5,4,3,2,1%")"
			io.put_string (s + " = " + n.out + "%N")
			assert (s, n.out_as_stored ~ "58,222,104,177")
			assert (s, n.out ~ "987654321")
				-- Negative test
			create n
			n.set_with_string ("-11,2,3,4,5,6,7,8,99")
			s := str + "set_with_string (%"-11,2345,678,9,9%")"
			io.put_string (s + " out_as_stored = " + n.out_as_stored + "%N")
			io.put_string (s + " = " + n.out + "%N")
			assert (s + ".out_as_stored", n.out_as_stored ~ "-2,157,161,230,219")
			assert (s + ".is_negative", n.is_negative)
			assert (s + ".out", n.out ~ "-11234567899")
		end

--	set_base
--			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
--		local
--			fn, str: STRING_8
--			n: like number_anchor
--			b: like digit_anchor
--		do
--			fn := ".set_base "
--				-- Max_base
--			create n
--			b := n.max_base
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + "(" + b.out + ")"
--			io.put_string (str)
--			n.set_base (b)
--			io.put_string (":  " + n.out_as_stored + "%N")
--			assert (str, n.out_as_stored ~ "0")
--			assert (str + " base", n.base ~ n.max_base)
--				-- (16 base 128).set_base (15) = 1,1 base 15
--			create n.make_with_value (n.sixteen_digit)
--			b := n.sixteen_digit - 1
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + "(" + b.out + ")"
--			io.put_string (str)
--			n.set_base (b)
--			io.put_string (":  " + n.out_as_stored + "%N")
--			assert (str, n.out_as_stored ~ "1,1")
--			assert (str + " base", n.base ~ b)
--				-- (1,1 base 100).set_base (10)
--			create n.make_with_base (n.ten_digit * n.ten_digit)
--			b := n.ten_digit
--			n.set_value (n.ten_digit * n.ten_digit + n.one_digit)
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + "(" + b.out + ")"
--			io.put_string (str)
--			n.set_base (b)
--			io.put_string (":  " + n.out_as_stored + "%N")
--			assert (str, n.out_as_stored ~ "1,0,1")
--			assert (str + " base", n.base = b)
--				-- (1,1,2 base 10).set_base (9)
--			create n.make_with_value_and_base (n.sixteen_digit * n.seven_digit, n.ten_digit)
--			b := n.nine_digit
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + "(" + b.out + ")"
--			io.put_string (str)
--			n.set_base (b)
--			io.put_string (":  " + n.out_as_stored + "%N")
--			assert (str + " base", n.base.out ~ "9")
--			assert (str, n.out_as_stored ~ "1,3,4")
--				-- (1,3,4 base 9).set_base (10)
--			create n.make_with_base (n.nine_digit)
--			n.set_with_array (<<1,3,4>>)
--			b := n.ten_digit
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + "(" + b.out + ")"
--			io.put_string (str)
--			n.set_base (b)
--			io.put_string (":  " + n.out_as_stored + "%N")
--			assert (str + " base", n.base.out ~ "10")
--			assert (str, n.out_as_stored ~ "1,1,2")
--				-- (3,2 base 10).set_base (100)
--			create n.make_with_value_and_base (n.sixteen_digit + n.sixteen_digit, n.ten_digit)
--			b := n.ten_digit * n.ten_digit
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + "(" + b.out + ")"
--			io.put_string (str)
--			n.set_base (b)
--			io.put_string (":  " + n.out_as_stored + "%N")
--			assert (str + " base", n.base.out ~ "100")
--			assert (str, n.out ~ "32")
--				-- (1,1,2 base 10).set_base (100)
--			create n.make_with_value_and_base (n.sixteen_digit * n.seven_digit, n.ten_digit)
--			b := n.ten_digit * n.ten_digit
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + "(" + b.out + ")"
--			io.put_string (str)
--			n.set_base (b)
--			io.put_string (":  " + n.out_as_stored + "%N")
--			assert (str + " base", n.base.out ~ "100")
--			assert (str, n.out_as_stored ~ "1,12")
--		end

--	set_base_failing
--			-- Some values that need fixing
--		local
--			fn, str: STRING_8
--			n, on: like number_anchor
--			b, ob: like digit_anchor
--			v: like digit_anchor
--			right, wrong: INTEGER
--		do
--			fn := ".set_base_failing "
--			io.put_string (fn + "%N")
--			create n
----			from ob := n.two_value
----			until ob > n.max_base
----			loop
----				from b := n.two_value
----				until b > n.max_base
----				loop
----					from v := n.zero_value
----					until v > n.max_digit_value
----					loop
----						create n.make_with_value_and_base (v, ob)
----						create on.make_with_value_and_base (v, b)
----						str := "v = " + v.out + "  (" + n.out_as_stored + " base " + n.base.out + ")" + fn
----						str := str + "(" + b.out + ")"
----						n.set_base (b)
----						if n.out ~ on.out then
----							right := right + 1
----						else
----							wrong := wrong + 1
----							io.put_string (str)
----							io.put_string (":%T '" + n.out_as_stored + "'")-- + " base " + n.base.out)-- + " %N")
----							io.put_string ("%T%T expected:  '" + on.out_as_stored + "'%N")--" base " + on.base.out + "%N")
----						end
----						v := v + n.one_value
----					end
----					b := b + n.one_value
----				end
----				ob := ob + n.one_value
----			end
----			io.put_string ("  correct count = " + right.out + "  wrong count = " + wrong.out + "%N")
----			io.new_line
----			io.new_line
--		end

--	set_value_and_base
--			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
--		local
--			fn, str: STRING_8
--			n: like number_anchor
--			b, v: like digit_anchor
--		do
--			fn := ".set_with_value_and_base:  "
--			create n
--				--
--			v := n.max_representable_value
--			b := n.ten_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + "(" + v.out + ", " + b.out + ")"
--			io.put_string (str + ":  ")
--			n.set_value_and_base (v, b)
--			io.put_string (n.out_as_stored + " base " + n.base.out + " %N")
--			assert (str + " out_as_stored", n.out_as_stored ~ "2,5,5")
--			assert (str + " base", n.base.out ~ "10")
--				-- 252 base 5
--			create n
--			v := n.max_representable_value - n.three_value
--			b := n.five_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + "(" + v.out + ", " + b.out + ")"
--			io.put_string (str + ":  ")
--			n.set_value_and_base (v, b)
--			io.put_string (n.out_as_stored + " base " + n.base.out + " %N")
--			assert (str + " out_as_stored", n.out_as_stored ~ "2,0,0,2")
--			assert (str + " base", n.base.out ~ "5")
--		end

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
			create n.make_with_array (a)
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "10,20,30,40,50,60,70,80,90")
		end

feature -- Basic operations (conversion tests)

--	to_base
--			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
--		local
--			str, s: STRING_8
--			fn: STRING_8
--			n: like number_anchor
--			b: like digit_anchor
--		do
--			fn := ".to_base"
--			str := ".to_base:  "
--				-- As in document
--			create n
--			create n.make_with_array_and_base (<<5,2,5,0>>, n.nine_value)
--			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base (" + n.ten_value.out + ")"
--			n.to_base (n.ten_value)
--			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
--			assert (s, n.out_as_stored ~ "3,8,5,2")
--				-- to_base (15)
--			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base ("
--			s := s + (n.ten_value + n.five_value).out + ")"
--			n.to_base (n.ten_value + n.five_value)
--			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
--			assert (s, n.out_as_stored ~ "1,2,1,12")
--				-- back to base ten
--			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base ("
--			s := s + (n.ten_value).out + ")"
--			n.to_base (n.ten_value)
--			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
--			assert (s, n.out_as_stored ~ "3,8,5,2")
--				-- back to base nine
--			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base ("
--			s := s + (n.nine_value).out + ")"
--			n.to_base (n.nine_value)
--			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
--			assert (s, n.out_as_stored ~ "5,2,5,0")
--				-- Zero
--			create n
--			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base (" + n.nine_value.out + ")"
--			n.to_base (n.nine_value)
--			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
--			assert (s, n.out_as_stored ~ "0")
--				-- (128).to_base (100)
--			create n
--			create n.make_with_value_and_base (n.max_digit_value, n.ten_value * n.ten_value)
--			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base (" + n.eight_value.out + ")"
--			n.to_base (n.eight_value)
--			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
--			assert (s, n.out_as_stored ~ "1,7,7")
--				-- to base 10
--			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base (" + n.ten_value.out + ")"
--			n.to_base (n.ten_value)
--			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
--			assert (s, n.out_as_stored ~ "1,2,7")
--				-- to binary
--			s := str + "(" + n.out_as_stored + " base " + n.base.out + ").to_base (" + n.two_value.out + ")"
--			n.to_base (n.two_value)
--			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
--			assert (s, n.out_as_stored ~ "1,1,1,1,1,1,1")
--				-- (<<1,1,1,1,1,1,1>> base 2).to_base (100)
--			create n.make_with_base (n.two_value)
--			n.set_with_array (<<1,1,1,1,1,1,1>>)
--			b := n.ten_value * n.ten_value
--			s := str + "(" + n.out_as_stored + " base " + n.base.out
--			s := s + ").to_base (" + (n.ten_value * n.ten_value).out + ")"
--			n.to_base (b)
--			io.put_string (s + " = " + n.out_as_stored + " base " + n.base.out + "%N")
--			assert (s + " value", n.out_as_stored ~ "1,27")
--			assert (s + " base", n.base.out ~ "100")
--				-- (<<1,2,3>> base 30).to_base (10)
--			create n.make_with_base (n.ten_value * n.three_value)
--			n.set_with_array (<<1,2,3>>)
--			b := n.ten_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + ".as_base" --fn
--			str := str + "(" + b.out + ")"
--			io.put_string (str)
--			n.to_base (b)
--			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
--			assert (str, n.out_as_stored ~ "9,6,3")
--			assert (str + " base", n.base ~ n.ten_value)
--				-- (<<1,2,3,4>> base 30).to_base (10)
--			create n.make_with_base (n.ten_value * n.three_value)
--			n.set_with_array (<<1,2,3,4>>)
--			b := n.ten_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")"
--			str := str + fn + " (" + b.out + ")"
--			io.put_string (str)
--			n.to_base (b)
--			io.put_string (":  " + n.out_as_stored + " base " + n.base.out + " %N")
--			assert (str, n.out_as_stored ~ "1,2,7,13,2,10")
--			assert (str + " base", n.base ~ n.sixteen_value)
--		end

--	as_base
--			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
--		local
--			str, s: STRING_8
--			n, a: like number_anchor
--			b: like digit_anchor
--		do
--			str := ".as_base:  "
--			create n
--				-- (1,2,3,4,5).as_base (10)
--			create n.make_with_array_and_base (<<1,2,3,4,5>>, n.ten_value)
--			b := n.ten_value
--			s := str + "(" + n.out_as_stored + " base " + n.base.out
--			s := s + ").as_base (" + b.out + ")"
--			io.put_string (s)
--			a := n.as_base (b)
--			io.put_string (" = " + a.out_as_stored + " base " + a.base.out + "%N")
--			assert (s + " value", a.out_as_stored ~ "1,2,3,4,5")
--			assert (s + " unchanged", n.out_as_stored ~ "1,2,3,4,5")
--			assert (s + " base unchanged", n.base.out ~ b.out)
--				-- (1,2).as_base (9)
--			create n.make_with_array_and_base (<<1,2>>, n.ten_value)
--			b := n.nine_value
--			s := str + "(" + n.out_as_stored + " base " + n.base.out
--			s := s + ").as_base (" + b.out + ")"
--			io.put_string (s)
--			a := n.as_base (b)
--			io.put_string (" = " + a.out_as_stored + " base " + a.base.out + "%N")
--			assert (s + " value", a.out_as_stored ~ "1,3")
--			assert (s + " unchanged", n.out_as_stored ~ "1,2")
--			assert (s + " base unchanged", n.base.out ~ "10")
--				-- (1,2,3).as_base (9)
--			create n.make_with_array_and_base (<<1,2,3>>, n.ten_value)
--			b := n.nine_value
--			s := str + "(" + n.out_as_stored + " base " + n.base.out
--			s := s + ").as_base (" + b.out + ")"
--			io.put_string (s)
--			a := n.as_base (b)
--			io.put_string (" = " + a.out_as_stored + " base " + a.base.out + "%N")
--			assert (s + " value", a.out_as_stored ~ "1,4,6")
--			assert (s + " unchanged", n.out_as_stored ~ "1,2,3")
--			assert (s + " base unchanged", n.base.out ~ "10")
--				-- (1,2,3,4).as_base (9)
--			create n.make_with_array_and_base (<<1,2,3,4>>, n.ten_value)
--			b := n.nine_value
--			s := str + "(" + n.out_as_stored + " base " + n.base.out
--			s := s + ").as_base (" + b.out + ")"
--			io.put_string (s)
--			a := n.as_base (b)
--			io.put_string (" = " + a.out_as_stored + " base " + a.base.out + "%N")
--			assert (s + " value", a.out_as_stored ~ "1,6,2,1")
--			assert (s + " unchanged", n.out_as_stored ~ "1,2,3,4")
--			assert (s + " base unchanged", n.base.out ~"10")
--				-- Convert back to base 10
--			b := n.ten_value
--			s := str + "(" + a.out_as_stored + " base " + a.base.out
--			s := s + ").as_base (" + b.out + ")"
--			io.put_string (s)
--			a := a.as_base (b)
--			io.put_string (" = " + a.out_as_stored + " base " + a.base.out + "%N")
--			assert (s + " value", a.out_as_stored ~ "1,2,3,4")
--		end

--	as_base_failing
--			-- Seperate run of a failing case for `as_base'
--				-- (1,2,3,4,5).as_base (9)
--		local
--			str, s: STRING_8
--			n, a: like number_anchor
--			b: like digit_anchor
--		do
--			str := ".as_base:  "
--			create n
--			create n.make_with_array_and_base (<<1,2,3,4,5>>, n.ten_value)
--			b := n.nine_value
--			s := str + "(" + n.out_as_stored + " base " + n.base.out
--			s := s + ").as_base (" + b.out + ")"
--			io.put_string (s)
--			a := n.as_base (b)
--			io.put_string (" = " + a.out_as_stored + " base " + a.base.out + "%N")
--			assert (s + " value", a.out_as_stored ~ "1,7,8,3,6")
--			assert (s + " unchanged", n.out_as_stored ~ "5,6,2,3,2,1")
--			assert (s + " base unchanged", n.base.out ~ b.out)
--		end

feature -- Basic operations (Status setting tests)

	set_is_negative
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like new_number
		do
			str := ".set_is_negative:  "
			create n
			n.set_is_negative (true)
			s := str + "(" + n.out_as_stored + ").set_is_negative (true)"
			io.put_string (s + " = " + n.is_negative.out + "%N")
			assert (s, not n.is_negative)
				-- (max_digit_value).set_is_negative (true)
			n.set_value (n.max_digit)
			assert (str + "not negated", not n.is_negative)
			s := str + "(" + n.out_as_stored + ").set_is_negative (true)"
			n.set_is_negative (true)
			io.put_string (s + " = " + n.is_negative.out + "%N")
			assert (s, n.is_negative)
				-- Set to false
			s := str + "(" + n.out_as_stored + ").set_is_negative (false)"
			n.set_is_negative (false)
			io.put_string (s + " = " + n.is_negative.out + "%N")
			assert (s, not n.is_negative)
		end

feature -- Basic operations (status report tests)

	is_zero
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like new_number
		do
			str := ".is_zero:  "
				-- Default create
			create n
			s := str + "(" + n.out_as_stored + ").is_zero"
			io.put_string (s + " = " + n.is_zero.out + "%N")
			assert (s, n.is_zero)
				-- Make it positive
			n.set_value (n.one_digit)
			s := str + "(" + n.out_as_stored + ").is_zero"
			io.put_string (s + " = " + n.is_zero.out + "%N")
			assert (s, not n.is_zero)
				-- Make it negative
			n.set_is_negative (true)
			s := str + "(" + n.out_as_stored + ").is_zero"
			io.put_string (s + " = " + n.is_zero.out + "%N")
			assert (s, not n.is_zero)
		end

	is_one
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like new_number
		do
			str := ".is_one:  "
				-- Default create
			create n
			s := str + "(" + n.out_as_stored + ").is_one"
			io.put_string (s + " = " + n.is_one.out + "%N")
			assert (s, not n.is_one)
				-- Make it one
			n.set_value (n.one_digit)
			s := str + "(" + n.out_as_stored + ").is_one"
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
			n: like new_number
		do
			str := ".is_base:  "
				-- Not base
			create n.make_with_array (<<1,2,3>>)
			s := str + "(" + n.out_as_stored + ").is_base"
			io.put_string (s + " = " + n.is_base.out + "%N")
			assert (s, not n.is_base)
				-- Is base
			create n.make_with_array (<<1,0>>)
			s := str + "(" + n.out_as_stored + ").is_base"
			io.put_string (s + " = " + n.is_base.out + "%N")
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
			n: like new_number
		do
			str := ".is_negative:  "
				-- Not is_negative
			create n.make_with_array (<<1,2,3>>)
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
			n, n2: like new_number
		do
			str := ".is_same_sign:  "
				-- Is same sign
			create n.make_with_array (<<1,2,3>>)
			create n2.make_with_array (<<4,5,6>>)
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
			n, n2: like new_number
		do
			str := ".divisible:  "
				-- Yes, non-zero divisor
			create n
			create n2.make_with_array (<<1,2,3>>)
			s := str + "(" + n.out_as_stored + ").divisible (" + n2.out_as_stored + ")"
			io.put_string (s + " = " + n.divisible (n2).out + "%N")
			assert (s, n.divisible (n2))
				-- No, divisor is zero
			create n
			create n2.make_with_array (<<1,2,3>>)
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
			n.set_value (n.nine_digit * n.nine_digit)
			s := str + "(" + n.out_as_stored + ").negate"
			n.negate
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "-81")
				-- (-81).negate
			s := str + "(" + n.out_as_stored + ").negate"
			n.negate
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "81")
		end

	identity
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, a: like number_anchor
		do
			str := ".identity:  "
			create n
			n.set_value (n.nine_digit)
			s := str + "(" + n.out_as_stored + ").identity"
			a := n.identity
			io.put_string (s + " = " + a.out_as_stored + "%N")
			assert (s + " values", n.out_as_stored ~ a.out_as_stored)
			assert (s + " unchanged", n.out_as_stored ~ "9")
				-- (-9).identity
			n.negate
			s := str + "(" + n.out_as_stored + ").identity"
			a := n.identity
			io.put_string (s + " = " + a.out_as_stored + "%N")
			assert (s + " values", n.out_as_stored ~ a.out_as_stored)
			assert (s + " unchanged", n.out_as_stored ~ "-9")
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
			n.set_value (n.seven_digit)
			s := str + "(" + n.out_as_stored + ").opposite"
			a := n.opposite
			io.put_string (s + " = " + a.out_as_stored + "%N")
			assert (s + " values", a.out_as_stored ~ "-7")
			assert (s + " unchanged", n.out_as_stored ~ "7")
				-- (-7).opposite
			n.copy (a)
			s := str + "(" + n.out_as_stored + ").opposite"
			a := n.opposite
			io.put_string (s + " = " + a.out_as_stored + "%N")
			assert (s + " values", a.out_as_stored ~ "7")
			assert (s + " unchanged", n.out_as_stored ~ "-7")
		end

	scalar_add
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			n: like number_anchor
			v, b: like digit_anchor
		do
			fn := ".scalar_add"
				-- (0).scalar_add (7)
			create n
			v := n.seven_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "7")
				-- (9).scalar_add (max_digit_value)
			create n.make_with_value (n.nine_digit)
			v := n.max_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + v.out + ")"
			io.put_string (str + " = ")
			n.scalar_add (v)
			io.put_string (n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "1,8")
				-- (max_digit_value).scalar_add (1)
			create n.make_with_value (n.max_digit)
			v := n.one_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "1,0")
				-- (max_representable_digit).scalar_add (1)
			create n.make_with_value (n.max_digit)
			v := n.one_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "1,0")
				-- (max_representable_value).scalar_add (max_representable_value)
			create n.make_with_value (n.max_digit)
			v := n.max_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "1,254")
		end

	scalar_sum
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			n, s: like number_anchor
			v, b: like digit_anchor
		do
			fn := ".scalar_sum"
				-- (0).acalar_sum (max_representable_value) = 255
			create n
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + n.max_digit.out + ")"
			io.put_string (str + " = ")
			s := n.scalar_sum (n.max_digit)
			io.put_string (s.out_as_stored + "%N")
			assert (str, s.out_as_stored ~ "255")
			assert (str + "n unchanged", n.out_as_stored ~ "0")
--				-- (<<1,20,33>> base 100).scalar_sum (99)
--			b := n.ten_digit * n.ten_digit
--			v := n.ten_digit * n.nine_digit + n.nine_digit
--			create n.make_with_base (b)
--			n.set_with_array (<<1,20,33>>)
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + " (" + v.out + ")"
--			io.put_string (str + " = ")
--			s := n.scalar_sum (v)
--			io.put_string (s.out_as_stored + "%N")
--			assert (str, s.out_as_stored ~ "47,100")
--			assert (str + "n unchanged", n.out_as_stored ~ "47,1")

--			s := str + "(" + n.out + ").scalar_sum (" + n.max_digit_value.out + ")"
--			a := n.scalar_sum (n.max_digit_value)
--			io.put_string (s + " = " + a.out + "%N")
--			assert (s, a.out ~ "127")
--			assert (s + "n unchanged", n.out ~ "0")
--				-- add 111
--			create n.make_with_array_and_base (<<9,3,1>>, n.ten_value)
--			s := str + "(" + n.out + ").scalar_sum ("
--			s := s + (n.base_minus_one_value - n.sixteen_value).out + ") base " + n.base.out
--			a := n.scalar_sum (n.base_minus_one_value - n.sixteen_value)
--			io.put_string (s + " = " + a.out + "  base = " + a.base.out + "%N")
--			assert (s, a.out ~ "1180")
--			assert (s + "n unchanged", n.out ~ "931")
--				-- Change the base to 13 and add 112
--			n.set_base (n.ten_value + n.three_value)
--			s := str + "(" + n.out + ").scalar_sum (" + (n.sixteen_value * n.seven_value).out
--			s := s + ")" + "  base " + n.base.out
--			a := n.scalar_sum (n.sixteen_value * n.seven_value)
--			io.put_string (s + " = " + a.out + "  a.base = " + a.base.out + "%N")
--			assert (s, a.out ~ "1043")
--			assert (s + " base", a.base.out ~ "13")
--			assert (s + "n unchanged", n.out ~ "931")
--				-- Negate and add 50
--			s := str + "(-357).scalar_add (50)"
--			n.negate
--			s := str + "(" + n.out + ").scalar_sum (" + (n.ten_value * n.five_value).out
--			s := s + ")" + "  base " + n.base.out
--			a := n.scalar_sum (n.ten_value * n.five_value)
--			io.put_string (s + " = " + a.out + "  a.base = " + n.base.out +"%N")
--			assert (s, a.out ~ "-881")
--			assert (s + "n unchanged", n.out ~ "-931")
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
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out_as_stored + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "0")
				-- (1).add (0)
			create n.make_with_value (n.one_digit)
			create x
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out_as_stored + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "1")
				-- (0).add (1)
			create n
			create x.make_with_value (n.one_digit)
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out_as_stored + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "1")
				-- (99).add (101), default_base
			n.set_value ((n.ten_digit + n.one_digit) * n.nine_digit)
			x.set_value (n.ten_digit * n.ten_digit + n.one_digit)
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out_as_stored + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "200")
--				-- big numbers, base 10
--				-- (834292018876).add (99584738599403878) = 99584822091422754
--			create n.make_with_base (n.ten_digit)
--			create x.make_with_base (n.ten_digit)
--			n.set_with_array (<<8,3,4,9,2,0,1,8,8,7,6>>)
--			x.set_with_array (<<9,9,5,8,4,7,3,8,5,9,9,4,0,3,8,7,8>>)
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + "(" + x.out_as_stored + ")"
--			io.put_string (str)
--			n.add (x)
--			io.put_string (":  " + n.out_as_stored + "%N")
--			assert (str, n.out_as_stored ~ "1,97,203,222,57,199,156,34")
--				-- (<<5,4,3,2,1>>).add (<<1,2,3,4,5>>) = <<1,2,7,13,2,10>> base 16
--				-- (344,865).add (866,825) = 1,211,690
--			create n.make_with_base (n.sixteen_digit)
--			create x.make_with_base (n.ten_digit * n.three_digit)
--			n.set_with_array (<<5,4,3,2,1>>)
--			x.set_with_array (<<1,2,3,4,5>>)
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + "(" + x.out_as_stored + ")"
--			io.put_string (str)
--			n.add (x)
--			io.put_string (":  " + n.out_as_stored + "%N")
--			assert (str, n.out_as_stored ~ "18,125,42")
----			assert (str, n.out ~ "1,2,7,13,2,10")
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
			create x.make_with_value (n.eight_digit)
			create y.make_with_value (n.nine_digit)
			str := "(" + x.out_as_stored + ")" + fn
			str := str + "(" + y.out_as_stored + ")"
			io.put_string (str)
			n := x.plus (y)
			io.put_string (":  " + n.out_as_stored + "%N")
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
			str := ".minus "
				-- (1000).minus (99) = 901
			create a.from_string ("1000")
			create b.from_string ("99")
--			s := str + "(" + a.out + " base " + a.base.out
--			s := s + ").simple_subtract (" + b.out + " base " + b.base.out + ")"
			s :="(" + a.out_as_stored + ")" + str
			s := s + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			n := a.minus (b)
			io.put_string (n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "3,133")
				-- (578372618996743892774658921536).minus
				-- (578372618990119377281937921536)
				--           = 6624515492721000000
			create a.from_string ("578372618996743892774658921536")
			create b.from_string ("578372618990119377281937921536")
			s :="(" + a.out_as_stored + ")" + str
			s := s + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			n := a.minus (b)
			io.put_string (n.out_as_stored + "%N")
			assert (s, n.out ~ "6624515492721000000")
				-- Munus test number three
			a.negate
			s := str + "(" + a.out + " - " + b.out + ")"
			n := a - b
			report (s, n)
			assert (s, n.out ~ "-1156745237986863270056596843072")

			io.new_line
		end

	simple_add
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			a: like testable_number_anchor
			n: like testable_number_anchor
		do
			fn := ".simple_add"
				-- (0).add (0)
			create n
			create a
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + a.out_as_stored + ")"
			io.put_string (str + " = ")
			n.simple_add (a)
			io.put_string (n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "0")
				-- Same sign, same bases
			create n.make_with_array (<<1,2,3,4>>)
			create a.make_with_array (<<4,3,2,1>>)
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + a.out_as_stored + ")"
			io.put_string (str + " = ")
			n.simple_add (a)
			io.put_string (n.out_as_stored + "%N")
			assert (str + " as_stored", n.out_as_stored ~ "5,5,5,5")
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
			create n.make_with_array (<<1,2,3,4>>)
			create a.make_with_array (<<1,2,3,4>>)
			s := str + "(" + n.out_as_stored
			s := s + ").simple_subtract (" + a.out_as_stored + ")"
			n.simple_subtract (a)
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s + " as_stored", n.out_as_stored ~ "0")
				-- Same sign, same bases
				-- (74,565).siple_subtract (4660) = 69,905
--			create n.make_with_base (n.sixteen_digit)
--			create a.make_with_base (n.sixteen_digit)
			n.set_with_array (<<1,2,3,4,5>>)
			a.set_with_array (<<1,2,3,4>>)
			s := str + "(" + n.out_as_stored
			s := s + ").simple_subtract (" + a.out_as_stored + ")"
			n.simple_subtract (a)
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s + " as_stored", n.out_as_stored ~ "1,17,17")
--			assert (s + " as_stored", n.out ~ "1,1,1,1,1")
				-- (321).siple_subtract (121) = 198
--			create n.make_with_base (n.ten_digit)
--			create a.make_with_base (n.ten_digit)
			n.set_with_array (<<3,2,1>>)
			a.set_with_array (<<1,2,3>>)
			s := str + "(" + n.out_as_stored
			s := s + ").simple_subtract (" + a.out_as_stored + ")"
			n.simple_subtract (a)
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s + " as_stored", n.out_as_stored ~ "198")
--			assert (s + " as_stored", n.out ~ "1,1,1,1,1")
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
			x := n.zero_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out + ")"
			io.put_string (str)
			n.scalar_multiply (x)
			io.put_string (":  " + n.out_as_stored + " %N")
			assert (str, n.out_as_stored ~ "0")
				-- by zero
			n.set_with_array (<<7,9,3,5>>)
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out + ")"
			io.put_string (str)
			n.scalar_multiply (x)
			io.put_string (":  " + n.out_as_stored + " %N")
			assert (str, n.out_as_stored ~ "0")
				-- (255,255).scalar_multiply (255)
			n.set_with_array (<<255,255>>)
			x := n.max_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out + ")"
			io.put_string (str)
			n.scalar_multiply (x)
			io.put_string (":  " + n.out_as_stored + " %N")
			assert (str, n.out_as_stored ~ "254,255,1")
				-- (255,255,255).scalar_multiply (255)
			n.set_with_array (<<255,255,255>>)
			x := n.max_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out + ")"
			io.put_string (str)
			n.scalar_multiply (x)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "254,255,255,1")

				-- (7,9,3,5).scalar_multiply (6), default base
				-- (14,827,909).scalar_multiply (6) = 88,967,454
			n.set_with_array (<<7,9,3,5>>)
			x := n.six_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out + ")"
			io.put_string (str)
			n.scalar_multiply (x)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "42,54,18,30")
				-- (-1,2,3,4,5,6,7,8,9 base 15).scalar_multiply (3)
				-- (2,942,093,829).scalar_multiply (3) = 8,826,281,487
--			create n.make_with_base (n.sixteen_digit - n.one_digit)
--			n.set_with_array (<<1,2,3,4,5,6,7,8,9>>)
--			n.set_is_negative (true)
--			x := n.three_digit
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + "(" + x.out + ")"
--			io.put_string (str)
--			n.scalar_multiply (x)
--			io.put_string (":  " + n.out_as_stored + "%N")
--			assert (str, n.out_as_stored ~ "-2,14,22,94,15")
--				-- (963 base 10).scalar_multiply (30)
--				-- (963).scalar_multiply (30) = 28,990
--			create n.make_with_base (n.ten_digit)
--			n.set_with_array (<<9,6,3>>)
--			x := n.ten_digit * n.three_digit
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + "(" + x.out + ")"
--			io.put_string (str)
--			n.scalar_multiply (x)
--			io.put_string (":  " + n.out_as_stored + "%N")
--			assert (str, n.out_as_stored ~ "112,218")
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
			fac := n.seven_digit
			s := "(" + n.out_as_stored + ")" + str
			s := s + "(" + fac.out + ")"
			io.put_string (s)
			p := n.scalar_product (fac)
			io.put_string (" = " + p.out_as_stored + "%N")
			assert (s, p.out_as_stored ~ "0")
				-- Multiply by zero
			fac := n.zero_digit
			s := "(" + n.out_as_stored + ")" + str
			s := s + "(" + fac.out + ")"
			io.put_string (s)
			p := n.scalar_product (fac)
			io.put_string (" = " + p.out_as_stored + "%N")
			assert (s, p.out_as_stored ~ "0")
				-- (1,2,3) max_base).scalar_product (81) = 66,051 * 81 = 5,350,131
			n.set_with_array (<<1,2,3>>)
			fac := n.nine_digit * n.nine_digit
			s := "(" + n.out_as_stored + ")" + str
			s := s + "(" + fac.out + ")"
			io.put_string (s)
			p := n.scalar_product (fac)
			io.put_string (" = " + p.out_as_stored + "%N")
			assert (s, p.out_as_stored ~ "81,162,243")
		end

	simple_product
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
			-- "https://defuse.ca/big-number-calculator.htm".
		local
			str, s: STRING_8
			n: like testable_number_anchor
			fac: like testable_number_anchor
		do
			str := ".simple_product "
			create n.from_string ("6648")
			create fac.from_string ("3995")
			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
			io.put_string (s)
			n := n.simple_product (fac)
			io.put_string (":  " + n.out + "%N")
			assert (s, n.out ~ "26558760")

		end

	multiply_helper
			-- Run some smaller tests discovered during a multiply test
			-- in order to debug the failing of a larger number test.
		local
			str, s: STRING_8
			a, b, n: like number_anchor
			fac: like number_anchor
		do
--			str := ".multiply_helper "
--				-- Is subtraction in karatsuba multiply getting wrong results.
--				-- Seems to be fixed now.
--			create a.from_string ("2,140,209,225")
--			create b.from_string ("74,852,190")
--			s := "(" + a.out + ")" + " - " + " (" + b.out + ")"
--			io.put_string (s)
--			n := a - b
--			io.put_string (" =  " + n.out + "%N")
--			assert (s, n.out ~ "2065357035")
--				-- (133,078,485).multiply (2,416,522,490)
--			create n.from_string ("133078485")
--			create fac.from_string ("2416522490")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s + "%N")
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "321587151937627650")
			Precursor
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
--			create n
--			create fac.make_with_array (<<99>>)
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "0")
--			assert (s + "  fac unchanged", fac.out ~ "99")
--				-- (99).multiply (0)
--			create n.make_with_array (<<99>>)
--			create fac
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "0")
--			assert (s + "  fac unchanged", fac.out ~ "0")
--				-- (5).multiply (9)
--			create n.make_with_array (<<5>>)
--			create fac.make_with_array (<<9>>)
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "45")
--			assert (s + "  fac unchanged", fac.out ~ "9")
--				-- (<<2,1>>).multiply (<<44>>) = <<88,44>>
--				-- (513).multiply (44) = 22,572
--			create n.make_with_array (<<2,1>>)
--			create fac.make_with_array (<<44>>)
--			s := "(" + n.out_as_stored + ")" + str + " (" + fac.out_as_stored + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out_as_stored + "%N")
----			assert (s, n.out ~ "1,4,7,6")
--			assert (s, n.out_as_stored ~ "88,44")
--				-- (<<1,2,3>>).multiply (<<1,2>>)
--				-- (66,051).multiply (258) = 17,041,158
--			create n.make_with_array (<<1,2,3>>)
--			create fac.make_with_array (<<1,2>>)
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "17041158")
--			assert (s, n.out_as_stored ~ "1,4,7,6")
--				-- (333) * (22) = 7326, length differs by one digit.
--			create n.make_with_base (n.ten_digit)
--			create fac.make_with_base (n.ten_digit)
--			n.set_with_array (<<3,3,3>>)
--			fac.set_with_array (<<2,2>>)
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "    as_stored: " + n.out_as_stored + "%N")
--			assert (s, n.out ~ "7326")
--				-- (7777777) * (4444) = 7326
--			create n.from_string ("7,777,777")
--			create fac.from_string ("4,444")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "34564440988")
--				-- (4444) * (333) = 1,479,852
--			create n.from_string ("4,444")
--			create fac.from_string ("333")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "1479852")

				-- (55555) * (333) = 18,499,815.
			create n.from_string ("55,555")
			create fac.from_string ("333")
			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out_formatted + "%N")
			assert (s, n.out ~ "18499815")
--				-- (1111) * (11) = 12,221.
--			create n.from_string ("1,111")
--			create fac.from_string ("11")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "12221")

--				-- (4444) * (22) = 97,768, length differs by two digits.
--			create n.from_string ("4,444")
--			create fac.from_string ("22")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "97768")
--				-- (666666) * (4444) = 2,962,663,704
--			create n.from_string ("666,666")
--			create fac.from_string ("4,444")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "2962663704")

--				-- (38374651928376).multiply (99573650866570) = 3821104193242259013972790320
--			create n.from_string ("38,374,651,928,376")
--			create fac.from_string ("99,573,650,866,570")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "3821104193242259013972790320")
				-- (-84736487483757564869490010293).multiply (57849399340004949681221)
				--      = -4901954903117222552481914443941818610639794358807753
			create n.from_string ("84,736,487,483,757,564,869,490,010,293")
			n.set_is_negative (true)
			create fac.from_string ("57,849,399,340,004,949,681,221")
			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
			io.put_string (s)
			n.multiply (fac)
			io.put_string (":  " + n.out + "%N")
			assert (s, n.out ~ "-4901954903117222552481914443941818610639794358807753")
--				-- (76830098273758661872848373648940382626284094938726398738889685720002828459).multiply
--				-- (958373849585736872304958798457775894021348798874729875798378793871119847467)
--				--      =
--			create n.from_string ("76830098273758661872848373648940382626284094938726398738889685720002828459")
--			create fac.from_string ("958373849585736872304958798457775894021348798874729875798378793871119847467")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			io.put_string ("   count = " + n.count.out + "    digit count = " + n.out.count.out)
--			io.put_string ("   bit_count = " + n.bit_count.out + "%N")
--			assert (s, n.out ~ "73631957046672565937925257190591320772352409826806244996676386%
--								%046169314383746193055493848375509280946999333549270158045540%
--								%510952030901985012646663353")


--			create n.from_string ("2113437065")
--			create fac.from_string ("5821885")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "12304187547167525")


--					-- 250 digits * 300 digits
--				-- (83538405938488853094850398200983583094850394859389
--				--  84983453847598347598370284538474019766117463655588
--				--  36346464647850001918847326255742816363288173654627
--				--  88573746549509289374578585858399020002882618937378
--				--  75867266647389001839253647618277365008917283945943).multiply
--				-- (57758698746572221826111119200011102485746373948473
--				--  39485729874528347587283475498234759238745982734598
--				--  39487539847587276340976823049839485729939283576239
--				--  74827364263562535555428736427784923864863874964687
--				--  63487268762834687573549273049273747277759283748273
--				--  25345726354827368765032648284592774083464597984375)
--				--      =
--			create n.from_string ("83538405938488853094850398200983583094850394859389%
--									%84983453847598347598370284538474019766117463655588%
--									%36346464647850001918847326255742816363288173654627%
--									%88573746549509289374578585858399020002882618937378%
--									%75867266647389001839253647618277365008917283945943")
--			create fac.from_string ("57758698746572221826111119200011102485746373948473%
--										%39485729874528347587283475498234759238745982734598%
--										%39487539847587276340976823049839485729939283576239%
--										%74827364263562535555428736427784923864863874964687%
--										%63487268762834687573549273049273747277759283748273%
--										%25345726354827368765032648284592774083464597984375")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--				-- Avoid multiple calls to n.out.
--			str := n.out
--			io.put_string (":  " + str.out + "%N")
--			io.put_string ("   count = " + n.count.out + "    digit count = " + str.count.out)
--			io.put_string ("   bit_count = " + n.bit_count.out + "%N")
--			assert (s, n.out ~ "4825069622370037571581047969665419797448540415%
--								%208614127393061696951534481046543312526107740%
--								%616881520201220721059058189474027364333280490%
--								%731711579833565141687110565609766141768385838%
--								%181800093879499351395375019465741496786437615%
--								%905097167960518223578143659640699463848834083%
--								%895169532864836580469168509063847997004568761%
--								%222855410335418261681974960860689195201798823%
--								%225258887886846265059106530177085061334147253%
--								%968350106247237989343625852064639555650237796%
--								%312026892273677206316139551013377145009476245%
--								%658014645173303892209806200718548107417653664%
--								%258640625")
		end

	product
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
			-- "https://defuse.ca/big-number-calculator.htm".
		local
			fn, str, s: STRING_8
			n: like number_anchor
			a, b: like number_anchor
		do
			fn := ".product"
			str := generating_type + "fn" + ":  "
				-- (<<1,2>>).multiply (<<44>>) = <<44,88>>
				-- (258).multiply (44) = 11,352
			create a.make_with_array (<<1,2>>)
			create b.make_with_array (<<44>>)
			s := "(" + a.out_as_stored + ")" + fn + " (" + b.out_as_stored + ")"
			io.put_string (s)
			n := a.product (b)
			io.put_string (" = " + n.out_as_stored + "%N")
--			assert (s, n.out ~ "1,4,7,6")
			assert (s, n.out_as_stored ~ "44,88")
				-- (<<2,1>>).multiply (<<44>>) = <<88,44>>
				-- (513).multiply (44) = 22,572
			create a.make_with_array (<<2,1>>)
			create b.make_with_array (<<44>>)
			s := "(" + a.out_as_stored + ")" + fn + " (" + b.out_as_stored + ")"
			io.put_string (s)
			n := a.product (b)
			io.put_string (" = " + n.out_as_stored + "%N")
--			assert (s, n.out ~ "1,4,7,6")
			assert (s, n.out_as_stored ~ "88,44")
		end

feature -- Basic operations (addition implementation tests)

	mult_test_1
			-- Test cases discovered during muliply.
		local
			fn, str: STRING_8
			n: like testable_number_anchor
			x, y: like digit_anchor
			tup: TUPLE [carry, product: like digit_anchor]
		do
			create n
			tup := [n.zero_digit, n.zero_digit]
				-- Test case discovered during multiply.
				-- (...).digits_multiplied (203, 204, tup):  tup = [161,196] = 41,412
			fn := ".digits_multiplied"
			x := (n.ten_digit * n.ten_digit) * n.two_digit + n.three_digit
			y := (n.ten_digit * n.ten_digit) * n.two_digit + n.four_digit
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "161")
			assert (str + " product", tup.product.out ~ "196")
				-- (...).digits_multiplied (230, 204, tup)
			x := (n.ten_digit * n.ten_digit) * n.two_digit + (n.ten_digit * n.three_digit)
			y := (n.ten_digit * n.ten_digit) * n.two_digit + n.four_digit
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "183")
			assert (str + " product", tup.product.out ~ "72")
				-- (...).digits_multiplied (34, 204, tup)
			x := (n.ten_digit * n.three_digit) + n.four_digit
			y := (n.ten_digit * n.ten_digit) * n.two_digit + n.four_digit
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "27")
			assert (str + " product", tup.product.out ~ "24")
					--------------------------
				-- (...).digits_multiplied (203, 143)
			x := (n.ten_digit * n.ten_digit) * n.two_digit + n.three_digit
			y := (n.ten_digit * n.ten_digit) + (n.ten_digit * n.four_digit) + n.three_digit
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "113")
			assert (str + " product", tup.product.out ~ "101")
				-- (...).digits_multiplied (230, 143)
			x := (n.ten_digit * n.ten_digit) * n.two_digit + (n.ten_digit * n.three_digit)
			y := (n.ten_digit * n.ten_digit) + (n.ten_digit * n.four_digit) + n.three_digit
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "128")
			assert (str + " product", tup.product.out ~ "122")
				-- (...).digits_multiplied (34, 143)
			x := (n.ten_digit * n.three_digit) + n.four_digit
			y := (n.ten_digit * n.ten_digit) + (n.ten_digit * n.four_digit) + n.three_digit
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "18")
			assert (str + " product", tup.product.out ~ "254")
					--------------------------
				-- (...).digits_multiplied (203, 90)
			x := (n.ten_digit * n.ten_digit) * n.two_digit + n.three_digit
			y := (n.ten_digit * n.nine_digit)
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "71")
			assert (str + " product", tup.product.out ~ "94")
				-- (...).digits_multiplied (230, 90)
			x := (n.ten_digit * n.ten_digit) * n.two_digit + (n.ten_digit * n.three_digit)
			y := (n.ten_digit * n.nine_digit)
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "80")
			assert (str + " product", tup.product.out ~ "220")
				-- (...).digits_multiplied (34, 90)
			x := (n.ten_digit * n.three_digit) + n.four_digit
			y := (n.ten_digit * n.nine_digit)
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "11")
			assert (str + " product", tup.product.out ~ "244")

		end

	digits_added
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			n: like testable_number_anchor
			b: like digit_anchor
			x, y, c: like digit_anchor
			tup: TUPLE [sum, carry: like digit_anchor]
		do
			fn := ".digits_added"
				-- (n base b).digits_added (x, y, c)
			create n
			tup := [n.zero_digit, n.zero_digit]
				-- (0 base 0).digits_added (0, 0, 0)
			x := n.zero_digit
			y := n.zero_digit
			c := n.zero_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
			io.put_string (str + " = ")
			n.digits_added (x, y, c, tup)
			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
			assert (str + " sum", tup.sum.out ~ "0")
			assert (str + " carry", tup.carry.out ~ "0")
				-- (0 base 0).digits_added (10, 16, 0)
			x := n.ten_digit
			y := n.sixteen_digit
			c := n.zero_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
			io.put_string (str + " = ")
			n.digits_added (x, y, c, tup)
			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
			assert (str + " sum", tup.sum.out ~ "26")
			assert (str + " carry", tup.carry.out ~ "0")
				-- (0 base 0).digits_added (max_digit_value, 1, 0)
			x := n.max_digit
			y := n.one_digit
			c := n.zero_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
			io.put_string (str + " = ")
			n.digits_added (x, y, c, tup)
			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
			assert (str + " sum", tup.sum.out ~ "0")
			assert (str + " carry", tup.carry.out ~ "1")
				-- (0 base 0).digits_added (max_digit_value, max_digit_value, 0)
			x := n.max_digit
			y := n.max_digit
			c := n.zero_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
			io.put_string (str + " = ")
			n.digits_added (x, y, c, tup)
			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
			assert (str + " sum", tup.sum.out ~ (n.max_digit - n.one_digit).out)
			assert (str + " carry", tup.carry.out ~ "1")
				-- (0 base 0).digits_added (max_digit_value, max_digit_value, 1)
			x := n.max_digit
			y := n.max_digit
			c := n.one_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
			io.put_string (str + " = ")
			n.digits_added (x, y, c, tup)
			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
			assert (str + " sum", tup.sum.out ~ (n.max_digit).out)
			assert (str + " carry", tup.carry.out ~ "1")
--			------------ Test with a reduced base --------------		
--				-- (0 base 0).digits_added (max_digit_value, four_value, 1)
--			create n.make_with_base (n.eight_value)
--			x := n.max_digit_value
--			y := n.four_value
--			c := n.one_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
--			io.put_string (str + " = ")
--			n.digits_added (x, y, c, tup)
--			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
--			assert (str + " sum", tup.sum.out ~ "4")
--			assert (str + " carry", tup.carry.out ~ "1")
--				-- (0 base 0).digits_added (max_digit_value, max_digit_value, 1)
--			create n.make_with_base (n.eight_value)
--			x := n.max_digit_value
--			y := n.max_digit_value
--			c := n.one_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
--			io.put_string (str + " = ")
--			n.digits_added (x, y, c, tup)
--			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
--			assert (str + " sum", tup.sum.out ~ (n.max_digit_value).out)
--			assert (str + " carry", tup.carry.out ~ "1")
		end


	digits_multiplied
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			n: like testable_number_anchor
			b: like digit_anchor
			x, y: like digit_anchor
			tup: TUPLE [carry, product: like digit_anchor]
		do
			fn := ".digits_multiplied"
				-- (n base b).digits_multiplied (x, y, c, tup)
			create n
			tup := [n.zero_digit, n.zero_digit]
				-- (0 base 0).digits_multiplied (0, 0, tup)
			x := n.zero_digit
			y := n.zero_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.product.out + "] %N")
			assert (str + " sum", tup.product.out ~ "0")
			assert (str + " carry", tup.carry.out ~ "0")
				-- (0 base 0).digits_multiplied (10, 10, tup)
			x := n.ten_digit
			y := n.ten_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " product", tup.product.out ~ "100")
			assert (str + " carry", tup.carry.out ~ "0")
				-- (0 base 0).digits_multiplied (max_representable_value, 2, tup)
			x := n.max_digit
			y := n.two_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " product", tup.product = n.max_digit - n.one_digit)
			assert (str + " carry", tup.carry = n.one_digit)
				-- (0 base 0).digits_multiplied (max_representable_value, max_representable_value, tup)
			x := n.max_digit
			y := n.max_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " product", tup.product = n.one_digit)
			assert (str + " carry", tup.carry = n.max_digit - n.one_digit)
--				-- (0).digits_multiplied (99, max_representable_value, tup)
--			b := n.zero_digit
--			create n.make_with_base (b)
--			x := n.ten_digit * n.nine_digit + n.nine_digit
--			y := n.max_representable_digit
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + " (" + x.out + ", " + y.out + ")"
--			io.put_string (str + " = ")
--			n.digits_multiplied (x, y, tup)
--			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
--			assert (str + " carry", tup.carry.out ~ "98")
--			assert (str + " product", tup.product.out ~ "157")
				-- (...).digits_multiplied (255, 255, tup):  tup = [254,1] = 65,025
			create n
			x := n.max_digit
			y := n.max_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "254")
			assert (str + " product", tup.product.out ~ "1")


				-- Test case discovered during multiply.
				-- (...).digits_multiplied (203, 204, tup):  tup = [161,196] = 41,412
			create n
			x := (n.ten_digit * n.ten_digit) * n.two_digit + n.three_digit
			y := (n.ten_digit * n.ten_digit) * n.two_digit + n.four_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "161")
			assert (str + " product", tup.product.out ~ "196")
				-- (...).digits_multiplied (230, 204, tup)
			create n
			x := (n.ten_digit * n.ten_digit) * n.two_digit + (n.ten_digit * n.three_digit)
			y := (n.ten_digit * n.ten_digit) * n.two_digit + n.four_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "183")
			assert (str + " product", tup.product.out ~ "72")
				-- (...).digits_multiplied (34, 204, tup)
			create n
			x := (n.ten_digit * n.three_digit) + n.four_digit
			y := (n.ten_digit * n.ten_digit) * n.two_digit + n.four_digit
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.digits_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "27")
			assert (str + " product", tup.product.out ~ "24")


			--------------  reduced base  ----------------
--				-- (0 base 100).digits_multiplied (1, max_digit_value, tup)
--			b := n.ten_value * n.ten_value
--			create n.make_with_base (b)
--			x := n.one_value
--			y := n.max_digit_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + " (" + x.out + ", " + y.out + ")"
--			io.put_string (str + " = ")
--			n.digits_multiplied (x, y, tup)
--			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
--			assert (str + " carry", tup.carry.out ~ "0")
--			assert (str + " product", tup.product.out ~ "99")

--			b := n.max_base - n.one_value
--			create n.make_with_base (b)
--			x := n.base_minus_one_value
--			y := n.base_minus_one_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + " (" + x.out + ", " + y.out + ")"
--			io.put_string (str + " = ")
--			n.digits_multiplied (x, y, tup)
--			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
--			assert (str + " carry", tup.carry.out ~ "0")
--			assert (str + " product", tup.product.out ~ "99")
--				-- (0 base 100).digits_multiplied (99, 99, tup)
--			b := n.ten_value * n.ten_value
--			create n.make_with_base (b)
--			x := n.ten_value * n.nine_value + n.nine_value
--			y := n.ten_value * n.nine_value + n.nine_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + " (" + x.out + ", " + y.out + ")"
--			io.put_string (str + " = ")
--			n.digits_multiplied (x, y, tup)
--			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
--			assert (str + " product", tup.product = n.max_representable_value \\ b)
--			assert (str + " carry", tup.carry = n.max_representable_value // b)
		end

feature -- Basic operations (selectively exported)

	bit_shift_left
			-- Test and demonstrate feature `bit_shift_left' from
			-- {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			n: like testable_number_anchor
			b, v: like digit_anchor
			i: INTEGER
		do
			fn := ".bit_shift_left"
				-- (00000000).bit_shift_left (7)
			create n
			i := 7
			str := "(" + n.out_as_bits + ")" + fn
			str := str + " (" + i.out + ")"
			io.put_string (str + " = ")
			n.bit_shift_left (i)
			io.put_string (n.out_as_bits + "%N")
			assert (str, n.out_as_bits ~ "00000000")
				-- (00000111).bit_shift_left (2)
			v := n.seven_digit
			i := 2
			create n.make_with_value (n.seven_digit)
			str := "(" + n.out_as_bits + ")" + fn
			str := str + " (" + i.out + ")"
			io.put_string (str + " = ")
			n.bit_shift_left (i)
			io.put_string (n.out_as_bits + "%N")
			assert (str, n.out_as_bits ~ "00011100")
				-- (00011110, 010000001).bit_shift_left (3)
			i := 4
			create n.make_with_array (<<30,65>>)
			str := "(" + n.out_as_bits + ")" + fn
			str := str + " (" + i.out + ")"
			io.put_string (str + " = ")
			n.bit_shift_left (i)
			io.put_string (n.out_as_bits + "%N")
			assert (str, n.out_as_bits ~ "00000001,11100100,00010000")
				-- ([1,2,3,4]).bit_shift_left (7)
			i := 7
			create n.make_with_array (<<1,2,3,4>>)
			str := "(" + n.out_as_bits + ")" + fn
			str := str + " (" + i.out + ")"
			io.put_string (str + " = ")
			n.bit_shift_left (i)
			io.put_string (n.out_as_bits + "%N")
			assert (str, n.out_as_bits ~ "10000001,00000001,10000010,00000000")
			n.bit_shift_right (i)
			io.put_string (n.out_as_bits + "%N")
			assert (str, n.out_as_bits ~ "00000001,00000010,00000011,00000100")
			n.bit_shift_right (i)

--				-- (xxxx1111).bit_shift_left (4)
--			v := n.sixteen_value - n.one_value
--			b := n.sixteen_value
--			i := 1
--			create n.make_with_value_and_base (v, b)
--			str := "(" + n.out_as_bits + " base " + n.base.out + ")" + fn
--			str := str + " (" + i.out + ")"
--			io.put_string (str + " = ")
--			n.bit_shift_left (i)
--			io.put_string (n.out_as_bits + "%N")
--			assert (str, n.out_as_bits ~ "xxxx0001,xxxx1110")
--				-- (xxxxx001,xxxxx110).bit_shift_left (4)
--			b := n.eight_value
--			i := 3
--			create n.make_with_base (b)
--			n.set_with_array (<<1,6>>)
--			str := "(" + n.out_as_bits + " base " + n.base.out + ")" + fn
--			str := str + " (" + i.out + ")"
--			io.put_string (str + " = ")
--			n.bit_shift_left (i)
--			io.put_string (n.out_as_bits + "%N")
--			assert (str, n.out_as_bits ~ "xxxxx001,xxxxx110,xxxxx000")
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
			create n.make_with_value (n.one_digit)
			s := str + "(" + n.out_as_bits + ").normalize = "
			i := n.normalize
			io.put_string (s + n.out_as_bits + "  i = " + i.out + "%N")
			assert (s + " as_bits", n.out_as_bits ~ "10000000")
			assert (s + " i", i = 7)
				-- i := (x0000111).normalize
			create n.make_with_value (n.seven_digit)
			s := str + "(" + n.out_as_bits + ").normalize = "
			i := n.normalize
			io.put_string (s + n.out_as_bits + "  i = " + i.out + "%N")
			assert (s + " as_bits", n.out_as_bits ~ "11100000")
			assert (s + " i", i = 5)
				-- i := (xxxx0101).normalize
			create n.make_with_value (n.five_digit)
			s := str + "(" + n.out_as_bits + ").normalize = "
			i := n.normalize
			io.put_string (s + n.out_as_bits + "  i = " + i.out + "%N")
			assert (s + " as_bits", n.out_as_bits ~ "10100000")
			assert (s + " i", i = 5)
				-- (00011110, 010000001).normalize
			create n.make_with_array (<<30,65>>)
			io.put_string (str + "(" + n.out_as_bits + ").normalize = ")
			i := n.normalize
			io.put_string (n.out_as_bits + "  i = " + i.out + "%N")
			assert (str, n.out_as_bits ~ "11110010,00001000")
			assert (s + " i", i = 3)
		end

	as_full_digit
			-- Test and demonstrate feature `as_full_digit' from
			-- {JJ_BIG_NATURAL}.
		local
			fn, str, s: STRING_8
			n: like testable_number_anchor
			a, b: like digit_anchor
			d: like digit_anchor
		do
			create n
			fn := ".as_full_digit"
			str := generating_type + fn + ":  "
			a := n.sixteen_digit - n.three_digit
			b := n.two_digit
			s := str + fn + " (" + a.out + ", " + b.out + ") = "
			io.put_string (s)
			d := n.as_full_digit (a, b)
			io.put_string (d.out + "%N")
			assert (s, d.out ~ "210")
		end

	as_half_digits
			-- Test and demonstrat feature `as_half_digits' from
			-- {JJ_BIG_NATURAL_8}.
		local
			fn, str, s: STRING_8
			n: like testable_number_anchor
			tup: like digit_tuple_anchor
			a: like digit_anchor
		do
			create n
			fn := ".as_half_digits"
			str := generating_type + fn + ":  "
			a := n.max_digit - n.one_digit
			s := str + fn + " (" + a.out + ") = "
			io.put_string (s)
			tup := n.as_half_digits (a)
			s := "[" + tup.high.out + "," + tup.low.out + "]"
			io.put_string (s)
			assert (s, s ~ "[15,14]")
		end


	divide_two_digits_by_one
			-- Test and demonstrate feature `divide_two_digits_by_one' from
			-- {JJ_BIG_NATURAL}.
		local
			a, b, d: like digit_anchor
			fn, str, s: STRING_8
			n: like testable_number_anchor
			denom: like testable_number_anchor
			i: INTEGER_32
			tup: like tuple_anchor
		do
			fn := ".divide_two_digits_by_one"
			str := generating_type + fn + ":  "
				-- Must handle each `number_type' (i.e. bit-representation) differently
				-- in order to ensure we have two digits only.)
				-- This case has two digits.

				-- Here is a case that was failing in some calls.
			create n.make_with_array (<<251,240>>)
--			create denom.make_with_array (<<200>>)
--			s := str + " (" + n.out_as_stored + " / " + denom.out_as_stored + ")"
			a := n.max_digit - n.four_digit
			b := n.max_digit - n.sixteen_digit + n.one_digit
			d := n.two_digit * n.ten_digit * n.ten_digit
			s := str + " (" + a.out + ", " + b.out + ", " + d.out + ")"
			io.put_string (s + " = ")
--			tup := n.divide_two_digits_by_one (n, denom)
			tup := n.divide_two_digits_by_one (a, b, d)
			io.put_string ("[(" + tup.quot.out_as_stored + "), ("+ tup.rem.out_as_stored + ")] %N")
			assert (s + " quot", tup.quot.out_as_stored ~ "1,66")
			assert (s + " rem", tup.rem.out_as_stored ~ "96")

--				-- [110,36] / [200] = [[140], [196]]
--				-- 28,196 / 200 = 140 rem 196
--			create n.make_with_array (<<110,36>>)
--			create denom.make_with_array (<<200>>)
--			s := str + " (" + n.out_as_stored + " / " + denom.out_as_stored + ")"
--			io.put_string (s + " = ")
--			tup := n.divide_two_digits_by_one (n, denom)
--			io.put_string ("[(" + tup.quot.out_as_stored + "), ("+ tup.rem.out_as_stored + ")] %N")
--			assert (s + " quot", tup.quot.out_as_stored ~ "140")
--			assert (s + " rem", tup.rem.out_as_stored ~ "196")

--				-- [171,154] / [200] = [[219], [130]]
--				-- 43,930 / 200 = 219 rem 130
--			create n.make_with_array (<<171,154>>)
--			create denom.make_with_array (<<200>>)
--			s := str + " (" + n.out_as_stored + " / " + denom.out_as_stored + ")"
--			io.put_string (s + " = ")
--			tup := n.divide_two_digits_by_one (n, denom)
--			io.put_string ("[(" + tup.quot.out_as_stored + "), ("+ tup.rem.out_as_stored + ")] %N")
--			assert (s + " quot", tup.quot.out_as_stored ~ "219")
--			assert (s + " rem", tup.rem.out_as_stored ~ "130")


--				-- 356 / 50 = [7, rem 6]
--			create n.make_with_array (<<1,100>>)
--			create denom.make_with_array (<<50>>)
----			if not denom.is_normalized then
----				denom.set_unstable
----				n.set_unstable
----				i := denom.normalize
----				n.bit_shift_left (i)
----				check
----					denom_is_noramlized: denom.is_normalized
----				end
----			end
--			s := str + "356/50  -- (" + n.out_as_bits + " / " + denom.out_as_bits + ")"
--			io.put_string (s + " = ")
--			tup := n.divide_two_digits_by_one (n, denom)
--			io.put_string ("[(" + tup.quot.out_as_stored + "), ("+ tup.rem.out_as_stored + ")] %N")
--			assert (s + " quot", tup.quot.out_as_stored ~ "7")
--			assert (s + " rem", tup.rem.out_as_stored ~ "6")
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

	quotient
		local
			fn, str, s: STRING_8
			n, a, b: like testable_number_anchor
			tup: like tuple_anchor
			i: INTEGER_32
		do
			fn := ".quotient"
			str := generating_type + fn + ":  "
			create n
				-- (0).quotient (1)
			create a
			create b.make_with_value (a.one_digit)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[(" + tup.quot.out_as_stored + "), (" + tup.rem.out_as_stored + ")] %N")
			assert (s + " quot", tup.quot.is_zero)
			assert (s + " rem", tup.rem.is_zero)
				-- (0).quotient (-1)
			create a
			create b.make_with_value (a.one_digit)
			b.negate
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[(" + tup.quot.out_as_stored + "), (" + tup.rem.out_as_stored + ")] %N")
			assert (s + " quot", tup.quot.is_zero)
			assert (s + " rem", tup.rem.is_zero)
				-- (9).quotient (1,1)   9/257 = 0 remainder 9
				--       count < other.count
			create a.make_with_value (n.nine_digit)
			create b.make_with_array (<<1,1>>)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[(" + tup.quot.out_as_stored + "), (" + tup.rem.out_as_stored + ")] %N")
			assert (s + " quot", tup.quot.is_zero)
			assert (s + " rem", tup.rem ~ a)
				-- (160).quotient (1)
			create a.make_with_value (n.sixteen_digit * n.ten_digit)
			create b.make_with_value (a.one_digit)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[(" + tup.quot.out_as_stored + "), (" + tup.rem.out_as_stored + ")] %N")
			assert (s + " quot", tup.quot ~ a)
			assert (s + " rem", tup.rem.is_zero)
				-- (1,2).quotient (-1)	 258/-1 = -258
			create a.make_with_array (<<1,2>>)
			create b.make_with_value (a.one_digit)
			b.negate
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[(" + tup.quot.out_as_stored + "), (" + tup.rem.out_as_stored + ")] %N")
			assert (s + " quot", tup.quot ~ a.opposite)
			assert (s + " rem", tup.rem.is_zero)
				-- Same magnitudes
				-- (4,1).quotient (4,1)		-- 4 * 256^1 + 1 = 1025
			create a.make_with_array (<<4,1>>)
			create b.make_with_array (<<4,1>>)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[(" + tup.quot.out_as_stored + "), (" + tup.rem.out_as_stored + ")] %N")
			assert (s + " quot", tup.quot.is_one)
			assert (s + " rem", tup.rem.is_zero)
				-- (1,2,3).quotient (-1,2,3)		66,049 / -66,049 = -1 rem 0
			create a.make_with_array (<<1,2,3>>)
			create b.make_with_array (<<1,2,3>>)
			b.negate
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[(" + tup.quot.out_as_stored + "), (" + tup.rem.out_as_stored + ")] %N")
			assert (s + " quot", tup.quot.is_one)
			assert (s + " neg quot", tup.quot.is_negative)
			assert (s + " rem", tup.rem.is_zero)
				-- Two-by-one divide case, requiring normalization.
				-- (1,2,3,4).quotient (1,44)	= (219) rem (79)
				--	16,843,009 / 300 = 56,143 rem 109
			create a.make_with_array (<<1,2,3,4>>)
			create b.make_with_array (<<1,44>>)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[(" + tup.quot.out_as_stored + "), (" + tup.rem.out_as_stored + ")] %N")
			assert (s + " quot", tup.quot.out_as_stored ~ "220,43")
			assert (s + " rem", tup.rem.out_as_stored ~ "160")
				-- X-by-one divide case, requiring conditioning.
				-- (1,2,3).quotient (1,44)	= (220) rem (51)
				--	66,051 / 300 = 220 rem 51
			create a.make_with_array (<<1,2,3>>)
			create b.make_with_array (<<1,44>>)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[(" + tup.quot.out_as_stored + "), (" + tup.rem.out_as_stored + ")] %N")
			assert (s + " quot", tup.quot.out_as_stored ~ "220")
			assert (s + " rem", tup.rem.out_as_stored ~ "51")
		end

	quotient_failing
			-- Test a test that was failing during timing tests.
		local
			fn, str, s: STRING_8
			n, a, b: like testable_number_anchor
			tup: like tuple_anchor
			i: INTEGER_32
		do
			fn := ".quotient_failing"
			str := generating_type + fn + ":  "
			create n
				-- Failing during speed test.
			create a.from_string ("60,889")
			create b.from_string ("190")
			s := str + "(60,889)" + fn + " (190):  "
			s := s + "[" + a.out_as_stored + "]" + fn + " [" + b.out_as_stored + "] = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string (tup.quot.out + " remainder " + tup.rem.out + "%N")
			assert (s + " quot", tup.quot.out ~ "320")
			assert (s + " rem", tup.rem.out ~ "89")
				-- Failing during speed test.
			create a.from_string ("672,057")
			create b.from_string ("2639")
			s := str + "(672,057)" + fn + " (2639):  "
			s := s + a.out_as_stored + fn + b.out_as_stored + " = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string (tup.quot.out + ", " + tup.rem.out + " %N")
			assert (s + " quot", tup.quot.out ~ "254")
			assert (s + " rem", tup.rem.out ~ "1751")
				-- Failing during out.
			create a.make_with_array (<<1,8,187>>)
			create b.make_with_value (100)
			s := str + "(67,771)" + fn + "(100) = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[(" + tup.quot.out + "), (" + tup.rem.out + ")] %N")
			assert (s + " quot", tup.quot.out ~ "677")
			assert (s + " rem", tup.rem.out ~ "71")
				-- 586,156 / 74,055 = 7 rem 67,771
			create a.from_string ("586156")
			create b.from_string ("74055")
--			s := str + "(" + a.out + ")" + fn + "(" + b.out + ") = "
					--- temp line to prevent calls to `out'.
			s := str + "(586156)" + fn + "(74055) = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[(" + tup.quot.out + "), (" + tup.rem.out + ")] %N")
			assert (s + " quot", tup.quot.out ~ "7")
			assert (s + " rem", tup.rem.out ~ "67771")
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
			n.set_value (n.one_digit)
			p := n.ten_to_the_power (n)
			s := str + "ten_to_the_power (" + n.out_formatted + ") = "
			io.put_string (s  +  p.out_formatted)
			io.put_string ("  count = " + t.count.out + "%N")
			assert (s, p.out_formatted ~ "10")
			assert (s + "  count", t.count = 2)
				-- 10 to 8th power
			n.set_value (n.eight_digit)
			p := n.ten_to_the_power (n)
--			s := str + "ten_to_the_power (" + n.out_formatted + ") = "
			s := str + "ten_to_the_power (" + n.out_as_stored + ") = "
--			io.put_string (s  +  p.out_formatted)
			io.put_string (s  +  p.out_as_stored)
			io.put_string ("  count = " + t.count.out + "%N")
			assert (s, p.out_as_stored ~ "5,245,225,0")
--			assert (s, p.out_formatted ~ "100,000,000")
--			assert (s + "  count", t.count = 9)
				-- 10 to 4th power
			n.set_value (n.four_digit)
			p := n.ten_to_the_power (n)
			s := str + "ten_to_the_power (" + n.out_formatted + ") = "
--			io.put_string (s  +  p.out_formatted)
			io.put_string (s  +  p.out_as_stored + "%N")
--			assert (s, p.out_formatted ~ "10,000")
			assert (s, p.out_as_stored ~ "39,16")
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

	partition
			-- Test the `partition' feature.
		local
			str, s: STRING_8
			n, sn: like testable_number_anchor
			a: ARRAY [like digit_anchor]
			i: INTEGER
		do
			set_verbose
			str := ".partition:  "
			a := <<1, 2, 3, 4, 5, 6, 7, 8, 9>>
			create n.make_with_array (a)
				-- Get the low three bits.
			s := str + "partition (3, 1) of " + n.out_as_stored
			sn := n.partition (3, 1)
			io.put_string (s + " = " + sn.out_as_stored + "%N")
			assert (s, sn.out_as_stored ~ "7,8,9")
				-- Get some other bits.
			s := str + "partition (8, 4) of " + n.out_as_stored
			sn := n.partition (8, 4)
			io.put_string (s + " = " + sn.out_as_stored + "%N")
			assert (s, sn.out_as_stored ~ "2,3,4,5,6")
		end

feature -- Factory access

	new_number: JJ_BIG_NATURAL_8
			-- Factory and anchor for new big numbers.
		do
			create Result
		end

	new_number_from_string (a_string: STRING_8): JJ_BIG_NATURAL_8
			-- Create a new big number from the contents of `a_string'.
		do
			create Result.from_string (a_string)
		end

feature {NONE} -- Anchors

	digit_anchor: NATURAL_8
			-- Anchor for declaring an entity to represent a digit.
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
