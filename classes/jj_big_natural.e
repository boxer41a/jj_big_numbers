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
		as `zero_value', `one_value', ... `sixteen_value', and `max_digit_value'
		provide convinent ways to get values of the correct type.

		Feature `digit' is `item' renamed, and it is not exported; use `i_th'
		to obtain a particular digit.

		Digits are stored low-order to high-order.

		Internally, each `digit' is used as a register.  To prevent overflows,
		the value stored in each digit [when the invariant holds] must be less
		than `max_digit', which is defined as `max_base' - 1.  During math
		operations, a `digit' may go up to the maximum number representable in
		the number of bits in the representation, but when the invariant holds,
		a digit will have a zero in at least the high-order bit.  (This class
		reserves the high-order bit to prevent operations from overflowing the
		available bits.

		      max_base = 10000000 = 128
		     max_digit = x1111111 = 127

		By default, a {JJ_BIG_NUMBER} uses the maximum base possible to store
		digits, but the `base' may be changed by the user with `set_base'.  For
		example, a base of 100 may be more convineint than a base of 128.

		For output the number is converted on the fly to the desired base in
		feature `out_as_base' or output in base ten in `out'.
	]"
	author: "Jimmy J.Johnson"
	date: "$Date$"
	revision: "$Revision$"

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
			base := max_base
			make (10)
			extend (zero_value)
		end

	make_with_value (a_value: like digit)
			-- Initialize Current with `a_value'
		local
			r, c: like digit
		do
			default_create
			set_value (a_value)
		end

	make_with_base (a_base: like base)
			-- Initialize Current, setting the `base'
		require
			base_big_enough: a_base > base.one
			base_small_enough: a_base <= max_base
		do
			default_create
			base := a_base
		end

	make_with_value_and_base (a_value: like digit; a_base: like base)
			-- Initialize Current so it is equivalent to `a_value' and set
			-- the `base' to `a_base'
		require
			base_big_enough: a_base > base.one
			base_small_enough: a_base <= max_base
		do
			default_create
			base := a_base
			set_value (a_value)
		end

	from_string (a_string: STRING_8)
			-- Create an instance from `a_value'.
		require
			string_long_enough: a_string.count >= 1
			is_number: a_string.is_number_sequence
		do
			default_create
			set_with_string (a_string)
		ensure
			base_is_max: base = max_base
		end

	from_array (a_array: ARRAY [like digit])
			-- Create an instance from `a_array', where the array holds the
			-- intended digits (in the `max_base') with high-order digits first.
		require
			array_exists: a_array /= Void
		local
			i: INTEGER
		do
			default_create
			wipe_out
				-- Remove any leading zero's
			from i := 1
			until i > a_array.count or else a_array.item (i) /= zero_value
			loop
				i := i + 1
			end
				-- Put rest of digits into Current
			from
			until i > a_array.count
			loop
				put_front (a_array.item (i))
				i := i + 1
			end
		end

	make_random (a_count: INTEGER)
			-- Create a random number containing `a_count' digits.
		local
			i: INTEGER
		do
			io.put_string ("JJ_BIG_NATURAL.make_random:  fix me! %N")
			default_create
			from i := 1
			until i > a_count
			loop
				i := i + 1
			end
		ensure
			correct_count: count = a_count
		end


	make_from_other (a_start, a_end: INTEGER_32; other: like Current)
			-- Copy of the digits indexed from `a_start' to `a_end'.min(count)
			-- inclusive withhout any leading zeros of digits from `other'.
		require
			other_exists: other /= Void
			start_big_enough: a_start >= 1
			start_small_enough: a_start <= other.count
			end_after_start: a_end >= a_start
		local
			i, n: INTEGER_32
		do
			make_with_base (other.base)
				-- To prevent leading zeros in the result, find the location of
				-- the high-order, non-zero digit and go up to that only.
			from n := a_end.min (other.count)
			until other.i_th (n) > zero_value or n = a_start
			loop
				n := n - 1
			end
				-- Put the first digit (even if zero) in the first position.
			put_i_th (other.i_th (a_start), 1)
				-- Loop through the rest of the digits.
			from i := a_start + 1
			until i > n
			loop
				extend (other.i_th (i))
				i := i + 1
			end
				-- Set to same sign as `other', unless `is_zero'.
			if not is_zero then
				set_is_negative (other.is_negative)
			end
		end

feature -- Constants

	zero_value: like digit
			-- The number zero in the same type as `base'.
		deferred
		end

	one_value: like digit
			-- The number one in the same type as `base'.
		deferred
		end

	two_value: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	three_value: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	four_value: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	five_value: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	six_value: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	seven_value: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	eight_value: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	nine_value: like digit
			-- The number ten in the same type as `digit'.
		deferred
		end

	ten_value: like digit
			-- The number two in the same type as `digit'.
		deferred
		end

	sixteen_value: like digit
			-- The number_16 in the same type as `digit'.
		deferred
		end

	max_digit_value: like digit
			-- The largest value allowed for a `digit' of Current without
			-- making Current `is_nonconforming'.
			--   For eight-bit representation:  01111111
			--   For 16-bit representation:     01111111 11111111
			-- To obtain the absolutely largest value representable by a
			-- `digit' of Current use {like digit}.max_value.
		deferred
		ensure
			definition: Result = max_base.bit_not
			definition_2: Result = max_base - one_value
		end

	max_base: like base
			-- The maximum allowed value for `base'.
			-- It is the number represented by a one in the high-order bit.
			-- Examples:
			--    NATURAL_8  ==>  10000000 = 128
			--    NATURAL_16 ==>  10000000 00000000 = 32,768
		deferred
		ensure
			definition: Result = base.one.bit_shift_left (base.bit_count - 1)
		end

	Default_karatsuba_threshold: INTEGER = 4
			-- Default value for `karatsuba_threshold

feature -- Access

	base_minus_one_value: like digit
			-- The maximum value allowed for a `digit'.
			-- In base ten, this is a 9; in base 2, this is a 1.
			-- This is always base - 1 for invariant, but the value in a
			-- "digit" may exceed this value during internal computations.
		do
				Result := base - one_value
		ensure
			definition: Result = base - one_value
		end

	base: like digit
			-- The number of unique values for each `digit'; the radix.

	frozen min_base: like base
			-- The minimum allowed for the `base' (i.e. two)
		do
			Result := two_value
		end

--	max_digit_for_multiplication: like digit
--			-- The maximum value that can be used for multiplying a digit in place
--			-- The binary will be all 1's except for the high-order bit reserved
--			-- for carries.
--		do
--			Result := max_base
--			Result := Result.bit_not
--		end

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
			Result := karatsuba_threshold_imp
		ensure
			result_big_enough: Result >= 2
		end

	frozen hash_code: INTEGER
			-- Hash value computed from the string representation of Current.
		do
			Result := out_as_stored.hash_code
		end

feature -- Element change

	set_value (a_value: like digit)
			-- Make Current equivalent to `a_value'.
		local
			r, c: like digit
		do
			wipe_out
			r := a_value \\ base
			extend (r)
			from c := a_value // base
			until c = 0
			loop
				r := c \\ base
				extend (r)
				c := c // base
			end
		end

	set_with_string (a_string: STRING_8)
			-- Make current equivalent to the base-ten value represented
			-- by `a_string'.
		require
			string_long_enough: a_string.count >= 1
			is_number: a_string.is_number_sequence
		local
			old_base: like base
			i:INTEGER
			s: STRING_8
			c: CHARACTER_8
			n: like digit		-- one digit of `a_string'
			bn: like Current	-- `n' converted to BIG_NUMBER
			e: like Current		-- Exponent for the place value calculation
			l_one: like Current
			ten: like Current
		do
				-- Save the `base; calculate in `max_base' and restore at end.
			old_base := base
			default_create
				-- Assume the string is a decimal number.
				-- Step through the string converting each digit to a
				-- JJ_NATURAL of the same type as `base'.
				-- Use a BIG_NUMBER so we can `raise' and `scalar_multiply'.
			e := new_big_number (zero_value, base)	-- The exponent starts at 0.
			bn := new_big_number (zero_value, base)
			l_one := new_big_number (one_value, base)
			ten := new_big_number (ten_value, base)
			from i := a_string.count
			until i < 1
			loop
				s := a_string.substring (i, i).as_string_8
				c := a_string.item (i)
				if s ~ "+" then
					do_nothing
				elseif s ~ "-" then
					negate
				elseif s ~ "0" then
					do_nothing
				else
					check
						is_number: s.is_number_sequence
							-- because of precondition "is_number"
					end
						-- Use `from_hex_string' because digits 0..9 are okay;
						-- we are assuming the string is decimal.
					n := new_value_from_character (c)
					bn.set_value (n)
					bn.multiply (ten_to_the_power (e))
					add (bn)
				end
				e := e + l_one
				i := i - 1
			end
			if old_base > zero_value and base /= old_base then
				set_base (old_base)
			end
		ensure
			base_unchanged: base = old base
		end

	set_base (a_new_base: like base)
			-- Convert Current to `a_new_base'.  That is, set Current to store
			-- each `digit' as if the number was in `a_new_base'.
		require
			base_big_enough: a_new_base >= min_base
			base_small_enough: base <= max_base
		do
			if base /= a_new_base then
				copy (as_base (a_new_base))
			end
		end

	set_value_and_base (a_value: like digit; a_base: like base)
			-- Change the `base' and the `value' without calling `set_base',
			-- thus avoiding the copy required in `set_base'.
		require
			base_big_enough: a_base >= min_base
			base_small_enough: base <= max_base
		local
			r, c: like digit
		do
				-- Set the `base'
			wipe_out
			base := a_base
				-- Set the `value'
			extend (zero_value)
			r := a_value \\ base
			put_i_th (r, 1)
			from c := a_value // base
			until c = 0
			loop
				r := c \\ base
				extend (r)
				c := c // base
			end
		end

	set_karatsuba_threshold (a_value: INTEGER)
			-- Change the `karatsub_threshold', the number of digits at which
			-- *all* multiplications of a {BIG_NUMBER} use the Karatsuba
			-- algorithm instead of a basic, grade-school method.
		require
			value_big_enough: a_value >= 1
		do
			karatsuba_threshold_imp.set_item (a_value)
		end

	set_from_other (a_other: JJ_BIG_NATURAL [JJ_NATURAL])
			-- Make Current equivalent to `a_other'.
		local
			bn: like a_other
			other_d: JJ_NATURAL
			n8: NATURAL_8
			i: INTEGER
		do
			wipe_out
			if a_other.same_type (Current) and a_other.base = base then
				bn := a_other
			else
				bn := a_other.deep_twin
			end
				-- Synchronize the bases;  `set_base' is no-cost if base
				-- is not changing.
--			if multiplication_bit_count <= bn.multiplication_bit_count then
--				bn.set_base (base)
--			else
--				set_base (max_base)
--				bn.set_base (max_base)
--			end
--			check
--				same_bit_counts: internal_bit_count = bn.internal_bit_count
--					-- Because they have same base
--			end
				-- Now copy each `digit' of `a_other' to Current.  There is no
				-- information lose when a digit of other is added to Current,
				-- because the code above ensures the two numbers, Current and
				-- `a_other', use the same bit counts.
			from i := 1
			until i > bn.count
			loop
				other_d := base.as_same_type (bn.i_th (i))
				force_extend (other_d)
				i := i + 1
			end
		end

feature -- Conversion

	to_base (a_base: like base)
			-- Change `base' to `a_base', changing the internal representation
			-- of Current so that each `digit' represents a power of the base
			-- times its position in Current.
		require
			base_small_enough: base <= max_base
		do
			copy (as_base (a_base))
		end

	as_base (a_new_base: like base): like Current
			-- New object equivalent to Current but converted to `a_new_base'.
			-- See "A Recursive Radix Conversion Formula and Its Application
			-- to Multiplication and Division", H. Asai, Lockheed Electronics
			-- Company, 1976, theorem 2 and equations 2.17, 2.18, and 2.19.
		require
			base_small_enough: base <= max_base
		local
			d: like Current	-- the present radix
			b: like Current	-- the target radix
			p: like Current
			s, r: like Current
			t: like Current	-- the accumulated result
			i: INTEGER
			eta_hat: like digit	-- the i_th digit
		do
			if base = a_new_base then
				Result := deep_twin
			else
-- ?				-- "Calculations must be done in the new radix."  This
					-- means that the arithmatic is modulo `a_new_base', so we
					-- discard any digits that "overflow".
--print ("%N")
--print (generating_type + "  " + out_as_stored + " base " + base.out +
--					"  as_base (" + a_new_base.out + ") %N")
				d := new_big_number (base, a_new_base)
				b := new_big_number (a_new_base, a_new_base)
				p := d - b
				s := new_big_number (i_th (count), a_new_base)
				r := new_big_number (zero_value, a_new_base)
					-- t_zero = s
				t := new_big_number (i_th (count), a_new_base)
--print ("  initialize: %N")
--print ("     d = " + d.out_as_bits + "%T%T" + d.out_as_stored + "%N")
--print ("     b = " + b.out_as_bits + "%T%T" + b.out_as_stored + "%N")
--print ("     p = " + p.out_as_bits + "%T%T" + p.out_as_stored + "%N")
--print ("     s = " + s.out_as_bits + "%T%T" + s.out_as_stored + "%N")
--print ("     r = " + r.out_as_bits + "%T%T" + r.out_as_stored + "%N")
--print ("     t = " + t.out_as_bits + "%T%T" + t.out_as_stored + "%N")
				from i := count - 1
				until i < 1
				loop
--print ("  i = " + i.out + ": %N")
					eta_hat := i_th (i)
--print ("   eta = " + eta_hat.out + "%N")
						--  s[i] := s[i-1]P + n[i]
					s := s * p
--print ("     s = s * p = " + s.out_as_bits + "%T%T" + s.out_as_stored + "%N")
					s.scalar_add (eta_hat)
--print ("     s.add (eta) = " + s.out_as_bits + "%T%T" + s.out_as_stored + "%N")
						-- r[i] := t[i-1] + r[i-1]P
					r := r * p
--print ("     r = r * p = " + r.out_as_bits + "%T%T" + r.out_as_stored + "%N")
					r.add (t)
--print ("     r.add (t) = " + r.out_as_bits + "%T%T" + r.out_as_stored + "%N")
						-- t[i] := r[i]B + s[i]
					t := r * b
--print ("     t = r * b = " + t.out_as_bits + "%T%T" + t.out_as_stored + "%N")
					t.add (s)
--print ("     t.add (s) = " + t.out_as_bits + "%T%T" + t.out_as_stored + "%N")
					i := i - 1
				end
				Result := t
				Result.set_is_negative (is_negative)
				Result.assign_to_base (a_new_base)
				Result.conform
			end
--			Result := Current
		end

feature -- Status setting

	set_is_negative (a_sign: BOOLEAN)
			-- Set `is_negative' to `a_sign' if Current /~ `zero'.
		do
			if not is_zero then
				is_negative := a_sign
			else
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
			-- Is Current equivalent to `one'?
		do
			Result := count = 1 and then i_th (1) = 1
		end

	is_base: BOOLEAN
			-- Is Current equal to the value of the `base'?
		do
			Result := count = 2 and then (i_th (1) = 0 and i_th (2) = 1)
		end

	is_negative: BOOLEAN
			-- Is Current a negative number?

	is_same_sign (other: like Current): BOOLEAN
			-- Does Current have the same sign as `other'?
		do
			Result := (is_zero or other.is_zero) or
						(is_negative = other.is_negative)
		end

	divisible (other: like Current): BOOLEAN
			-- May current object be divided by `other'?
		do
			Result := other ~ zero
		end

	exponentiable (other: NUMERIC): BOOLEAN
			-- May current object be elevated to the power `other'?
			-- Must be defined, because it comes deferred from {NUMERIC}.
		obsolete
			"[2008_04_01] Will be removed since not used."
		do
		end

feature -- Basic operations

	scalar_add (a_value: like digit)
			-- Change Current by adding `a_value' to Current.
			-- By definition `a_value' will be no larger than the value
			-- representable by the type of a `digit'.
		local
			n: like Current
		do
			n := new_big_number (a_value, base)
			add (n)
		end

	scalar_sum (a_value: like digit): like Current
			-- The result of adding `a_digit' to Current.
			-- Do not change Current.
		do
			Result := deep_twin
			Result.scalar_add (a_value)
		end

	scalar_multiply (a_value: like digit)
			-- Multipy Current by `a_value'.
		require
			value_small_enough: a_value <= base_minus_one_value
		local
			i: INTEGER
			c: like digit
			tup: like digits_multiplied
			t, t2: like digit
		do
			if is_zero then
				do_nothing
			elseif a_value = zero_value then
				wipe_out
				extend (zero_value)
				is_negative := false
			else
				c := zero_value
				from i := 1
				until i > count
				loop
--					io.put_string ("    " + generating_type + ".scalar_multiply:  i = " + i.out + "  ")
--					io.put_string ("c = " + c.out + "   ")
					tup := digits_multiplied (i_th (i), a_value)
					t := tup.low + c
					put_i_th (t \\ base, i)
					c := tup.high + (t // base)
					i := i + 1
				end
				from
				until c = zero_value
				loop
					extend (c \\ base)
					c := c // base
				end
				if (is_negative and a_value >= zero_value) or
						(not is_negative and a_value < zero_value) then
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
			value_small_enough: a_value <= base.max_value
		do
			Result := twin
			Result.scalar_multiply (a_value)
		end

	add (other: like Current)
			-- Change Current by adding other to Current.
		require
			other_exists: other /= Void
		local
			subtrahend, minuend: detachable like Current
			is_neg_o, sign_max: BOOLEAN
		do
				-- Save the sign of `other' for restoration at end
			is_neg_o := other.is_negative
				-- Do the addition
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
				Result := new_big_number (zero_value, base)
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
			Result := new_big_number (zero_value, base)
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
			i, n: INTEGER
			c: INTEGER
			bn: like Current

		do
			Result := new_big_number (zero_value, base)
			if count < other.count then
				lit := Current
				big := other
			else
				lit := other
				big := Current
			end
			n := lit.count
			from i := 1
			until i > big.count
			loop
				bn := new_sub_number (i, i + n - 1, big)
				p := bn * lit
				if not p.is_zero then
					p.shift_left (n * c)
				end
				Result := Result + p
				i := i + n
				c := c + 1
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
			a := new_sub_number (n + 1, count, Current)
			b := new_sub_number (1, n, Current)
				-- High and low order digits of other
			c := new_sub_number (n + 1, other.count, other)
			d := new_sub_number (1, n, other)
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

	negate
			-- Reverse the sign of Current.
		do
			if not is_zero then
				is_negative := not is_negative
			end
		ensure
			sign_toggled: not is_zero implies is_negative = not (old is_negative)
		end

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

	integer_quotient alias "//" (other: like Current): like Current
			-- Division by `other'.
			-- Does not change Current.
			-- See "Multiple-Length Division Revisited - A Tour of the
			-- Minefield" by Per Brinch Hanser, pp 12 - 18.
		local
			num: like Current		-- dividend
			denom: like Current		-- divisor ?
			high, low: like digit
		do
			io.put_string ("JJ_BIG_NATURAL.integer_quotient:  fix me %N")
			Result := Current	-- fix me
--			if other.count = 1 then
--				Result := scalar_divide (other.i_th (1)).quot
--			elseif other.count > count then
--				Result := zero
--			else

--			end
--			from num := deep_twin
--			until num < other
--			loop

--			end


--			Result := new_big_number (zero_value, base)
--				-- Set the sign
--			if is_same_sign (other) then
--				Result.set_is_negative (false)
--			else
--				Result.set_is_negative (true)
--			end
		ensure then
--			definition:
		end

	integer_remainder alias "\\" (other: like Current): like Current
			-- Remainder of the integer division of Current by `other'.
			-- Does not change Current.
		do
			io.put_string ("JJ_BIG_NATURAL.integer_remainder:  fix me %N")
			Result := new_big_number (zero_value, base)
				-- fix me
		end

feature  -- Division

	condition_for_x_by_one_division (a_other: like Current)
			-- Modify, if required, both Current and `a_other' so that a
			-- left-to-right division using `two_by_one_divide'.  This feature
			-- ensures `a_other' has a power-of-two number of digits, padding
			-- it with leading zeroes if reqired.  Current is also padded with
			-- zeros so that it has a number of digits that is a multiple of
			-- the number of digits now in `a_other'.
			-- See Burnikel & Zieler, "Fast Recursive Division", pp 9-10.
		require
			is_marked_unstable: is_unstable
			other_is_marked_unstable: a_other.is_unstable
		local
			n: INTEGER		-- number of digits required in `a_other'
			blks: INTEGER	-- number of blocks of size `n' required in Current
			t: INTEGER		-- number of digits required in Current
			s: INTEGER		-- number of left shifts after normalization
		do
				-- Pad `a_other', if required, until it has 2^k digits.
			from n := log_2 (a_other.count).ceiling
			until a_other.count = n
			loop
				a_other.extend (zero_value)
			end
			check
				correct_count: a_other.count = n
					-- Becuase we don't want too many or too few digits.
			end
				-- Pad Current, if required, until it has a digit `count'
				-- equal to a multiple of `a_other'.
			blks := count // n + 1
			from t := blks * n
			until count = t
			loop
				extend (zero_value)
			end
			check
				correct_count: count = t
					-- Becuase we don't want too many or too few digits.
			end
				-- Normalize `a_other' and shift Current accordingly.
			s := a_other.normalize
			bit_shift_left (s)
		ensure
			is_conditioned:
		end

	quotient (a_other: like Current): TUPLE [quot, rem: like Current]
			-- The quotient and remainder resulting from dividing Current
			-- by `a_other' without changing Current.
		require
			divisor_non_zero: a_other /~ zero
		local

		do
			if Current ~ zero then
				Result := [zero, zero]
			elseif a_other ~ one then
				Result := [Current.twin, zero]
			elseif count < a_other.count then
				Result := [zero, a_other.twin]
			else
				if a_other.count \\ 2 = 0 and count // 2 = a_other.count then
					Result := two_by_one_divide (a_other)
				else
					a_other.set_unstable
					set_unstable
					condition_for_x_by_one_division (a_other)
					Result := x_by_one_divide (a_other)
				end
			end
			a_other.remove_leading_zeros
				-- Current should not be `is_nonconforming' now.
			check
				conforms: not is_nonconforming
			end
			set_stable
			a_other.set_stable
		end

	divide (a_other: like Current): like Current
			-- Modify Current to contain the integer quotient between Current
			-- and `a_other' and return the remainder.
		require
			divisor_not_zero: a_other /~ zero
		local
--			q, r: like Current
			t: like quotient
		do
--			q := twin
--			r := q.divide (a_other)
--			Result := [q, r]
			t := quotient (a_other)
			copy (t.quot)
			Result := t.rem
		end

	two_by_one_divide (a_other: like Current): TUPLE [quot, rem: like Current]
			-- The result of dividing Current by `a_other' when Current
			-- has exactly two times the number of digits as `a_other'.
		do
			Result := Current
		end

	x_by_one_divide (a_other: like Current): TUPLE [quot, rem: like Current]
			-- The result of dividing Current by `a_other' when Current
			-- has x number of blocks of digits, where each block has the
			-- number digits in `a_other'.
		do
			Result := Current
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

--	as_binary (a_digit: like digit): STRING_8
--			-- Show the binary representation of `a_digit'
--		local
--			i: INTEGER
--		do
--			create Result.make_empty
--			from i := base.bit_count - 1
--			until i < 0
--			loop
--				if (a_digit.bit_shift_right (i)).bit_and (one_value) = one_value then
--					Result.append ("1")
--				else
--					Result.append ("0")
--				end
--				i := i - 1
--			end
--		end


	divide_two_digits_by_one (a_dividend, a_divisor: like Current):
							TUPLE [quot: like Current; rem: like Current]
			-- Divide a two-digit number `a_dividend' by a single-digit number
			-- `a_divisor', returning a quotient and remainder.
			-- Since `a_divisor' `is_normalized' we must assume that `a_dividend'
			-- has been shifted accordingly with the normalization of `a_divisor'.
			-- (There is no way to check/proove this assumption.)
			-- See "Fast Recursive Division" by Burnikel and Ziegler, p 3.
			-- Unlike most division operations on a divide by zero, this feature
			-- upholds Knuth's demand that a \\ 0 = a, providing the useful
			-- property that (a // b) * b + (a \\ b) = a.
			-- (See Knuth: The Art of Computer Programming, Volumn 2".)
		require
--			divisor_non_zero: a_divisor /= zero_value
			dividend_has_two_digits: a_dividend.count = 2
			divisor_is_normalized: a_divisor.is_normalized
		local
			c: like digit
			tup: TUPLE [a3, a4: like digit]
			tup_b: TUPLE [b1, b2: like digit]

			qr: TUPLE [q1, R: like digit]
			qs: TUPLE [q2, S: like digit]
			r: TUPLE [r1, r2: like digit]
			f: like digit
			quot, rem: like Current
		do
			tup := as_half_digits (a_dividend.i_th (1))
			qr := div_three_halves_by_two (a_dividend.i_th (2), tup.a3, a_divisor.i_th (1))
			r := as_half_digits (qr.R)
			qs := div_three_halves_by_two (qr.R, tup.a4, a_divisor.i_th (1))
			f := as_full_digit (qr.q1, qs.q2)
			quot := new_big_number (f, base)
			rem := new_big_number (qs.s, base)
			Result := [quot, rem]
		end

	div_three_halves_by_two (A, a3, B: like digit): TUPLE [quot, rem: like digit]
			-- Divide three half-digits, "a1" and "a2" (contained in `A') and
			-- `a3' by two half-digits, "b1" and "b2" (contained in `B'), in
			-- such a way that the computations fit into the representation
			-- (i.e. the number of bits) of a digit.
			-- See "Fast Recursive Division" by Burnikel and Ziegler, p 3.
		local
			tup: TUPLE [b1, b2: like digit]
			q, c, d, r: like digit
			t: like digit
		do
			tup := as_half_digits (B)
			q := A // tup.b1
			c := A - q * tup.b1
			d := q * tup.b2
				-- Digits can never be negative, so in order to perform the test
				-- "if (R < 0)" on lines 10 and 13 of Burnikel's algoritm page 3,
				-- we use temporary, `t', which is [c, a3], and check it against
				-- `d'.  Instead of subtracting d from R, which would not work,
				-- we subtract `d' from `t' only after adding `b' to it (once or
				-- twice), which prevents integer underflow.
			t := as_full_digit (c, a3)
			if t < d then				-- Same as "if (R < 0)".
				q := q - one_value
				t := t + b
				if t < d then			-- Same as "if (R + B < 0)".
					q := q - one_value
					t := t + b
				end
			end
			r := t - d					-- Now R is correct.
			Result := [q, r]
		end

	as_half_digits (a_digit: like digit): TUPLE [high, low: like digit]
			-- Split `a_digit' into two half-digits.
			-- See "Fast Recursive Division" by Burnikel and Ziegler, p 3.
		local
			h: INTEGER
		do
			h := a_digit.bit_count // 2
			Result := [a_digit.bit_shift_right (h),
						a_digit.bit_shift_left (h).bit_shift_right (h)]
		end

	as_full_digit (a_high, a_low: like digit): like digit
			-- Combine `a_high' half and `a_low' half into a single digit
		do
			Result := a_high.bit_shift_left (base.bit_count // 2) + a_low
		end

--	digits_divided (a_digit, a_other: like digit): TUPLE [high, low: like digit]
--			-- Divide a_digit by other giving a quotient and remainder
--		require
--			divisor_not_zero: a_other /= zero_value
--		do
--			Result := [a_digit // a_other, a_digit \\ a_other]
--		end

--	two_by_one_divided (a_high, a_low, a_other: like digit): TUPLE [quot, rem: like digit]
--			-- Divide the "number" represented by the two digits, `a_high' & `a_low'
--			-- by `a_other' digit.
--		require
--			divisor_not_zero: not a_other /= zero_value
--		local

--		do
--			if a_divisor >= a_high then
--				Result := digits_divided (a_high + a_low, a_other)
--			else
--				tup := digits_divided (a_high, a_other)
--				h := tup.quot
--				p := h * a_other
--				d := a_high - p
--				s := (d * max_base) + a_low
--				tup := digits_divided (s, a_other)
--				Result := [h + tup.high, tup.rem]
--			end
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
					-- Ensure we have same bases to compare
				if other.base /= base then
					temp := other.as_base (base)
				else
					temp := other
				end
				if is_zero and temp.is_zero then
					Result := false
				elseif count < temp.count then
					Result := True
				elseif count > temp.count then
					Result := False
				else
					check
						same_counts: count = temp.count
							-- because of if statements above
					end
					check
						same_bases: base = temp.base
							-- Because of above
					end
						-- Start with most significant digit
					from i := count
					until i < 1 or i_th (i) > temp.i_th (i) or Result
					loop
						Result := i_th (i) < temp.i_th (i)
						i := i - 1
					end
				end
			end
		end

feature -- Output

	show
			-- Display the number in bits and in its base.
		do
			io.put_string ("base = " + base.out + "%N")
			io.put_string ("max_base = " + max_base.out + "%N")
--			io.put_string ("internal_bit_count = " + internal_bit_count.out + "%N")
			io.put_string ("Bits_required_for_base = " + bits_used_for_digit.out + "%N")
			io.put_string ("Largest_digit = " + base_minus_one_value.out + "%N")
			io.put_string (count.out + " digits")
			io.put_string ("%T" + out_as_bits)
			io.put_string (" %T" + out + " base '" + base.out + "'")
			io.new_line
		end

	out: STRING_8
			-- Representation as a base ten number with no coma seperators.
		local
			temp: like Current
			s: STRING_8
			i: INTEGER_32
		do
			temp := as_base (ten_value)
			Result := ""
			from
				i := 1
			until i > temp.count
			loop
				s := temp.i_th (i).out
				Result.prepend (s)
				i := i + 1
			end
			if is_negative then
				Result.prepend ("-")
			end
		end

	out_formatted: STRING_8
			-- Representation as base ten number with coma's.
		local
			temp: like Current
			n: INTEGER_32
			s: STRING_8
			i: INTEGER_32
		do
			temp := as_base (ten_value)
			Result := ""
			from
				i := 1
				n := 0
			until i > temp.count
			loop
				s := temp.i_th (i).out
				Result.prepend (s)
				n := n + 1
				if i /= temp.count and temp.count > 3 and n = 3 then
					Result.prepend (",")
					n := 0
				end
				i := i + 1
			end
			if is_negative then
				Result.prepend ("-")
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
			s := base_minus_one_value.out
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
			j: like bits_used_for_digit
			dig: like digit
			bc: INTEGER_32
			n: INTEGER
		do
			create Result.make_empty
			if is_negative then
				Result := "-"
			end
			bc := base.bit_count
			from i := count
			until i < 1
			loop
				dig := i_th (i)
				from j := 1
				until j > bc
				loop
					n := bc - j + 1		-- which bit?
					if not is_unstable and n > bits_used_for_digit then
						Result.append ("x")
					else
						if dig.bit_test (n - 1) then		-- zero base test
							Result.append ("1")
						else
							Result.append ("0")
						end
					end
					j := j + 1
				end
				if i > 1 then
					Result.append (",")
				end
				i := i - 1
			end
		end


feature -- {JJ_BIG_NATURAL} -- Implementation (to {JJ_BIG_NUMBER}

	force_extend (a_digit: JJ_NATURAL)
			-- Attempt to add `a_digit' to Current, bypassing some type checking
		require
			same_digit_types: a_digit.conforms_to (base)
		deferred
		end

	assign_to_base (a_new_base: like base)
			-- Assign `a_new_base' to `base'.
			-- This is used internally in `as_base' to finish the feature.
		require
			base_big_enough: a_new_base >= min_base
			base_small_enough: base <= max_base
		do
			base := a_new_base
		end

	shift_left (a_shift: INTEGER)
			-- Shift the digits to the left by putting zeros into the
			-- low-order digits
		require
			shift_big_enough: a_shift >= 0
		local
			i: INTEGER
		do
			from i := 1
			until i > a_shift
			loop
				insert (zero_value, 1)
				i := i + 1
			end
		end

	bit_shift_left (a_shift: INTEGER_32)
			-- Change Current by shifting the bits left by `a_number', carrying
			-- into the next digit if required.  Current must be marked as
			-- `is_unstable' by the caller to demonstrate that the caller
			-- recognizes that this feature might violate the invariant if the
			-- shift happens to make a digit greater than the `max_digit'.
		require
			is_unstable: is_unstable
--			conforms: not is_nonconforming
			shift_big_enough: a_shift >= 0
			shift_small_enough: a_shift <= base.bit_count - 1
		local
			c, c_out: like digit
			d: like digit
			i: INTEGER
		do
--			c := i_th (1).bit_shift_right (base.bit_count - a_shift)
--			put_i_th (i_th (1).bit_shift_left (a_shift)
			c := zero_value
			from i := 1
			until i > count
			loop
					-- Determine the carry out
				c_out := i_th (i).bit_shift_right (base.bit_count - a_shift)
					-- Shift and then modulo add
				put_i_th (i_th (i).bit_shift_left (a_shift) + c, i)
				c := c_out
				i := i + 1
			end
			if c > zero_value then
				extend (c)
			end

--			from i := 2
--			until c = zero_value
--			loop
--				if i > count then
--					extend (c)
--					c := zero_value
--				else
--					d := i_th (i)
--					if d <= d.max_value - c then
--							-- No overflow will occur, so just add.
--						c := zero_value
--					else
--							-- The add will overflow, but by no more than one.
--						c := one_value
--					end
--					d := d + c
--					put_i_th (d, i)
--				end
--				i := i + 1
--			end
		ensure
--			conforms: not is_nonconforming
			correct_count: count <= old count + 1
		end

	simple_add (other: like Current)
			-- Change Current by adding `other' to it.
			-- Used internally for `add' and `subtract'.
		require
			other_exists: other /= Void
			same_sign: is_same_sign (other)
		local
			i: like count
			d: like digit
			c: like digit
		do
			c := zero_value
			d := zero_value
			if is_zero then
				copy (other)
			elseif not other.is_zero then
					-- Add each paired `digit'
				from i := 1
				until i > count or i > other.count
				loop
					d := i_th (i) + other.i_th (i) + c
					c := d // base
					d := d \\ base
					check
						item_small_enough: d <= base_minus_one_value
					end
					put_i_th (d, i)
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
						d := other.i_th (i) + c
						c := d // base
						extend (d \\ base)
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
						d := i_th (i) + c
						c := d // base
						put_i_th (d \\ base, i)
						i := i + 1
					end
				end
					-- If still have a carry (overflow), add a digit
				if c > zero_value then
					extend (d.one)
				end
			end
		end

	simple_subtract (other: like Current)
			-- Change Current by subtracting `other' from Current.
		require
--			other_non_zero: not other.is_zero
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

	conform
			-- Ensure the digits contain no overflow, by carrying into the next
			-- digit if required.  In other words, ensure that each digit is
			-- less than the `base'.  For example, given the number 54 base 10
			-- as a {JJ_BIG_NUMBER} in eight bits with `base' = 4, that
			-- `is_nonconforming' (as could happen in feature `as_base'):
			--                     `base' = 16 = xxx10000
			--     `base_minus_one_value' = 15 = xxxx1111
			--     Current before = xx110110
			--     Current after  = xxxx0011 xxxx0001 xxxx0010
		local
			i: INTEGER
			r, c: like digit
		do
			from i := 1
			until i > count
			loop
				r := i_th (i) \\ base
				c := i_th (i) // base
				put_i_th (r, i)
				if c > zero_value then
					if i < count then
						put_i_th (i_th (i + 1) + c, i + 1)
					else
						extend (c)
					end
				end
				i := i + 1
			end
		ensure
			conforms: not is_nonconforming
		end

	is_nonconforming: BOOLEAN
			-- Is Current NOT in the correct format?
			-- Yes, if any digit is greater than the `base' or if there is a
			-- leading zero when `count' > 1.
		local
			i: INTEGER
		do
			Result :=  count > 1 and then i_th (count) = zero_value
			from i := 1
			until i > count or Result
			loop
				Result :=  i_th (i) >= base
				i := i + 1
			end
		end

	normalize: INTEGER
			-- Ensure Current `is_normalized', possibly shifting the bits of
			-- each digit in Current until the most high-order digit is greater
			-- or equal to the `base' // 2.  (See Knuth: The Art of Computer
			-- Programming, Volumn 2", pp 257-258.)  Also return the number of
			-- shifts required to do so.
		require
			is_unstable: is_unstable
		local
			n: INTEGER
		do
			Result := bits_used_for_digit - i_th (count).most_significant_bit
			bit_shift_left (Result)
		ensure
			is_normalized: is_normalized
			is_nonconforming: not is_nonconforming
		end

	is_normalized: BOOLEAN
			-- Is the most high-order digit greater than or equal to `base'//2?
			-- (See Knuth: The Art of Computer Programming, Volumn 2".)
		do
			Result := i_th (count) >= base // two_value
		ensure
			definition: Result implies i_th (count) >= base // two_value
			is_nonconforming: Result implies is_nonconforming
		end

	is_unstable: BOOLEAN
			-- Used internally to avoid an invariant violation when a
			-- selectively exported feature would otherwise violate
			-- the invariant (e.g. `scalar_divide' might put a leading
			-- zero into Current) or a digit might temporarily become
			-- greater than the `max_digit'.

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
			until count = 1 or else i_th (count) > zero_value
			loop
				go_i_th (count)
				remove
			end
		end

feature {NONE} -- Implementation (subtraction)

	can_borrow (a_index: INTEGER): BOOLEAN
			-- Is it possible to borrow from `a_index'th digit?
			-- In other words, can we subtract one place-value amount from
			-- Current at `a_index' and add that amount to the lower-order
			-- digit without overflowing the representation of a digit?
		local
			i: INTEGER
		do
				-- Check the index in range and then we know we can borrow if
				-- there is a higher-order digit at least.
			Result := (a_index > 1 and a_index <= count)
				-- Can the next lower-order digit accept a borrowed value?
				-- Yes, if the value + base < base.max_value, because we can
				-- add a base.
			Result := Result and base.max_value - base > i_th (a_index - 1)
				-- Ignore any leading zeros.
			if Result then
				from i := count
				until i_th (i) >= one_value or i < a_index
				loop
					i := i - 1
				end
				Result := i >= a_index
			end
		end

	borrow (a_index: INTEGER)
			-- Modify current by borrowing from the `a_index'-th digit and
			-- increasing the next lower-order digit by the `base' amount.
		require
			is_unstable: is_unstable
			index_large_enough: a_index > 1
			index_small_enough: a_index <= count
			can_borrow: can_borrow (a_index)
		local
			i: INTEGER
		do
			check
				lower_digit_can_increase: base.max_value - base > i_th (a_index - 1)
					-- because of precondition "can_borrow".
			end
			put_i_th (i_th (a_index - 1) + base, a_index - 1)
			from i := a_index
			until i_th (i) > zero_value
			loop
				check
					eventually_find_a_borrow: i < count
						-- because of precondition "can_borrow".
				end
				put_i_th (base - base.one, i)
				i := i + 1
			end
			put_i_th (i_th (i) - base.one, i)
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
				-- will make the borrowing digit greater than the base,
				-- otherwise violating the invariant.
			set_unstable
			if i_th (a_index) < a_value then
				borrow (a_index + 1)
			end
			check
				is_larger: i_th (a_index) >= a_value
					-- because of if statement and `borrow'
			end
			d := i_th (a_index) - a_value
			put_i_th (d, a_index)
			if a_index = count and d = 0 then
				remove_leading_zeros
			end
			set_stable
		end

feature {NONE} -- Implementation (multiplication)

	digits_multiplied (a_digit, a_other: like digit): TUPLE [high: like digit; low: like digit]
			-- Multiply two "digits", giving the result as two digits of the
			-- same size as `digit'; the sum is in `value' and the overflow is
			-- in `carry'.
			-- This decomposition feature is used by `scalar_multiply'.
		require
			digit_small_enough: a_digit <= max_digit_value
			other_small_enough: a_other <= max_digit_value
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
			--       replace a {NATURAL_8} with a {NATURAL_16})  This idean was
			--       rejected because there is nothing to which to cast a
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
			--       This approach was rejected because it is not clear how to
			--       handle the middle term in relation to both the first and
			--       third term.
			--
			--   3)  Multiply the digits in place, keeping the result as the
			--      `value' and temporarily accepting the lose of any overflow.
			--      Then calculate the lost overflow using an algorithm from
			--      http://stackoverflow.com/questions/28868367/getting-the-
			--      high-part-of-64-bit-integer-multiplication, storing that
			--      overflow in the `carry'.
			--
			--       This approach works for any size representation, because
			--       it always shifts right [into a smaller representation].
			--
				-- Calculate the low-order half of the Result.
				-- Any overflow is discarded.
			low := a_digit * a_other
				-- Now calculate the high-order half of the Result.
				-- Find the shift amount
			h := base.bit_count // 2
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
			high := ac + ad.bit_shift_right (h) + bc.bit_shift_right (h) + car
				-- At this point we have a binary number split into high and
				-- low bits.  Now must get the two values into the correct
				-- base (i.e. the `max_base').  By experiment, I determined:
				--    1) shift the high bits to the left by one
				--    2) add a carry bit (if there is one) from the low bits
				-- This result should still fit in the tuple, because the value
				-- of the arguments are garanteed by the invariant to not have
				-- a one in the high bit, so, before the shift, `high' will
				-- start with two zeros and can't overflow.
--			print (generating_type + ".digits_multiplied (")
--			print (a_digit.out + ", " + a_other.out + ") = %T")
--			print ("[" + high.out + "," + low.out + "] %T")
			high := high.bit_shift_left (1)
			high := high + (low // base)
			low := low \\ base
--			print ("  shifted to  ")
--			print ("[" + high.out + "," + low.out + "] %N")
			Result := [high, low]
		ensure
			value_small_enough: Result.high <= base_minus_one_value
			carry_small_enough: Result.low <= base_minus_one_value
		end

	karatsuba_threshold_imp: INTEGER_32_REF
			-- Implementation of the `karatsuba_threshold, the value above
			-- which multiplication operations use `karatsuba_product'.
		once
			create Result
			Result.set_item (Default_karatsuba_threshold)
		end

feature {NONE} -- Implementation

	new_big_number (a_value: like digit; a_base: like base): like Current
			-- Create an instance containing `a_value' in `a_base'.
			-- Used throughout to obtain a {JJ_BIG_NUMBER} of the correct type.
		deferred
		end

	new_sub_number (a_start, a_end: INTEGER; other: like Current): like Current
			-- Copy of the digits indexed from `a_start' and `a_end'.min(count)
			-- inclusive without any leading zero digits from `other'.
			-- This wraps `make_from_other', allowing routines to obtain a new
			-- {JJ_BIG_NUMBER} in places where an object of a deferred class
			-- is needed but cannot be created.
		require
			other_exists: other /= Void
			start_big_enough: a_start >= 1
			start_small_enough: a_start <= other.count
			end_after_start: a_end >= a_start
		deferred
		end

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		do
			Result := new_big_number (zero_value, base)
		end

	bits_used_for_digit: INTEGER_32
			-- Number of bits needed in order to represent a number in the `base'
			-- while leaving one bit for a carry.
		local
			temp: like digit
		do
				-- This is naive approach.  It might be better to start high
				-- since the point of this class is a really big number with
				-- a large base.
			temp := base.one
			from Result := 0
			until temp >= base
			loop
				Result := Result + 1
				temp := temp.bit_shift_left (1) + base.one
			end
		ensure
			result_big_enough: Result >= 2
			result_small_enough: Result <= base.bit_count
		end

	new_value_from_character (a_character: CHARACTER_8): like digit
			-- Get the number given by `a_character'
		do
			Result := zero_value
			inspect a_character
			when '0' then
				Result := zero_value
			when '1' then
				Result := one_value
			when '2' then
				Result := two_value
			when '3' then
				Result := three_value
			when '4' then
				Result := four_value
			when '5' then
				Result := five_value
			when '6' then
				Result := six_value
			when '7' then
				Result := seven_value
			when '8' then
				Result := eight_value
			when '9' then
				Result := nine_value
			when 'a', 'A' then
				Result := ten_value
			when 'b', 'B' then
				Result := ten_value + one_value
			when 'c', 'C' then
				Result := ten_value + two_value
			when 'd', 'D' then
				Result := ten_value + three_value
			when 'e', 'E' then
				Result := ten_value + four_value
			when 'f', 'F' then
				Result := ten_value + five_value
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
				ten := new_big_number (ten_value, base)
				if a_power ~ zero then
					num := new_big_number (one_value, base)
					power_of_ten_table.extend (num, zero)
				elseif a_power ~ one then
					num := ten.twin
					power_of_ten_table.extend (num, one)
				else
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

invariant

	base_big_enough: base >= zero_value
	base_small_enough: base <= base.max_value
	has_at_least_one_digit: count >= 1
	no_leading_zeroes_if_stable: not is_unstable implies (count > 1 implies last >= base.one)
	is_zero_implication: not is_unstable implies (is_zero implies count = 1)
	is_one_implication: is_one implies count = 1

	is_zero_implies_non_negative: is_zero implies not is_negative
	is_negative_implies_non_zero: is_negative implies not is_zero

	all_digits_small_enough: not is_unstable implies not is_nonconforming

end
