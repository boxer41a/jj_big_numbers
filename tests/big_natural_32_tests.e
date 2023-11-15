note
	description: "Summary description for {BIG_NATURAL_32_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BIG_NATURAL_32_TESTS

inherit

	BIG_NATURAL_TESTS
		redefine
			run_known_fails,
				-- Initialization
			default_create_test,
			set_with_integer,
			set_with_value,
			set_with_string,
			set_with_array,
			set_random,
			set_random_with_digit_count,
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
				-- Queries
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
			scalar_sum,
			scalar_difference,
			plus,
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
				-- Basic operations (implementation--division)
--			bit_shift_left,



				-- Implementation
			digit_anchor,
			number_anchor
		end

feature -- Constants

	known_bits_per_word: INTEGER = 32
			-- Know number of bits in each word

	known_max_word: NATURAL_32 = 0xFFFFFFFF
			-- Known value of the max value representable in a word.

	known_max_half_word: NATURAL_32 = 0x0000FFFF
			-- Known value of the max value representable in a half a word

	known_max_ten_power: NATURAL_32 = 1_000_000_000
			-- Known value of the maximum multiple of 10 representable in a word

feature -- Failed tests

	run_known_fails
			-- Run tests that were previously discovered to fail
		local
			s: STRING
			pow: NATURAL_32
			n, n2: like number_anchor
			mp_n: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			io.put_string ("{BIG_NATURAL_32_TESTS}.run_known_fails: %N")
				-- fails with integer_remainder
			s := "67481806940030140066982757483494117521"
			n := new_number
			n.set_with_string (s)
			n2 := new_number
			s := "16580898624578913509"
			n2.set_with_string (s)
			function (agent n.integer_quotient (n2), "integer_quotient", "4069852211749102341")
			function (agent n.integer_remainder (n2), "integer_remainder", "2845594835665692952")
				-- fails in quotient
			divider ("raise")
			s := "157682840352094851032842628677015822187"
			n := new_number
			n.set_with_string (s)
			create mp_n.make_string (s)
			procedure (agent n.raise (9), "raise")
			function (agent n.out, "out", mp_n.power (9).out)
		end

feature -- Initialization tests

	default_create_test
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	set_with_integer
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	set_with_value
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	set_with_string
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	set_with_array
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	set_random
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	set_random_with_digit_count
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

feature -- Basic operations (constants tests)

	bits_per_word
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	zero_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	one_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	two_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	three_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	four_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	five_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	six_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	seven_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	eight_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	nine_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	ten_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	sixteen_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	max_half_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	max_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	max_ten_power
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	default_karatsuba_threshold
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

	default_div_limit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor {BIG_NATURAL_TESTS}
		end

feature -- Basic operations (Access & setters)

	zero
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	one
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	ones
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	zeros
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	karatsuba_threshold
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	div_limit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	hash_code
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	bit_count
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

feature -- Test status reports

	is_zero
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	is_one
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	is_base
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

--	is_base_multiple
--			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
--		do
--			Precursor
--		end

	is_negative
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	divisible
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

feature -- Test Queries

	is_same_sign
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	is_less
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	is_magnitude_less
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	is_magnitude_equal
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

feature -- Test basic operations (simple)

--	wipe_out
--			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
--		do
--			Precursor
--		end

	negate
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	increment
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	decrement
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	identity
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	opposite
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	magnitude
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

feature -- Test basic operations (addition & subtraction)

	scalar_sum
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	scalar_difference
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	plus
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	minus
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

feature -- Test basic operations (multiplication)

	scalar_multiply
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	scalar_product
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	multiply
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	product
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

feature -- Test basic operations (division

	quotient
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	integer_quotient
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	integer_remainder
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

feature -- Test basic operations (exponentiation)

	raise
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	power
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

	power_modulo
			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
		do
			Precursor
		end

feature -- Test implementation (division)

--	bit_shift_left
--			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
--		do
--			Precursor
--		end

feature {NONE} -- Factory access

	new_number: like number_anchor
			-- Factory and anchor for new big numbers.
		do
			create Result
		end

	new_number_from_integer (a_value: INTEGER): like number_anchor
			-- Create a new big number from `a_value'
		do
			create Result.from_integer (a_value)
		end

	new_number_from_value (a_value: like digit_anchor): JJ_BIG_NATURAL_32
			-- Create a new big number from `a_value'
		do
			create Result.from_value (a_value)
		end

	new_number_from_string (a_string: STRING_8): JJ_BIG_NATURAL_32
			-- Create a new big number from the contents of `a_string'.
		do
			create Result.from_string (a_string)
		end

	new_number_from_array (a_array: ARRAY [like digit_anchor]): JJ_BIG_NATURAL_32
			-- Create a new big number from contents of `a_array'.
		do
			create Result.from_array (a_array)
		end

	random: JJ_NATURAL_32_RNG
			-- A generator for 32-bit values
		once
			create Result
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

	number_anchor: JJ_BIG_NATURAL_32
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

end
