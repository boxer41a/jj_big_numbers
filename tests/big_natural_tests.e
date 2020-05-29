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
		redefine
			on_prepare
		end

feature {NONE} -- Events

	on_prepare
			-- Called after all initializations in `default_create'.
			-- Redefined to set `test_limit' for auto-testing.
		do
			test_limit := Default_test_limit
			word_limit := Default_word_limit
			digit_limit := Default_digit_limit
			power_limit := Default_power_limit
		end

feature -- Constants

	known_bits_per_word: INTEGER
			-- Know number of bits in each word
		deferred
		end

	known_max_word: like digit_anchor
			-- Known value of the max value representable in a word.
		deferred
		end

	known_max_half_word: like digit_anchor
			-- Known value of the max value representable in a half a word
		deferred
		end

	known_max_ten_power: like digit_anchor
			-- Known value of the maximum multiple of 10 representable in a word
		deferred
		end

	format_as_string: INTEGER = 0
			-- Display a {JJ_BIG_NUMBER} as a decimal number

	format_as_stored: INTEGER = 1
			-- Display a {JJ_BIG_NUMBER} using `out_as_stored'
			-- (i.e. <1,2,3,4>)

	format_as_bits: INTEGER = 2
			-- Display a {JJ_BIG_NUMBER} using `out_as_binary'
			-- (i.e. <11110011, 00011011, 00000001>)

	Default_test_limit: INTEGER = 30
			-- The default number of times to run a test.

	Default_word_limit: INTEGER = 4
			-- The default max number of words to create for tests

	Default_digit_limit: INTEGER = 10
			-- The default number of digits to create for tests

	Default_power_limit: INTEGER = 10
			-- The default maximum value allowed for exponentiation tests

feature -- Access

	test_limit: INTEGER
			-- The number of times to run a test

	word_limit: INTEGER
			-- The maximum number of words to create for tests

	digit_limit: INTEGER
			-- The maximum number of digits to create for tests

	power_limit: INTEGER
			-- The maximum exponent allowed in exponetiation tests

	target_format: INTEGER
			-- The format in which to display the target of calls is `signature'

	argument_format: INTEGER
			-- The format in which to display arguments in `signature'

	result_format: INTEGER
			-- The format in which to display results

feature -- Element change

	set_test_limit (a_limit: INTEGER)
			-- Set `test_limit' to `a_count'
		require
			count_big_enough: a_limit >= 1
		do
			test_limit := a_limit
		end

	set_word_limit (a_limit: INTEGER)
			-- Set `word_limit'
		require
			count_big_enough: a_limit >= 1
		do
			word_limit := a_limit
		end

	set_digit_limit (a_limit: INTEGER)
			-- Set `word_limit'
		require
			count_big_enough: a_limit >= 1
		do
			word_limit := a_limit
		end

	set_power_limit (a_limit: INTEGER)
			-- Set `word_limit'
		require
			count_big_enough: a_limit >= 1
		do
			power_limit := a_limit
		end

	set_target_format (a_format: INTEGER_32)
			-- Change `target_format' to `a_format'
		require
			format_big_enough: a_format >= format_as_string
			format_small_enough: a_format <= format_as_bits
		do
			target_format := a_format
		end

	set_argument_format (a_format: INTEGER_32)
			-- Change `argument_format' to `a_format'
		require
			format_big_enough: a_format >= format_as_string
			format_small_enough: a_format <= format_as_bits
		do
			argument_format := a_format
		end

	set_result_format (a_format: INTEGER_32)
			-- Change `result_format' to `a_format'
		require
			format_big_enough: a_format >= format_as_string
			format_small_enough: a_format <= format_as_bits
		do
			result_format := a_format
		end

feature -- Status report

	is_terse: BOOLEAN
			-- Should the report features print extra information?

feature -- Status setting

	set_verbose
			-- Force tests to output little or no information to `io'
		do
			is_terse := false
		end

	set_terse
			-- Force tests to output information to `io' when executed.
		do
			is_terse := true
		end

feature -- Basic operations

	run_all
			-- Demo/test all the features on the current `tester'.
		do
			bit_shift_left
			integer_remainder

			run_initialization_tests
			run_constants_tests
			run_access_tests
			run_status_report_tests
			run_query_tests
			run_simple_basic_operations_tests
			run_addition_and_subtraction_tests
			run_multiplication_tests
			run_exponetiation_tests
		end

	run_initialization_tests
			-- Test creation & related features of {JJ_BIG_NATURAL}
		do
			put_line ("Initialization")
			default_create_test
			set_with_integer
			set_with_value
			set_with_string
--			set_with_array			-- give inconsistent results ???
			set_random
			set_random_with_digit_count
		end

	run_constants_tests
			-- Test the constants of {JJ_BIG_NATURAL}
		do
			put_line ("Constants")
			bits_per_word
			zero_word
			one_word
			two_word
			three_word
			four_word
			five_word
			six_word
			seven_word
			eight_word
			nine_word
			ten_word
			sixteen_word
			max_half_word
			max_word
			max_ten_power
			default_karatsuba_threshold
			default_div_limit
		end

	run_access_tests
			-- Test access features of {JJ_BIG_NATURAL}
		do
			put_line ("Access")
			zero
			one
			ones
			zeros
			karatsuba_threshold
			div_limit
			hash_code
			bit_count
		end

	run_status_report_tests
			-- Test access features of {JJ_BIG_NATURAL}
		do
			put_line ("Status report")
			is_zero
			is_one
			is_base
--			is_base_multiple
--			is_negative				-- Why failing precondition ??
--			divisible
		end

	run_query_tests
			-- Test the query features of {JJ_BIG_NATURAL}
		do
			put_line ("Query")
			is_same_sign
			is_less
			is_magnitude_less
			is_magnitude_equal
		end

	run_simple_basic_operations_tests
			-- Test simple basic operations features of {JJ_BIG_NATURAL}
		do
			put_line ("Basic Operations (simple)")
--			wipe_out
			negate
			increment
			decrement
			identity
			opposite
			magnitude
		end

	run_addition_and_subtraction_tests
			-- Test addition and subtraction features of {JJ_BIG_NATURAL}
		do
			put_line ("Basic Operations (addition & subtraction)")
			scalar_add
			scalar_subtract
			add
			plus
			subtract
			minus
		end

	run_multiplication_tests
			-- Test multiplication feature of {JJ_BIG_NATURAL}
		do
			put_line ("Basic Operations (multiplication)")
			scalar_multiply
			scalar_product
			multiply
			product
		end

	run_exponetiation_tests
			-- Test exponetiation feature of {JJ_BIG_NATURAL}
		do
			put_line ("Basic Operations (exponetiation)")
			raise
			power
			power_modulo
		end

feature -- Test Initializations

	default_create_test
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
		do
			n := new_number
			s := signature (n, "default_create", {ARRAY [ANY]} <<>>)
			io.put_string (s + n.out_as_stored + "%N")
			assert (s, n.out_as_stored ~ "<0>")
		end

	set_with_integer
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			i: INTEGER_32
			b: BOOLEAN
			fn, s: STRING_8
			n: like number_anchor
			v: INTEGER_32
		do
			fn := "set_with_integer"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				v := es_random.item
				es_random.forth
				if es_random.real_item > 0.5 then
					v := -v
				end
				es_random.forth
				n := new_number
				s := signature (n, fn, <<v>>)
				io.put_string (s)
				n.set_with_integer (v)
				n.set_with_integer (v)
				io.put_string (n.out + "%N")
				assert (s, n.out ~ v.out)
				i := i + 1
			end
		end

	set_with_value
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			i: INTEGER
			fn, s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			fn := "set_with_value"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				v := random.item
				random.forth
				n := new_number
				s := signature (n, fn, <<v>>)
				n.set_with_value (v)
				io.put_string (s + n.out_as_stored + "%N")
				assert (s, n.out_as_stored ~ "<" + v.out + ">")
				i := i + 1
			end
		end

	set_with_string
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			i: INTEGER
			a: STRING_8
			fn, s: STRING_8
			n: like number_anchor
		do
			fn := "set_with_string"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				a := random_string (digit_limit)
				n := new_number
				s := signature (n, fn, <<a>>)
				n.set_with_string (a)
				io.put_string (s + n.out + "%N")
				assert (s, n.out ~ a)
				i := i + 1
			end
		end

	set_with_array
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			i: INTEGER
			a: ARRAY [like digit_anchor]
			fn, s: STRING
			n: like number_anchor
		do
			fn := "set_with_array"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				a := random_array (word_limit)
				n := new_number
				s := signature (n, fn, <<a>>)
				io.put_string (s)
				n.set_with_array (a)
				io.put_string (n.out_as_stored + "%N")
				assert (s, n.out_as_stored ~ array_as_string (a))
				i := i + 1
			end
		end

	set_random
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, s: STRING_8
			n: like number_anchor
			i, c: INTEGER
		do
			fn := "set_random"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				c := es_random.item \\ word_limit + 1
				es_random.forth
				n := new_number
				s := signature (n, fn, <<c>>)
				n.set_random (c)
				io.put_string (s + n.out_as_stored + "  count = " + n.count.out + "%N")
				assert (s, n.count = c)
				i := i + 1
			end
		end

	set_random_with_digit_count
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, s: STRING_8
			n: like number_anchor
			i, c: INTEGER
		do
			fn := "set_random_with_digit_count"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				c := es_random.item \\ word_limit + 1
				es_random.forth
				n := new_number
				s := signature (n, fn, <<c>>)
				n.set_random_with_digit_count (c)
				io.put_string (s + n.out + "  count = " + n.out.count.out + "%N")
				assert (s, n.out.count = c)
				i := i + 1
			end
		end

--	from_string
--			-- Test the corresponding feature from {JJ_BIG_NATURAL}.
--		local
--			gt, fn, str, s: STRING_8
--			n: like number_anchor
--		do
--			io.put_string ("{BIG_NATURAL_TESTS} with formatted output: %N")
--			n := new_number
--			gt := n.generating_type + ":  "
--			fn := ".from_string "
--			str := gt + fn
--				-- First test
--			s := "123456789"
--			io.put_string (str + "(%"" + s + "%") = ")
--			n := new_number
--			n.from_string (s)
--			io.put_string (n.out_formatted + "%N")
--			assert (s, n.out ~ "123456789")
--				-- Test leading zeroes.
--			s := "0,0,0,0,0,9,8,7,6,5,4,3,2,1"
--			io.put_string (str + "(%"" + s + "%") = ")
--			n := new_number
--			n.from_string (s)
--			io.put_string (n.out_formatted + "%N")
--			assert (s, n.out ~ "987654321")
--				-- Negative test
--			s := "-11,234,567,899"
--			io.put_string (str + "(%"" + s + "%") = ")
--			n := new_number
--			n.from_string (s)
--			io.put_string (n.out_formatted + "%N")
--			assert (s + ".is_negative", n.is_negative)
--			assert (s + ".out", n.out ~ "-11234567899")
--				--  Test
--			s := "1,000,000,000,000"
--			io.put_string (str + "(%"" + s + "%") = ")
--			n := new_number
--			n.from_string (s)
--			io.put_string (n.out_formatted + "%N")
--			assert (s + ".out", n.out ~ "1000000000000")
--		end

feature -- Test constants

	bits_per_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: INTEGER
		do
			n := new_number
			v := n.bits_per_word
			s := signature (n, "bits_per_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + n.bits_per_word.out + "%N")
			assert (s, n.bits_per_word ~ known_bits_per_word)
		end

	zero_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.zero_word
			s := signature (n, "zero_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "0")
		end

	one_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.one_word
			s := signature (n, "one_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "1")
		end

	two_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.two_word
			s := signature (n, "two_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "2")
		end

	three_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.three_word
			s := signature (n, "three_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "3")
		end

	four_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.four_word
			s := signature (n, "four_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "4")
		end

	five_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.five_word
			s := signature (n, "five_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "5")
		end

	six_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.six_word
			s := signature (n, "six_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "6")
		end

	seven_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.seven_word
			s := signature (n, "seven_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "7")
		end

	eight_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.eight_word
			s := signature (n, "eight_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "8")
		end

	nine_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.nine_word
			s := signature (n, "nine_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "9")
		end

	ten_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.ten_word
			s := signature (n, "ten_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "10")
		end

	sixteen_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.sixteen_word
			s := signature (n, "sixteen_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "16")
		end

	max_half_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.max_half_word
			s := signature (n, "max_half_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v ~ known_max_half_word)
		end

	max_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.max_word
			s := signature (n, "max_word", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v ~ known_max_word)
		end

	max_ten_power
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like digit_anchor
		do
			n := new_number
			v := n.max_ten_power
			s := signature (n, "max_ten_power", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v ~ known_max_ten_power)
		end

	default_karatsuba_threshold
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: INTEGER
		do
			n := new_number
			v := n.default_karatsuba_threshold
			s := signature (n, "default_karatsuba_threshold", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "4")
		end

	default_div_limit
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: INTEGER
		do
			n := new_number
			v := n.default_div_limit
			s := signature (n, "default_div_limit", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "4")
		end

feature -- Test access & setters

	zero
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like number_anchor
		do
			n := new_number
			v := n.zero
			s := signature (n, "zero", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "0")
		end

	one
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			s: STRING_8
			n: like number_anchor
			v: like number_anchor
		do
			n := new_number
			v := n.one
			s := signature (n, "one", {ARRAY [ANY]} <<>>)
			io.put_string (s + v.out + "%N")
			assert (s, v.out ~ "1")
		end

	ones
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			fn, s: STRING_8
			n: like number_anchor
			i, c: INTEGER
		do
			fn := "ones"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_number
				c := es_random.item \\ word_limit + 1
				es_random.forth
				s := signature (n, fn, <<c>>)
				io.put_string (s)
				n := n.ones (c)
				io.put_string (n.out_as_bits + "%N")
				assert (s, n.count = c and across n as v all v.item ~ known_max_word end)
				i := i + 1
			end
		end

	zeros
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			fn, s: STRING_8
			n: like number_anchor
			i, c: INTEGER
		do
			fn := "zeros"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_number
				c := es_random.item \\ word_limit + 1
				es_random.forth
				s := signature (n, fn, <<c>>)
				io.put_string (s)
				n := n.zeros (c)
				io.put_string (n.out_as_bits + "%N")
				assert (s, n.count = c and across n as v all v.item ~ n.zero_word end)
				i := i + 1
			end
		end

	karatsuba_threshold
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			fn, s: STRING_8
			n: like number_anchor
			i, c: INTEGER
		do
			fn := "karatsuba_threshold"
			io.put_string (divider (fn))
			n := new_number
			from i := 1
			until i > test_limit
			loop
				c := es_random.item \\ word_limit + 1
				from
				until c >= 2
				loop
					es_random.forth
					c := es_random.item \\ word_limit + 1
				end
				es_random.forth
				s := signature (n, fn, <<c>>)
				n.set_karatsuba_threshold (c)
				io.put_string (s + n.karatsuba_threshold.out + "%N")
				assert (s, n.karatsuba_threshold ~ c)
				i := i + 1
			end
		end

	div_limit
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, s: STRING_8
			n: like number_anchor
			i, c: INTEGER
		do
			fn := "set_div_limit"
			io.put_string (divider (fn))
			n := new_number
			from i := 1
			until i > test_limit
			loop
				c := es_random.item \\ word_limit + 1
				from
				until c >= 4
				loop
					es_random.forth
					c := es_random.item \\ word_limit + 1
				end
				es_random.forth
				s := signature (n, fn, <<c>>)
				n.set_div_limit (c)
				io.put_string (s + n.div_limit.out + "%N")
				assert (s, n.div_limit ~ c)
				i := i + 1
			end
		end

	hash_code
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, s: STRING_8
			n: like number_anchor
			i, c: INTEGER
		do
			fn := "hash_code"
			io.put_string (divider (fn))
			n := new_number
			from i := 1
			until i > test_limit
			loop
				c := es_random.item \\ word_limit + 1
				es_random.forth
				n.set_random (c)
				s := signature (n, fn, {ARRAY [ANY]} <<>>)
				io.put_string (s + n.hash_code.out + "%N")
				assert (s, n.hash_code ~ n.out_as_stored.hash_code)
				i := i + 1
			end
		end

	bit_count
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, s: STRING_8
			n: like number_anchor
			i, c: INTEGER
		do
			fn := "bit_count"
			io.put_string (divider (fn))
			n := new_number
			from i := 1
			until i > test_limit
			loop
				c := es_random.item \\ word_limit + 1
				es_random.forth
				n.set_random (c)
				s := signature (n, fn, {ARRAY [ANY]} <<>>)
				io.put_string (s + "%T" + n.bit_count.out + "%T for " + c.out + " words %N")
				assert (s, n.bit_count = c * known_bits_per_word)
				i := i + 1
			end
		end

feature -- Test status reports

	is_zero
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			mp_n: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "is_zero"
			io.put_string (divider (fn))
			n := new_number
			from i := 1
			until i > test_limit
			loop
				n := new_random_near_value (n.one_word, n.four_word)
				mp_n := new_gmp_number (n)
				compare_functions (agent n.is_zero,
									n.out ~ mp_n.zero.out,
									fn, {ARRAY [ANY]} <<>>)
				i := i + 1
			end
		end

	is_one
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			mp_n: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "is_one"
			io.put_string (divider (fn))
			n := new_number
			from i := 1
			until i > test_limit
			loop
				n := new_random_near_value (n.one_word, n.four_word)
				mp_n := new_gmp_number (n)
				compare_functions (agent n.is_one,
									n.out ~ mp_n.one.out or n.out ~ (-(mp_n.one)).out,
									fn, {ARRAY [ANY]} <<>>)
				i := i + 1
			end
		end

	is_base
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			i: INTEGER_32
		do
			fn := "is_base"
			io.put_string (divider (fn))
			n := new_number
			from i := 1
			until i > test_limit
			loop
				n := new_random_near_value (n.max_word, n.four_word)
				n.scalar_add (n.max_word)
					-- ????????
				compare_functions (agent n.is_base,
									n.out ~ (n.ones (1) + n.one).out,
									fn, {ARRAY [ANY]} <<>>)
				i := i + 1
			end
		end

--	is_base_multiple
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		local
--			fn, s: STRING_8
--			n: like number_anchor
--			i, c: INTEGER
--			b: BOOLEAN
--			a: ARRAY [like digit_anchor]
--		do
--			fn := "is_base_multiple"
--			io.put_string (divider (fn))
--			n := new_number
--			from i := 1
--			until i > test_limit
--			loop
--				c := word_limit
--				a := random_array_with_range (c, n.zero_word, n.one_word)
--				n.set_with_array (a)
--				b := es_random.real_item.rounded > 0.5
--				es_random.forth
--				if b then
--					n.set_is_negative (True)
--				end
--				s := signature (n, fn, {ARRAY [ANY]} <<>>)
--				io.put_string (s + n.is_base_multiple.out + "  %N")
----				assert ("Fix me! " + s, n.is_base_multiple implies (n[2].out ~ "1" and n[1].out ~ "0"))
--				assert ("Fix me!   fix this assertion", False)
--				i := i + 1
--			end
--		end

	is_negative
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			mp_n: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "is_negative"
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				compare_functions (agent n.is_negative,
									agent mp_n.is_negative,
									fn, {ARRAY [ANY]} <<>>)
				i := i + 1
			end
		end

	divisible
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "divisible"
			io.put_string (divider (fn))
			n := new_number
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				n2 := new_random_near_value (n.zero_word, n.four_word)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				compare_functions (agent n.divisible (n2),
									agent mp_n.divisible (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

feature -- Test Queries

	is_same_sign
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "is_same_sign"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				n2 := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				compare_functions (agent n.is_same_sign (n2),
									agent mp_n.is_same_sign (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

	is_less
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "is_less"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				n2 := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				compare_functions (agent n.is_less (n2),
									agent mp_n.is_less (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

	is_magnitude_less
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "is_magnitude_less"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				n2 := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				compare_functions (agent n.is_magnitude_less (n2),
									agent mp_n.is_magnitude_less (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

	is_magnitude_equal
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "is_magnitude_equal"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				n2 := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				compare_functions (agent n.is_magnitude_equal (n2),
									agent mp_n.is_magnitude_equal (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

feature -- Test Basic operations (simple)

--	wipe_out
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		local
--			s: STRING_8
--			n: like number_anchor
--			i, c: INTEGER_32
--		do
--			io.put_string (divider)
--			from i := 1
--			until i > test_count
--			loop
--				c := es_random.item \\ word_count + 1	-- so not zero
--				es_random.forth
--				n := new_number
--				n.set_random (c)
--				s := signature (n, "wipe_out", <<>>)
--				io.put_string (s)
--				n.wipe_out
--				io.put_string (n.out + "%N")
--				assert (s, n.count = 1 and n.out ~ "0")
--			end
--		end

	negate
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			mp_n: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "negate"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				compare_functions (agent n.negate,
									agent mp_n.opposite,
									fn, {ARRAY [ANY]} <<>>)
				i := i + 1
			end
		end

	increment
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			mp_n: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "increment"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				compare_functions (agent n.increment,
									agent mp_n.scalar_add (1),
									fn, {ARRAY [ANY]} <<>>)
				i := i + 1
			end
		end

	decrement
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			mp_n: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "decrement"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				compare_functions (agent n.decrement,
									agent mp_n.scalar_subtract (1),
									fn, {ARRAY [ANY]} <<>>)
				i := i + 1
			end
		end

	identity
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			mp_n: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "identity"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				compare_functions (agent n.identity,
									agent mp_n.identity,
									fn, {ARRAY [ANY]} <<>>)
				i := i + 1
			end
		end

	opposite
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			mp_n: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "opposite"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				compare_functions (agent n.opposite,
									agent mp_n.opposite,
									fn, {ARRAY [ANY]} <<>>)
				i := i + 1
			end
		end

	magnitude
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			v: like digit_anchor
			mp_n: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "magnitude"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				compare_functions (agent n.magnitude,
									agent mp_n.abs,
									fn, {ARRAY [ANY]} <<>>)
				i := i + 1
			end
		end

feature -- Test basic operations (addition & subtraction)

	scalar_add
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			v: like digit_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "scalar_add"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				v := random.item
				random.forth
				mp_n2 := new_gmp_number (v)
				compare_functions (agent n.scalar_add (v),
									agent mp_n.plus (mp_n2),
									fn, {ARRAY [ANY]} <<v>>)
				i := i + 1
			end
		end

	scalar_subtract
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			v: like digit_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "scalar_subtract"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				v := random.item
				random.forth
				mp_n2 := new_gmp_number (v)
				compare_functions (agent n.scalar_subtract (v),
									agent mp_n.minus (mp_n2),
									fn, {ARRAY [ANY]} <<v>>)
				i := i + 1
			end
		end

	add
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "add"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				n2 := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				n.add (n2)
				mp_n := mp_n.plus (mp_n2)
				compare_functions (agent n.add (n2),
									agent mp_n.plus (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

	plus
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2, old_n: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "plus"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				old_n := n.deep_twin
				n2 := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				compare_functions (agent n.plus (n2),
									agent mp_n.plus (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

	subtract
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "subtract"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				n2 := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				compare_functions (agent n.subtract (n2),
									agent mp_n.minus (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

	minus
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "minus"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				n2 := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				compare_functions (agent n.minus (n2),
									agent mp_n.minus (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

feature -- Basic operations (multiply)

	scalar_multiply
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			v: like digit_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "scalar_multiply"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				v := random.item
				random.forth
				mp_n2 := new_gmp_number (v)
				compare_functions (agent n.scalar_multiply (v),
									agent mp_n.product (mp_n2),
									fn, {ARRAY [ANY]} <<v>>)
				i := i + 1
			end
		end

	scalar_product
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			v: like digit_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
			bool: BOOLEAN
		do
			fn := "scalar_product"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				v := random.item
				random.forth
				mp_n2 := new_gmp_number (v)
				compare_functions (agent n.scalar_product (v),
									agent mp_n.product (mp_n2),
									fn, {ARRAY [ANY]} <<v>>)
				i := i + 1
			end
		end

	multiply
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "multiply"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				n2 := new_random_number (word_limit)
				mp_n2 := new_gmp_number (n2)
				compare_functions (agent n.multiply (n2),
									agent mp_n.product (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

	product
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "product"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				n2 := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				compare_functions (agent n.product (n2),
									agent mp_n.product (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

feature -- Basic operations (exponentiation)

	raise
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			pow: NATURAL_32
			n: like number_anchor
			mp_n: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "raise"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				pow := (es_random.item \\ power_limit).as_natural_32
				es_random.forth
				compare_functions (agent n.raise (pow),
									agent mp_n.power (pow),
									fn, {ARRAY [ANY]} <<pow>>)
				i := i + 1
			end
		end

	power
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			pow: NATURAL_32
			n: like number_anchor
			mp_n: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "power"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				pow := (es_random.item \\ power_limit).as_natural_32
				es_random.forth
				compare_functions (agent n.power (pow),
									agent mp_n.power (pow),
									fn, {ARRAY [ANY]} <<pow>>)
				i := i + 1
			end
		end

	power_modulo
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, pow, mod: like number_anchor
			mp_n, mp_pow, mp_mod: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "power_modulo"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
					-- Value must be positive for {JJ_BIG_NATURAL}
				from
				until not n.is_negative
				loop
					n := new_random_number (word_limit)
				end
				pow := new_random_number (power_limit)
				from
				until pow > n.zero
				loop
					pow := new_random_number (word_limit)
				end
					-- modulus must be positive and odd for {GMP_INTEGER}
				from mod := new_random_number (word_limit)
				until not mod.is_even
				loop
					mod := new_random_number (word_limit)
				end
				mp_n := new_gmp_number (n)
				mp_pow := new_gmp_number (pow)
				mp_mod := new_gmp_number (mod)
				compare_functions (agent n.power_modulo (pow, mod),
									agent mp_n.power_modulo (mp_pow, mp_mod),
									fn, {ARRAY [ANY]} <<pow, mod>>)
				i := i + 1
			end
		end

feature -- Test basic operations (division)

	quotient
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "quotient"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				n2 := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				es_random.forth
				compare_functions (agent n.quotient (n2),
									agent mp_n.quotient (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

	integer_quotient
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "integer_quotient"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				n2 := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				es_random.forth
				compare_functions (agent n.integer_quotient (n2),
									agent mp_n.integer_quotient (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

	integer_remainder
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n, n2: like number_anchor
			mp_n, mp_n2: JJ_GMP_INTEGER
			i: INTEGER_32
		do
			fn := "integer_remainder"
			io.put_string (divider (fn))
			from i := 1
			until i > test_limit
			loop
				n := new_random_number (word_limit)
				n2 := new_random_number (word_limit)
				mp_n := new_gmp_number (n)
				mp_n2 := new_gmp_number (n2)
				compare_functions (agent n.integer_remainder (n2),
									agent mp_n.integer_remainder (mp_n2),
									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

feature -- Test implementation (division)

	bit_shift_left
			 -- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn: STRING_8
			n: like number_anchor
			i: INTEGER_32
		do
			fn := "bit_shift_left"
			io.put_string (divider (fn))
			from i := 0
			until i > test_limit
			loop
				n := new_random_number (word_limit)
--				n.bit_shift_left (i)
--				compare_functions (agent n.bit_shift_left (i),
--									agent mp_n.integer_remainder (mp_n2),
--									fn, {ARRAY [ANY]} <<n2>>)
				i := i + 1
			end
		end

--feature -- Basic operations (selectively exported)

----	bit_shift_left
----			-- Test and demonstrate feature `bit_shift_left' from
----			-- {JJ_BIG_NATURAL}.
----		deferred
----		end

----	normalize
----			-- Test and demonstrate feature `normalize' from {JJ_BIG_NATURAL}.
----		deferred
----		end

----	divide_two_words_by_one
----			-- Test and demonstrate feature `divide_two_words_by_one' from
----			-- {JJ_BIG_NATURAL}.
----		deferred
----		end

----	scalar_divide
----			-- Test and demonstrate feature `scalar_divide' from {JJ_BIG_NATURAL}.
----			-- I checked the calculations at
----			-- "https://defuse.ca/big-number-calculator.htm".
----		local
----			str, s: STRING_8
----			n: like new_number
----			d: like new_number.digit
----			tup: like new_number.scalar_divide
----		do
----			str := ".scalar_divide:  "
----				-- test number one
----			n := new_number_from_string ("8")
----			d := n.eight_value
----			s := str + "(" + n.out + ").scalar_divide (" + d.out + ")"
----			tup := n.scalar_divide (d)
----			report_tuple (s, tup)
----			assert (s + "  quot", tup.quot.out ~ "1")
----			assert (s + "  rem", tup.rem.out ~ "0")
----				-- test number two
----			n := new_number_from_string ("49")
----			d := n.three_value
----			s := str + "(" + n.out + ").scalar_divide (" + d.out + ")"
----			tup := n.scalar_divide (d)
----			report_tuple (s, tup)
----			assert (s, tup.quot.out ~ "18")
----			assert (s, tup.rem.out ~ "1")
----				-- test number three
----			n := new_number_from_string ("84746229876")
----			d := n.sixteen_value
----			s := str + "(" + n.out + ").scalar_divide (" + d.out + ")"
----			tup := n.scalar_divide (d)
----			report_tuple (s, tup)
----			assert (s, tup.quot.out ~ "5296639367")
----			assert (s, tup.rem.out ~ "4")
----		end



feature {NONE} -- Implementation

	compare_functions (a_routine: ROUTINE [like number_anchor, detachable TUPLE];
						a_expected: ANY;
						a_name: STRING_8; a_args: ARRAY [ANY])
			-- Compare the result of `a_routine' from {JJ_BIG_NUMBER} to the one of:
			--     1) if `a_expected' is a {ROUTINE}, the result of executing a
			--        call to that routine, or
			--     2) if NOT a {ROUTINE}, the result of calling `out' on that argument.
			-- Return the result of the comparison, possibly printing (depending
			-- on `is_terse') the result of executing `a_routine' (and the expected
			-- value if they don't match).
			-- Arguments `a_name' and `a_args' are only used to output the `signature'
			-- of `a_function'.
		require
			target_closed: attached {like number_anchor} a_routine.target
			other_target_closed: attached {ROUTINE} a_expected as r implies
								attached {JJ_GMP_INTEGER} r.target
			arguments_closed: a_routine.open_count = 0
			other_arguments_closed: attached {ROUTINE} a_expected as r implies
										r.open_count = 0
		local
			s: STRING_8
			ans, exp: ANY	-- the answer and the expected answer
			is_ok: BOOLEAN
		do
			check attached {like number_anchor} a_routine.target as t then
					-- Print the `signature'
				s := signature (t, a_name, a_args)
				if not is_terse then
					io.put_string (s)
				end
					-- Execute `a_routine', assuming the answer is the number's value
				if attached {PROCEDURE} a_routine as p then
					p.call ([])
					ans := t
				elseif attached {FUNCTION [like number_anchor, TUPLE, ANY]} a_routine as f then
					ans := f.item ([])
				else
					check
						should_not_happen: False
							-- because `a_routine' is a {PROCEDURE} or a {FUNCTION}
					end
					ans := " should_not_happen "
				end
					-- Execute `a_other_routine_or_value' or use `out'
				if attached {PROCEDURE} a_expected as gmp_p then
					gmp_p.call ([])
					exp := gmp_p
				elseif attached {FUNCTION [JJ_GMP_INTEGER, TUPLE, ANY]} a_expected as gmp_f then
					exp := gmp_f.item ([])
				else
					exp := a_expected
				end
					-- Compare and print results
				is_ok := ans.out ~ exp.out
				if not is_terse then
					io.put_string (ans.out + "%N")
					if not is_ok then
						io.put_string ("%T ERROR -- expected   " + exp.out + "%N")
					end
				end
				assert (s, is_ok)
			end
		end

	put_line (a_string: STRING)
			-- Print a dividing line containing `a_string'
			-- (e.g.  "----------- a_string ------------"
		local
			w, c, n, i: INTEGER_32
		do
			io.put_string ("%N")
			w := 70
			c := a_string.count
			n := (w - c) // 2
			from i := 1
			until i > n
			loop
				io.put_string ("-")
				i := i + 1
			end
			io.put_string (" " + a_string + " ")
			from i := 1
			until i > n
			loop
				io.put_string ("-")
				i := i + 1
			end
			io.put_string ("%N")
		end

	divider (a_string: STRING_8): STRING_8
			-- A simple marker to output at beginning of a test feature
		do
			Result := "     -------- " + a_string + " -------- %N"
		end

	formatted_number (a_number: like number_anchor; a_format: INTEGER_32): STRING_8
			-- A string representing `a_number' displayed as `out',
			-- `out_formatted_out', `out_as_stored', or `out_as_bits',
			-- depending on `a_format'.
		do
			inspect a_format
			when Format_as_string then
				Result := a_number.out
			when Format_as_stored then
				Result := a_number.out_formatted
			when Format_as_bits then
				Result := a_number.out_as_bits
			else
				Result := " error in number format "
			end
		end

	signature (a_target: like number_anchor; a_feature: STRING_8;
				a_arguments: ARRAY [ANY]): STRING_8
			-- Create a string representing a features signature.
			-- The format for {JJ_BIG_NATURAL} numbers is set by
			-- calls to `set_format'.
		local
			i: INTEGER
			a: detachable ANY
		do
			Result := a_target.generating_type + ":  "
			Result := Result + "(" + formatted_number (a_target, target_format) + ")"
			Result := Result + "." + a_feature
			if a_arguments.count > 0 then
					-- Add agruments
				Result := Result + " ("
				from i := 1
				until i > a_arguments.count
				loop
					a := a_arguments[i]
					if attached {STRING} a as s then
						Result := Result + "%"" + s.out + "%""
					elseif attached {like number_anchor} a as n then
						Result := Result + formatted_number (n, argument_format)
					elseif attached {ARRAY [like digit_anchor]} a as otl_a then
						Result := Result + array_as_string (otl_a)
					elseif attached a then
						Result := Result + a.out
					else
						Result := Result + "Void"
					end
					if i < a_arguments.count then
						Result := Result + ", "
					end
					i := i + 1
				end
				Result := Result + ")"
			end
			Result := Result + " = "
		end

	array_as_string (a_array: ARRAY [like digit_anchor]): STRING_8
			-- Format `a_array' for output in the same format as
			-- feature `out_as_stored' from {JJ_BIG_NATURAL}.
		local
			i: INTEGER
		do
			Result := "<"
			from i := 1
			until i > a_array.count
			loop
				Result := Result + a_array[i].out
				if i < a_array.count then
					Result := Result + ","
				end
				i := i + 1
			end
			Result := Result + ">"
		end

feature {NONE} -- Implementation

	new_number: like number_anchor
			-- Factory for new big numbers.
		deferred
		end

	new_random_number (a_count: INTEGER): like number_anchor
			-- A big number with `a_count' or fewer words.
		local
			c: INTEGER_32
		do
			Result := new_number
			c := es_random.item \\ a_count + 1
			es_random.forth
			Result.set_random (c)
				-- Make some numbers negative
			if es_random.real_item < .5 then
				Result.set_is_negative (true)
			end
			es_random.forth
		end

	new_random_near_value (a_value, a_delta: like digit_anchor): like number_anchor
			-- A new one-word number that is within `a_delta' of `a_value'
		local
			v: like digit_anchor
			r: like digit_anchor
		do
			r := random.item
			random.forth
			v := (r + a_value) \\ a_delta
			Result := new_number
			Result.set_with_value (v)
				-- Make some numbers negative
			if es_random.real_item < .5 then
				Result.set_is_negative (true)
			end
		end

	new_gmp_number (a_number: NUMERIC): JJ_GMP_INTEGER
			-- Create a {JJ_GMP_INTEGER} eqivalent to `a_number'
		do
			create Result.make_string (a_number.out)
		ensure
			same_numbers: Result.out ~ a_number.out
		end

	es_random: RANDOM
			-- The EiffelBase random number generator from Eiffel Software
		once
			create Result.make
		end

	random: JJ_NATURAL_RNG [JJ_NATURAL]
			-- The RNG currently in use
		deferred
		end

	random_string (a_count: INTEGER): STRING_8
			-- A string of up to `a_count' numbers
		require
			count_large_enough: a_count >= 1
		local
			done: BOOLEAN
			n: like number_anchor
		do
			n := new_number
			random.set_range (n.one_word, n.nine_word)
				-- Now build a string of random digits
				-- Add the first number which is not a zero
			Result := random.item.out
			random.set_range (n.zero_word, n.nine_word)
			from
			until Result.count >= a_count or done
			loop
				Result := Result + random.item.out
				random.forth
					-- Finish with number possibly shorter than `a_count'
				done := random.item > n.eight_word
				random.forth
			end
		ensure
			string_long_enough: Result.count >= 1
			no_leading_zeros: not (Result.item (1) ~ '0')
		end

	random_array (a_count: INTEGER): ARRAY [like digit_anchor]
			-- An array of up to `a_count' number of digits
		require
			count_large_enough: a_count >= 1
		local
			done: BOOLEAN
			n: like number_anchor
			c: INTEGER
			i: INTEGER
		do
			c := es_random.item \\ a_count + 1
			check
				c_big_enough: c >= 1
				c_small_enough: c <= a_count
			end
			n := new_number
			create Result.make_filled (n.zero_word, 1, c)
			random.set_range (n.one_word, n.max_word)
			Result[1] := random.item
			random.set_range (n.one_word, n.max_word)
			random.forth
			from i := 1
			until i > c
			loop
				Result[i] := (random.item)
				random.forth
				i := i + 1
			end
		end

	random_array_with_range (a_count: INTEGER;
				a_lower, a_upper: like digit_anchor): ARRAY [like digit_anchor]
			-- An array of up to `a_count' number of digits, where each digit
			-- is in the range [`a_lower', `a_upper']
		require
			count_large_enough: a_count >= 1
		local
			done: BOOLEAN
			n: like number_anchor
			c: INTEGER
			i: INTEGER
		do
			c := es_random.item \\ a_count + 1
			n := new_number
			create Result.make_filled (n.zero_word, 1, c)
			random.set_range (a_lower, a_upper)
			random.forth
			from i := 1
			until i > c
			loop
				Result[i] := (random.item)
				random.forth
				i := i + 1
			end
		end

feature {NONE} -- Anchors

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

	gmp_anchor: JJ_GMP_INTEGER
			-- Anchor for GMP type for comparisons
		once
			check
				do_not_call: false then
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

--	digit_tuple_anchor: like number_anchor.as_half_words
--			-- Anchor for typs involved in division.
--			-- Not to be called; just used to anchor types.
--			-- Declared as a feature to avoid adding an attribute.
--		require
--			never_called: false
--		do
--			check
--				do_not_call: false then
--					-- Because gives no info; simply used as anchor.
--			end
--		end

end





