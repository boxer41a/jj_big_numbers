note
	description: "[
		Root class for other test classes.  The descendent class
		must redefine each feature in order for the autotest to
		execute it.  In decendents, simply call precursor.
	]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	JJ_BIG_NATURAL_TESTS [G -> JJ_BIG_NATURAL [JJ_NATURAL]
							 create default_create, from_array, from_string end]

inherit
	EQA_TEST_SET

feature {NONE} -- Anchors

	digit_type: like {JJ_BIG_NATURAL [JJ_NATURAL]}.digit
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

	digit_tuple_type: TUPLE [num: like number; dig: like digit_type]
			-- Anchor
		require else
			not_callable: False
		do
			check
				do_not_call: False then
					-- Because gives no info; simply used as anchor.
			end
		end

feature -- Access

	class_name: STRING_8
			-- The name of this class
		once
			Result := generating_type
		end

	f_name: STRING_8
			-- The name of the feature being tested, which is used in `report'
		attribute
			Result := "no name"
		end

	number: G
			-- To get a big number of the correct type
		do
			create Result
		end

	number_from_string (a_string: STRING_8): like number
			-- Create a new number from `a_string'
		do
			create Result.from_string (a_string)
		end

	report_terse (a_number: like number; a_expected: STRING_8)
			-- Display minimal information (for demo) about `a_number' and assert
			-- that its string representation, `out_as_stored', is as `a_expected'.
		do
				print (class_name + "." + f_name + "%N")
				print ("%T    expected = " + a_expected + "%N")
				assert (f_name, a_number.out_as_stored ~ a_expected)
		end

	report_digit_tuple_terse (a_tuple: like digit_tuple_type; a_expected: TUPLE [num: STRING_8; dig: STRING_8])
			-- Display `a_tuple' (with the number shown with `out_as_stored' and
			-- compare that to the expected string
		local
			s, es: STRING_8
		do
				print (class_name + "." + f_name + "%N")
				es := "[" + a_expected.num + ", " + a_expected.dig + "]"
				s := "[" + a_tuple.num.out_as_stored + ", " + a_tuple.dig.out + "]"
				print ("%T    expected = " + es + "%N")
				print ("%T         tup = " + s + "%N")
				assert ("num/rem", s ~ es)
		end

	report (a_comment: STRING_8; a_number: like number)
			-- Display some information (for demo) about `a_number' and assert
			-- that its string representation, `plain_out', is as `a_expected'.
		do
				print (class_name + a_comment + "%N")
				print ("%T          base = " + a_number.base.out + "%N")
				print ("%T     as_stored = " + a_number.out_as_stored + "%N")
				print ("%T       as_bits = " + a_number.out_as_bits + "%N")
				print ("%T           out = " + a_number.out + "%N")
				print ("%T out_formatted = " + a_number.out_formatted + "%N")
--				assert (f_name, a_number.out ~ a_expected)
		end

	report_properties (a_feature_name: STRING_8; a_number: like number; a_expected: STRING;
					a_base, a_max_base, a_max_digit: like digit_type;
					a_karatsuba_threshold: INTEGER_32)
			-- Display some information (for demo) about `a_number' and assert
			-- that its string representation, `out_as_stored', is as `a_expected'.
		do
				print (class_name + ".properties - " + a_feature_name + "%N")
				print ("%T           n = " + a_number.out + "%N")
				print ("%T    expected = " + a_expected + "%N")
				print ("%T        base = " + a_number.base.out + "%N")
				print ("%T    max_base = " + a_number.max_base.out + "%N")
				print ("%T   max_digit = " + a_number.max_digit.out + "%N")
				print ("%T	threshold = " + a_number.karatsuba_threshold.out + "%N")
				print ("%T   plain_out = " + a_number.out + "%N")
				print ("%T   as_stored = " + a_number.out_as_stored + "%N")
				print ("%T     as_bits = " + a_number.out_as_bits + "%N")
				assert (a_feature_name + ".out_as_stored", a_number.out_as_stored ~ a_expected)
				assert (a_feature_name + ".base", a_number.base = a_base)
				assert (a_feature_name + ".max_base", a_number.max_base = a_max_base)
				assert (a_feature_name + ".max_digit", a_number.max_digit = a_max_digit)
				assert (a_feature_name + ".karatsuba_threshold",
								 a_number.karatsuba_threshold = a_karatsuba_threshold)
		end

feature -- Test initialization

	test_default_create
		deferred
		end

	make_with_base
		deferred
		end

	make_with_value
		deferred
		end

	make_with_value_and_base
		deferred
		end

	from_string
		local
			str, s: STRING_8
			bn: like number
			e: STRING_8
			i: INTEGER
		do
			str := ".from_string:  "
				-- Base 10 number
			bn := number_from_string ("3852")
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
			bn := number_from_string ("852")
			s := str + "852 max_base"
			report (s, bn)
			assert (f_name + " base", bn.base.out ~ bn.max_base.out)
			assert (f_name + " out ", bn.out ~ "852")
			assert (f_name + " out_fomatted ", bn.out_formatted ~ "852")
				-- Negative number
			bn := number_from_string ("-1325839")
			s := str + "-1325839 max_base"
			report (s, bn)
			assert (s + " base", bn.base.out ~ bn.max_base.out)
			assert (s + " out ", bn.out ~ "-1325839")
			assert (s + " out_fomatted ", bn.out_formatted ~ "-1,325,839")
			io.new_line
		end

	from_array
		deferred
		end

	from_max
		local
			str, s: STRING_8
			bn: like number
			m: like number.base.max_value
			n: INTEGER_32
		do
			str := generating_type + ".from_max"
			bn := number
			m := bn.base.max_value - bn.base.one
			bn.set_value (m)
			s := m.out
			report (str, bn)
			assert (str, bn.out ~ m.out)
		end

feature -- Test conversion

	as_base
		local
			n: like number
		do

		end


feature -- Test basic operations

	scalar_divide
		deferred
		end

	divide_two_by_one
		deferred
		end

	knuth_divide
		deferred
		end

	plus
		local
			str, s: STRING_8
			a, b: like number
			n: like number
		do
			str := ".plus:  "
			a := number_from_string ("99")
			b := number_from_string ("101")
			n := a + b
			s := str + "99 + 101"
			report (s, n)
			assert (s, n.out ~ "200")
			io.new_line
		end

	minus
		local
			str, s: STRING_8
			a, b: like number
			n: like number
		do
			str := ".minus:  "
				-- minus test number one
			a := number_from_string ("1000")
			b := number_from_string ("99")
			n := a - b
			s := str + "1000 - 99"
			report (s, n)
			assert (s, n.out ~ "901")
				-- Minus test number two
			s := str + "99 - 1000"
			n := b - a
			report (s, n)
			assert (s, n.out ~ "-901")
			io.new_line
		end

	scalar_multiply
		local
			str, s: STRING_8
			a: like number
		do
			str := ".scalar_multiply:  "
			a := number_from_string ("7")
			a.scalar_multiply (a.four_value)
			s := str + "7.scalar_multiply (4)"
			report (s, a)
			assert (s, a.out ~ "28")
			io.new_line
		end

	scalar_multiply_double_digit
		local
			a, e: JJ_BIG_NATURAL_8
		do
			a := "23"
			a.scalar_multiply (5)
			e := "115"
			assert ("(23).scalar_multiply (5)", a ~ e)
		end

	scalar_multiply_two_double_digits
		local
			a, e: JJ_BIG_NATURAL_8
		do
			a := "94"
			a.scalar_multiply (15)
			e := "1410"
			assert ("(94).scalar_multiply (15)", a ~ e)
		end

	scalr_multiply_big
		local
			a, e: JJ_BIG_NATURAL_8
		do
			a := "12345"
			a.scalar_multiply (14)
			e := "172830"
			assert ("(12345).scalar_multiply (14)", a ~ e)
		end


	digits_multiplied
		local
			str, s: STRING_8
			n: like number
			tup: like {like number}.digits_multiplied
			a, b: like number.base
		do
			str := generating_type + ".digits_multiplied:  "
			create n
				-- 10 * 100
			a := n.ten_value
			b := n.ten_value * n.ten_value
			tup := n.digits_multiplied (a, b)
			s := str + "10 * 100"
			io.put_string (s + "10 * 100 -- [" + tup.high.out + ", " + tup.low.out + "] %N")
			assert (s, "[" + tup.high.out + ", " + tup.low.out + "]" ~ "[7, 104]")
				-- 11 * 100
			a := a + n.one_value
			tup := n.digits_multiplied (a, b)
				-- 11 * 101
			b := b + n.one_value
			tup := n.digits_multiplied (a, b)
				-- 20 * 101
			a := a + n.nine_value
			tup := n.digits_multiplied (a, b)
				-- 29 * 110
			a := a + n.nine_value
			b := b + n.nine_value
			tup := n.digits_multiplied (a, b)
				-- 30 * 110
			a := a + n.one_value
			tup := n.digits_multiplied (a, b)
				-- 36 * 107 = 3852  (see Radix conversion paper, example)
			a := a + n.six_value
			b := b - n.three_value
			tup := n.digits_multiplied (a, b)
				-- 127 * 127			
			a := n.max_digit
			b := n.max_digit
			tup := n.digits_multiplied (a, b)

			io.new_line
		end

	star
		local
			str, s: STRING_8
			a, b, n: like number
			e: STRING_8
		do
			str := ".star:  "
			create n
			n.set_base (n.three_value)
				-- star test number one
			a := number_from_string ("5")
			b := number_from_string ("9")
			a.set_base (a.three_value)
			b.set_base (b.three_value)
			n := a * b
			s := str + "9 * 5"
			report (s, n)
			assert (s, n.out ~ "45")
				-- star test with big values
			a := number_from_string ("84736487483757564869490010293")
			b := number_from_string ("57849399340004949681221")
			n := a * b
			s := str + "  big values"
			report (s, n)
			assert (s, n.out ~ "4901954903117222552481914443941818610639794358807753")
		end

feature -- Test conversion

	is_less
		local
			a, b: like number
			e: BOOLEAN
			n: INTEGER_32
		do
			f_name := ".is_less"
			a := number_from_string ("28")
			b := number_from_string ("10")
			e := false
			print (class_name + f_name + "%N")
			print ("%T           a = " + a.out + " < " + b.out + "%N")
			print ("%T a base = " + a.base.out + "  b.base = " + b.base.out + "%N")
			print ("%T    expected = " + e.out + "%N")
			print ("%T         out = " + (a < b).out + "%N")
			assert (f_name, (a < b) ~ e)
			print ("%N")
		end



	test_conversion_1
		local
			n: JJ_BIG_NATURAL_8
			e: STRING_8
		do
			n := "98765"
			e := "9,8,7,6,5"
			f_name := ".test_conversion_1"
			n.set_base (8)
			print (class_name + f_name + "%N")
			print ("%T expected = " + e + "%N")
			print ("%T actual =   " + n.out_as_base (10) + "%N")
			assert (f_name, n.out_as_base (10) ~ e)
		end

	test_conversion_2
		local
			n: JJ_BIG_NATURAL_8
			e: STRING_8
		do
			n := "-7"
			e := "-7"
			f_name := ".test_conversion_2"
			n.set_base (3)
			print (class_name + f_name + "%N")
			print ("%T expected = " + e + "%N")
			print ("%T actual =   " + n.out_as_base (10) + "%N")
			assert (f_name, n.out_as_base (10) ~ e)
		end

	test_conversion_3
		local
			n: JJ_BIG_NATURAL_8
			e: STRING_8
		do
			n := "32"
			e := "32"
			f_name := ".test_conversion_3"
			n.set_base (8)
			n.set_base (7)
			n.set_base (2)
			print (class_name + f_name + "%N")
			print ("%T expected = " + e + "%N")
			print ("%T actual =   " + n.out_as_base (10) + "%N")
			assert ("f_name", n ~ e)
		end

	test_conversion_4
		local
			n: JJ_BIG_NATURAL_8
			e: STRING_8
		do
			n := "99"
			e := "99"
			f_name := ".test_conversion_4"
			n.set_base (8)
			print (class_name + f_name + "%N")
			print ("%T expected = " + e + "%N")
			print ("%T actual =   " + n.out_as_base (10) + "%N")
			assert ("f_name", n ~ e)
		end

	test_conversion_5
		local
			a, e: JJ_BIG_NATURAL_8
		do
			a := "99"
			e := "99"
			a.set_base (3)
			assert ("after conversion", a ~ e)
		end

	test_conversion_6
		local
			a, e: JJ_BIG_NATURAL_8
		do
			a := "99"
			e := "99"
			a.set_base (8)
			a.set_base (3)
			assert ("after conversion", a ~ e)
		end

	test_conversion_9
		local
			a, e: JJ_BIG_NATURAL_8
		do
			a := "98765"
			a.set_base (8)
			a.set_base (2)
			a.set_base (100)
			assert ("a after conversions", a.out_as_base (10) ~ "9,8,7,6,5")
		end


end


