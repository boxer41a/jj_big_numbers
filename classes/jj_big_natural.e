note
	description: "[
		Base class for all the JJ_BIG_NUMBER_xxx classes, which represent a
		number that is much larger than what is represented in 64 bits.

		This class implements a big number as a list of digits, where each
		`digit' is stored as an 8, 16, 32, or 64-bit natural number, depending
		on the type of the actual generic parameter used by the descendent
		class (e.g. {JJ_NATURAL_8}, {JJ_NATURAL_16}, {JJ_NATURAL_32}, and
		{JJ_NATURAL_64}).

		Create a {JJ_BIG_NUMBER} with `from_string' or one of the creation
		routines that take a value of the same type as `digit'.  Features such
		as `zero_digit', `one_digit', ... `sixteen_digit', and `max_digit'
		provide convinent ways to get values of the correct type.

		Feature `digit' is `item' renamed, and it is not exported; use `i_th'
		to obtain a particular digit.

		Digits are stored low-order to high-order.

		Each digit in a {JJ_BIG_NUMBER} represents a value in the maximum
		base.  For example, an eight-bit representation has base 256.  The
		largest digit in an eight-bit representation is therefore 255.  The
		`base' feature is only used by creation and output features, where the
		number is converted on the fly.
	]"
	author: "Jimmy J.Johnson"

deferred class
	JJ_BIG_NATURAL [G -> JJ_NATURAL]

inherit

	NUMERIC
		rename
			quotient as integer_quotient alias "//"
		undefine
			copy,
			is_equal,
			default_create,
			out
		end

	COMPARABLE
		undefine
			copy
		redefine
			default_create,
			out
		end

	HASHABLE
		undefine
			copy,
			is_equal
		redefine
			default_create,
			out
		end

	SINGLE_MATH			-- for `log_2' in division algorithms
		undefine
			copy,
			is_equal
		redefine
			default_create,
			out
		end

	ARRAYED_LIST [G]
		rename
			item as digit
		export
			{NONE}
				all
			{JJ_BIG_NATURAL}
				area,
				wipe_out,
				prunable,
				extend,
				put_i_th,
				put_front,
				merge_right,
				merge_left,
				extendible,
				remove,
				writable,
				first,
				area_v2,
				before,
				after,
				off,
				go_i_th,
				valid_cursor_index,
				copy,
				is_equal,
				is_empty,
				duplicate,
				object_comparison,
				same_type,
				index,
				deep_twin,
				is_deep_equal,
				standard_is_equal
			{ANY}
				i_th,
				valid_index,
				count
		undefine
			is_equal
		redefine
			default_create,
			out,
			new_filled_list
		end

feature {NONE} -- Initialization

	default_create
			-- Initialize current
		do
			make (10)
			extend (zero_digit)
		end

	make_with_value (a_value: like digit)
			-- Initialize Current with `a_value'
		local
			r, c: like digit
		do
			default_create
			set_value (a_value)
		end

--	make_with_base (a_base: like base)
--			-- Initialize Current, setting the `base'
--		require
----			base_big_enough: a_base >= two_value
----			base_small_enough: a_base <= max_base
--			valid_base: a_base /= one_digit
--		do
--			default_create
--			base := a_base
--		ensure
--			base_set: base = a_base
--		end

--	make_with_value_and_base (a_value: like digit; a_base: like base)
--			-- Initialize Current so it is equivalent to `a_value' and set
--			-- the `base' to `a_base'
--		require
--			valid_base: a_base /= one_digit
--		do
--			default_create
--			base := a_base
--			set_value (a_value)
--		ensure
--			base_set: base = a_base
--		end

	from_string (a_string: STRING_8)
			-- Create an instance from `a_value'.
		require
			string_long_enough: a_string.count >= 1
			is_number: is_valid_string (a_string)
		do
			default_create
			set_with_string (a_string)
		end

	make_with_array (a_array: ARRAY [like digit])
			-- Create an instance from `a_array', where the array holds the
			-- intended digits with high-order digits first.  Each item in
			-- `a_array' must be representable in the `max_base' and at
			-- least one digit must be non-zero.
		require
			array_exists: a_array /= Void
			array_not_empty: not a_array.is_empty
			has_valid_digits: across a_array as it all it.item <= max_digit end
			not_all_zero: across a_array as it some it.item > zero_digit end
		local
			i: INTEGER
		do
			default_create
			set_with_array (a_array)
		end

--	make_with_array_and_base (a_array: ARRAY [like digit]; a_base: like base)
--			-- Create an instance from `a_array', where the array holds the
--			-- intended digits with high-order digits first.  Each item in
--			-- `a_array' must be representable in the current `base' and at
--			-- least one digit must be non-zero.
--		require
--			array_exists: a_array /= Void
--			array_not_empty: not a_array.is_empty
--			has_valid_digits: across a_array as it all it.item < a_base end
--			not_all_zero: across a_array as it some it.item > zero_digit end
----			base_big_enough: a_base >= two_value
----			base_small_enough: a_base <= max_base
--			valid_base: a_base /= one_digit
--		do
--			make_with_base (a_base)
--			set_with_array (a_array)
--		ensure
--			base_was_set: base = a_base
--		end

	make_random (a_count: INTEGER; a_base: like digit_anchor)
			-- Create a random number containing `a_count' digits, and
			-- with `a_base'.
		require
			count_big_enough: a_count >= 1
--			base_big_enough: a_base >= two_value
--			base_small_enough: a_base <= max_base
			valid_base: a_base /= one_digit
		local
			i: INTEGER
			r: INTEGER
			rng: INTEGER    -- range
			rem: INTEGER    -- remainder
			bkt: INTEGER    -- bucket
			low: INTEGER
			high: INTEGER
			random: RANDOM
		do
			default_create
			wipe_out
--			set_base (a_base)
				-- This generates random numbers in the semi-open
				-- interval [`low', `high').  It was adapted from
				-- http://stackoverflow.com/questions/2509679.
				-- "The recursion gives a perfectly uniform distribution."
--			create random.make
--			low := 0
--			high := (a_base - one_value)
--			r := random.next_random (random.default_seed)
--			rng := high - low
--			rem := random.modulus \\ rng
--			bkt := random.modulus // rng
--			from i := 1
--			until i > a_count
--			loop
--					-- There are range buckets, plus one smaller interval
--					-- within remainder of Modulus.
--				from
--				until r < random.Modulus - rem
--				loop
--					r := random.next_random (r)
--				end
--				r := low + (r // bkt)
--				extend (r)
--				i := i + 1
--			end
-- The code above can not work because RANDOM generates INTEGER values
-- but this class needs {JJ_NATURAL} values to match the type of `digit'.
		ensure
			correct_count: count = a_count
		end

feature -- Constants

	bits_utilized: INTEGER_32
			-- Number of bits in each digit for this implementation.
		local
			temp: like digit
		do
			Result := digit_anchor.bit_count
		ensure
			result_big_enough: Result >= 2
			result_small_enough: Result <= bits_utilized
		end

	bit_count_digit: like digit
			-- The number of bits in each digit of Current in same type as `digit'.
		deferred
		end

	zero_digit: like digit
			-- The number zero in the same type as `base'.
		deferred
		end

	one_digit: like digit
			-- The number one in the same type as `base'.
		deferred
		end

	two_digit: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	three_digit: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	four_digit: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	five_digit: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	six_digit: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	seven_digit: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	eight_digit: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	nine_digit: like digit
			-- The number ten in the same type as `digit'.
		deferred
		end

	ten_digit: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	sixteen_digit: like digit
			-- The number 16 in the same type as `digit'.
		deferred
		end

	max_ten_power: like digit
			-- Largest multiple of 10 representable in a digit of Current.
		deferred
		ensure
			power_of_ten: Result \\ ten_digit = zero_digit
		end

	max_half_digit: like digit
			-- The largest value representable in half the number of
			-- bits in Current's representation of a `digit'.
		deferred
		end

	max_digit: like digit
			-- The largest value allowed for a `digit' of Current (i.e. all ones).
		deferred
		ensure
			definition: Result = zero_digit - one_digit
		end

	base: like Current
			-- The radix of Current.
		do
			Result := new_big_number (max_digit)
			Result.scalar_add (one_digit)
		end

	ones (a_count: INTEGER): like Current
			-- A big number containing `a_count' digits where each digit
			-- is all ones (i.e. each digit contains the `max_digit').
		require
			count_big_enough: a_count >= 1
		local
			i: INTEGER
		do
			Result := new_big_number (max_digit)
			from i := 2
			until i > a_count
			loop
				Result.extend (max_digit)
				i := i + 1
			end
		end

	zeros (a_count: INTEGER): like Current
			-- A big number containing `a_count' digits where each digit
			-- is all ones (i.e. each digit contains the `max_digit').
		require
			count_big_enough: a_count >= 1
		local
			i: INTEGER
		do
			Result := new_big_number (zero_digit)
			from i := 2
			until i > a_count
			loop
				Result.extend (zero_digit)
			end
		end

	Default_karatsuba_threshold: INTEGER = 4
			-- Default value for `karatsuba_threshold'.

	Default_div_limit: INTEGER = 4
			-- Default value for `div_limit'.

feature -- Access

	digit_anchor: like digit
			-- The number of unique values for each "digit" when Current
			-- is output.  This does not affect Current's implementaion, as
			-- each `digit' in Current is stored in the largest possible
			-- representation.

	zero: like Current
			-- Neutral element for "+" and "-".
		deferred
		end

	one: like Current
			-- Neutral element for "*" and "/".
		deferred
		end

	frozen karatsuba_threshold: INTEGER
			-- The value above which multiplications use `karatsuba_product'.
			-- Change with `set_karatsuba_threshold'.
		do
			Result := karatsuba_threshold_imp.item
		ensure
			result_big_enough: Result >= 2
		end

	frozen div_limit: INTEGER
			-- Used by Burnikel and Zeigler division algorithm `two_by_one_divide'.
			-- The number of digits in a divisor above which the B&Z algorithms
			-- recurse; below this number, division reverts to `school_division'.
		do
			Result := div_limit_imp.item
		ensure
			result_big_enough: Result >= 4
		end

	frozen hash_code: INTEGER
			-- Hash value computed from the string representation of Current.
		do
			Result := out_as_stored.hash_code
		end

	bit_count: like Current
			-- The number of binary digits in Current.
		local
			i: INTEGER
		do
			Result := new_big_number (zero_digit)
			from i := 1
			until i > count
			loop
				Result.scalar_add (bit_count_digit)
				i := i + 1
			end
		end

feature -- Element change

	set_karatsuba_threshold (a_value: INTEGER)
			-- Change the `karatsub_threshold', the number of digits at which
			-- *all* multiplications of a {BIG_NUMBER} use the Karatsuba
			-- algorithm instead of a basic, grade-school method.
		require
			value_big_enough: a_value >= 1
		do
			karatsuba_threshold_imp.set_item (a_value)
		end

	set_value (a_value: like digit)
			-- Make Current equivalent to `a_value'.
		local
			r, c: like digit
			v: like digit
		do
			wipe_out
			extend (a_value)
		ensure
			has_one_digit: count = 1
		end

	is_valid_string (a_string: STRING_8): BOOLEAN
			-- Is `a_string' in the correct format?
			-- Yes if it contains only characters '0'..'9', optional
			-- commas, and optional leading '+' or '-'.
			-- (The placement of commas is unimportant and ignored.)
			-- Valid strings:
			--    "-99,505,999"
			--    "9950,599,9"
			--    ""
		require
			string_exists: a_string /= Void
		local
			s, ss: STRING_8
			i: INTEGER
		do
			Result := true
			s := a_string.twin
			s.prune_all (',')
					-- Is the first character a plus or minus sign?
			ss := s.substring (1, 1)
			if ss ~ "+" or ss ~ "-" then
				s.keep_tail (s.count - 1)
			else
				do_nothing
			end
			from i := 1
			until i > s.count or not Result
			loop
				Result := s.item (i).is_digit
				i := i + 1
			end
		end

	set_with_string (a_string: STRING_8)
			-- Set Current as on a string given in base 10.
			-- If `a_string' is empty, then Current is equivalent to zero.
		require
			is_number: is_valid_string (a_string)
		local
			s, ss: STRING_8
			neg: BOOLEAN
			i: INTEGER
			place: like Current
			d: like digit

			temp: like Current
		do
			Default_create
			if a_string.count > 0 then
				wipe_out
				s := a_string.twin
				s.prune_all (',')
					-- Is the first character a plus or minus sign?
				ss := s.substring (1, 1)
				if ss ~ "-" then
					neg := true
					s.keep_tail (s.count - 1)
				elseif s ~ "+" then
					s.keep_tail (s.count - 1)
				else
					do_nothing
				end
				place := new_big_number (one_digit)
				from i := s.count
				until i < 1
				loop
						-- for each digit, multiply by place and add
					d := new_value_from_character (s.item (i))
					temp := place.scalar_product (d)
					add (place.scalar_product (d))
					place.scalar_multiply (ten_digit)
					i := i - 1
				end
			end
			if neg then
				set_is_negative (true)
			end
			remove_leading_zeros
		end

--	set_base (a_base: like base)
--			-- Set the `base' to `a_base', to control how Current is output.
--			-- Passing `zero_digit' in returns output to the default, corresponding
--			-- to the way Current is stored.
--			-- Internally, Current is still stored in the max possible base.
--		require
--			valid_base: a_base /= one_digit
--		do
--			base := a_base
--		end

	set_with_array (a_array: ARRAY [like digit])
			-- Set the digits from `a_array', where the array holds the
			-- intended digits with high-order digits first.  Each item in
			-- `a_array' must be representable in the current `base' and at
			-- least one digit must be non-zero.
		require
			array_exists: a_array /= Void
			array_not_empty: not a_array.is_empty
			has_valid_digits: across a_array as it all it.item <= max_digit end
			not_all_zero: across a_array as it some it.item > zero_digit end
		local
			i: INTEGER
			d: like digit
			place: like Current
		do
--			make_with_base (base)
--			if is_reduced_base then
--				place := new_big_number (one_digit)
--				from i := a_array.count
--				until i < 1
--				loop
--						-- for each digit, multiply by place and add
--					d := a_array [i]
--					add (place.scalar_product (d))
--					place.scalar_multiply (base)
--					i := i - 1
--				end
--			else
					-- Just put array values into Current
				wipe_out
				from i := a_array.count
				until i < 1
				loop
					extend (a_array [i])
					i := i - 1
				end
--			end
		end

feature -- Conversion

--	to_base (a_base: like base)
--			-- Change `base' to `a_base', changing the internal representation
--			-- of Current so that each `digit' represents a power of the base
--			-- times its position in Current.
--		require
--			valid_base: a_base /= one_value
--		do
--			copy (as_base (a_base))
--		end

--	as_base (a_base: like base): like Current
--			-- New object equivalent to Current but converted to `a_new_base'.
--			-- "Knuth, "The Art of Computer Programming", Vol 2, p. 302.	
--		require
----			base_big_enough: a_base >= two_value
----			base_small_enough: a_base <= max_base
--			valid_base: a_base /= 1
--		local
--			n: like Current
--			i: INTEGER
--		do
--			if a_base = base then
--				Result := deep_twin
--			else
--					-- Use arithmatic in the new base
--				n := new_big_number (i_th (count), a_base)
--				from i := count - 1
--				until i < 1
--				loop
--					n.scalar_multiply (base)
--					n.scalar_add (i_th (i))
--					i := i - 1
--				end
--				Result := n
--				Result.assign_to_base (a_base)
--			end
--		end

--	as_base (a_new_base: like base): like Current
--			-- New object equivalent to Current but converted to `a_new_base'.
--			-- See "A Recursive Radix Conversion Formula and Its Application
--			-- to Multiplication and Division", H. Asai, Lockheed Electronics
--			-- Company, 1976, theorem 2 and equations 2.17, 2.18, and 2.19,
--			-- p 262.
--		require
--			base_small_enough: base <= max_base
--		local
--			d: like Current	-- the present radix
--			b: like Current	-- the target radix
--			p: like Current
--			s, r: like Current
--			t: like Current	-- the accumulated result
--			i: INTEGER
--			eta_hat: like digit	-- the i_th digit
--		do
--			if base = a_new_base then
--				Result := deep_twin
--			else
---- ?				-- "Calculations must be done in the new radix."  This
--					-- means that the arithmatic is modulo `a_new_base', so we
--					-- discard any digits that "overflow".
----print ("%N")
----print (generating_type + "  " + out_as_stored + " base " + base.out +
----					"  as_base (" + a_new_base.out + ") %N")
--				d := new_big_number (base, a_new_base)
--				b := new_big_number (a_new_base, a_new_base)
--				p := d - b
--				s := new_big_number (i_th (count), a_new_base)
--				r := new_big_number (zero_value, a_new_base)
--					-- t_zero = s
--				t := new_big_number (i_th (count), a_new_base)
----print ("  initialize: %N")
----print ("     d = " + d.out_as_bits + "%T%T" + d.out_as_stored + "%N")
----print ("     b = " + b.out_as_bits + "%T%T" + b.out_as_stored + "%N")
----print ("     p = " + p.out_as_bits + "%T%T" + p.out_as_stored + "%N")
----print ("     s = " + s.out_as_bits + "%T%T" + s.out_as_stored + "%N")
----print ("     r = " + r.out_as_bits + "%T%T" + r.out_as_stored + "%N")
----print ("     t = " + t.out_as_bits + "%T%T" + t.out_as_stored + "%N")
--				from i := count - 1
--				until i < 1
--				loop
----print ("  i = " + i.out + ": %N")
--					eta_hat := i_th (i)
----print ("   eta = " + eta_hat.out + "%N")
--						--  s[i] := s[i-1]P + n[i]
--					s := s * p
----print ("     s = s * p = " + s.out_as_bits + "%T%T" + s.out_as_stored + "%N")
--					s.scalar_add (eta_hat)
----print ("     s.add (eta) = " + s.out_as_bits + "%T%T" + s.out_as_stored + "%N")
--						-- r[i] := t[i-1] + r[i-1]P
--					r := r * p
----print ("     r = r * p = " + r.out_as_bits + "%T%T" + r.out_as_stored + "%N")
--					r.add (t)
----print ("     r.add (t) = " + r.out_as_bits + "%T%T" + r.out_as_stored + "%N")
--						-- t[i] := r[i]B + s[i]
--					t := r * b
----print ("     t = r * b = " + t.out_as_bits + "%T%T" + t.out_as_stored + "%N")
--					t.add (s)
----print ("     t.add (s) = " + t.out_as_bits + "%T%T" + t.out_as_stored + "%N")
--					i := i - 1
--				end
--				Result := t
--				Result.set_is_negative (is_negative)
--				Result.assign_to_base (a_new_base)
----				Result.conform
--			end
----			Result := Current
--		end

feature -- Status setting

	set_is_negative (a_sign: BOOLEAN)
			-- Set `is_negative' to `a_sign' if Current /~ `zero'.
		do
			if not is_zero then
				is_negative := a_sign
			end
		ensure
			positive_assigned: not a_sign implies not is_negative
			negative_assigned: not is_zero implies (a_sign implies is_negative)
		end

feature -- Status report

	is_zero: BOOLEAN
			-- Is Current equivalent to `zero'?
		local
			i: INTEGER
		do
				-- Some calculations can produce an intermediate {BIG_NUMBER}
				-- with more than one zero, so check all values.
			Result := true
			from i := 1
			until i > count or else not Result
			loop
				Result := i_th (i) = 0
				i := i + 1
			end
		end

	is_one: BOOLEAN
			-- Is Current's magnitude equivalent to `one'?
			-- Is Current equal to one or negative one?
		local
			i: INTEGER
		do
				-- Must account for leading zeros
			from i := count
			until i = 1 or else i_th (i) /= zero_digit
			loop
				i := i - 1
			end
			Result := i = 1 and then i_th (1) = one_digit
		end

	is_base: BOOLEAN
			-- Is Current equal to the value of the [implementation]
			-- of the base?
		local
			i: INTEGER
		do
				-- Must account for leading zeros
			from i := count
			until i = 2 or else i_th (i) /= zero_digit
			loop
				i := i - 1
			end
			Result := i = 2 and then (i_th (1) = zero_digit and i_th (2) = one_digit)
		end

	is_base_multiple: BOOLEAN
			-- Is Current a power of the [implementation]
			-- of the base, such as <<1, 0, 0, 0, 0>>?
		local
			i: INTEGER
		do
			Result := true
				-- Must account for leading zeros
			from i := count
			until i = 1 or else i_th (i) /= zero_digit
			loop
				i := i - 1
			end
				-- Is first non-zero digit a one?
			Result := i_th (i) = one_digit
				-- Check the remaining digits for all zeros.
			from i := i - 1
			until not Result or else i < 1
			loop
				Result := i_th (i) = zero_digit
			end
		end

	is_negative: BOOLEAN
			-- Is Current a negative number?

--	is_reduced_base: BOOLEAN
--			-- Is `base' set to less than the maximum?
--			-- Reminder `base' is used only for input and output; Current's
--			-- digits are still stored in the largest possible representation.
--		do
--			Result := base /= zero_digit
--		end

	divisible (other: like Current): BOOLEAN
			-- May current object be divided by `other'?
		do
			Result := other /~ zero
		end

	exponentiable (other: NUMERIC): BOOLEAN
			-- May current object be elevated to the power `other'?
			-- Must be defined, because it comes deferred from {NUMERIC}.
		obsolete
			"[2008_04_01] Will be removed since not used."
		do
		end

feature -- Query

	is_same_sign (other: like Current): BOOLEAN
			-- Does Current have the same sign as `other'?
		do
			Result := (is_zero or other.is_zero) or
						(is_negative = other.is_negative)
		end

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is Current less than `other'?
		do
			if other /= Current then
				if is_negative and not other.is_negative then
					Result := true
				elseif not is_negative and other.is_negative then
					Result := false
				elseif not is_negative and not other.is_negative then
					Result := is_magnitude_less (other)
				else
					Result := other.is_magnitude_less (Current)
				end
			end
		end

	is_magnitude_less (other: like Current): BOOLEAN
			-- Is Current's absolute value < `other's absolute value?
		require
			other_exists: other /= Void
		local
			i: INTEGER
			temp: like Current
		do
			if other /= Current then
				if is_zero and other.is_zero then
					Result := false
				elseif count < other.count then
					Result := True
				elseif count > other.count then
					Result := False
				else
					check
						same_counts: count = other.count
							-- because of if statements above
					end
						-- Start with most significant digit
					from i := count
					until i < 1 or i_th (i) > other.i_th (i) or Result
					loop
						Result := i_th (i) < other.i_th (i)
						i := i - 1
					end
				end
			end
		end

	is_magnitude_equal (other: like Current): BOOLEAN
			-- Is the magnitude of Current the same as `other'?
			-- The signs may be different.
		local
			i: INTEGER
		do
			if Current = other then
				Result := true
			else
				if count = other.count then
					Result := true
					from i := 1
					until not Result or i > count
					loop
						Result := i_th (i) = other.i_th (i)
						i := i + 1
					end
				end
			end
		end

feature -- Basic operations (simple)

	negate
			-- Reverse the sign of Current.
		do
			if not is_zero then
				is_negative := not is_negative
			end
		ensure
			sign_toggled: not is_zero implies is_negative = not (old is_negative)
		end

	increment
			-- Add one to Current.
		do
			add (one)
		end

	decrement
			-- Subtract one from Current.
		local
			n: like Current
		do
			n := one
			n.negate
			add (n)
		end

	identity alias "+": like Current
			-- Unary plus.
		do
			Result := twin
		end

	opposite alias "-": like Current
			-- Unary minus.
		do
			Result := twin
			Result.negate
		end

feature -- Basic operations (addition & subtraction)

	scalar_add (a_value: like digit)
			-- Change Current by adding `a_value' to Current.
			-- By definition `a_value' will be no larger than the value
			-- representable by the type of a `digit'.
		local
			n: like Current
		do
			n := new_big_number (a_value)
			add (n)
		end

	scalar_subtract (a_value: like digit)
			-- Change Current by subtracting `a_value' from Current.
			-- By definition `a_value' will be no larger than the value
			-- representable by the type of a `digit'.
		local
			n: like Current
		do
			n := new_big_number (a_value)
			n.negate
			add (n)
		end

	scalar_sum (a_value: like digit): like Current
			-- The result of adding `a_digit' to Current.
			-- Do not change Current.
		do
			Result := deep_twin
			Result.scalar_add (a_value)
		end

	add (other: like Current)
			-- Change Current by adding other to Current.
		require
			other_exists: other /= Void
--			same_bases: other.base = base
		local
			subtrahend, minuend: detachable like Current
			is_neg_o, sign_max: BOOLEAN
--			b: like base
		do
				-- Save the sign and `base' of `other' for restoration
				-- at the end of the feature.
			is_neg_o := other.is_negative
--			b := other.base
				-- Do the addition
--			other.set_base (base)
			if is_same_sign (other) then
				simple_add (other)
			else
					-- minuend - subtrahend = difference
					-- Find the larger
				minuend := magnitude_max (other)
				sign_max := minuend.is_negative
					-- Set both to positive
				set_is_negative (false)
				other.set_is_negative (false)
					-- find the subtrahend
				if minuend = Current then
					subtrahend := other
				else
					subtrahend := Current
					minuend := minuend.twin
				end
				check
					same_signs: minuend.is_same_sign (subtrahend)
				end
				check
					sub_less: subtrahend.magnitude <= minuend.magnitude
				end
					-- Subtract smaller from larger
				minuend.simple_subtract (subtrahend)
					-- Restore Current if it was not the larger
				if minuend /= Current then
					copy (minuend)
				end
					-- Set the sign to that of larger
				set_is_negative (sign_max)
					-- Restore sign of `a_other' in case it had changed
				other.set_is_negative (is_neg_o)
			end
			if is_zero then
				is_negative := false
			end
--			other.set_base (b)
		end

	plus alias "+" (other: like Current): like Current
			-- New object containing the sum of Current and `other'.
		do
			Result := twin
			Result.add (other)
		end

	subtract (other: like Current)
			-- Subtract other from Current.
		require
			other_exists: other /= Void
		do
			other.negate
			add (other)
			other.negate
		end

	minus alias "-" (other: like Current): like Current
			-- Result of subtracting `other' from Current.
			-- Does not change Current.
		do
			Result := twin
			Result.subtract (other)
		end

feature {JJ_BIG_NATURAL} -- Implementation (addition & subtraction)

	simple_add (other: like Current)
			-- Change Current by adding `other' to it.
			-- Used internally for `add' and `subtract'.
		require
			other_exists: other /= Void
			same_sign: is_same_sign (other)
		local
			i: like count
			tup: TUPLE [sum, carry: like digit]
		do
			if is_zero then
				copy (other)
			elseif not other.is_zero then
					-- Add each paired `digit'
				tup := [zero_digit, zero_digit]
				from i := 1
				until i > count or i > other.count
				loop
					digits_added (i_th (i), other.i_th (i), tup.carry, tup)
					put_i_th (tup.sum, i)
					i := i + 1
				end
					-- Include the unpaired digits
				if i > count then
						-- Bring the rest of the digits of other into Current
					check
						finished_with_currents_digits: i = count + 1
					end
					from
					until i > other.count
					loop
						digits_added (zero_digit, other.i_th (i), tup.carry, tup)
						extend (tup.sum)
						i := i + 1
					end
				elseif i > other.count then
						-- Add carry into Current's digits
					check
						finished_with_others_digits: i = other.count + 1
					end
					from
					until i > count
					loop
						digits_added (i_th (i), zero_digit, tup.carry, tup)
						put_i_th (tup.sum, i)
						i := i + 1
					end
				end
					-- If still have a carry (overflow), add a digit
				if tup.carry > zero_digit then
					extend (one_digit)
				end
			end
		end

	simple_subtract (other: like Current)
			-- Change Current by subtracting `other' from Current.
		require
			other_exists: other /= Void
			same_sign: is_same_sign (other)
			other_is_less: other.magnitude <= magnitude
		local
			i: INTEGER
		do
				-- Step through values changing `minuend' which will be returned
			from i := 1
			until i > count or i > other.count
			loop
				subtract_i_th (other.i_th (i), i)
				i := i + 1
			end
			check
				i >= other.count
					-- because subtrahend (other) is less than the minuend (Current)
			end
			if is_zero then
				is_negative := false
			end
		end

	digits_added (a, b, c_in: like digit; tup: TUPLE [sum, carry: like digit])
			-- Add two digits and a carry digit, giving a sum with a
			-- carry out, because simply adding the values might result
			-- in overflow with data lose.  The result is passed out in
			-- the `tup' in order avoid creating a new TUPLE on every
			-- call to this feature.
			-- This decomposition feature is used by `simple_add'.
--			-- The preconditions express the fact that if Current is in
--			-- its `max_base', `simple_add' will never produce a carry that
--			-- is greater than one; if Current is represented in a `base'
--			-- less than the `max_base', then `simple_add' must ensure that
--			-- the addends are less than the `base'.
		require
--			not_reduced_implication: not is_reduced_base implies c_in <= one_value
--			big_carry_implication: c_in > one_value implies not is_reduced_base
--			reduced_implication_a: is_reduced_base implies a < base
--			reduced_implication_b: is_reduced_base implies b < base
--			reduced_implication_c: is_reduced_base implies c_in < base
			carry_in_one_or_zero: c_in <= one_digit
		local
			d: like digit
			c: like digit
		do
--			d := a + b
--			d := b + c_in
--			d := a + b + c_in
----			if is_reduced_base then
----				c := d // base
----				d := d \\ base
----			else
--				c := zero_digit
----				if d < a or else d + c_in < a then
--				if d < a or else d < b or else d < c then
--						-- there was overflow, so should carry
--					c := one_digit
--				end
----			end
			c := zero_digit
			d := a + b
			if d < a or d < b then
				c := one_digit
			end
			d := d + c_in
			if d < c_in then
				c := one_digit
			end
			tup.sum := d
			tup.carry := c
		ensure
--			reduced_implication: is_reduced_base implies tup.sum < base
		end

	can_borrow (a_index: INTEGER): BOOLEAN
			-- Is it possible to borrow from `a_index'th digit?
			-- In other words, can we subtract one place-value amount from
			-- Current at `a_index' and add that amount to the lower-order
			-- digit without overflowing the representation of a digit?
		do
			Result := (a_index > 1 and a_index <= count)
		end

	borrow (a_index: INTEGER)
			-- Modify current by borrowing from the `a_index'-th digit.
			-- The calling routine (i.e. the subtraction routine) must
			-- account for the value of the receiving digit, because the
			-- borrowed amount (i.e the max base), which not representable
			-- cannot be added to that digit.
		require
--			is_unstable: is_unstable
			index_large_enough: a_index > 1
			index_small_enough: a_index <= count
			can_borrow: can_borrow (a_index)
		local
			i: INTEGER
		do
			from i := a_index
			until i_th (i) > zero_digit
			loop
				check
					eventually_find_a_borrow: i <= count
						-- because of precondition "can_borrow".
				end
				put_i_th (max_digit, i)
				i := i + 1
			end
			put_i_th (i_th (i) - zero_digit.one, i)
			if i = count and i_th (count) = 0 then
				go_i_th (count)
				remove
			end
		end

	subtract_i_th (a_value: like digit; a_index: INTEGER)
			-- Modify current by subtracting `a_value' from `a_index'th digit,
			-- borrowing if necessary.
		require
			index_big_enough: a_index >= 1
			index_small_enough: a_index <= count
			subtraction_allowed: a_value <= i_th (a_index) or can_borrow (a_index + 1)
		local
			d: like digit
		do
				-- Mark as unstable, because a `borrow' might happen, which
				-- causes the borrowed into digit to temporatily ,
				-- otherwise violating the invariant.
--			set_unstable
			if i_th (a_index) < a_value then
				borrow (a_index + 1)
					-- Subtract first, then add the borrow;
				d := max_digit - a_value + i_th (a_index) + one_digit
				check
					positive_d: d > zero_digit
						-- because, otherwise, would not have borrowed.
				end
			else
				d := i_th (a_index) - a_value
			end
			put_i_th (d, a_index)
			if a_index = count and d ~ zero_digit then
				remove_leading_zeros
			end
--			set_stable
		end

feature -- Basic operations (multiplication)

	scalar_multiply (a_value: like digit)
			-- Multipy Current by `a_value'.
		local
			temp: like Current
			i: INTEGER
			prev_hi: like digit
			tup: TUPLE [high, low: like digit]
			t, t2: like digit
		do
			if is_zero then
				do_nothing
			elseif a_value = zero_digit then
				wipe_out
				extend (zero_digit)
				is_negative := false
			else
				temp := twin
				wipe_out
				tup := [zero_digit, zero_digit]
				prev_hi := zero_digit
				from i := 1
				until i > temp.count
				loop
					digits_multiplied (temp.i_th (i), a_value, tup)
					extend (tup.low + prev_hi)		-- throw out high-order bits
					if tup.low > max_digit - prev_hi then
						prev_hi := tup.high + one_digit	-- carry a one
					else
						prev_hi := tup.high
					end
					i := i + 1
				end
				if prev_hi > zero_digit then
					extend (prev_hi)
				end
				if (is_negative and a_value >= zero_digit) or
						(not is_negative and a_value < zero_digit) then
					set_is_negative (true)
				else
					set_is_negative (false)
				end
			end
		end

	scalar_product (a_value: like digit): like Current
			-- New object equivalent to Current multiplied by `a_value'.
			-- Do not change Current.
		require
			value_small_enough: a_value <= max_digit
		do
			Result := twin
			Result.scalar_multiply (a_value)
		end

	multiply (other: like Current)
			-- Change Current by multiplying it by `other'.
		do
			copy (Current * other)
		end

	product alias "*" (other: like Current): like Current
			-- Product by `other'.
		do
				-- Unlike the relationship between `add' and `+', where the
				-- work is done in `add' and `+' is a copy; the work for
				-- multiplication is done in `*' and `multiply' performs the
				-- copy.  This results in fewer copy or twin operations.
			if is_zero or other.is_zero then
				Result := new_big_number (zero_digit)
			elseif is_one then
				Result := other.deep_twin
			elseif other.is_one then
				Result := deep_twin
			elseif is_base then
				Result := other.deep_twin
				Result.shift_left (1)
			elseif other.is_base then
				Result := deep_twin
				Result.shift_left (1)
			else
				if count < karatsuba_threshold and other.count < karatsuba_threshold then
					Result := simple_product (other)
				elseif count >= karatsuba_threshold and other.count >= karatsuba_threshold then
					if (count - other.count).abs <= 1 then
						Result := karatsuba_product (other)
					else
						Result := recursive_product (other)
					end
				else
					Result := recursive_product (other)
				end
			end
			if is_same_sign (other) then
				Result.set_is_negative (false)
			else
				Result.set_is_negative (true)
			end
		ensure then
			zero_factor_implies_is_zero: (is_zero or other.is_zero) implies Result.is_zero
			zero_result_implies_count: Result.is_zero implies Result.count = 1
		end

feature {JJ_BIG_NUMBER} -- Implementation (multiplication)

	simple_product (other: like Current): like Current
			-- The result of multiplying Current and `other'.
			-- Grade-school style algorithim with complexity ~ O(n^2).
		require
			other_exists: other /= Void
			not_zero: not is_zero
			other_not_zero: not other.is_zero
			not_one: not is_one
			other_not_one: not other.is_one
			not_base: not is_base
			other_not_base: not other.is_base
			karatsuba_inapplicable: count < karatsuba_threshold and other.count < karatsuba_threshold
		local
			fac_1, fac_2: like Current
			s: like Current
			i: INTEGER
			d: like digit
		do
			if count < other.count then
				fac_1 := other
				fac_2 := Current
			else
				fac_1 := Current
				fac_2 := other
			end
			Result := new_big_number (zero_digit)
			from i := 1
			until i > fac_2.count
			loop
				s := fac_1.twin
				d := fac_2.i_th (i)
				s.scalar_multiply (d)
				if not s.is_zero then
					s.shift_left (i - 1)
				end
				Result := Result + s
				i := i + 1
			end
			if is_same_sign (other) then
				Result.set_is_negative (false)
			else
				Result.set_is_negative (true)
			end
--io.put_string ("count = " + count.out + "  other.count = " + other.count.out + "   ")
--io.put_string ("(" + Current.out + ").simple_product (" + other.out + ") = ")
--io.put_string (Result.out + "%N")
		end

	recursive_product (other: like Current): like Current
			-- Divide-and-conquer multiplication used when there is a disparity
			-- between the number of digits in Current and other.
		require
			other_exists: other /= Void
			simple_inapplicable: count >= karatsuba_threshold or other.count >= karatsuba_threshold
			big_size_difference: (count >= karatsuba_threshold and other.count >= karatsuba_threshold) implies
									(count - other.count).abs > 1
		local
			big, lit, p: like Current
			i: INTEGER
			t: INTEGER		-- block length
			n: INTEGER		-- number of blocks
			e: INTEGER		-- number of left over digits at high end
			bn: like Current

		do
			Result := new_big_number (zero_digit)
				-- Find which factor has the most digits, in order to
				-- multiply the longer number by the shorter number.
			if count < other.count then
				lit := Current
				big := other
			else
				lit := other
				big := Current
			end
				-- Get the length of the shorter number, so that we can
				-- logically divide the longer into blocks of that length.
			t := lit.count
			n := big.count // t
			e := big.count \\ t
			from i := 1
			until i > n
			loop
					-- Starting at the low-order digits, break the longer
					-- number into segments containing the same number of
					-- digits as the shorter number.
				bn := big.partition (t * i, t * i - t + 1)
					-- Recursive multiply.
				p := bn * lit
				if not p.is_zero then
					p.shift_left (t * (i - 1))
				end
				Result := Result + p
				i := i + 1
			end
			if e > 0 then
					-- There's one or more digits remaining at high end that
					-- do not fill an entire block of size `t'.
				check
					not_complete_block: e < t
					one_block_more: i = n + 1
				end
				bn := big.partition (big.count, t * i - t + 1)
				p := bn * lit
				p.shift_left (t * (i - 1))
				Result := Result + p
			end
			if is_same_sign (other) then
				Result.set_is_negative (false)
			else
				Result.set_is_negative (true)
			end
		end

	karatsuba_product (other: like Current): like Current
			-- Divide and conquer multiplication using Karatsub's algorithm
			-- where the middle term, z1, is calculated as:
			--    (x1 + x0)(y1 + y0) - x1y1 - x0y0
		require
			other_exists: other /= Void
			almost_same_size: (count - other.count).abs <= 1
			karatsuba_applies: count >= karatsuba_threshold and other.count >= karatsuba_threshold
		local
			n: INTEGER
			a, b: like Current
			c, d: like Current
			z2, z1, z0: like Current
		do
				-- Split both numbers into two smaller ones
			n := count.min (other.count)
			n := (n // 2) + (n \\ 2)
				-- High & low order digits of Current
--			a := new_sub_number (n + 1, count, Current)
--			b := new_sub_number (1, n, Current)
			a := partition (count, n + 1)
			b := partition (n, 1)
				-- High and low order digits of other
--			c := new_sub_number (n + 1, other.count, other)
--			d := new_sub_number (1, n, other)
			c := other.partition (other.count, n + 1)
			d := other.partition (n, 1)
				-- Create the terms for the multiplication
				--		z2*Base^2 + z1*Base^1 + z0*Base^0
			z2 := a * c
			z0 := b * d
			z1 := (a + b) * (c + d) - z2 - z0
			if not z2.is_zero then
				z2.shift_left (n * 2)
			end
			if not z1.is_zero then
				z1.shift_left (n)
			end
			Result := z2 + z1 + z0
			if is_same_sign (other) then
				Result.set_is_negative (false)
			else
				Result.set_is_negative (true)
			end
--io.put_string ("count = " + count.out + "  other.count = " + other.count.out + "   ")
--io.put_string ("(" + Current.out + ").karatsuba_product (" + other.out + ") = ")
--io.put_string (Result.out + "%N")
		end

	digits_multiplied (a_digit, a_other: like digit; a_tuple: TUPLE [high, low: like digit])
			-- Multiply `a_digit' and `a_other', resulting in a product and
			-- a carry, which is passed out in `a_tuple'.
			-- The result is passed out in `a_tuple' instead of as Result, in
			-- order avoid creating a new TUPLE on every call to this feature.
			-- This decomposition feature is used by `scalar_multiply'.
		require
--			digit_small_enough: is_reduced_base implies a_digit < base
--			other_small_enough: is_reduced_base implies a_other < base
--			will_not_overflow: a_digit.max (a_other) <= base.max_value - a_digit.min (a_other)
		local
			h: INTEGER_32
			a, b, c, d: like digit
			ac, ad, bc, bd: like digit
			high, low: like digit
			car: like digit
		do
			-- Options:
			--   1)  Cast each digit to the next higher representation (e.g.
			--       replace a {NATURAL_8} with a {NATURAL_16})  I rejected
			--       this idea, because there is nothing to which to cast a
			--       {NATURAL_64}.
			--   2)  Split each digit into two digits of half the size of the
			--       current representation treating the resulting values as the
			--       coefficients of a factored polynomial and multiply:
			--
			--                       a   b
			--           a_digit =  0111 1111     ==>  Ax + B
			--           a_other =  0111 1111     ==>  Cx + D
			--                       c   d
			--
			--       Evaluating the terms gives:
			--           ac  =  00000111 * 00000111 = 00110001
			--           ad  =  00000111 * 00001111 = 01101001
			--           bc  =  00001111 * 00000111 = 01101001
			--           bd  =  00001111 * 00001111 = 11100001
			--       So, for the multiplication of  (Ax + B)(Cx + D), showing only
			--       the coefficients gives:
			--          ac + (ad + bc) + bd
			--
			--       I rejected this approach, because it is not clear how to
			--       handle the middle term in relation to both the first and
			--       third term.
			--
			--   3)  Multiply the digits in place, keeping the result as the
			--      `value' and temporarily accepting the lose of any overflow.
			--      Then calculate the lost overflow using an algorithm from
			--      http://stackoverflow.com/questions/28868367/getting-the-
			--      high-part-of-64-bit-integer-multiplication, storing that
			--      overflow in the `carry'.
			--         This bit-shifting approach works for any size representation,
			--      but only when the base is not reduced.
			--
					-- Calculate the low-order half of the Result.
					-- Any overflow is discarded.
			a_tuple.low := a_digit * a_other
				-- Now calculate the high-order half of the Result.
				-- Find the shift amount
			h := bits_utilized // 2
				-- High & low order bits of `a_digit'
			a := a_digit.bit_shift_right (h)
			b := a_digit.bit_shift_left (h).bit_shift_right (h)
				-- High and low order bits of `a_other'
			c := a_other.bit_shift_right (h)
			d := a_other.bit_shift_left (h).bit_shift_right (h)
				-- Calculate the four terms.
			ac := a * c
			ad := a * d
			bc := b * c
			bd := b * d
				--  ((ad + bc) + (bd >> h)) >> h
			car := ((ad.bit_shift_left (h).bit_shift_right (h) +
					bc.bit_shift_left (h).bit_shift_right (h)) +
					bd.bit_shift_right (h)).bit_shift_right (h)
				--  ac + (ad >> h) + (bc >> h) + car
			a_tuple.high := ac + ad.bit_shift_right (h) + bc.bit_shift_right (h) + car
		ensure
--			value_small_enough: Result.high <= base_minus_one_value
--			carry_small_enough: Result.low <= base_minus_one_value
		end

	karatsuba_threshold_imp: INTEGER_32_REF
			-- Implementation of the `karatsuba_threshold, the value above
			-- which multiplication operations use `karatsuba_product'.
		once
			create Result
			Result.set_item (Default_karatsuba_threshold)
		end

feature -- Basic operations (other)

	raise (a_power: like Current)
			-- Raise Current by `a_power'.
			-- This is a slow implementation using a loop.
		local
			i: like Current
			orig: like Current
		do
			if a_power ~ zero then
				copy (one)
			elseif a_power > one then
				orig := twin
				from i := one + one
				until i > a_power
				loop
					multiply (orig)
					i := i + one
				end
			end
		end

	integer_power alias "|pow" (a_power: like Current): like Current
			-- Integer power of Current by `a_power'.
			-- Does not change Current.
			-- This is a slow implementation using a loop.
		do
			Result := twin
			Result.raise (a_power)
		end

	power alias "^" (a_power: REAL_64): REAL_64
			-- FIX ME to return a BIG_REAL
		do
		end

	magnitude: like Current
			-- The absolute value of Current.
		do
			Result := twin
			Result.set_is_negative (false)
		end

feature  -- Division

	divide (a_other: like Current)
			-- Modify Current to contain the integer quotient between Current
			-- and `a_other'; discard the remainder.
		require
			divisor_not_zero: a_other /~ zero
		local
			q: like quotient
		do
			q := quotient (a_other)
			copy (q.quot)
		end

	integer_quotient alias "//" (a_other: like Current): like Current
			-- Division by `a_other'.
			-- Does not change Current.
		do
			Result := quotient (a_other).quot
		end

	integer_remainder alias "\\" (a_other: like Current): like Current
			-- Remainder of the integer division of Current by `a_other'.
			-- Does not change Current.
		do
			Result := quotient (a_other).rem
		end

	quotient alias "/" (a_other: like Current): TUPLE [quot, rem: like Current]
			-- The quotient and remainder resulting from dividing Current
			-- by `a_other' without changing Current.
		require
			divisor_non_zero: a_other /~ zero
		local
			x, y: like Current
			i, n: INTEGER
		do
				-- Reminder:  the tilde operator calls `is_less'.
			if Current ~ zero then
					-- Numerator is zero.
				Result := [zero, zero]
			elseif count < a_other.count or else Current < a_other then
					-- Denominator is bigger than numerator.
				Result := [zero, Current.twin]
			elseif a_other.is_one then
					-- Dividing by one or negative one.
				if a_other ~ one then
					Result := [Current.twin, zero]
				else
					Result := [Current.twin.opposite, zero]
				end
			elseif Current.is_magnitude_equal (a_other) then
					-- Absolute values of numerator and denominator are equal.
				if Current.is_same_sign (a_other) then
					Result := [one, zero]
				else
					Result := [one.opposite, zero]
				end
			elseif count = 1 then
				check
					other_also_length_one: a_other.count = 1
						-- because of the second condition above.
				end
				Result := [new_big_number (Current.i_th (1) // a_other.i_th (1)),
							new_big_number (Current.i_th (1) \\ a_other.i_th (1))]
			else
				x := twin
				y := a_other.twin
				i := y.normalize
				n := 0
				x.bit_shift_left (i)
				if x.count = 2 and y.count = 1 then
					Result := divide_two_digits_by_one (x.i_th (2), x.i_th (1), y.i_th (1))
					-- Count is even and twice the count of other.
				elseif y.count <= div_limit then
					Result := school_divide (x, y)
--				elseif x.count \\ 2 = 0 and x.count // 2 = a_other.count then
----					Result := two_by_one_divide (x.t_th_block (2, 2), x.t_th_block (1, 2), y)
--					Result := two_by_one_divide (x, y)
				else
					x.set_unstable
					y.set_unstable
					n := x.condition_for_x_by_one_division (y)
					Result := x.x_by_one_divide (y)
				end
				Result.rem.bit_shift_right (i)
				Result.rem.shift_right (n)
				Result.rem.remove_leading_zeros
				Result.quot.remove_leading_zeros
				Result.rem.set_stable
				Result.quot.set_stable
			end
		end

feature {JJ_BIG_NATURAL} -- Implementation (division)

	div_limit_imp: INTEGER_32_REF
			-- Implementation of the `div_limit', the denominator digit count
			-- above which division uses Burnikel and Zieler recursive division.
		once
			create Result
			Result.set_item (Default_div_limit)
		end

	school_divide (a, v: like Current): TUPLE [quot, rem: like Current]
			-- The quotient and remainder of dividing `a' by `v', implemented as
			-- described by Knuth's Algorithm D.
			-- See Knuth, "The Art of Computer Programming", Vol 2, second edition,
			-- pp 257-258.
		require
			n_greater_than_one: v.count >= 1
			a_long_enough: a.count >= v.count
			is_normalized: v.is_normalized
		local
			j: INTEGER
			n, m: INTEGER
			b: like Current
			u: like Current
			v1, v2, u1, u2: like digit
			u12: like Current
			r: like Current				-- a remainder
			q, q_hat, d: like Current
			tup: like divide_two_digits_by_one
		do
			n := v.count
			m := a.count
			b := ones (n)
			q := new_big_number (zero_digit)
			u := new_big_number (zero_digit)
			v1 := v.i_th (v.count)
				-- D1.  Normalize.  It already is normalized.
			check
				already_normalized: v.is_normalized
					-- because of precondition.  Must assume `a' was adjusted.
			end
			if a.count = v.count then
				a.extend (zero_digit)
			end
				-- Start at high-order digit.
				-- Feature `new_sub_number' arguments:  (a_low, a_high).
				-- One-based arrays make the indexing look odd, but...
				-- Get `n' number of digits or at least two.
--			u := new_sub_number (a.count - n + 1, a.count, a)
			u := a.partition (a.count, a.count - n + 1)
			from j := a.count - n	-- m - n
			until j = 0
			loop
					-- Get one more digit.
				u.shift_left (1)
				u.scalar_add (a.i_th (j))
				from
				until u.count > v.count
				loop
					u.extend (zero_digit)
				end
				u1 := u.i_th (u.count)
				u2 := u.i_th (u.count - 1)
					-- D3.  Calulate `q_hat'.
--				if u1 = v1 then
--					q_hat := new_big_number (max_digit)
--				else
					q_hat := divide_two_digits_by_one (u1, u2, v1).quot
					if v.count > 1 then
						v2 := v.i_th (v.count - 1)
						u12 := new_big_number (u1)
						u12.shift_left (1)
						u12.scalar_add (u2)
						d := q_hat.scalar_product (v2)
						r := u12 - q_hat.scalar_product (v1)
						r.shift_left (1)
						r.scalar_add (u.i_th (u.count - 2))
						if d > r then
							q_hat := q_hat - one
							d := q_hat.scalar_product (v2)
							r := u12 - q_hat.scalar_product (v1)
							r.shift_left (1)
							r.scalar_add (a.i_th (a.count - 2))
							if d > r then
								q_hat := q_hat - one
							end
						end
					end
--				end
					-- D4.  Multiply and subtract.
				u := u - (q_hat * v)
				u.remove_leading_zeros
					-- D5.  Test remainder.
				if u.is_negative then
						-- D6.  Add back.
					q_hat := q_hat - one
					u := u + v
				end
				check
					q_hat_count_big_enough: q_hat.count >= 1
					q_hat_count_small_enough: q_hat.count <= 2
				end
				q.shift_left (q_hat.count)
				q.add (q_hat)
				j := j - 1
			end
			Result := [q, u]
		end

	two_by_one_divide (a: like Current; a_other: like Current):
							 TUPLE [quot, rem: like Current]
			-- The result of dividing a number that has twice the number of
			-- digits as `a_other'.  The number is split into its high and low
			-- order digits, `a_high' and `a_low'.
			-- See Burnikel & Zieler, "Fast Recursive Division", p 4,
			-- Algorighm 1.
		require
			divisor_is_normalized: a_other.is_normalized
			n_big_enough: a_other.count >= div_limit or a_other.count = 1
			n_is_even_or_one: a_other.count \\ 2 = 0
			is_twice_n: a.count = 2 * a_other.count
		local
			a12, a3, a4: like Current
			r1, r2: like Current
			n, half_n, t: INTEGER
			q: like Current
			tup: TUPLE [quot, rem: like Current]
		do
			if a_other.count = 1 then
				check
					should_not_happen: false
						-- because ?  remove if never reached.
				end
				Result := divide_two_digits_by_one (a.i_th ((2)), a.i_th (1), a_other.i_th (1))
			else
				n := a_other.count
				half_n := n // 2
					-- 2)  Split A into four parts...
					-- High order digits first
					-- Reminder:  `t_th_block' counts blocks from low to high.
				a12 := a.t_th_block (2, a.count // 2)
				t := a.count // 4
				a3 := a.t_th_block (2, t)
				a4 := a.t_th_block (1, t)
					-- 3) Compute the high part Q1 of floor(A/B)... with remainder...
				tup := three_by_two_divide (a12, a3, a_other)
				q := tup.quot
					-- 4) Compute the low part Q2...
				from
				until tup.rem.count >= a_other.count
				loop
					tup.rem.extend (zero_digit)
				end
				check
					rem_has_correct_count: tup.rem.count = a_other.count
				end
				tup := three_by_two_divide (tup.rem, a4, a_other)
				Result := [new_combined_number (q, tup.quot), tup.rem]
			end
		end

	three_by_two_divide (a, a3, b: like Current): TUPLE [quot, rem: like Current]
			-- Called by `two_by_one_divide'.  It has similar structure as
			-- `div_three_halves_by_two_halfs', but the arguments to this
			-- function have type {JJ_BIG_NATURAL} instead of like `digit'.
			-- See Burnikel & Zieler, "Fast Recursive Division", pp 4-8,
			-- Algorithm 2.
			-- The first precondition is there, so that "the upper and lower
			-- parts Q1, Q2 of the quotient consist of n/2 digits..."  See
			-- post-condition "quotient_has_correct_count".
		require
			n_not_odd: b.count >= div_limit and b.count \\ 2 = 0
			b_has_2n_digits: b.count = a3.count * 2
			a_has_2n_digits: a.count = a3.count * 2
		local
			n: INTEGER
			a1, a2: like Current
			b1, b2: like Current
			tup: TUPLE [quot, rem: like Current]
			q, q1, q2, r, r1: like Current
			c, d: like Current
		do
			n := b.count // 2
				-- 1) Split `a'.
			a1 := a.partition (a.count, n + 1)
			a2 := a.partition (n.max (1), 1)
				-- 2) Split `b'.
			b1 := b.partition (b.count, n + 1)
			b2 := b.partition (n.max (1), 1)
				-- 3) Distinguish cases.
			if a1 < b1 then
					-- 3a) compute Q = floor ([A1,A2] / B1 with remainder.
				if b1.count < div_limit then
					tup := school_divide (a, b1)
				else
					tup := two_by_one_divide (a, b1)
				end
				q := tup.quot
				r1 := tup.rem
			else
					-- 3b) Q = beta^n - 1 and ...
				q := ones (n)
					-- ... R1 = [A1,A2] - [B1,0] + [0,B1] = [A1,A2] - QB1.
--				r1 := a - (q * b1)
				r1 := a + b1
				if n > 1 then
					b1.shift_left (n)
				else
					b1.bit_shift_left (bits_utilized // 2)
				end
				r1.subtract (b1)
			end
				-- 4) D = Q * B2
			d := q * b2
				-- 5) R1 * B^n + A3 - D.  (The paper says "a4".)
			r1.shift_left (n)
			r := r1 + a3 - d
				-- 6) As long as R < 0, repeat
			from
			until not r.is_negative
			loop
				r := r + b
				q.decrement
			end
			check
				remainder_small_enough: r.count <= b.count
					-- because remainder must be less than divisor.
			end
			Result := [q, r]
		ensure
--			n_digit_remainder: Result.rem.count = b.count // 2
			quotient_has_correct_count: Result.quot.count <= b.count // 2
		end

	x_by_one_divide (a_other: like Current): TUPLE [quot, rem: like Current]
			-- The result of dividing Current by `a_other' when Current
			-- has x number of blocks of digits, where each block has the
			-- number digits in `a_other'.
			-- See Burnikel & Zieler, "Fast Recursive Division", pp 9-10.
		require
			not_divide_by_zero: a_other /~ zero
			other_long_enough: a_other.count > 0
			other_has_power_of_two_count: a_other.count - (a_other.count - 1) = 1
			other_is_normalized: a_other.is_normalized
			long_enough: count > a_other.count
			has_correct_count: count \\ a_other.count = 0
		local
			i, t, n, low, high: INTEGER
			sft: INTEGER
			a, z: like Current
			q_sub_i: TUPLE [quot, rem: like Current]
			q: like Current
		do
			n := a_other.count
				-- Get the number of blocks into which Current is divided.
			t := count // n
			q := zero
			q_sub_i := [zero, zero]
				-- Get the first two blocks.
			a := t_th_block (t, n)
			z := t_th_block (t - 1, n)
			from i := t - 1
			until i = 0
			loop
					-- Combine the next block `z' (low-order) with the
					-- remainder `a' (high-order).
				z.combine (a)
				q_sub_i := two_by_one_divide (z, a_other)
					-- Ensure the remainder has enough digits for `two_by_one_divide'.
				from
				until q_sub_i.rem.count >= a_other.count
				loop
					q_sub_i.rem.extend (zero_digit)
				end
				if q.is_zero then
					q.add (q_sub_i.quot)
				else
					q := new_combined_number (q, q_sub_i.quot)
				end
				a := q_sub_i.rem
					-- Bring down next block.
				if i > 1 then
					z := t_th_block (i - 1, n)
				end
				i := i - 1
			end
			Result := [q, q_sub_i.rem]
			Result.quot.remove_leading_zeros
		end

	t_th_block (t: INTEGER; a_size: INTEGER): like Current
			-- Get a new number consisting of the t-th block of digits
			-- where `a_size' is the number of digits in each block.
			-- Index `t' begins with block one at the low-order end
			-- and increases toward the high-order end.
			-- Decomposition feature used by `x_by_one_divide'.
			-- See Burnikel & Zieler, "Fast Recursive Division", pp 9-10.
		require
			t_big_enough: t >= 1
			size_big_enough: a_size >= 1
			valid_block_size: count \\ a_size = 0
			valid_block: t <= count // a_size
		local
			high, low: INTEGER
		do
			high := t * a_size
			low := high - a_size + 1
			Result := partition (high, low)
		ensure
			result_has_correct_count: Result.count = a_size
		end

	condition_for_x_by_one_division (a_other: like Current): INTEGER
			-- Modify, if required, both Current and `a_other' so that a
			-- left-to-right division using `two_by_one_divide' is possible,
--			-- returning the amount of left shifting required.
			-- This feature ensures `a_other' has a power-of-two number of
			-- digits, padding it with low-order zeroes if required.  Current
			-- is also padded with zeros so that it has a number of digits
			-- that is a multiple of the number of digits now in `a_other'.
			-- See Burnikel & Zieler, "Fast Recursive Division", pp 9-10.
			-- The Result is the number of left shifts, which we used to fix
			-- the remainder given by `x_by_one_divide', because the remainder
			-- returned by that function is "the overall division remainder
			-- (left-shifted by 2^alpha)."
			-- See Burnikel & Zieler, page 10, just above "Claim 2".
		require
			is_marked_unstable: is_unstable
			other_is_marked_unstable: a_other.is_unstable
		local
--			n: INTEGER		-- number of digits required in `a_other'
--			blks: INTEGER	-- number of blocks of size `n' required in Current
--			t: INTEGER		-- number of digits required in Current
			n: INTEGER		-- number of left shifts after normalization
		do
				-- Extend the divisor (i.e. `a_other') so that it has 2^k (i.e. a
				-- power of two) digits by adding zeros on the low-order end
				-- and adjust Current accordingly.
			from n := 0
			until a_other.count.bit_and (a_other.count - 1) = 0
			loop
				a_other.put_front (zero_digit)
				n := n + 1
			end
				-- Now shift Current so it has the same number of "new" zeroes.
			shift_left (n)
			Result := n
				-- Normalize `a_other' and adjust Current accordingly.
			n := a_other.normalize
			bit_shift_left (n)
				-- Pad Current with leading zeroes to make its digit `count'
				-- a multiple of `a_other'.
			if count = a_other.count then
				extend (zero_digit)		-- special case
			end
			from
			until count \\ a_other.count = 0
			loop
				extend (zero_digit)
			end
		ensure
			divisor_count_power_of_two: a_other.count.bit_and (a_other.count - 1) = 0
			count_is_multiple_of_other_count: count \\ a_other.count = 0
			other_is_normalized: a_other.is_normalized
		end

	divide_two_digits_by_one (a_high, a_low, a_divisor: like digit):
							TUPLE [quot: like Current; rem: like Current]
			-- Divide a two-digit number containing `a_high' and `a_low' digit
			-- by a single-digit number `a_divisor', returning a quotient and remainder.
			-- See "Fast Recursive Division" by Burnikel and Ziegler, p 3.
			-- Unlike most division operations on a divide by zero, this feature
			-- upholds Knuth's demand that a \\ 0 = a, providing the useful
			-- property that (a // b) * b + (a \\ b) = a.
			-- (See Knuth: The Art of Computer Programming, Volumn 2".)
		require
--			divisor_non_zero: a_divisor /= zero_value
			divisor_is_normalized: is_digit_normalized (a_divisor)
		local
			i: INTEGER
			tup: TUPLE [a3, a4: like digit]
			qr: like div_three_halves_by_two
			qs: like div_three_halves_by_two
			r: TUPLE [r1, r2: like digit]
			f: like digit
			quot, rem: like Current
		do
				-- "Let [a3, a4] = AL"
			tup := as_half_digits (a_low)
				-- "[q1,R] = DivThreeHalvesByTwo (a1,a2,a3,b1,b2)"
			qr := div_three_halves_by_two (a_high, tup.a3, a_divisor)
				-- "Let [r1,r2] = R"
			r := as_half_digits (qr.rem)
				-- "[q2,S] = DivThreeHalvesByTwo (r1,r2,a4,b1,b2)"
			qs := div_three_halves_by_two (qr.rem, tup.a4, a_divisor)
				-- "Return the quotient Q = [q1,q2] and the remainder S."
			if qr.quot > max_half_digit then
				quot := new_big_number (qr.quot)
				quot.bit_shift_left (bits_utilized // 2)
				quot.scalar_add (qs.quot)
			else
				f := as_full_digit (qr.quot, qs.quot)
				quot := new_big_number (f)
			end
			rem := new_big_number (qs.rem)
			Result := [quot, rem]
		ensure
--			quotient_has_only_one_digit: Result.quot.count = 1
		end

	div_three_halves_by_two (A, a3, B: like digit): TUPLE [quot, rem: like digit]
			-- Divide three half-digits, "a1" and "a2" (contained in `A') and
			-- `a3' by two half-digits, "b1" and "b2" (contained in `B'), in
			-- such a way that the computations fit into the representation
			-- (i.e. the number of bits) of a digit.
			-- See "Fast Recursive Division" by Burnikel and Ziegler, p 3 to top p 4.
		local
			tup: TUPLE [b1, b2: like digit]
			q, c, ca: like digit
			D, R: like Current
			t: like digit
		do
			tup := as_half_digits (B)
			q := a // tup.b1		-- Line 6
			c := a \\ tup.b1		-- Same as "c := A - Q * b1" (i.e. remainder).
				-- Use a big number to account for values larger than one digit.
			D := new_big_number (q)
			D.scalar_multiply (tup.b2)	-- Same as "d := q * b2"
				-- Add half-word of numerator to remainder.
			ca := as_full_digit (c, a3)	-- Same as [c,a3]
				-- Perform "R := [c,a3] - D", line 9
			D.negate
			R := D.scalar_sum (ca)
				-- Here begins the code that corrects a quotient that is too big.
				-- Unlike Bernikel and Ziegler's algorithm, which makes at most
				-- two corrections to the originally "guessed" quotient, this code,
				-- for some reason, can make up to four corrections.  Most of the
				-- time, only one or no corrections are made.  Tests on possible
				-- values in 8-bit representation shows this distribution:
				--   num corrections     percentage
				--          0              52.32% 
				--          1              40.77%
				--          2               6.15%
				--          3               0.75%
				--          4               0.01%
			from
			until not R.is_negative
			loop
				q := q - one_digit
				R.scalar_add (B)
			end
			check
				only_on_digit: R.count = 1
			end
			Result := [q, R.i_th (1)]
		end
--			r := as_full_digit (c, a3)
--			if r < d then					-- Same as "if (R < 0)".
--				q := q - one_digit
--					-- Recompute `r' using multiplication, instead of subtracting
--					-- `d', testing < 0, and adding `b', because the representation
--					-- in NATURAL numbers does not allow for negative values.
--				c := A - q * tup.b1
--				d := q * tup.b2
--				r := as_full_digit (c, a3)
--				if r < d then
--					q := q - one_digit
--					c := A - q * tup.b1
--					r := as_full_digit (c, a3)
----				r := r + b
----				if r < d then
----					q := q - one_digit
----					r := r + b - d
--				else
--					r := r - d
--				end
--			else
--				r := r - d
--			end
				-- Version modeled after Colin Plumb's C code
--			q := a // tup.b1	-- Line 6
--			r := a \\ tup.b1	-- Same as "c := A - q * b1" (i.e. remainder).
--				-- Add half-word of numerator to remainder.
--			r := as_full_digit (r, a3)
--				-- Multiply by "guessed" quotient and correct if necessary.			
--			d := q * tup.b2		-- Error:  this line can cause overflow !!!
--				-- Digits can never be negative, so in order to perform the test
--				-- "if (R < 0)" on lines 10 and 13 of Burnikel's algoritm page 3,
--				-- we use temporary, `r', which is [c, a3], and check it against
--				-- `d'.  Instead of subtracting d from R, which would not work,
--				-- we subtract `d' from `r' only after adding `b' to it (once or
--				-- twice), which prevents integer underflow.
--			if r < d then
--				q := q - one_digit
--				r := r + b
--				if r >= b and r < d then
--					q := q - one_digit
--					r := r + b
--				end
--			end
--			r := r - d
--				-- No longer need `B' so reuse the `tup' variable.
--			tup := as_half_digits (q)
--			Result := [tup.b1, tup.b2, r]
--			check
--				valid_overflow: Result.over <= one_digit
--			end
--			Result := [q, r]
--		end

	as_half_digits (a_digit: like digit): TUPLE [high, low: like digit]
			-- Split `a_digit' into two half-digits.
			-- See "Fast Recursive Division" by Burnikel and Ziegler, p 3.
		local
			h: INTEGER
		do
			h := bits_utilized // 2
			Result := [a_digit.bit_shift_right (h),
						a_digit.bit_shift_left (h).bit_shift_right (h)]
		end

	as_full_digit (a_high, a_low: like digit): like digit
			-- Combine `a_high' half and `a_low' half into a single digit
		require
			high_small_enough: a_high <= max_half_digit
			low_small_enough: a_low <= max_half_digit
		do
			Result := a_high.bit_shift_left (bits_utilized // 2) + a_low
		end

	normalize: INTEGER
			-- Ensure Current `is_normalized', possibly shifting the bits of
			-- each digit in Current until the most high-order digit is greater
			-- or equal to the `max_base' // 2, returning the number of shifts
			-- required to do so.
			-- Knuth: The Art of Computer Programming, Volumn 2", pp 257-258.
		require
			not_zero: magnitude > zero
		local
			n: INTEGER
			c, c_out: like digit
			d: like digit
			i: INTEGER
		do
			Result := bits_utilized - i_th (count).most_significant_bit
			bit_shift_left (Result)
		ensure
			is_normalized: is_normalized
			unchanged_count: count = old count
		end

	is_normalized: BOOLEAN
			-- Is the most high-order digit greater than or equal to `max_base' // 2?
			-- (See Knuth: The Art of Computer Programming, Volumn 2".)
		do
			Result := i_th (count) >= max_digit // two_digit + one_digit
		ensure
			definition: Result implies i_th (count) >= max_digit // two_digit + one_digit
		end

	is_digit_normalized (a_digit: like digit): BOOLEAN
			-- Is `a_digit' greater than or equal to `base' // 2?
			-- (See Knuth: The Art of Computer Programming, Volumn 2".)
		do
			Result := a_digit >= max_digit // two_digit + one_digit
		end

	bit_shift_left (a_shift: INTEGER_32)
			-- Change Current by shifting the bits left by `a_number', carrying
			-- into the next digit if required.
		require
			shift_big_enough: a_shift >= 0
			shift_small_enough: a_shift <= bits_utilized
		local
			c, c_out: like digit
			d: like digit
			i: INTEGER
		do
			c := zero_digit
			from i := 1
			until i > count
			loop
					-- Determine the carry out
				c_out := i_th (i).bit_shift_right (bits_utilized - a_shift)
					-- Shift to far to zero out unutilized bits.
				d := i_th (i).bit_shift_left (a_shift)
					-- Shift back to prepare for modulo add
				d := d.bit_shift_right (bits_utilized - bits_utilized)
					-- Modulo add the carry
				put_i_th (d + c, i)
				c := c_out
				i := i + 1
			end
			if c > zero_digit then
				extend (c)
			end
		ensure
--			conforms: not is_unstable implies not is_nonconforming
			count_might_grow: count <= old count + 1
		end

	bit_shift_right (a_shift: INTEGER_32)
			-- Change Current by shifting the bits right by `a_number', carrying
			-- into the lower-order digit if required.
			-- Bits could be lost as they are shifted of the end.
		require
			shift_big_enough: a_shift >= 0
		local
			c, c_down: like digit
			d: like digit
			i: INTEGER
			n: INTEGER
		do
			c := zero_digit
			n := bits_utilized - a_shift
			from i := count
			until i < 1
			loop
					-- Determine the carry down.
				c_down := i_th (i).bit_shift_left (n).bit_shift_right (n)
				c_down := c_down.bit_shift_left (n)
					-- Shift the i-th digit.
				d := i_th (i).bit_shift_right (a_shift)
					-- Add any carry down bits.
				put_i_th (d + c, i)
				c := c_down
				i := i - 1
			end
			if count > 1 and then i_th (count) ~ zero_digit then
				go_i_th (count)
				remove
			end
		ensure
--			conforms: not is_nonconforming
			count_might_shrink: count >= old count - 1
		end

--	scalar_divide (a_digit: like digit): TUPLE [quot: like Current; rem: like digit]
--			-- Divide Current by `a_digit' giving a quotient and remainder.
--			-- Basic division of a number by one digit.
--			-- Complexity = O(n).
--		require
--			non_zero_divisor: a_digit /= zero_value
--		local
--			i: INTEGER
--			u: like Current
--			q: like Current
--			v: like digit
--			sf: like digit		-- scale factor for normalization
--			r, d: like digit
--			tup: like divide_two_digits_by_one
--		do
--			if a_digit ~ one then
--				Result := [deep_twin, zero_value]
--			else
--					-- Ensure `a_digit' is at least half the `base'
--					-- (i.e. "normalize" the numbers).
--				if a_digit < (base // two_value) then
--					sf := (base // (two_value * a_digit)) + one_value
--					u := scalar_product (sf)
--					v := a_digit * sf
--				else
--					sf := one_value
--					u := Current
--					v := a_digit
--				end
--					-- Create the Result
--				q := new_big_number (zero_value, base)
--					-- Loop through each digit of Current
--				q.set_unstable
--				from
--					r := zero_value
--					i := count
--				until i < 1
--				loop
--					d := u.i_th (i)
--					tup := divide_two_digits_by_one (r, d, v)
--					q.put_front (tup.quot)
--					r := tup.rem
--					i := i - 1
--				end
--					-- remove leading zeros
--				from
--				until q.count = 0 or q.i_th (q.count) /= zero_value
--				loop
--					q.go_i_th (q.count)
--					q.remove
--				end
--				q.normalize
--				q.set_stable
--				Result := [q, r // sf]
--			end
--			Result.quot.set_is_negative (is_negative and not (a_digit < zero_value))
--		ensure
--			same_signs_implication: (is_negative and a_digit < zero_value) or
--									(not is_negative and a_digit >= zero_value) implies
--										 not Result.quot.is_negative
--			different_signs_implication: (is_negative and a_digit < zero_value) or
--										(not is_negative and not (a_digit >= zero_value)) implies
--										 Result.quot.is_negative
----			definition: Result.quot.scalar_product (a_digit).scalar_sum (Result.rem) ~ Current
--		end

feature -- Comparison

	magnitude_max (other: like Current): like Current
			-- The number with the largest absolute value.
		require
			other_exists: other /= Void
		local
			neg, o_neg: BOOLEAN
		do
			neg := is_negative
			o_neg := other.is_negative
				-- Set Current and other to positive
			set_is_negative (false)
			other.set_is_negative (false)
			if Current >= other then
				Result := Current
			else
				Result := other
			end
				-- Restore the sign of Current and other
			set_is_negative (neg)
			other.set_is_negative (o_neg)
		end

	magnitude_min (other: like Current): like Current
			-- The number with the smallest absolute value.
		require
			other_exists: other /= Void
		local
			neg: BOOLEAN
		do
			neg := other.is_negative
			other.set_is_negative (is_negative)
			if Current <= other then
				Result := Current
			else
				Result := other
			end
			other.set_is_negative (neg)
		end

feature -- Output

	out: STRING_8
			-- Representation as a base ten number with NO coma seperators.
		local
			len: INTEGER
			n, q, r: like Current
			quot: like quotient
			ten_n: like Current	-- a multiple of 10
			s: STRING
		do
				-- temp, delete next line
--			Result := out_as_stored
			Result := ""
			len := max_ten_power.out.count - 1	-- number of zeros ?
			ten_n := new_big_number (max_ten_power)
			from n := magnitude		-- so its always positive.
			until n ~ zero
			loop
				quot := n / ten_n
				q := quot.quot
				r := quot.rem
				check
					only_one_digit_in_remainder: r.count = 1
				end
				s := r.i_th (1).out
				from
				until s.count = len
				loop
					s.prepend ("0")
				end
				Result.prepend (s)
				n := q
			end
			Result.prune_all_leading ('0')
			if Result.count = 0 then
				Result := "0"
			end
			if is_negative then
				Result.prepend ("-")
			end
		end

	out_formatted: STRING_8
			-- Representation as base ten number with coma's.
		local
			len: INTEGER
			p, q, r: like Current
			quot: like quotient
			ten_n: like Current	-- a multiple of 10
			s: STRING_8
			i, n: INTEGER_32
		do
				-- temp for debugging, can delete this section and replace with call to `out'.
			Result := ""
			len := max_ten_power.out.count - 1	-- number of zeros ?
			ten_n := new_big_number (max_ten_power)
			from p := magnitude		-- so its always positive.
			until p ~ zero
			loop
				quot := p / ten_n
				q := quot.quot
				r := quot.rem
				check
					only_one_digit_in_remainder: r.count = 1
				end
				s := r.i_th (1).out
				from
				until s.count = len
				loop
					s.prepend ("0")
				end
				Result.prepend (s)
				p := q
			end
			Result.prune_all_leading ('0')
			if Result.count = 0 then
				Result := "0"
			end
			if is_negative then
				Result.prepend ("-")
			end
			s := Result
				-- end debugging section
--			s := out
			if s.count > 3 then
				create Result.make (s.count)
				n := s.count \\ 3
				Result := Result + s.substring (1, n)
				from i := n + 1
				until i > s.count
				loop
					Result := Result + "," + s.substring (i, (i + 2).min (s.count))
					i := i + 3
				end
			else
				Result := s
			end
		end

	out_as_stored: STRING_8
			-- Output as sequence of digits seperated by comas.
		local
			i, j: INTEGER
			s: STRING
			n: INTEGER
		do
				-- Determine the length of string needed to represent
				-- the `largest_digit'.
			s := max_digit.out
			n := s.count
			create Result.make (count * n)
			if is_negative then
				Result := "-"
			end
			from i := count
			until i < 1
			loop
				s := i_th (i).out
				Result.append (s)
				if i > 1 then
					Result.append (",")
				end
				i := i - 1
			end
		end

	out_as_bits: STRING_8
			-- Output as groups of bits.
		local
			i: INTEGER
			j: like bits_utilized
			dig: like digit
			bc: INTEGER_32
			n: INTEGER
		do
			create Result.make_empty
			if is_negative then
				Result := "-"
			end
			bc := bits_utilized
			from i := count
			until i < 1
			loop
				dig := i_th (i)
				from j := 1
				until j > bc
				loop
					n := bc - j + 1		-- which bit?
					if dig.bit_test (n - 1) then		-- zero base test
						Result.append ("1")
					elseif not is_unstable and n > bits_utilized then
						Result.append ("x")
					else
						Result.append ("0")
					end
					j := j + 1
				end
				if i > 1 then
					Result.append (",")
				end
				i := i - 1
			end
		end

feature {JJ_BIG_NATURAL} -- Implementation

--	force_extend (a_digit: JJ_NATURAL)
--			-- Attempt to add `a_digit' to Current, bypassing some type checking
--		require
--			same_digit_types: a_digit.conforms_to (base)
--		deferred
--		end

--	assign_to_base (a_new_base: like base)
--			-- Assign `a_new_base' to `base'.
--			-- This is used internally in `as_base' to finish the feature.
--		require
----			base_big_enough: a_new_base >= min_base
----			base_small_enough: base <= max_base
--			valid_base: a_new_base /= 1
--		do
--			base := a_new_base
--		end

	shift_left (a_shift: INTEGER)
			-- Shift the digits to the left by putting zeros into the
			-- low-order digits.
		require
			shift_big_enough: a_shift >= 0
		local
			i: INTEGER
		do
			from i := 1
			until i > a_shift
			loop
				insert (zero_digit, 1)
				i := i + 1
			end
		end

	shift_right (a_shift: INTEGER)
			-- Shift the digits to the right by putting dropping the
			-- low-order digits.
		require
			shift_big_enough: a_shift >= 0
		local
			i: INTEGER
		do
			go_i_th (1)
			from i := 1
			until i > a_shift
			loop
				remove
				i := i + 1
			end
		end

--	conform
--			-- Ensure the digits contain no overflow, by carrying into the next
--			-- digit if required.  In other words, ensure that each digit is
--			-- less than the `base'.  For example, given the number 54 base 10
--			-- as a {JJ_BIG_NUMBER} in eight bits with `base' = 4, that
--			-- `is_nonconforming' (as could happen in feature `as_base'):
--			--                     `base' = 16 = xxx10000
--			--     `base_minus_one_value' = 15 = xxxx1111
--			--     Current before = xx110110
--			--     Current after  = xxxx0011 xxxx0001 xxxx0010
--		local
--			i: INTEGER
--			r, c: like digit
--		do
--			if is_reduced_base then
--				from i := 1
--				until i > count
--				loop
--					r := i_th (i) \\ base
--					c := i_th (i) // base
--					put_i_th (r, i)
--					if c > zero_value then
--						if i < count then
--							put_i_th (i_th (i + 1) + c, i + 1)
--						else
--							extend (c)
--						end
--					end
--					i := i + 1
--				end
--			else
--				-- Nothing to do, because Current cannot be `is_nonconforming'.
--			end
--		ensure
--			conforms: not is_nonconforming
--		end

	is_nonconforming: BOOLEAN
			-- Is Current NOT in the correct format?
			-- Yes, if there is a leading zero when `count' > 1.
		do
			Result :=  count > 1 and then i_th (count) = zero_digit
		end

	is_unstable: BOOLEAN
			-- Used internally to avoid an invariant violation when a
			-- selectively exported feature would otherwise violate
			-- the invariant (e.g. `scalar_divide' might put a leading
			-- zero into Current).

	set_stable
			-- Ensure not `is_unstable'.
		do
			is_unstable := false
		end

	set_unstable
			-- Ensure `is_unstable'.
		do
			is_unstable := true
		end

	remove_leading_zeros
			-- Remove any leading zeros resulting from a `subract_i_th'.
		do
			from
			until count = 1 or else i_th (count) > zero_digit
			loop
				go_i_th (count)
				remove
			end
		end

	combine (a_high: like Current)
			-- Extend the digits of `a_high' into Current as
			-- Current's new high-order digits.
		local
			i: INTEGER
		do
			from i := 1
			until i > a_high.count
			loop
				extend (a_high.i_th (i))
				i := i + 1
			end
		end

	partition (a_high, a_low: INTEGER): like Current
			-- Copy of the digits indexed from `a_low' up to `a_high' inclusive
			-- without any leading zero digits.
		require
			low_big_enough: a_low >= 1
			high_small_enough: a_high <= count
			low_before_high: a_low <= a_high
		local
			i: INTEGER
		do
			Result := new_big_number (zero_digit)
			Result.put_i_th (i_th (a_low), 1)
				-- Loop through the rest of the digits.
			from i := a_low + 1
			until i > a_high
			loop
				Result.extend (i_th (i))
				i := i + 1
			end
				-- Set to same sign as Current, unless `is_zero'.
			if not is_zero then
				Result.set_is_negative (is_negative)
			end
		end

feature {NONE} -- Implementation

	new_big_number (a_value: like digit): like Current
			-- Create an instance equivalent to `a_value'.
			-- Used throughout to obtain a {JJ_BIG_NUMBER} of the correct type.
		deferred
		end

	new_combined_number (a_high, a_low: like Current): like Current
			-- A new number made from two others where `a_high' contains the
			-- high-order digits and `a_low' contains the low-order digits.
		local
			i: INTEGER
		do
			Result := a_low.twin
			Result.combine (a_high)
		end

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		do
			Result := new_big_number (zero_digit)
		end

	new_value_from_character (a_character: CHARACTER_8): like digit
			-- Get the number given by `a_character'
		do
			Result := zero_digit
			inspect a_character
			when '0' then
				Result := zero_digit
			when '1' then
				Result := one_digit
			when '2' then
				Result := two_digit
			when '3' then
				Result := three_digit
			when '4' then
				Result := four_digit
			when '5' then
				Result := five_digit
			when '6' then
				Result := six_digit
			when '7' then
				Result := seven_digit
			when '8' then
				Result := eight_digit
			when '9' then
				Result := nine_digit
			when 'a', 'A' then
				Result := ten_digit
			when 'b', 'B' then
				Result := ten_digit + one_digit
			when 'c', 'C' then
				Result := ten_digit + two_digit
			when 'd', 'D' then
				Result := ten_digit + three_digit
			when 'e', 'E' then
				Result := ten_digit + four_digit
			when 'f', 'F' then
				Result := ten_digit + five_digit
			else
				check
					should_not_happen: false
						-- because of precondition
				end
			end
		end

	ten_to_the_power (a_power: like Current): like Current
			-- Memoized result of raising 10 to `a_power'.
			-- Helper function for `from_string'.
		require
			positive_exponent: not a_power.is_negative
		local
			num: detachable like Current
			ten: like Current
			p: like Current
		do
			num := power_of_ten_table.item (a_power)
			if not attached num then
				if a_power ~ zero then
					num := new_big_number (one_digit)
					power_of_ten_table.extend (num, zero)
				elseif a_power ~ one then
					if not power_of_ten_table.has (zero) then
						num := ten_to_the_power (zero)
					end
					num := new_big_number (ten_digit)
					power_of_ten_table.extend (num, one)
				else
					ten := new_big_number (ten_digit)
					num := ten_to_the_power (a_power - one) * ten
					power_of_ten_table.extend (num, a_power)
				end
			end
			check attached num as n then
				Result := n
			end
		end

	power_of_ten_table: HASH_TABLE [like Current, like Current]
			-- Table used by `from_string' to memoize the powers of ten in the
			-- same representation as Current.  It contains a value indexed by
			-- a power.
			--     [ the value,  a power]
			-- It is deferred, because Eiffel does not allow a once function
			-- to have a generic or anchored result.
		deferred
		end

	Default_table_size: INTEGER = 10
			-- The initial capacity assigned to the `power_of_ten_table'.

invariant

--	valid_base: base /= one_digit
--	is_reduced_base_implication: is_reduced_base implies base /= zero_value
--	is_zero_base_implication: base /= zero_value implies is_reduced_base

--	base_big_enough: base >= zero_value
--	base_small_enough: base <= base.max_value
	has_at_least_one_digit: count >= 1
--	no_leading_zeroes_if_stable: not is_unstable implies (count > 1 implies last >= base.one)
--	is_zero_implication: not is_unstable implies (is_zero implies count = 1)

	is_zero_implies_non_negative: is_zero implies not is_negative
	is_negative_implies_non_zero: is_negative implies not is_zero

--	all_digits_small_enough: not is_unstable implies not is_nonconforming

end
