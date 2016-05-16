note
	description: "[
		This class tests {JJ_BIG_NATURAL} and its four descendents:
		{JJ_BIG_NATURAL_8}, {JJ_BIG_NATURAL_16}, {JJ_BIG_NATURAL_32}, and
		{JJ_BIG_NATURAL_64}.
		
		In addition to running assert statements, each test feature prints
		information pertinant to that test, so that these features can be
		called from a {BIG_NUMBER_DEMO} to print demonstration values.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	BIG_NATURAL_TESTS

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			number_type := natural_8_type
			last_type := 1		-- just check {NATURAL_8} for now
		end

feature -- Access

	number_type: INTEGER_32
			-- Identifies which type of {JJ_BIG_NATURAL} is currently
			-- being tested.  One of the number_type_contsants

	last_type: INTEGER_32
			-- The highest `number_type' to check of the 4 types as
			-- defined in the constants.

	new_number: JJ_BIG_NATURAL [JJ_NATURAL]
			-- Get a new default {JJ_BIG_NUMBER}, selecting the type to
			-- create based on the value of `number_type'.
			-- Also, serves as anchor.
		do
			inspect number_type
			when natural_8_type then
				create {JJ_BIG_NATURAL_8} Result
--			when natural_16_type then
--				create {JJ_BIG_NATURAL_16} Result
			when natural_32_type then
				create {JJ_BIG_NATURAL_32} Result
--			when natural_64_type then
--				create {JJ_BIG_NATURAL_64} Result
			else
				check
					should_not_happen: False then
						-- Because all types are covered above.
				end
			end
		end

	new_number_from_string (a_value: STRING_8): like new_number
			-- Get a new {JJ_BIG_NUMBER}, selecting the type to create
			-- based on the value of `number_type' and setting its
			-- value from `a_value'.
		do
			inspect number_type
			when natural_8_type then
				create {JJ_BIG_NATURAL_8} Result.from_string (a_value)
			else
				check
					should_not_happen: False then
						-- Because all types are covered above.
				end
			end
		end

feature -- Constants

	natural_8_type: INTEGER = 1

	natural_16_type: INTEGER = 2

	natural_32_type: INTEGER = 3

	natural_64_type: INTEGER = 4

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

	test_default_create
		local
			str, s: STRING_8
			i: INTEGER_32
			n: like new_number
		do
			str := ".test_default_create:  "
			from i := 1
			until i > last_type
			loop
				n := new_number
				report_properties (str, n)
				assert (str + "base_big_enough", n.base.as_integer_32 >= 2)
				assert (str + "base_at_max", n.base = n.max_base)
				assert (str + "count_is_one", n.count = 1)
				assert (str + "is_zero", n.is_zero)
				assert (str + "value = 0", n.out ~ "0")
				i := i + 1
			end
			io.new_line
		end

	make_with_base
		do
		end

	make_with_value
		do
		end

	make_with_value_and_base
		do
		end

	from_string
			-- Test the `from_string' feature;
		local
			str, s: STRING_8
			bn: like new_number
			e: STRING_8
			i: INTEGER
		do
			str := ".from_string:  "
				-- Base 10 number
			bn := new_number_from_string ("3852")
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
			bn := new_number_from_string ("852")
			s := str + "852 max_base"
			report (s, bn)
			assert (s + " base", bn.base.out ~ bn.max_base.out)
			assert (s + " out ", bn.out ~ "852")
			assert (s + " out_fomatted ", bn.out_formatted ~ "852")
				-- Negative number
			bn := new_number_from_string ("-1325839")
			s := str + "-1325839 max_base"
			report (s, bn)
			assert (s + " base", bn.base.out ~ bn.max_base.out)
			assert (s + " out ", bn.out ~ "-1325839")
			assert (s + " out_fomatted ", bn.out_formatted ~ "-1,325,839")
			io.new_line
		end

	from_array
		local
			n: like new_number
			str, s: STRING_8
		do
			n := new_number
			str := n.generating_type + ".from_array:  "
			s := str
			assert (s, false)
		end

	from_max
		local
			str, s: STRING_8
			bn: like new_number
			m: like new_number.base.max_value
			n: INTEGER_32
		do
			str := generating_type + ".from_max"
			bn := new_number
			m := bn.base.max_value - bn.base.one
			bn.set_value (m)
			s := m.out
			report (str, bn)
			assert (str, bn.out ~ m.out)
		end

feature -- Basic operations (element change tests)

	set_value
			-- Test the `set_value' feature.
			-- The argument to the `set_value' feature must be the
			-- same type as the elements in the {JJ_BIG_NATURAL}, so
			-- we use the xxx_value features from the big number.
		local
			str, s: STRING_8
			n: like new_number
		do
			str := ".set_value:  "
				-- zero
			n := new_number
			n.set_value (n.zero_value)
			s := str + "zero_value"
			report (s, n)
			assert (s, n.out ~ "0")
			assert (s, n.base = n.max_base)
				-- max_value
			n.set_value (n.max_digit)
			s := str + "max value"
			report (s, n)
			assert (s, n.out ~ n.max_digit.out)
			assert (s, n.base = n.max_base)
				-- 112, base 16
			n := new_number
			n.set_base (n.sixteen_value)
			n.set_value (n.sixteen_value * n.seven_value)
			s := str + "112 base 16"
			report (s, n)
			assert (s, n.base.out ~ "16")
			assert (s, n.out ~ "112")
			io.new_line
		end

feature -- Basic operations (conversion tests)

	as_base
		local
			n: like new_number
		do

		end


feature -- Basic operations (basic operations tests)

	scalar_add
			-- Test/demo the `scalar_add' and `scalar_sum' functions
			-- from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, p: like new_number
		do
			str := ".scalar_add:  "
			n := new_number
				-- add seven
			s := str + "scalar_add (7) = 7"
			n.scalar_add (n.seven_value)
			report (s, n)
			assert (s, n.out ~ "7")
				-- add max_digit
			s := str + "scalar_add (max_digit)"
			n.scalar_add (n.max_digit)
			report (s, n)
			assert (s, n.out ~ "134")
				-- add 111
			s := str + "scalar_add (111) "
			n.scalar_add (n.max_digit - n.sixteen_value)
			report (s, n)
			assert (s, n.out ~ "245")
				-- Change the base to 8
			s := str + "base change to 8"
			n.set_base (n.eight_value)
			report (s, n)
			assert (s, n.out ~ "245")
				-- Now add 119
			s := str + "scalar_add (119)"
			n.scalar_add (n.sixteen_value * n.seven_value)
			report (s, n)
			assert (s, n.out ~ "357")
				-- Negate and add 50
			s := str + "(-357).scalar_add (50)"
			n.negate
			p := n.scalar_sum (n.ten_value * n.five_value)
			report (s, p)
			assert (s, n.is_negative)
			assert (s + "  n unchaged", n.out ~ "-357")
			assert (s, p.out ~ "-307")
			io.new_line
		end

	scalar_multiply
			-- Test/demo the `scalar_multiply' and `scalar_product' functions
			-- from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, p: like new_number
		do
			str := ".scalar_multiply:  "
			n := new_number
				-- Multiply zero by anything
			s := str + "(0).scalar_multiply (16)"
			n.scalar_multiply (n.sixteen_value)
			report (s, n)
			assert (s, n.out ~ "0")
				-- Multiply by zero
			s := str + "(7935).scalar_multiply (0)"
			n := new_number_from_string ("7935")
			n.scalar_multiply (n.zero_value)
			report (s, n)
			assert (s, n.out ~ "0")
				-- Multiply 7935 by 96
			s := str + "(7935).scalar_multiply (96)"
			n := new_number_from_string ("7935")
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
			-- Test/demo the `add', `plus', and `+' features from {JJ_BIG_NATURAL}.
			-- I checked the calculations at "https://defuse.ca/big-number-calculator.htm".
		local
			str, s: STRING_8
			a, b: like new_number
			n: like new_number
		do
			str := ".add:  "
			n := new_number_from_string ("99")
			a := new_number_from_string ("101")
			n.add (a)
			s := str + "(99).add (101)"
			report (s, n)
			assert (s, n.out ~ "200")
				--  check "+" alias
			a := new_number_from_string ("83492018876")
			b := new_number_from_string ("99584738599403878")
			n := a + b
			s := str + a.out + " + " + b.out
			report (s, n)
			assert (s, n.out_formatted ~ "99,584,822,091,422,754")
			assert (s + "  a unchaged", a.out ~ "83492018876")
				-- negate a and call plus
			a.negate
			b := new_number_from_string ("83492018856")
			s := str + a.out + " + " + b.out
			n := a.plus (b)
			report (s, n)
			assert (s, n.out_formatted ~ "-20")
			assert (s + "  a unchaged", a.out ~ "-83492018876")
			io.new_line
		end


	minus
			-- Test/demo the `subtract', `minus', and `-' features from {JJ_BIG_NATURAL}.
			-- I checked the calculations at "https://defuse.ca/big-number-calculator.htm".
		local
			str, s: STRING_8
			a, b: like new_number
			n: like new_number
		do
			str := ".minus:  "
				-- minus test number one
			n := new_number_from_string ("1000")
			b := new_number_from_string ("99")
			s := str + "(" + n.out + ").subtract (" + b.out + ")"
			n.subtract (b)
			report (s, n)
			assert (s, n.out ~ "901")
				-- Minus test number two
			a := new_number_from_string ("578372618996743892774658921536")
			b := new_number_from_string ("578372618990119377281937921536")
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
			-- Test/demo the `multiply', `product', and `*' features from {JJ_BIG_NATURAL}.
			-- I checked the calculations at "https://defuse.ca/big-number-calculator.htm".
		local
			str, s: STRING_8
			a, b, n: like new_number
		do
			str := ".multiply:  "
				-- test multiply
			n := new_number_from_string ("5")
			b := new_number_from_string ("9")
			s := str + "(" + n.out + ").multiply (" + b.out + ")"
			n.multiply (b)
			report (s, n)
			assert (s, n.out ~ "45")
			assert (s + "  b unchanged", b.out ~ "9")
				-- test product
			a := new_number_from_string ("38374651928376")
			b := new_number_from_string ("99573650866570")
			s := str + "(" + a.out + ").product (" + b.out + ")"
			n := a.product (b)
			report (s, n)
			assert (s, n.out ~ "3821104193242259013972790320")
			assert (s + "  a unchanged", a.out ~ "38374651928376")
			assert (s + "  b unchanged", b.out ~ "99573650866570")
				-- star test with big values
			a := new_number_from_string ("-84736487483757564869490010293")
			b := new_number_from_string ("57849399340004949681221")
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

	divide_two_digits_by_one
			-- Test/demo the `divide_two_digits_by_one' feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n: like new_number
			high_d, low_d: like new_number.i_th
			div: like new_number.i_th
			tup: like new_number.divide_two_digits_by_one
		do
			str := ".divide_two_digits_by_one:  "
				-- Must handle each `number_type' (i.e. bit-representation) differently
				-- in order to ensure we have two digits only.)
			inspect number_type
			when natural_8_type then
					-- This case has two digits.
				n := new_number_from_string ("29")
				n.set_base (n.eight_value)
				div := n.five_value
				low_d := n.i_th (1)
				high_d := n.i_th (2)
				s := str + "43/10  -- (" + high_d.out + ", " + low_d.out + ", " + div.out + ")"
				tup := n.divide_two_digits_by_one (high_d, low_d, div)
				report_digit_tuple (s, tup)
				assert (s + "quot", tup.quot.out ~ "20")
				assert (s + "rem", tup.rem.out ~ "3")
					-- This case has only one digit even in eight bits.
				n := new_number_from_string ("98")
				div := n.ten_value
				low_d := n.i_th (1)
				high_d := n.zero_value
				s := str + "98/10  -- (" + high_d.out + ", " + low_d.out + ", " + div.out + ")"
				tup := n.divide_two_digits_by_one (high_d, low_d, div)
				report_digit_tuple (s, tup)
				assert (s + "quot", tup.quot.out ~ "9")
				assert (s + "rem", tup.rem.out ~ "8")
					-- This case has only one digit even in eight bits.
				n := new_number_from_string ("119")
				div := n.ten_value
				low_d := n.i_th (1)
				high_d := n.zero_value
				s := str + "119/10  -- (" + high_d.out + ", " + low_d.out + ", " + div.out + ")"
				tup := n.divide_two_digits_by_one (high_d, low_d, div)
				report_digit_tuple (s, tup)
				assert (s + "quot", tup.quot.out ~ "11")
				assert (s + "rem", tup.rem.out ~ "9")
			else

			end

		end

	scalar_divide
			-- Test/demo the `scalar_divide' feature from {JJ_BIG_NATURAL}
			-- I checked the calculations at "https://defuse.ca/big-number-calculator.htm".
		local
			str, s: STRING_8
			n: like new_number
			d: like new_number.digit
			tup: like new_number.scalar_divide
		do
			str := ".scalar_divide:  "
				-- test number one
			n := new_number_from_string ("8")
			d := n.eight_value
			s := str + "(" + n.out + ").scalar_divide (" + d.out + ")"
			tup := n.scalar_divide (d)
			report_tuple (s, tup)
			assert (s + "  quot", tup.quot.out ~ "1")
			assert (s + "  rem", tup.rem.out ~ "0")
				-- test number two
			n := new_number_from_string ("49")
			d := n.three_value
			s := str + "(" + n.out + ").scalar_divide (" + d.out + ")"
			tup := n.scalar_divide (d)
			report_tuple (s, tup)
			assert (s, tup.quot.out ~ "18")
			assert (s, tup.rem.out ~ "1")
				-- test number three
			n := new_number_from_string ("84746229876")
			d := n.sixteen_value
			s := str + "(" + n.out + ").scalar_divide (" + d.out + ")"
			tup := n.scalar_divide (d)
			report_tuple (s, tup)
			assert (s, tup.quot.out ~ "5296639367")
			assert (s, tup.rem.out ~ "4")
		end

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


feature {NONE} -- Implementation

	report (a_comment: STRING_8; a_number: like new_number)
			-- Display some information (for demo) about `a_number'.
		do
			print (a_number.generating_type + a_comment + "%N")
			print ("           base = " + a_number.base.out + "%N")
			print ("          count = " + a_number.count.out + "%N")
			print ("    digit_count = " + a_number.as_base (a_number.ten_value).count.out + "%N")
			if is_verbose then
				print ("      as_stored = " + a_number.out_as_stored + "%N")
				print ("        as_bits = " + a_number.out_as_bits + "%N")
				print ("            out = " + a_number.out + "%N")
			end
			print ("  out_formatted = " + a_number.out_formatted + "%N")
		end

	report_properties (a_comment: STRING_8; a_number: like new_number)
			-- Display verbose information (for demo) about `a_number'.
		do
			print (a_number.generating_type + a_comment + "  report_properties %N")
			print ("                 base: " + a_number.base.generating_type + " = " + a_number.base.out + "%N")
			print ("             min_base: " + a_number.min_base.generating_type + " = " + a_number.min_base.out + "%N")
			print ("             max_base: " + a_number.max_base.generating_type + " = " + a_number.max_base.out + "%N")
			print ("            max_digit: " + a_number.max_digit.generating_type + " = " + a_number.max_digit.out + "%N")
			print ("         max_dig_mult: " + a_number.max_digit_for_multiplication.generating_type + " = " + a_number.max_digit_for_multiplication.out + "%N")
--				print ("            max_value: " + a_number.max_value.generating_type + " = " + a_number.max_value.out + "%N")
			print ("                 zero: " + a_number.zero.generating_type + " = " + a_number.zero.out + "%N")
			print ("                  one: " + a_number.one.generating_type + " = " + a_number.one.out + "%N")
			print ("  karatsuba_threshold: " + a_number.karatsuba_threshold.generating_type + " = " + a_number.karatsuba_threshold.out + "%N")
			print ("           zero_value: " + a_number.zero_value.generating_type + " = " + a_number.zero_value.out + "%N")
			print ("            one_value: " + a_number.one_value.generating_type + " = " + a_number.one_value.out + "%N")
			print ("            two_value: " + a_number.two_value.generating_type + " = " + a_number.two_value.out + "%N")
			print ("          three_value: " + a_number.three_value.generating_type + " = " + a_number.three_value.out + "%N")
			print ("           four_value: " + a_number.four_value.generating_type + " = " + a_number.four_value.out + "%N")
			print ("           five_value: " + a_number.five_value.generating_type + " = " + a_number.five_value.out + "%N")
			print ("            six_value: " + a_number.six_value.generating_type + " = " + a_number.six_value.out + "%N")
			print ("          seven_value: " + a_number.seven_value.generating_type + " = " + a_number.seven_value.out + "%N")
			print ("          eight_value: " + a_number.eight_value.generating_type + " = " + a_number.eight_value.out + "%N")
			print ("           nine_value: " + a_number.nine_value.generating_type + " = " + a_number.nine_value.out + "%N")
			print ("            ten_value: " + a_number.ten_value.generating_type + " = " + a_number.ten_value.out + "%N")
			print ("        sixteen_value: " + a_number.sixteen_value.generating_type + " = " + a_number.sixteen_value.out + "%N")
			print ("                  out: " + a_number.out + "%N")
			print ("        out_formatted: " + a_number.out_formatted + "%N")
			print ("        out_as_stored: " + a_number.out_as_stored + "%N")
			print ("          out_as_bits: " + a_number.out_as_bits + "%N")
		end

	report_tuple (a_comment: STRING_8; a_tuple: like new_number.scalar_divide)
			-- Display information about `a_tuple' which contains a quotient
			-- and a remainder, likely resulting from some division operation.
		do
			print (a_tuple.generating_type + a_comment + "%N")
			print ("  tuple:  [" + a_tuple.quot.out + ", " + a_tuple.rem.out + "] %N")
		end

	report_digit_tuple (a_comment: STRING_8; a_tuple: like new_number.divide_two_digits_by_one)
			-- Display information about `a_tuple' which contains a quotient
			-- and a remainder, likely resulting from some division operation.
		do
			print (a_tuple.generating_type + a_comment + "%N")
			print ("  tuple:  [" + a_tuple.quot.out + ", " + a_tuple.rem.out + "] %N")
		end

end





