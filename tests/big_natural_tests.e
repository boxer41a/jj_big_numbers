note
	description: "[
		This class tests {JJ_BIG_NATURAL} and its four descendents:
		{JJ_BIG_NATURAL_8}, {JJ_BIG_NATURAL_16}, {JJ_BIG_NATURAL_32}, and
		{JJ_BIG_NATURAL_64}.

		In addition to running assert statements, each test feature prints
		information pertinant to that test, so that these features can be
		called from {BIG_NUMBER_DEMO} to print demonstration values.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	BIG_NATURAL_TESTS

inherit

	EQA_TEST_SET

feature -- Status report

	is_verbose: BOOLEAN
			-- Should the report features print extra information?

feature -- Status setting

	set_verbose
			-- Ensure `is_verbose', so `report' features print extra information.
		do
			is_verbose := true
		end

	set_terse
			-- Ensure not `is_verbose', so `report' features print less.
		do
			is_verbose := false
		end

feature -- Basic operations (initialization tests)

	default_create_test
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		deferred
		end

	make_with_value
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		deferred
		end

--	make_with_base
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	make_with_value_and_base
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

	from_string
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		deferred
		end

	make_with_array
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		deferred
		end

	make_random
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		deferred
		end

feature -- Basic operations (constants tests)

	zero_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".zero_digit:  "
			n := new_number
			v := n.zero_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "0")
		end

	one_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".one_digit:  "
			n := new_number
			v := n.one_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "1")
		end

	two_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".two_digit:  "
			n := new_number
			v := n.two_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "2")
		end

	three_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type +".three_digit:  "
			n := new_number
			v := n.three_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "3")
		end

	four_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".four_digit:  "
			n := new_number
			v := n.four_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "4")
		end

	five_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".five_digit:  "
			n := new_number
			v := n.five_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "5")
		end

	six_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".six_digit:  "
			n := new_number
			v := n.six_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "6")
		end

	seven_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".seven_digit:  "
			n := new_number
			v := n.seven_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "7")
		end

	eight_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".eight_digit:  "
			n := new_number
			v := n.eight_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "8")
		end

	nine_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".nine_digit:  "
			n := new_number
			v := n.nine_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "9")
		end

	ten_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".ten_digit:  "
			n := new_number
			v := n.ten_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "10")
		end

	sixteen_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".sixteen_digit:  "
			n := new_number
			v := n.sixteen_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "16")
		end

	max_digit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".max_digit:  "
			n := new_number
			v := n.max_digit
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ (n.zero_digit - n.one_digit).out)
		end

	default_karatsuba_threshold
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			i: INTEGER
		do
			str := generating_type + ".default_karatsuba_threshold:  "
			n := new_number
			i := n.default_karatsuba_threshold
			io.put_string (str + i.out + "%N")
			assert (str, i.out ~ "4")
		end

feature -- Basic operations (Access)

--	base
--			-- Tests and demonstrates the corresponding feature
--			-- from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	min_base
--			-- Tests and demonstrates the corresponding feature
--			-- from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	zero
--			-- Tests and demonstrates the corresponding feature
--			-- from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	one
--			-- Tests and demonstrates the corresponding feature
--			-- from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	karatsuba_threshold
--			-- Tests and demonstrates the corresponding feature
--			-- from {JJ_BIG_NATURAL}.
--		deferred
--		end

feature -- Basic operations (element change tests)

--	set_karatsuba_threshold
--			-- Test the corresponging feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	set_value
--			-- Test the corresponging feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	set_with_string
--			-- Test the corresponging feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	set_base
--			-- Test the corresponging feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	set_value_and_base
--			-- Test the corresponging feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	set_with_array
--			-- Test the corresponging feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

feature -- Basic operations (conversion tests)

--	to_base
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	as_base
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

feature -- Basic operations (status setting tests)

--	set_is_negative
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

feature -- Basic operations (status report tests)

--	is_zero
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	is_one
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	is_base
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	is_negative
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	is_same_sign
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	divisible
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

feature -- Basic operations (basic operations tests)

--	negate
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	identity
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	opposite
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	scalar_add
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end


--	scalar_sum
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	add
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	plus
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	subtract
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	minus
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	simple_add
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	simple_subtract
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

feature -- Basic operations (multiply)

	multiply_helper
			-- Run some smaller tests discovered during a multiply test
			-- in order to debug the failing of a larger number test.
		local
			str, s: STRING_8
			a, b, n: like new_number
			fac: like new_number
		do
			str := ".multiply_helper "
				-- Is subtraction in karatsuba multiply getting wrong results.
				-- Seems to be fixed now.
			a := new_number_from_string ("2,140,209,225")
			b := new_number_from_string ("74,852,190")
			s := "(" + a.out + ")" + " - " + " (" + b.out + ")"
			io.put_string (s)
			n := a - b
			io.put_string (" =  " + n.out + "%N")
			assert (s, n.out ~ "2065357035")
				-- (133,078,485).multiply (2,416,522,490)
			n := new_number_from_string ("133078485")
			fac := new_number_from_string ("2416522490")
			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
			io.put_string (s + "%N")
			n.multiply (fac)
			io.put_string (":  " + n.out + "%N")
			assert (s, n.out ~ "321587151937627650")
		end


--	scalar_multiply
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	scalar_product
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

	multiply
			-- Test and demonstrate the `multiply', `product', and `*' features
			-- from {JJ_BIG_NATURAL}.  I checked the calculations at
			-- "https://defuse.ca/big-number-calculator.htm".
		deferred
		end

feature -- Basic operations (selectively exported)

--	bit_shift_left
--			-- Test and demonstrate feature `bit_shift_left' from
--			-- {JJ_BIG_NATURAL}.
--		deferred
--		end

--	normalize
--			-- Test and demonstrate feature `normalize' from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	divide_two_digits_by_one
--			-- Test and demonstrate feature `divide_two_digits_by_one' from
--			-- {JJ_BIG_NATURAL}.
--		deferred
--		end

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
		deferred
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

feature -- Basic operations (tests implementation features)

--	power_of_ten_table
--			-- Tests the existence of the `power_of_ten_table'.
--			-- This test feature must be called before any math operations
--			-- that access the `power_of_ten_table'.
--		deferred
--		end

--	ten_to_the_power
--			-- Tests the intended once-ness of the `power_of_ten_table'
--			-- somewhat tests its memoization usage.
--			-- This test feature must be called before any math operations
--			-- that access the `power_of_ten_table'.
--		deferred
--		end

--	new_value_from_character
--			-- Tests the `new_value_from_character' feature.
--		deferred
--		end

--	bits_utilized
--			-- Tests the `bits_utilized' feature, which gives the
--			-- number of bits used for representing numbers given
--			-- a specific `base'.
--		deferred
--		end

--	new_big_number
--			-- Tests the `new_big_number' feature.
--		deferred
--		end

--	new_sub_number
--			-- Test the `new_sub_number' feature.
--		deferred
--		end

feature {NONE} -- Implementation

	report (a_comment: STRING_8; a_number: like number_anchor)
			-- Display some information (for demo) about `a_number'.
		do
			print (a_number.generating_type + a_comment + "%N")
			print ("           base = " + a_number.base.out + "%N")
			print ("          count = " + a_number.count.out + "%N")
--			print ("    digit_count = " + a_number.as_base (a_number.ten_value).count.out + "%N")
			if is_verbose then
				print ("      as_stored = " + a_number.out_as_stored + "%N")
				print ("        as_bits = " + a_number.out_as_bits + "%N")
--				print ("            out = " + a_number.out + "%N")
			end
			print ("  out_formatted = " + a_number.out_formatted + "%N")
		end

	report_properties (a_comment: STRING_8; a_number: like number_anchor)
			-- Display verbose information (for demo) about `a_number'.
		do
			print (a_number.generating_type + a_comment + "  report_properties %N")
			print ("                 base: " + a_number.base.generating_type + " = " + a_number.base.out + "%N")
--			print ("             min_base: " + a_number.min_base.generating_type + " = " + a_number.min_base.out + "%N")
--			print (" base_minus_one_value: " + a_number.base_minus_one_value.generating_type + " = " + a_number.base_minus_one_value.out + "%N")
			print ("         max_dig_value: " + a_number.max_digit.generating_type + " = " + a_number.max_digit.out + "%N")
--				print ("            max_value: " + a_number.max_value.generating_type + " = " + a_number.max_value.out + "%N")
			print ("                 zero: " + a_number.zero.generating_type + " = " + a_number.zero.out + "%N")
			print ("                  one: " + a_number.one.generating_type + " = " + a_number.one.out + "%N")
			print ("  karatsuba_threshold: " + a_number.karatsuba_threshold.generating_type + " = " + a_number.karatsuba_threshold.out + "%N")
			print ("           zero_value: " + a_number.zero_digit.generating_type + " = " + a_number.zero_digit.out + "%N")
			print ("            one_value: " + a_number.one_digit.generating_type + " = " + a_number.one_digit.out + "%N")
			print ("            two_value: " + a_number.two_digit.generating_type + " = " + a_number.two_digit.out + "%N")
			print ("          three_value: " + a_number.three_digit.generating_type + " = " + a_number.three_digit.out + "%N")
			print ("           four_value: " + a_number.four_digit.generating_type + " = " + a_number.four_digit.out + "%N")
			print ("           five_value: " + a_number.five_digit.generating_type + " = " + a_number.five_digit.out + "%N")
			print ("            six_value: " + a_number.six_digit.generating_type + " = " + a_number.six_digit.out + "%N")
			print ("          seven_value: " + a_number.seven_digit.generating_type + " = " + a_number.seven_digit.out + "%N")
			print ("          eight_value: " + a_number.eight_digit.generating_type + " = " + a_number.eight_digit.out + "%N")
			print ("           nine_value: " + a_number.nine_digit.generating_type + " = " + a_number.nine_digit.out + "%N")
			print ("            ten_value: " + a_number.ten_digit.generating_type + " = " + a_number.ten_digit.out + "%N")
			print ("        sixteen_value: " + a_number.sixteen_digit.generating_type + " = " + a_number.sixteen_digit.out + "%N")
			print ("                  out: " + a_number.out + "%N")
			print ("        out_formatted: " + a_number.out_formatted + "%N")
			print ("        out_as_stored: " + a_number.out_as_stored + "%N")
			print ("          out_as_bits: " + a_number.out_as_bits + "%N")
		end

--	report_tuple (a_comment: STRING_8; a_tuple: like tuple_anchor)
--			-- Display information about `a_tuple' which contains a quotient
--			-- and a remainder, likely resulting from some division operation.
--		do
--			print (a_tuple.generating_type + a_comment + "%N")
--			print ("  tuple:  [" + a_tuple.quot.out + ", " + a_tuple.rem.out + "] %N")
--		end

--	report_digit_tuple (a_comment: STRING_8; a_tuple: like digit_tuple_anchor)
--			-- Display information about `a_tuple' which contains a quotient
--			-- and a remainder, likely resulting from some division operation.
--		do
--			print (a_tuple.generating_type + a_comment + "%N")
--			print ("  tuple:  [" + a_tuple.quot.out + ", " + a_tuple.rem.out + "] %N")
--		end


feature -- Factory access

	new_number: JJ_BIG_NATURAL [like digit_anchor]
			-- Factory and anchor for new big numbers.
		deferred
		end

	new_number_from_string (a_string: STRING_8): like new_number
			-- Create a new big number from the contents of `a_string'.
		deferred
		end

feature {NONE} -- Anchors

--	number: like number_anchor
--			-- Used as handle to obtain values, etc.
--			-- Redefine as once.
--		deferred
--		end

	digit_anchor: JJ_NATURAL
			-- Anchor for declaring an entity to representi a digit.
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require
			never_called: false
		do
			check
				do_not_call: false then
					-- Because gives no info; simply used as anchor.
			end
		end

	number_anchor: JJ_BIG_NATURAL [like digit_anchor]
			-- Anchor when declaring numbers in descendants.
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require
			never_called: false
		do
			check
				do_not_call: false then
					-- Because gives no info; simply used as anchor.
			end
		end

	testable_number_anchor: TESTABLE_BIG_NATURAL [like digit_anchor]
			-- Anchor when declaring numbers for which access to
			-- all features is needed.
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require
			never_called: false
		do
			check
				do_not_call: false then
					-- Because gives no info; simply used as anchor.
			end
		end

	tuple_anchor: like number_anchor.quotient
			-- Anchor for typs involved in division.
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require
			never_called: false
		do
			check
				do_not_call: false then
					-- Because gives no info; simply used as anchor.
			end
		end

	digit_tuple_anchor: like number_anchor.as_half_digits
			-- Anchor for typs involved in division.
			-- Not to be called; just used to anchor types.
			-- Declared as a feature to avoid adding an attribute.
		require
			never_called: false
		do
			check
				do_not_call: false then
					-- Because gives no info; simply used as anchor.
			end
		end

end





