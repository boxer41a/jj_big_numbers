note
	description: "[
		Test routines specific to {JJ_BIG_NUMBER_8} numbers.

		Features from {BIG_NUMBER_TESTS}, even though fully defined in
		the {BIG_NUMBER_TESTS} ancestor class, must be redefined here
		in order to be recognized by the automatic test system.
	]"
	author: "Jimmy J. Johnson"

class
	BIG_NUMBER_8_TESTS

inherit

	BIG_NUMBER_TESTS
		redefine
				-- Initialization
			default_create_test,
			set_with_integer,
			set_with_value,
			set_with_string,
			set_with_array,
			set_random,
			set_random_with_digit_count,

--			from_string,
				-- Constants
			bits_per_word,
			zero_word,
			one_word,
			two_word,
			three_word,
			four_word,
			five_word,
			six_word,
			seven_word,
			eight_word,
			nine_word,
			ten_word,
			sixteen_word,
			max_half_word,
			max_word,
			max_ten_power,
			default_karatsuba_threshold,
			default_div_limit,
				-- Access
			zero,
			one,
			ones,
			zeros,
			karatsuba_threshold,
			div_limit,
			hash_code,
			bit_count,
				-- Status report
			is_zero,
			is_one,
			is_base,
--			is_base_multiple,
			is_negative,
			divisible,
				-- Query
			is_same_sign,
			is_less,
			is_magnitude_less,
			is_magnitude_equal,
				-- Basic operations (simple)
--			wipe_out,
			negate,
			increment,
			decrement,
			identity,
			opposite,
			magnitude,
				-- Basic operations (addition & subtraction)
			scalar_add,
			scalar_subtract,
			add,
			plus,
			subtract,
			minus,
				-- Basic operations (multiplication)
			scalar_multiply,
			scalar_product,
			multiply,
			product,
				-- Basic operations (division)
			quotient,
			integer_quotient,
			integer_remainder,
				-- Basic operations (exponentiation)
			raise,
			power,
			power_modulo,
				-- Implementation (division)
			bit_shift_left,

				-- Implementation
			digit_anchor,
			number_anchor,
			testable_number_anchor
		end

feature -- Constants

	known_bits_per_word: INTEGER = 8
			-- Know number of bits in each word

	known_max_word: NATURAL_8 = 0xFF
			-- Known value of the max value representable in a word.

	known_max_half_word: NATURAL_8 = 0x0F
			-- Known value of the max value representable in a half a word

	known_max_ten_power: NATURAL_8 = 100
			-- Known value of the maximum multiple of 10 representable in a word

feature -- Basic operations (initialization tests)

	default_create_test
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	set_with_integer
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	set_with_value
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	set_with_string
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	set_with_array
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	set_random
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	set_random_with_digit_count
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

--	from_string
--			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
--		local
--			gt, fn, str, s: STRING_8
--			n: like number_anchor
--		do
--			io.put_string ("{BIG_NUMBER_8_TESTS} with output as stored: %N")
--			n := new_number
--			gt := n.generating_type + ":  "
--			fn := ".from_string "
--			str := gt + fn
--				-- Test
--			s := "3852"
--			io.put_string (str + "(%"" + s + "%") = ")
--			n.from_string (s)
--			io.put_string (n.out_as_stored + "%N")
--			assert (s + " out_as_stored ", n.out_as_stored ~ "<15,12>")
--				-- Longer number
--			s := "10,987,654,321"
--			io.put_string (str + "(%"" + s + "%") = ")
--			n.from_string (s)
--			io.put_string ( n.out_as_stored + "%N")
--			assert (s + " out_as_stored ", n.out_as_stored ~ "<2,142,234,76,177>")
--				-- Negative number
--			s := "-00012,34"
--			io.put_string (str + "(%"" + s + "%") = ")
--			n.from_string (s)
--			io.put_string (n.out_as_stored + "%N")
--			assert (s + " out_as_stored ", n.out_as_stored ~ "-<4,210>")
--				-- Failing ? number
--			s := "33333"
--			io.put_string (str + "(%"" + s + "%") = ")
--			n.set_is_negative (false)
--			n.from_string (s)
--			io.put_string (n.out_as_stored + "%N")
--			assert (s + " out_as_stored ", n.out_as_stored ~ "<130,53>")
--				-- Number arrived at during failing simple_multiply?
--			s := "26,558,760"
--			io.put_string (str + "(%"" + s + "%") = ")
--			n.from_string (s)
--			s := str + fn + "(%"" + n.out + "%") = "
--			io.put_string (n.out_as_stored + "%N")
--			assert (s + " out_as_stored ", n.out_as_stored ~ "<1,149,65,40>")
--				-- Call general tests.
--			io.put_string ("Precursor ")
--			Precursor
--		end

feature -- Basic operations (constants tests)

	bits_per_word
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	zero_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	one_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	two_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	three_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	four_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	five_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	six_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	seven_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	eight_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	nine_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	ten_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	sixteen_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	max_half_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	max_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	max_ten_power
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	default_karatsuba_threshold
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

	default_div_limit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor {BIG_NUMBER_TESTS}
		end

feature -- Basic operations (Access & setters)

	zero
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	one
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	ones
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	zeros
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	karatsuba_threshold
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	div_limit
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	hash_code
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	bit_count
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

feature -- Basic operations (Status report tests)

	is_zero
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	is_one
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	is_base
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

--	is_base_multiple
--			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
--		do
--			Precursor
--		end

	is_negative
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	divisible
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

feature -- Test Queries

	is_same_sign
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	is_less
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	is_magnitude_less
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	is_magnitude_equal
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

feature -- Test basic operations (simple)

--	wipe_out
--			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
--		do
--			Precursor
--		end

	negate
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	increment
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	decrement
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	identity
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	opposite
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	magnitude
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

feature -- Test basic operations (addition & subtraction)

	scalar_add
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	scalar_subtract
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	add
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	plus
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	subtract
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	minus
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

feature -- Test basic operations (multiplication)

	scalar_multiply
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	scalar_product
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	multiply
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	product
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

feature -- Test basic operations (division

	quotient
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	integer_quotient
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	integer_remainder
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

feature -- Test basic operations (exponentiation)

	raise
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	power
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

	power_modulo
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end

feature -- Test implementation (division)

	bit_shift_left
			-- Test the corresponding feature from {JJ_BIG_NUMBER}.
		do
			Precursor
		end



feature -- Basic operations (additional implementation tests)

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

	words_addedadded
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
		local
			fn, str: STRING_8
			n: like testable_number_anchor
			b: like digit_anchor
			x, y, c: like digit_anchor
			tup: TUPLE [sum, carry: like digit_anchor]
		do
			fn := ".words_addedadded"
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
			-- Tests the corresponding feature from {JJ_BIG_NUMBER}.
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
			assert (str + " carry", tup.carry.out ~ "254")
			assert (str + " product", tup.product.out ~ "1")


				-- Test case discovered during multiply.
				-- (...).words_multiplied (203, 204, tup):  tup = [161,196] = 41,412
			create n
			x := (n.ten_word * n.ten_word) * n.two_word + n.three_word
			y := (n.ten_word * n.ten_word) * n.two_word + n.four_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "161")
			assert (str + " product", tup.product.out ~ "196")
				-- (...).words_multiplied (230, 204, tup)
			create n
			x := (n.ten_word * n.ten_word) * n.two_word + (n.ten_word * n.three_word)
			y := (n.ten_word * n.ten_word) * n.two_word + n.four_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "183")
			assert (str + " product", tup.product.out ~ "72")
				-- (...).words_multiplied (34, 204, tup)
			create n
			x := (n.ten_word * n.three_word) + n.four_word
			y := (n.ten_word * n.ten_word) * n.two_word + n.four_word
			str := "(" + n.out_as_stored + ")" + fn
			str := str + " (" + x.out + ", " + y.out + ")"
			io.put_string (str + " = ")
			n.words_multiplied (x, y, tup)
			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
			assert (str + " carry", tup.carry.out ~ "27")
			assert (str + " product", tup.product.out ~ "24")


			--------------  reduced base  ----------------
--				-- (0 base 100).words_multiplied (1, max_word_value, tup)
--			b := n.ten_value * n.ten_value
--			create n.make_with_base (b)
--			x := n.one_value
--			y := n.max_word_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + " (" + x.out + ", " + y.out + ")"
--			io.put_string (str + " = ")
--			n.words_multiplied (x, y, tup)
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
--			n.words_multiplied (x, y, tup)
--			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
--			assert (str + " carry", tup.carry.out ~ "0")
--			assert (str + " product", tup.product.out ~ "99")
--				-- (0 base 100).words_multiplied (99, 99, tup)
--			b := n.ten_value * n.ten_value
--			create n.make_with_base (b)
--			x := n.ten_value * n.nine_value + n.nine_value
--			y := n.ten_value * n.nine_value + n.nine_value
--			str := "(" + n.out_as_stored + " base " + n.base.out + ")" + fn
--			str := str + " (" + x.out + ", " + y.out + ")"
--			io.put_string (str + " = ")
--			n.words_multiplied (x, y, tup)
--			io.put_string ("[carry = " + tup.carry.out + ", product = " + tup.product.out + "] %N")
--			assert (str + " product", tup.product = n.max_representable_value \\ b)
--			assert (str + " carry", tup.carry = n.max_representable_value // b)
		end

feature -- Basic operations (selectively exported)

--	bit_shift_left
--			-- Test and demonstrate feature `bit_shift_left' from
--			-- {JJ_BIG_NUMBER}.
--		local
--			fn, str, s: STRING_8
--			n: like testable_number_anchor
--			b, v: like digit_anchor
--			i: INTEGER
--		do
--			create n
--			str := n.generating_type + ":  "
--			fn := ".bit_shift_left"
--				-- (00000000).bit_shift_left (7)
--			create n
--			i := 7
--			s := str + "(" + n.out_as_bits + ")" + fn
--			s := s + " (" + i.out + ") = "
--			io.put_string (s)
--			n.bit_shift_left (i)
--			io.put_string (n.out_as_bits + "%N")
--			assert (s, n.out_as_bits ~ "00000000")
--				-- (00000111).bit_shift_left (2)
--			v := n.seven_word
--			i := 2
--			create n.from_value (n.seven_word)
--			s := str + "(" + n.out_as_bits + ")" + fn
--			s := s + " (" + i.out + ") = "
--			io.put_string (s)
--			n.bit_shift_left (i)
--			io.put_string (n.out_as_bits + "%N")
--			assert (str, n.out_as_bits ~ "00011100")
--				-- (00011110, 010000001).bit_shift_left (3)
--			i := 4
--			create n.from_array (<<30,65>>)
--			s := str + "(" + n.out_as_bits + ")" + fn
--			s := s + " (" + i.out + ") = "
--			io.put_string (s)
--			n.bit_shift_left (i)
--			io.put_string (n.out_as_bits + "%N")
--			assert (str, n.out_as_bits ~ "00000001,11100100,00010000")
--				-- ([1,2,3,4]).bit_shift_left (7)
--			i := 7
--			create n.from_array (<<1,2,3,4>>)
--			s := str + "(" + n.out_as_bits + ")" + fn
--			s := s + " (" + i.out + ") = "
--			io.put_string (s)
--			n.bit_shift_left (i)
--			io.put_string (n.out_as_bits + "%N")
--			assert (str, n.out_as_bits ~ "10000001,00000001,10000010,00000000")
--		end

	normalize
			-- Test and demonstrate feature `normalize' from {JJ_BIG_NUMBER}.
		local
			str, s: STRING_8
			n: like testable_number_anchor
			i: INTEGER_32
		do
			str := generating_type + ".normalize:  "
			create n
				-- i := (x0000001).normalize
			create n.from_value (n.one_word)
			s := str + "(" + n.out_as_bits + ").normalize = "
			i := n.normalize
			io.put_string (s + n.out_as_bits + "  i = " + i.out + "%N")
			assert (s + " as_bits", n.out_as_bits ~ "10000000")
			assert (s + " i", i = 7)
				-- i := (x0000111).normalize
			create n.from_value (n.seven_word)
			s := str + "(" + n.out_as_bits + ").normalize = "
			i := n.normalize
			io.put_string (s + n.out_as_bits + "  i = " + i.out + "%N")
			assert (s + " as_bits", n.out_as_bits ~ "11100000")
			assert (s + " i", i = 5)
				-- i := (xxxx0101).normalize
			create n.from_value (n.five_word)
			s := str + "(" + n.out_as_bits + ").normalize = "
			i := n.normalize
			io.put_string (s + n.out_as_bits + "  i = " + i.out + "%N")
			assert (s + " as_bits", n.out_as_bits ~ "10100000")
			assert (s + " i", i = 5)
				-- (00011110, 010000001).normalize
			create n.from_array (<<30,65>>)
			io.put_string (str + "(" + n.out_as_bits + ").normalize = ")
			i := n.normalize
			io.put_string (n.out_as_bits + "  i = " + i.out + "%N")
			assert (str, n.out_as_bits ~ "11110010,00001000")
			assert (s + " i", i = 3)
		end

	as_full_word
			-- Test and demonstrate feature `as_full_word' from
			-- {JJ_BIG_NUMBER}.
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
			-- Test and demonstrat feature `as_half_words' from
			-- {JJ_BIG_NUMBER_8}.
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
			assert (s, s ~ "[15,14]")
		end


	divide_two_words_by_one
			-- Test and demonstrate feature `divide_two_words_by_one' from
			-- {JJ_BIG_NUMBER}.
		local
			a, b, d: like digit_anchor
			fn, str, s: STRING_8
			n: like testable_number_anchor
			denom: like testable_number_anchor
			i: INTEGER_32
			tup: like tuple_anchor
		do
			fn := ".divide_two_words_by_one"
			str := generating_type + fn
			create n
				-- Here is a case that was failing in some calls.
			a := n.max_word - n.four_word
			b := n.max_word - n.sixteen_word + n.one_word
			d := n.two_word * n.ten_word * n.ten_word
			s := str + " (" + a.out + ", " + b.out + ", " + d.out + ")"
			io.put_string (s + " = ")
			tup := n.divide_two_words_by_one (a, b, d)
			io.put_string ("[" + tup.quot.out_as_stored + ", "+ tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot.out_as_stored ~ "<1,66>")
			assert (s + " rem", tup.rem.out_as_stored ~ "<96>")
				-- [110,36] / [200] = [[140], [196]]
				-- 28,196 / 200 = 140 rem 196
			a := 110
			b := 36
			d := 200
			s := str + " (" + a.out + ", " + b.out + ", " + d.out + ")"
			io.put_string (s + " = ")
			tup := n.divide_two_words_by_one (a, b, d)
			io.put_string ("[" + tup.quot.out_as_stored + ", "+ tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot.out_as_stored ~ "<140>")
			assert (s + " rem", tup.rem.out_as_stored ~ "<196>")
				-- [171,154] / [200] = [[219], [130]]
				-- 43,930 / 200 = 219 rem 130
			a := 171
			b := 154
			d := 200
			s := str + " (" + a.out + ", " + b.out + ", " + d.out + ")"
			io.put_string (s + " = ")
			tup := n.divide_two_words_by_one (a, b, d)
			io.put_string ("[" + tup.quot.out_as_stored + ", "+ tup.rem.out_as_stored + "] %N")
			assert (s + " quot", tup.quot.out_as_stored ~ "<219>")
			assert (s + " rem", tup.rem.out_as_stored ~ "<130>")
				-- 356 / 50 = [7, rem 6]
			create n.from_array (<<1,100>>)
			create denom.from_array (<<50>>)
			i := 0
			if not denom.is_normalized then
				denom.set_unstable
				n.set_unstable
				i := denom.normalize
				n.bit_shift_left (i)
				check
					denom_is_noramlized: denom.is_normalized
				end
			end
			s := str + " 356/50  -- (" + n.out_as_bits + " / " + denom.out_as_bits + ")"
			io.put_string (s + " = ")
			tup := n.divide_two_words_by_one (n.i_th (2), n.i_th (1), denom.i_th (1))
--			tup.rem.bit_shift_left (i)
			io.put_string ("[(" + tup.quot.out_as_stored + "), ("+ tup.rem.out_as_stored + ")] %N")
			assert (s + " quot", tup.quot.out_as_stored ~ "<7>")
--			assert (s + " rem", tup.rem.out_as_stored ~ "<6>")
				-- Answer without bit shifting (feature unavailable for export)
			assert (s + " rem", tup.rem.out_as_stored ~ "<24>")
		end

--	scalar_divide
--			-- Test and demonstrate feature `scalar_divide' from {JJ_BIG_NUMBER}.
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

--	quotient
--		local
--			fn, str, s: STRING_8
--			n, a, b: like testable_number_anchor
--			tup: like tuple_anchor
--			i: INTEGER_32
--		do
--			fn := ".quotient"
--			str := generating_type + fn + ":  "
--			create n
--				-- (0).quotient (1)
--			create a
--			create b.from_value (a.one_word)
--			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
--			io.put_string (s)
--			tup := a.quotient (b)
--			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
--			assert (s + " quot", tup.quot.is_zero)
--			assert (s + " rem", tup.rem.is_zero)
--				-- (0).quotient (-1)
--			create a
--			create b.from_value (a.one_word)
--			b.negate
--			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
--			io.put_string (s)
--			tup := a.quotient (b)
--			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
--			assert (s + " quot", tup.quot.is_zero)
--			assert (s + " rem", tup.rem.is_zero)
--				-- (9).quotient (1,1)   9/257 = 0 remainder 9
--				--       count < other.count
--			create a.from_value (n.nine_word)
--			create b.from_array (<<1,1>>)
--			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
--			io.put_string (s)
--			tup := a.quotient (b)
--			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
--			assert (s + " quot", tup.quot.is_zero)
--			assert (s + " rem", tup.rem ~ a)
--				-- (160).quotient (1)
--			create a.from_value (n.sixteen_word * n.ten_word)
--			create b.from_value (a.one_word)
--			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
--			io.put_string (s)
--			tup := a.quotient (b)
--			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
--			assert (s + " quot", tup.quot ~ a)
--			assert (s + " rem", tup.rem.is_zero)
--				-- (1,2).quotient (-1)	 258/-1 = -258
--			create a.from_array (<<1,2>>)
--			create b.from_value (a.one_word)
--			b.negate
--			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
--			io.put_string (s)
--			tup := a.quotient (b)
--			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
--			assert (s + " quot", tup.quot ~ a.opposite)
--			assert (s + " rem", tup.rem.is_zero)
--				-- Same magnitudes
--				-- (4,1).quotient (4,1)		-- 4 * 256^1 + 1 = 1025
--			create a.from_array (<<4,1>>)
--			create b.from_array (<<4,1>>)
--			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
--			io.put_string (s)
--			tup := a.quotient (b)
--			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
--			assert (s + " quot", tup.quot.is_one)
--			assert (s + " rem", tup.rem.is_zero)
--				-- (1,2,3).quotient (-1,2,3)		66,049 / -66,049 = -1 rem 0
--			create a.from_array (<<1,2,3>>)
--			create b.from_array (<<1,2,3>>)
--			b.negate
--			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
--			io.put_string (s)
--			tup := a.quotient (b)
--			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
--			assert (s + " quot", tup.quot.is_one)
--			assert (s + " neg quot", tup.quot.is_negative)
--			assert (s + " rem", tup.rem.is_zero)
--				-- Two-by-one divide case, requiring normalization.
--				-- (1,2,3,4).quotient (1,44)	= (219) rem (79)
--				--	16,843,009 / 300 = 56,143 rem 109
--			create a.from_array (<<1,2,3,4>>)
--			create b.from_array (<<1,44>>)
--			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
--			io.put_string (s)
--			tup := a.quotient (b)
--			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
--			assert (s + " quot", tup.quot.out_as_stored ~ "<220,43>")
--			assert (s + " rem", tup.rem.out_as_stored ~ "<160>")
--				-- X-by-one divide case, requiring conditioning.
--				-- (1,2,3).quotient (1,44)	= (220) rem (51)
--				--	66,051 / 300 = 220 rem 51
--			create a.from_array (<<1,2,3>>)
--			create b.from_array (<<1,44>>)
--			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
--			io.put_string (s)
--			tup := a.quotient (b)
--			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
--			assert (s + " quot", tup.quot.out_as_stored ~ "<220>")
--			assert (s + " rem", tup.rem.out_as_stored ~ "<51>")
--				-- A failing case discovered during timeing tests.
--			create a.from_array (<<15,59,225,60,149,85,149,158,57,15,244,99,28>>)
--			create b.from_array (<<243,177,116,68,249,106,136,11>>)
--			s := str + "(" + a.out_as_stored + ")" + fn + "(" + b.out_as_stored + ") = "
--			io.put_string (s)
--			tup := a.quotient (b)
--			io.put_string ("[" + tup.quot.out_as_stored + ", " + tup.rem.out_as_stored + "] %N")
--			assert (s + " quot", tup.quot.out_as_stored ~ "<16,0,212,43,103>")
--			assert (s + " rem", tup.rem.out_as_stored ~ "<154,225,51,171,40,33,205,175>")

--		end

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
		local
			str, fn: STRING_8
			n: like testable_number_anchor
			t: like {like number_anchor}.power_of_ten_table
		do
			create n
			str := n.generating_type + ":  "
			fn := ".power_of_ten_table:  "
			str := str + fn
			t := n.power_of_ten_table
			io.put_string (str + "capacity = " + t.capacity.out + "%N")
			io.put_string (str + "   count = " + t.count.out + "%N")
			assert (str + "capacity", t.capacity >= n.default_table_size)
			assert (str + "count", t.count >= 0)
		end

--	ten_to_the_power
--			-- Tests the intended once-ness of the `power_of_ten_table'
--			-- somewhat tests its memoization usage.
--			-- This test feature must be called before any math operations
--			-- that access the `power_of_ten_table'.
--		local
--			str, s: STRING_8
--			n: like testable_number_anchor
--			t: like {like number_anchor}.power_of_ten_table
--			c: INTEGER
--			p: like number_anchor
--		do
--			str := ".ten_to_the_power:  "
--			create n
--			t := n.power_of_ten_table
--			c := n.power_of_ten_table.count
--			s := str + "count = "
--			io.put_string (s + t.count.out + "%N")
--			assert (s, t.count = 0)
--				-- 10 to one-th power
--			n.set_value (n.one_word)
--			p := n.ten_to_the_power (n)
--			s := str + "ten_to_the_power (" + n.out_formatted + ") = "
--			io.put_string (s  +  p.out_formatted)
--			io.put_string ("  count = " + t.count.out + "%N")
--			assert (s, p.out_formatted ~ "10")
--			assert (s + "  count", t.count = 2)
--				-- 10 to 8th power
--			n.set_value (n.eight_word)
--			p := n.ten_to_the_power (n)
----			s := str + "ten_to_the_power (" + n.out_formatted + ") = "
--			s := str + "ten_to_the_power (" + n.out_as_stored + ") = "
----			io.put_string (s  +  p.out_formatted)
--			io.put_string (s  +  p.out_as_stored)
--			io.put_string ("  count = " + t.count.out + "%N")
--			assert (s, p.out_as_stored ~ "<5,245,225,0>")
----			assert (s, p.out_formatted ~ "100,000,000")
----			assert (s + "  count", t.count = 9)
--				-- 10 to 4th power
--			n.set_value (n.four_word)
--			p := n.ten_to_the_power (n)
--			s := str + "ten_to_the_power (" + n.out_formatted + ") = "
----			io.put_string (s  +  p.out_formatted)
--			io.put_string (s  +  p.out_as_stored + "%N")
----			assert (s, p.out_formatted ~ "10,000")
--			assert (s, p.out_as_stored ~ "<39,16>")
--		end

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
			set_verbose
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

	new_number: JJ_BIG_NUMBER_8
			-- Factory and anchor for new big numbers.
		do
			create Result
		end

	new_number_from_integer (a_value: INTEGER): like number_anchor
			-- Create a new big number from `a_value'
		do
			create Result.from_integer (a_value)
		end

	new_number_from_value (a_value: like digit_anchor): JJ_BIG_NUMBER_8
			-- Create a new big number from `a_value'
		do
			create Result.from_value (a_value)
		end

	new_number_from_string (a_string: STRING_8): JJ_BIG_NUMBER_8
			-- Create a new big number from the contents of `a_string'.
		do
			create Result.from_string (a_string)
		end

	new_number_from_array (a_array: ARRAY [like digit_anchor]): JJ_BIG_NUMBER_8
			-- Create a new big number from contents of `a_array'.
		do
			create Result.from_array (a_array)
		end

	random: JJ_NATURAL_8_RNG
			-- A generator for 8-bit values
		once
			create Result
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

	number_anchor: JJ_BIG_NUMBER_8
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

	testable_number_anchor: TESTABLE_BIG_NUMBER_8
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
