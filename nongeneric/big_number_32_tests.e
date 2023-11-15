note
	description: "[
		Test routines specific to {JJ_BIG_NATURAL_8} numbers.

		Features from {BIG_NATURAL_TESTS}, even though fully defined in
		the {BIG_NATURAL_TESTS} ancestor class, must be redefined here
		in order to be recognized by the automatic test system.
	]"
	author: "Jimmy J. Johnson"

class
	BIG_NUMBER_32_TESTS

inherit

	EQA_TEST_SET

feature -- Basic operations (initialization tests)

	default_create_test
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str, s: STRING_8
			n: like number_anchor
		do
			n := new_number
			str := n.generating_type + ":  "
			fn := ".default_create = "
			s := str + fn
			io.put_string (s + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<0>")
		end

	from_value
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			fn := ".make_with_value"
			n := new_number
				-- .make_with_value (16 * 7)
			v := n.sixteen_word * n.seven_word
			str := fn + " (" + v.out + ")"
			io.put_string (str + " = ")
			create n.from_value (v)
			assert (str, n.out_as_stored ~ "<112>")
		end

	from_string
			-- Test the `from_string' feature;
		local
			fn, str, s: STRING_8
			n: like number_anchor
		do
			n := new_number
			str := n.generating_type + ":  "
			fn := ".from_string "
				-- Test
			n := new_number_from_string ("3852")
			s := str + fn + "(%"" + n.out + "%") = "
			io.put_string (s + n.out + "%N")
			assert (s + " out ", n.out ~ "3852")
				-- Longer number
			n := new_number_from_string ("10,987,654,321")
			s := str + fn + "(%"" + n.out + "%") = "
			io.put_string (s + n.out_formatted + "%N")
			assert (s + " out_formatted ", n.out_formatted ~ "10,987,654,321")
				-- Negative number
			n := new_number_from_string ("-00012,34")
			s := str + fn + "(%"" + n.out + "%") = "
			io.put_string (s + n.out + "%N")
			assert (s + " out ", n.out ~ "-1234")
				-- Failing ? number
			n := new_number_from_string ("33333")
			s := str + fn + "(%"" + n.out + "%") = "
			io.put_string (s + n.out + "%N")
			assert (s + " out ", n.out ~ "33333")
				-- Number arrived at during failing simple_multiply?
			n := new_number_from_string ("26,558,760")
			s := str + fn + "(%"" + n.out + "%") = "
			io.put_string (s + n.out + "%N")
			assert (s + " out ", n.out ~ "26558760")
		end

	from_array
		local
			fn, str: STRING_8
			n: like number_anchor
			a: ARRAY [like digit_anchor]
		do
			fn := ".make_with_array"
			str := fn + " (<1, 2, 3, 4>>)"
			io.put_string (str + " = ")
			a := <<1, 2, 3, 4>>
			create n.from_array (a)
			io.put_string (n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<1,2,3,4>")
--				-- test the out function (it was failing on this)
			a := <<1,8,187>>
			str := fn + " (<1, 8, 187>>)"
			io.put_string (str + " = ")
			create n.from_array (a)
			io.put_string (n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<1,8,187>")
		end

	set_random
			-- Tests corresponding feature from {JJ_BIG_NATURAL_8}.
		local
			fn, str, s: STRING_8
			n: like number_anchor
			i: INTEGER
		do
			n := new_number
			str := generating_type
			fn := ".set_random"
				-- set_random (1)	
			i := 1
			s := str + fn + "(" + i.out + ")"
			n.set_random (i)
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.count = i)
				-- set_random (3)	
			i := 3
			s := str + fn + "(" + i.out + ")"
			n.set_random (i)
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.count = i)
				-- set_random (8)	
			i := 8
			s := str + fn + "(" + i.out + ")"
			n.set_random (i)
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.count = i)
		end

	set_random_with_digit_count
			-- Tests corresponding feature from {JJ_BIG_NATURAL_8}.
		local
			fn, str, s: STRING_8
			n: like number_anchor
			i: INTEGER
		do
			n := new_number
			str := n.generating_type
			fn := ".set_random_with_digit_count"
			from i := 1
			until i > 10
			loop
				s := str + fn + " (" + i.out + ")"
				n.set_random_with_digit_count (i)
				io.put_string (s + " = " + n.out + "   " + n.out_as_stored + "%N")
				assert (s, n.out.count = i)
				i := i + 1
			end
			i := 100
			s := str + fn + " (" + i.out + ")"
			n.set_random_with_digit_count (i)
			io.put_string (s + " = " + n.out + "   " + n.out_as_stored + "%N")
			assert (s, n.out.count = i)
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
			v := n.zero_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + v.out + ")"
			io.put_string (str + " = ")
			n.set_value (v)
			io.put_string (n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<0>")
				-- max_value
			create n
			v := n.max_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + v.out + ")"
			io.put_string (str + " = ")
			n.set_value (v)
			io.put_string (n.out_as_stored + " %N")
			assert (str, n.out_as_stored ~ "<" + n.max_word.out + ">")
		end

	set_with_string
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			gt, fn, str, s: STRING_8
			n: like number_anchor
		do
			io.put_string ("{BIG_NATURAL_8_TESTS} with output as stored: %N")
			n := new_number
			gt := n.generating_type + ":  "
			fn := ".set_with_string "
			str := gt + fn
				-- Test
			s := "3852"
			io.put_string (str + "(%"" + s + "%") = ")
			n.set_with_string (s)
			io.put_string (n.out_as_stored + "%N")
			assert (s + " out_as_stored ", n.out ~ "3852")
				-- Longer number
			s := "10,987,654,321"
			io.put_string (str + "(%"" + s + "%") = ")
			n.set_with_string (s)
			io.put_string ( n.out + "%N")
			assert (s + " out_as_stored ", n.out ~ "10987654321")
				-- Negative number
			s := "-00012,34"
			io.put_string (str + "(%"" + s + "%") = ")
			n.set_with_string (s)
			io.put_string (n.out_as_stored + "%N")
			assert (s + " out_as_stored ", n.out_as_stored ~ "-<1234>")
				-- Failing ? number
			s := "33333"
			io.put_string (str + "(%"" + s + "%") = ")
			n.set_is_negative (false)
			n.set_with_string (s)
			io.put_string (n.out_as_stored + "%N")
			assert (s + " out_as_stored ", n.out_as_stored ~ "<33333>")
				-- First test
			s := "123456789"
			io.put_string (str + "(%"" + s + "%") = ")
			n := new_number
			n.set_with_string (s)
			io.put_string (n.out_formatted + "%N")
			assert (s, n.out ~ "123456789")
				-- Test leading zeroes.
			s := "0,0,0,0,0,9,8,7,6,5,4,3,2,1"
			io.put_string (str + "(%"" + s + "%") = ")
			n := new_number
			n.set_with_string (s)
			io.put_string (n.out_formatted + "%N")
			assert (s, n.out ~ "987654321")
				-- Negative test
			s := "-11,234,567,899"
			io.put_string (str + "(%"" + s + "%") = ")
			n := new_number
			n.set_with_string (s)
			io.put_string (n.out_formatted + "%N")
			assert (s + ".is_negative", n.is_negative)
			assert (s + ".out", n.out ~ "-11234567899")
				--  Test
			s := "1,000,000,000,000"
			io.put_string (str + "(%"" + s + "%") = ")
			n := new_number
			n.set_with_string (s)
			io.put_string (n.out_formatted + "%N")
			assert (s + ".out", n.out ~ "1000000000000")
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
			assert (s, n.out_as_stored ~ "<10,20,30,40,50,60,70,80,90>")
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
			assert (str, n.out_as_stored ~ "<0>")
		end

	one
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			n: like number_anchor
		do
			create n
			fn := n.generating_type + ":  "
			str := fn + ".one = "
			n := n.one
			io.put_string (str + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<1>")
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
				-- (max_word_value).set_is_negative (true)
			n.set_value (n.max_word)
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
			n.set_value (n.one_word)
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
			n.set_value (n.one_word)
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
			create n.from_array (<<1,2,3>>)
			s := str + "(" + n.out_as_stored + ").is_base"
			io.put_string (s + " = " + n.is_base.out + "%N")
			assert (s, not n.is_base)
				-- Is base
			create n.from_array (<<1,0>>)
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
			n, n2: like new_number
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
			n, n2: like new_number
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
			n.set_value (n.nine_word * n.nine_word)
			s := str + "(" + n.out_as_stored + ").negate"
			n.negate
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "-<81>")
				-- (-81).negate
			s := str + "(" + n.out_as_stored + ").negate"
			n.negate
			io.put_string (s + " = " + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<81>")
		end

	identity
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			str, s: STRING_8
			n, a: like number_anchor
		do
			str := ".identity:  "
			create n
			n.set_value (n.nine_word)
			s := str + "(" + n.out_as_stored + ").identity"
			a := n.identity
			io.put_string (s + " = " + a.out_as_stored + "%N")
			assert (s + " values", n.out_as_stored ~ a.out_as_stored)
			assert (s + " unchanged", n.out_as_stored ~ "<9>")
				-- (-9).identity
			n.negate
			s := str + "(" + n.out_as_stored + ").identity"
			a := n.identity
			io.put_string (s + " = " + a.out_as_stored + "%N")
			assert (s + " values", n.out_as_stored ~ a.out_as_stored)
			assert (s + " unchanged", n.out_as_stored ~ "-<9>")
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
			n.set_value (n.seven_word)
			s := str + "(" + n.out_as_stored + ").opposite"
			a := n.opposite
			io.put_string (s + " = " + a.out_as_stored + "%N")
			assert (s + " values", a.out_as_stored ~ "-<7>")
			assert (s + " unchanged", n.out_as_stored ~ "<7>")
				-- (-7).opposite
			n.copy (a)
			s := str + "(" + n.out_as_stored + ").opposite"
			a := n.opposite
			io.put_string (s + " = " + a.out_as_stored + "%N")
			assert (s + " values", a.out_as_stored ~ "<7>")
			assert (s + " unchanged", n.out_as_stored ~ "-<7>")
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
			v := n.seven_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<7>")
				-- (9).scalar_add (max_word_value)
			create n.from_value (n.nine_word)
			v := n.max_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + v.out + ")"
			io.put_string (str + " = ")
			n.scalar_add (v)
			io.put_string (n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<1,8>")
				-- (max_word_value).scalar_add (1)
			create n.from_value (n.max_word)
			v := n.one_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<1,0>")
				-- (max_representable_word).scalar_add (1)
			create n.from_value (n.max_word)
			v := n.one_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<1,0>")
				-- (max_representable_value).scalar_add (max_representable_value)
			create n.from_value (n.max_word)
			v := n.max_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + v.out + ")"
			io.put_string (str)
			n.scalar_add (v)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<1,4294967294>")
		end

	scalar_sum
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, s, str: STRING_8
			n, sum: like number_anchor
			v, b: like digit_anchor
		do
			fn := ".scalar_sum"
				-- (0).acalar_sum (max_representable_value) = 255
			create n
			str := "(" + n.out_as_stored + ")" + fn + " (" + n.max_word.out + ") = "
			io.put_string (str)
			sum := n.scalar_sum (n.max_word)
			io.put_string (sum.out_as_stored + "   n unchanged = " + n.out_as_stored + "%N")
			assert (str, sum.out_as_stored ~ "<4294967295>")
			assert (str + "n unchanged", n.out_as_stored ~ "<0>")
				-- <<max_word, max_word>>.scalar_sum (1)
			create n.from_array (<<n.max_word, n.max_word>>)
			v := n.one_word
			str := n.out_as_stored + fn + " (" + v.out + ") = "
			io.put_string (str)
			sum := n.scalar_sum (v)
			io.put_string (sum.out_as_stored + "   n unchanged = " + n.out_as_stored + "%N")
			assert (str, sum.out_as_stored ~ "<1,0,0>")
			assert (str + "n unchanged", n.out_as_stored ~ "<4294967295,4294967295>")
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
			assert (str, n.out_as_stored ~ "<0>")
				-- (1).add (0)
			create n.from_value (n.one_word)
			create x
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out_as_stored + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<1>")
				-- (0).add (1)
			create n
			create x.from_value (n.one_word)
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out_as_stored + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<1>")
				-- <0,0,0,0>.add <0,2,1>
			create n.from_array (<<0,0,0,0>>)
			create x.from_array (<<0,2,1>>)
			str := n.out_as_stored + fn
			str := str + " (" + x.out_as_stored + ")"
			io.put_string (str + " = ")
			n.add (x)
			io.put_string (n.out_as_stored + "%N")
			assert (str + " as_stored", n.out_as_stored ~ "<2,1>")
				-- (99).add (101)
			n.set_value ((n.ten_word + n.one_word) * n.nine_word)
			x.set_value (n.ten_word * n.ten_word + n.one_word)
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out_as_stored + ")"
			io.put_string (str)
			n.add (x)
			io.put_string (":  " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<200>")
				-- (834292018876).add (99584738599403878) = 99584822091422754
			create n.from_string      ("834292018876")
			create x.from_string ("99584738599403878")
			str := "(" + n.out + ")" + fn
			str := str + "(" + x.out + ")"
			io.put_string (str)
			n.add (x)
			io.put_string ("= " + n.out + "%N")
			assert (str, n.out ~ "99585572891422754")
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
			create x.from_value (n.eight_word)
			create y.from_value (n.nine_word)
			str := x.out_as_stored + fn
			str := str + "(" + y.out_as_stored + ")"
			io.put_string (str)
			n := x.plus (y)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<17>")
			assert (str + " x unchanged", x.out_as_stored ~ "<8>")
			assert (str + " y unchanged", y.out_as_stored ~ "<9>")
				-- n := (0).plus (-100)
			create n
			create x
			create y.from_value (n.ten_word * n.ten_word)
			y.negate
			str := x.out_as_stored + fn
			str := str + "(" + y.out_as_stored + ")"
			io.put_string (str)
			n := x.plus (y)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "-<100>")
			assert (str + " x unchanged", x.out_as_stored ~ "<0>")
			assert (str + " y unchanged", y.out_as_stored ~ "-<100>")
				-- n := (80).plus (-100)
			create n
			create x.from_value (n.eight_word * n.ten_word)
			create y.from_value (n.ten_word * n.ten_word)
			y.negate
			str := x.out_as_stored + fn
			str := str + "(" + y.out_as_stored + ")"
			io.put_string (str)
			n := x.plus (y)
			io.put_string (" = " + n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "-<20>")
			assert (str + " x unchanged", x.out_as_stored ~ "<80>")
			assert (str + " y unchanged", y.out_as_stored ~ "-<100>")
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
			fn, str, s: STRING_8
			a, b: like number_anchor
			n: like number_anchor
		do
			create n
			str := n.generating_type + ":  "
			fn := ".minus "
				-- (1000).minus (99) = 901
			create a.from_array (<<3,232>>)
			create b.from_array (<<99>>)
			s := str + "(" + a.out_as_stored + ")" + fn
			s := s + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			n := a.minus (b)
			io.put_string (n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<3,133>")
				-- Test with negative.
			create a.from_array (<<3,232>>)
			create b.from_array (<<99>>)
			b.negate
			s := str + "(" + a.out_as_stored + ")" + fn
			s := s + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			n := a.minus (b)
			io.put_string (n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<3,331>")
				-- Test with leading zeros.
			create a.from_array (<<3,232>>)
			create b.from_array (<<3,231>>)
			s := str + "(" + a.out_as_stored + ")" + fn
			s := s + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			n := a.minus (b)
			io.put_string (n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<1>")

--			Precursor
		end

	simple_add
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			a: like testable_number_anchor
			n: like testable_number_anchor
		do
			fn := ".simple_add"
				-- <0>.add (<0>)
			create n
			create a
			str := n.out_as_stored + fn
			str := str + " (" + a.out_as_stored + ")"
			io.put_string (str + " = ")
			n.simple_add (a)
			io.put_string (n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<0>")
				-- <0,0,0>.add <2,1>
			create n.from_array (<<0,0,0>>)
			create a.from_array (<<2,1>>)
			str := n.out_as_stored + fn
			str := str + " (" + a.out_as_stored + ")"
			io.put_string (str + " = ")
			n.simple_add (a)
			io.put_string (n.out_as_stored + "%N")
			assert (str + " as_stored", n.out_as_stored ~ "<0,2,1>")
				-- <3,2,1>.add <0,0,0,2,1>
			create n.from_array (<<0,2,1>>)
			create a.from_array (<<0,0,0,2,1>>)
			str := n.out_as_stored + fn
			str := str + " (" + a.out_as_stored + ")"
			io.put_string (str + " = ")
			n.simple_add (a)
			io.put_string (n.out_as_stored + "%N")
			assert (str + " as_stored", n.out_as_stored ~ "<0,0,0,4,2>")

				-- Same sign.
			create n.from_array (<<1,2,3,4>>)
			create a.from_array (<<4,3,2,1>>)
			str := n.out_as_stored + fn
			str := str + " (" + a.out_as_stored + ")"
			io.put_string (str + " = ")
			n.simple_add (a)
			io.put_string (n.out_as_stored + "%N")
			assert (str + " as_stored", n.out_as_stored ~ "<5,5,5,5>")
		end

	simple_subtract
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, s, str: STRING_8
			a: like testable_number_anchor
			n: like testable_number_anchor
		do
			create n
			fn := ".simple_subtract"
			str := n.generating_type + ":  "
				-- Same sign
			create n.from_array (<<1,2,3,4>>)
			create a.from_array (<<1,2,3,4>>)
			s := str + n.out_as_stored + fn
			s := s + "(" + a.out_as_stored + ") = "
			n.simple_subtract (a)
			io.put_string (s + n.out_as_stored + "%N")
			assert (s + " as_stored", n.out_as_stored ~ "<0,0,0,0>")
				-- (74,565).siple_subtract (4660) = 69,905
			n.set_with_array (<<1,2,3,4,5>>)
			a.set_with_array (<<1,2,3,4>>)
			s := str + n.out_as_stored + fn
			s := s + "(" + a.out_as_stored + ") = "
			n.simple_subtract (a)
			io.put_string (s + n.out_as_stored + "%N")
			assert (s + " as_stored", n.out_as_stored ~ "<1,1,1,1,1>")
				-- <0,0,3,2,1.siple_subtract (<2,0,1>) = <0,0,1,2,0>
			n.set_with_array (<<0,0,3,2,1>>)
			a.set_with_array (<<2,0,1>>)
			s := str + n.out_as_stored + fn
			s := s + "(" + a.out_as_stored + ") = "
			n.simple_subtract (a)
			io.put_string (s + n.out_as_stored + "%N")
			assert (s + " as_stored", n.out_as_stored ~ "<0,0,1,2,0>")
		end

	scalar_multiply
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str, s: STRING_8
			n: like number_anchor
			x: like digit_anchor
		do
			create n
			str := n.generating_type + ":  "
			fn := ".scalar_multiply "
				-- <>.scalar_mulitply (0)
			x := n.zero_word
			s := str + n.out_as_stored + fn
			s := s + "(" + x.out + ") = "
			io.put_string (s)
			n.scalar_multiply (x)
			io.put_string (n.out_as_stored + " %N")
			assert (str, n.out_as_stored ~ "<0>")
				-- by zero
			n.set_with_array (<<7,9,3,5>>)
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out + ") = "
			io.put_string (str)
			n.scalar_multiply (x)
			io.put_string (n.out_as_stored + " %N")
			assert (str, n.out_as_stored ~ "<0>")
				-- (200,15).scalar_multiply (500) = <100000,7500>
			n.set_with_array (<<200,15>>)
			x := 500
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out + ") = "
			io.put_string (str)
			n.scalar_multiply (x)
			io.put_string (n.out_as_stored + " %N")
			assert (str, n.out_as_stored ~ "<100000,7500>")
				-- (max).scalar_multiply (max) = <max-1,1> = 18 446 744 060 824 649 731
			n.set_with_array (<<n.max_word>>)
			x := n.max_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + "(" + x.out + ") = "
			io.put_string (str)
			n.scalar_multiply (x)
			io.put_string (n.out_as_stored + "%N")
			assert (str, n.out_as_stored ~ "<4294967294,1>")
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
			fac := n.seven_word
			s := "(" + n.out_as_stored + ")" + str
			s := s + "(" + fac.out + ")"
			io.put_string (s)
			p := n.scalar_product (fac)
			io.put_string (" = " + p.out_as_stored + "%N")
			assert (s, p.out_as_stored ~ "<0>")
				-- Multiply by zero
			fac := n.zero_word
			s := "(" + n.out_as_stored + ")" + str
			s := s + "(" + fac.out + ")"
			io.put_string (s)
			p := n.scalar_product (fac)
			io.put_string (" = " + p.out_as_stored + "%N")
			assert (s, p.out_as_stored ~ "<0>")
				-- (1,2,3) max_base).scalar_product (81) = 66,051 * 81 = 5,350,131
			n.set_with_array (<<1,2,3>>)
			fac := n.nine_word * n.nine_word
			s := "(" + n.out_as_stored + ")" + str
			s := s + "(" + fac.out + ")"
			io.put_string (s)
			p := n.scalar_product (fac)
			io.put_string (" = " + p.out_as_stored + "%N")
			assert (s, p.out_as_stored ~ "<81,162,243>")
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

	multiply
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
			-- "https://defuse.ca/big-number-calculator.htm".
		local
			fn, str, s: STRING_8
			n: like number_anchor
			fac: like number_anchor
		do
			create n
			str := n.generating_type + ":  "
			fn := ".multiply"
				-- (0).multiply (99)
			create n
			create fac.from_array (<<99>>)
			s := n.out_as_stored + fn + " (" + fac.out_as_stored + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<0>")
			assert (s + "  fac unchanged", fac.out_as_stored ~ "<99>")
				-- (99).multiply (0)
			create n.from_array (<<99>>)
			create fac
			s := n.out_as_stored + fn + " (" + fac.out_as_stored + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<0>")
			assert (s + "  fac unchanged", fac.out_as_stored ~ "<0>")
				-- (5).multiply (9)
			create n.from_array (<<5>>)
			create fac.from_array (<<9>>)
			s := n.out_as_stored + fn + " (" + fac.out_as_stored + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<45>")
			assert (s + "  fac unchanged", fac.out_as_stored ~ "<9>")
				-- (<<2,1>>).multiply (<<44>>) = <<88,44>>
				-- (513).multiply (44) = 22,572
			create n.from_array (<<2,1>>)
			create fac.from_array (<<44>>)
			s := n.out_as_stored + fn + " (" + fac.out_as_stored + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<88,44>")
				-- (<<1,2,3>>).multiply (<<1,2>>)
				-- (66,051).multiply (258) = 17,041,158
			create n.from_array (<<1,2,3>>)
			create fac.from_array (<<1,2>>)
			s := n.out_as_stored + fn + " (" + fac.out_as_stored + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<1,4,7,6>")
				-- (7777777) * (4444) = 34,564,440,988
			create n.from_array (<<118,173,241>>)
			create fac.from_array (<<17,92>>)
			s := n.out_as_stored + fn + " (" + fac.out_as_stored + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<8,12,51,131,156>")
				-- (88,888,888) * (4,444) = 395,022,218,272
			create n.from_array (<<5,76,86,56>>)
			create fac.from_array (<<17,92>>)
			s := n.out_as_stored + fn + " (" + fac.out_as_stored + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<91,249,40,180,32>")
				-- (4444) * (333) = 1,479,852
			n := new_number_from_string ("4,444")
			fac := new_number_from_string ("333")
			s := n.out + fn + " (" + fac.out + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out + "%N")
			assert (s, n.out ~ "1479852")

				-- (55555) * (333) = 18,499,815.
			n := new_number_from_string ("55,555")
			fac := new_number_from_string ("333")
			s := n.out + fn + " (" + fac.out + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out + "%N")
			assert (s, n.out ~ "18499815")
				-- (-84736487483757564869490010293).multiply (57849399340004949681221)
				--      = -4901954903117222552481914443941818610639794358807753
			n := new_number_from_string ("84,736,487,483,757,564,869,490,010,293")
			n.set_is_negative (true)
			fac := new_number_from_string ("57,849,399,340,004,949,681,221")
			s := n.out + fn + " (" + fac.out + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out + "%N")
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
			create a.from_array (<<1,2>>)
			create b.from_array (<<44>>)
			s := "(" + a.out_as_stored + ")" + fn + " (" + b.out_as_stored + ")"
			io.put_string (s)
			n := a.product (b)
			io.put_string (" = " + n.out_as_stored + "%N")
--			assert (s, n.out ~ "1,4,7,6")
			assert (s, n.out_as_stored ~ "<44,88>")
				-- (<<2,1>>).multiply (<<44>>) = <<88,44>>
				-- (513).multiply (44) = 22,572
			create a.from_array (<<2,1>>)
			create b.from_array (<<44>>)
			s := "(" + a.out_as_stored + ")" + fn + " (" + b.out_as_stored + ")"
			io.put_string (s)
			n := a.product (b)
			io.put_string (" = " + n.out_as_stored + "%N")
--			assert (s, n.out ~ "1,4,7,6")
			assert (s, n.out_as_stored ~ "<88,44>")
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
			tup := [n.zero_word, n.zero_word]
				-- Test case discovered during multiply.
				-- (...).words_multiplied (203, 204, tup):  tup = [161,196] = 41,412
			fn := ".words_multiplied"
			x := (n.ten_word * n.ten_word) * n.two_word + n.three_word
			y := (n.ten_word * n.ten_word) * n.two_word + n.four_word
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "161")
			assert (str + " product", tup.product.out ~ "196")
				-- (...).words_multiplied (230, 204, tup)
			x := (n.ten_word * n.ten_word) * n.two_word + (n.ten_word * n.three_word)
			y := (n.ten_word * n.ten_word) * n.two_word + n.four_word
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "183")
			assert (str + " product", tup.product.out ~ "72")
				-- (...).words_multiplied (34, 204, tup)
			x := (n.ten_word * n.three_word) + n.four_word
			y := (n.ten_word * n.ten_word) * n.two_word + n.four_word
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "27")
			assert (str + " product", tup.product.out ~ "24")
					--------------------------
				-- (...).words_multiplied (203, 143)
			x := (n.ten_word * n.ten_word) * n.two_word + n.three_word
			y := (n.ten_word * n.ten_word) + (n.ten_word * n.four_word) + n.three_word
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "113")
			assert (str + " product", tup.product.out ~ "101")
				-- (...).words_multiplied (230, 143)
			x := (n.ten_word * n.ten_word) * n.two_word + (n.ten_word * n.three_word)
			y := (n.ten_word * n.ten_word) + (n.ten_word * n.four_word) + n.three_word
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "128")
			assert (str + " product", tup.product.out ~ "122")
				-- (...).words_multiplied (34, 143)
			x := (n.ten_word * n.three_word) + n.four_word
			y := (n.ten_word * n.ten_word) + (n.ten_word * n.four_word) + n.three_word
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "18")
			assert (str + " product", tup.product.out ~ "254")
					--------------------------
				-- (...).words_multiplied (203, 90)
			x := (n.ten_word * n.ten_word) * n.two_word + n.three_word
			y := (n.ten_word * n.nine_word)
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "71")
			assert (str + " product", tup.product.out ~ "94")
				-- (...).words_multiplied (230, 90)
			x := (n.ten_word * n.ten_word) * n.two_word + (n.ten_word * n.three_word)
			y := (n.ten_word * n.nine_word)
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "80")
			assert (str + " product", tup.product.out ~ "220")
				-- (...).words_multiplied (34, 90)
			x := (n.ten_word * n.three_word) + n.four_word
			y := (n.ten_word * n.nine_word)
			str := " (...)" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + ":  tup = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[" + tup.carry.out + ", " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "11")
			assert (str + " product", tup.product.out ~ "244")

		end

	words_added
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			n: like testable_number_anchor
			b: like digit_anchor
			x, y, c: like digit_anchor
			tup: TUPLE [sum, carry: like digit_anchor]
		do
			fn := ".words_added"
				-- (n base b).words_added (x, y, c)
			create n
			tup := [n.zero_word, n.zero_word]
				-- (0 base 0).words_added (0, 0, 0)
			x := n.zero_word
			y := n.zero_word
			c := n.zero_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
			io.put_string (str + " = ")
			n.words_added (x, y, c, tup)
			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
			assert (str + " sum", tup.sum.out ~ "0")
			assert (str + " carry", tup.carry.out ~ "0")
				-- (0 base 0).words_added (10, 16, 0)
			x := n.ten_word
			y := n.sixteen_word
			c := n.zero_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
			io.put_string (str + " = ")
			n.words_added (x, y, c, tup)
			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
			assert (str + " sum", tup.sum.out ~ "26")
			assert (str + " carry", tup.carry.out ~ "0")
				-- (0 base 0).words_added (max_word_value, 1, 0)
			x := n.max_word
			y := n.one_word
			c := n.zero_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
			io.put_string (str + " = ")
			n.words_added (x, y, c, tup)
			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
			assert (str + " sum", tup.sum.out ~ "0")
			assert (str + " carry", tup.carry.out ~ "1")
				-- (0 base 0).words_added (max_word_value, max_word_value, 0)
			x := n.max_word
			y := n.max_word
			c := n.zero_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
			io.put_string (str + " = ")
			n.words_added (x, y, c, tup)
			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
			assert (str + " sum", tup.sum.out ~ (n.max_word - n.one_word).out)
			assert (str + " carry", tup.carry.out ~ "1")
				-- (0 base 0).words_added (max_word_value, max_word_value, 1)
			x := n.max_word
			y := n.max_word
			c := n.one_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
			io.put_string (str + " = ")
			n.words_added (x, y, c, tup)
			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
			assert (str + " sum", tup.sum.out ~ (n.max_word).out)
			assert (str + " carry", tup.carry.out ~ "1")
--			------------ Test with a reduced base --------------
--				-- (0 base 0).words_added (max_word_value, four_value, 1)
--			create n.make_with_base (n.eight_value)
--			x := n.max_word_value
--			y := n.four_value
--			c := n.one_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
--			io.put_string (str + " = ")
--			n.words_added (x, y, c, tup)
--			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
--			assert (str + " sum", tup.sum.out ~ "4")
--			assert (str + " carry", tup.carry.out ~ "1")
--				-- (0 base 0).words_added (max_word_value, max_word_value, 1)
--			create n.make_with_base (n.eight_value)
--			x := n.max_word_value
--			y := n.max_word_value
--			c := n.one_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + " (" + x.out + ", " + y.out + ", " + c.out + ")"
--			io.put_string (str + " = ")
--			n.words_addedadded (x, y, c, tup)
--			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.sum.out + "] %N")
--			assert (str + " sum", tup.sum.out ~ (n.max_word_value).out)
--			assert (str + " carry", tup.carry.out ~ "1")
		end


	words_multiplied
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str: STRING_8
			n: like testable_number_anchor
			b: like digit_anchor
			x, y: like digit_anchor
			tup: TUPLE [carry, product: like digit_anchor]
		do
			fn := ".words_multiplied"
				-- (n base b).words_multiplied (x, y, c, tup)
			create n
			tup := [n.zero_word, n.zero_word]
				-- (0 base 0).words_multiplied (0, 0, tup)
			x := n.zero_word
			y := n.zero_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", sum = " + tup.product.out + "] %N")
			assert (str + " sum", tup.product.out ~ "0")
			assert (str + " carry", tup.carry.out ~ "0")
				-- (0 base 0).words_multiplied (10, 10, tup)
			x := n.ten_word
			y := n.ten_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " product", tup.product.out ~ "100")
			assert (str + " carry", tup.carry.out ~ "0")
				-- (0 base 0).words_multiplied (max_representable_value, 2, tup)
			x := n.max_word
			y := n.two_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " product", tup.product = n.max_word - n.one_word)
			assert (str + " carry", tup.carry = n.one_word)
				-- (0 base 0).words_multiplied (max_representable_value, max_representable_value, tup)
			x := n.max_word
			y := n.max_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " product", tup.product = n.one_word)
			assert (str + " carry", tup.carry = n.max_word - n.one_word)
--				-- (0).words_multiplied (99, max_representable_value, tup)
--			b := n.zero_word
--			create n.make_with_base (b)
--			x := n.ten_word * n.nine_word + n.nine_word
--			y := n.max_representable_word
--			str := "(" + n.out_as_stored + ")" + fn
--			str := str + " (" + x.out + ", " + y.out + ")"
--			io.put_string (str + " = ")
--			n.words_multiplied (x, y, tup)
--			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
--			assert (str + " carry", tup.carry.out ~ "98")
--			assert (str + " product", tup.product.out ~ "157")
				-- (...).words_multiplied (255, 255, tup):  tup = [254,1] = 65,025
			create n
			x := n.max_word
			y := n.max_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ (n.max_word - n.one_word).out)
			assert (str + " product", tup.product.out ~ "1")
		end

feature -- Basic operations (selectively exported)

	bit_shift_left
			-- Test and demonstrate feature `bit_shift_left' from
			-- {JJ_BIG_NATURAL}.
		local
			fn, str, s: STRING_8
			n: like testable_number_anchor
			b, v: like digit_anchor
			i: INTEGER
		do
			create n
			str := n.generating_type + ":  "
			fn := ".bit_shift_left"
				-- (00000000).bit_shift_left (7)
			create n
			i := 7
			s := str + "(" + n.out_as_bits + ")" + fn
			s := s + " (" + i.out + ") = "
			io.put_string (s)
			n.bit_shift_left (i)
			io.put_string (n.out_as_bits + "%N")
			assert (s, n.out_as_bits ~ "00000000")
				-- (00000111).bit_shift_left (2)
			v := n.seven_word
			i := 2
			create n.from_value (n.seven_word)
			s := str + "(" + n.out_as_bits + ")" + fn
			s := s + " (" + i.out + ") = "
			io.put_string (s)
			n.bit_shift_left (i)
			io.put_string (n.out_as_bits + "%N")
			assert (str, n.out_as_bits ~ "00011100")
				-- (00011110, 010000001).bit_shift_left (3)
			i := 4
			create n.from_array (<<30,65>>)
			s := str + "(" + n.out_as_bits + ")" + fn
			s := s + " (" + i.out + ") = "
			io.put_string (s)
			n.bit_shift_left (i)
			io.put_string (n.out_as_bits + "%N")
			assert (str, n.out_as_bits ~ "00000001,11100100,00010000")
				-- ([1,2,3,4]).bit_shift_left (7)
			i := 7
			create n.from_array (<<1,2,3,4>>)
			s := str + "(" + n.out_as_bits + ")" + fn
			s := s + " (" + i.out + ") = "
			io.put_string (s)
			n.bit_shift_left (i)
			io.put_string (n.out_as_bits + "%N")
			assert (str, n.out_as_bits ~ "10000001,00000001,10000010,00000000")
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
				-- i := (0b00000000000000000000000000000001).normalize
			create n.from_value (n.one_word)
			s := str + "(" + n.out_as_bits + ").normalize = "
			i := n.normalize
			io.put_string (s + n.out_as_bits + "  i = " + i.out + "%N")
			assert (s + " as_bits", n.out_as_bits ~ "10000000000000000000000000000000")
			assert (s + " i", i = 31)
				-- i := (0b00000000000000000000000000000111).normalize
			create n.from_value (n.seven_word)
			s := str + "(" + n.out_as_bits + ").normalize = "
			i := n.normalize
			io.put_string (s + n.out_as_bits + "  i = " + i.out + "%N")
			assert (s + " as_bits", n.out_as_bits ~ "11100000000000000000000000000000")
			assert (s + " i", i = 29)
				-- i := (0b00000101).normalize
			create n.from_value (n.five_word)
			s := str + "(" + n.out_as_bits + ").normalize = "
			i := n.normalize
			io.put_string (s + n.out_as_bits + "  i = " + i.out + "%N")
			assert (s + " as_bits", n.out_as_bits ~ "10100000000000000000000000000000")
			assert (s + " i", i = 29)
				-- (00011110000000000000000000000000, 0b01011000000000000000000000000001).normalize
			create n.from_array (<<0b00011110000000000000000000000000,0b01011000000000000000000000000001>>)
			io.put_string (str + "(" + n.out_as_bits + ").normalize = ")
			i := n.normalize
			io.put_string (n.out_as_bits + "  i = " + i.out + "%N")
			assert (str, n.out_as_bits ~ "11110000000000000000000000000010,11000000000000000000000000001000")
			assert (s + " i", i = 3)
		end

	as_full_word
			-- Test and demonstrate feature `as_full_word' from
			-- {JJ_BIG_NATURAL}.
		local
			fn, str, s: STRING_8
			n: like testable_number_anchor
			a, b: like digit_anchor
			d: like digit_anchor
		do
			create n
			fn := ".as_full_word"
			str := generating_type + fn + ":  "
			a := n.sixteen_word - n.three_word
			b := n.two_word
			s := str + fn + " (" + a.out + ", " + b.out + ") = "
			io.put_string (s)
			d := n.as_full_word (a, b)
			io.put_string (d.out + "%N")
			assert (s, d.out ~ "210")
		end

	as_half_words
			-- Test and demonstrate feature `as_half_words' from
			-- {JJ_BIG_NATURAL_8}.
		local
			fn, str, s: STRING_8
			n: like testable_number_anchor
			tup: TUPLE [high, low: like digit_anchor]
			a: like digit_anchor
		do
			create n
			fn := ".as_half_words"
			str := generating_type + fn + ":  "
			a := n.max_word - n.one_word
			s := str + fn + " (" + a.out + ") = "
			io.put_string (s)
			tup := n.as_half_words (a)
			s := "[" + tup.high.out + "," + tup.low.out + "]"
			io.put_string (s)
			assert (s, s ~ "[65535,65534]")
		end


	divide_two_words_by_one
			-- Test and demonstrate feature `divide_two_words_by_one' from
			-- {JJ_BIG_NATURAL}.
		local
			a, b, d: like digit_anchor
			fn, str, s: STRING_8
			n: like testable_number_anchor
			denom: like testable_number_anchor
			i: INTEGER_32
			tup: like tuple_anchor
		do
			fn := ".divide_two_words_by_one "
			create n
			str := n.generating_type + fn
			a := 3_591_137_483
			b := 3_865_920_759
			d := 4_000_000_000
				-- Here is a case that was failing in some calls.
			s := str + " (" + a.out + ", " + b.out + ", " + d.out + ")"
			io.put_string (s + " = ")
			tup := n.divide_two_words_by_one (a, b, d)
			io.put_string ("[" + tup.quot.out_as_stored + ", "+ tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot.out_as_stored ~ "<1,66>")
			assert (s + " rem", tup.rem.out_as_stored ~ "<96>")
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
			create b.from_value (a.one_word)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot.is_zero)
			assert (s + " rem", tup.rem.is_zero)
				-- (0).quotient (-1)
			create a
			create b.from_value (a.one_word)
			b.negate
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot.is_zero)
			assert (s + " rem", tup.rem.is_zero)
				-- (9).quotient (1,1)   9/257 = 0 remainder 9
				--       count < other.count
			create a.from_value (n.nine_word)
			create b.from_array (<<1,1>>)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot.is_zero)
			assert (s + " rem", tup.rem ~ a)
				-- (160).quotient (1)
			create a.from_value (n.sixteen_word * n.ten_word)
			create b.from_value (a.one_word)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot ~ a)
			assert (s + " rem", tup.rem.is_zero)
				-- (1,2).quotient (-1)	 258/-1 = -258
			create a.from_array (<<1,2>>)
			create b.from_value (a.one_word)
			b.negate
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot ~ a.opposite)
			assert (s + " rem", tup.rem.is_zero)
				-- Same magnitudes
				-- (4,1).quotient (4,1)		-- 4 * 256^1 + 1 = 1025
			create a.from_array (<<4,1>>)
			create b.from_array (<<4,1>>)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot.is_one)
			assert (s + " rem", tup.rem.is_zero)
				-- (1,2,3).quotient (-1,2,3)		66,049 / -66,049 = -1 rem 0
			create a.from_array (<<1,2,3>>)
			create b.from_array (<<1,2,3>>)
			b.negate
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot.is_one)
			assert (s + " neg quot", tup.quot.is_negative)
			assert (s + " rem", tup.rem.is_zero)
				-- Two-by-one divide case, requiring normalization.
				-- (1,2,3,4).quotient (1,44)	= (219) rem (79)
				--	16,843,009 / 300 = 56,143 rem 109
			create a.from_array (<<1,2,3,4>>)
			create b.from_array (<<1,44>>)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot.out_as_stored ~ "<220,43>")
			assert (s + " rem", tup.rem.out_as_stored ~ "<160>")
				-- X-by-one divide case, requiring conditioning.
				-- (1,2,3).quotient (1,44)	= (220) rem (51)
				--	66,051 / 300 = 220 rem 51
			create a.from_array (<<1,2,3>>)
			create b.from_array (<<1,44>>)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot.out_as_stored ~ "<220>")
			assert (s + " rem", tup.rem.out_as_stored ~ "<51>")
				-- A failing case discovered during timeing tests.
			create a.from_array (<<15,59,225,60,149,85,149,158,57,15,244,99,28>>)
			create b.from_array (<<243,177,116,68,249,106,136,11>>)
			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
			io.put_string (s)
			tup := a.quotient (b)
			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot.out_as_stored ~ "<16,0,212,43,103>")
			assert (s + " rem", tup.rem.out_as_stored ~ "<154,225,51,171,40,33,205,175>")

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

--	words_multiplied
--		local
--			str, s: STRING_8
--			n: like number
--			tup: like {like number}.words_multiplied
--			a, b: like number.base
--		do
--			str := generating_type + ".words_multiplied:  "
--			create n
--				-- 10 * 100
--			a := n.ten_value
--			b := n.ten_value * n.ten_value
--			tup := n.words_multiplied (a, b)
--			s := str + "10 * 100"
--			io.put_string (s + "10 * 100 -- [" + tup.high.out + ", " + tup.low.out + "] %N")
--			assert (s, "[" + tup.high.out + ", " + tup.low.out + "]" ~ "[7, 104]")
--				-- 11 * 100
--			a := a + n.one_value
--			tup := n.words_multiplied (a, b)
--				-- 11 * 101
--			b := b + n.one_value
--			tup := n.words_multiplied (a, b)
--				-- 20 * 101
--			a := a + n.nine_value
--			tup := n.words_multiplied (a, b)
--				-- 29 * 110
--			a := a + n.nine_value
--			b := b + n.nine_value
--			tup := n.words_multiplied (a, b)
--				-- 30 * 110
--			a := a + n.one_value
--			tup := n.words_multiplied (a, b)
--				-- 36 * 107 = 3852  (see Radix conversion paper, example)
--			a := a + n.six_value
--			b := b - n.three_value
--			tup := n.words_multiplied (a, b)
--				-- 127 * 127
--			a := n.max_word
--			b := n.max_word
--			tup := n.words_multiplied (a, b)

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
				-- 10 to one-th power
			n.set_value (n.one_word)
			p := n.ten_to_the_power (n)
			s := str + "ten_to_the_power (" + n.out_formatted + ") = "
			io.put_string (s  +  p.out_formatted + "%N")
			assert (s, p.out_formatted ~ "10")
				-- 10 to 8th power
			create n
			n.set_value (n.eight_word)
			p := n.ten_to_the_power (n)
			s := str + "ten_to_the_power (" + n.out_formatted + ") = "
--			s := str + "ten_to_the_power (" + n.out_as_stored + ") = "
			io.put_string (s  +  p.out_formatted)
--			io.put_string (s  +  p.out_as_stored)
			assert (s, p.out_formatted ~ "100,000,000")
			assert (s, p.out_as_stored ~ "<100000000>")
				-- 10 to 30th power
			create n
			n.set_value (n.ten_word * n.three_word)
			p := n.ten_to_the_power (n)
			s := str + "ten_to_the_power (" + n.out_formatted + ") = "
			io.put_string (s  +  p.out_formatted)
			io.put_string (s  +  p.out_as_stored + "%N")
--			assert (s, p.out_formatted ~ "10,000")
			assert (s, p.out_as_stored ~ "<39,16>")
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
			fn, s: STRING_8
			n, sn: like testable_number_anchor
			a: ARRAY [like digit_anchor]
			i: INTEGER
		do
			fn := ".partition"
			a := <<9,8,7,6,5,4,3,2,1>>
			create n.from_array (a)
				-- Get the low three bits.
			s := n.out_as_stored + fn
			sn := n.partition (3, 1)
			io.put_string (s + " (3,1) = " + sn.out_as_stored + "%N")
			assert (s, sn.out_as_stored ~ "<3,2,1>")
				-- Get some other bits.
			s := n.out_as_stored + fn
			sn := n.partition (8, 4)
			io.put_string (s + " (8,4) = " + sn.out_as_stored + "%N")
			assert (s, sn.out_as_stored ~ "<8,7,6,5,4>")
		end

feature -- Factory access

	new_number: BIG_NUMBER_32
			-- Factory and anchor for new big numbers.
		do
			create Result
		end

	new_number_from_string (a_string: STRING_8): BIG_NUMBER_32
			-- Create a new big number from the contents of `a_string'.
		do
			create Result.from_string (a_string)
		end

feature {NONE} -- Anchors

	digit_anchor: NATURAL_32
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

	number_anchor: BIG_NUMBER_32
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

	testable_number_anchor: TESTABLE_BIG_NUMBER_32
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

end
