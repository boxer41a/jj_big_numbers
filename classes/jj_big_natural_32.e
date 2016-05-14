note
	description: "[
		Big numbers implmented on 32 bits.
		]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	JJ_BIG_NATURAL_32

inherit

	JJ_BIG_NATURAL [NATURAL_32]
		redefine
			base
		end

create
	default_create,
	make_with_value,
	make_with_base,
	make_with_value_and_base,
	from_string,
	make_from_other

create {ARRAYED_LIST}
	make

convert
	from_string ({STRING_8})

feature {NONE} -- Initialization

	from_natural_32 (a_natural_32: JJ_BIG_NATURAL_32)
			-- Create Current from `a_natural_32'
		do
			deep_copy (a_natural_32)
		end

feature -- Access

	base: NATURAL_32
			-- The number of unique values for each `digit'; the radix

	min_base: NATURAL_32
			-- The minimum allowed for the `base' (i.e. two)
		once
			Result := 2
		end

	zero_value: NATURAL_32
			-- The number zero in the same type as `base'
		do
			Result := 0
		end

	one_value: NATURAL_32
			-- The number one in the same type as `base'
		do
			Result := 1
		end

	two_value: NATURAL_32
			-- The number two in the same type as `base'
		do
			Result := 2
		end

	three_value: NATURAL_32
			-- The number two in the same type as `base'
		do
			Result := 3
		end

	four_value: NATURAL_32
			-- The number two in the same type as `base'
		do
			Result := 4
		end

	five_value: NATURAL_32
			-- The number two in the same type as `base'
		do
			Result := 5
		end

	six_value: NATURAL_32
			-- The number two in the same type as `base'
		do
			Result := 6
		end

	seven_value: NATURAL_32
			-- The number two in the same type as `base'
		do
			Result := 7
		end

	eight_value: NATURAL_32
			-- The number two in the same type as `base'
		do
			Result := 8
		end

	nine_value: NATURAL_32
			-- The number ten in the same type as `base'
		do
			Result := 9
		end

	ten_value: NATURAL_32
			-- The number two in the same type as `base'
		do
			Result := 10
		end

--	bits_per_digit: NATURAL_32 = 8
--			-- The number of bits in each digit

--	max_digit: NATURAL_32
--			-- The maximum value allowed for each digit.
--			-- In base ten, this is a 9; in base 2, this is a 1.
--			-- This is always base - 1 for invariant, but the value in a
--			-- "digit" may exceed this during internal computations.
--		once
--			Result := base - 1
--		end

--	max_digit_for_multiplication: NATURAL_32
--			-- The maximum value that can be used for multiplying a digit in place.
--			-- The binary will have ones in the lower-order digits.
--		once
--			Result := 0x0000ffff
--		end

	Max_value: JJ_BIG_NATURAL_32
			-- The largest value representable by Current.
			-- Limited by number of INTEGER_32.max_value, because INTEGER_32
			-- is used for `count' from ARRAYED_LIST, which restricts the
			-- number of digits that Current can hold.
			-- This feature is really slow as it needs to create a result
			-- containing INTEGER_32.max_value - 1 items.
		local
			d: NATURAL_32
			i: INTEGER
		once
			create Result
			Result.put_i_th (max_digit, 1)
			from i := 2
			until i > i.max_value - 1
			loop
				Result.extend (max_digit)
				i := i + 1
			end
		end

	zero: JJ_BIG_NATURAL_32
			-- Neutral element for "+" and "-"
		once
			create Result
		end

	one: JJ_BIG_NATURAL_32
			-- Neutral element for "*" and "/"
		do
			create Result
			Result.put_i_th (one_value, 1)
		end

	bit_count: like Current
			-- The number of bits used to represent Current.
			-- This does not count leading zeros in the digits.
		do
--			create Result.make_with_value (count * base.bit_count - one_base)
			create Result
			print ("Fix me!  Test conversions from integer count to base 8 %N")
		end

feature -- Element change

	force_extend (a_digit: JJ_NATURAL)
			-- Attempt to add `a_digit' to Current, bypassing some type checking
		do
			check attached {NATURAL_32} a_digit as n then
				extend (n)
			end
		end

feature {NONE} -- Implementation (terms used in `digit_multiply'

	bn_a: JJ_BIG_NATURAL_32
			-- Set to high bits of Current in `digit_multiply'
		once
			create Result
		end

	bn_b: JJ_BIG_NATURAL_32
			-- Set to low bits of Current in `digit_multiply'
		once
			create Result
		end

	bn_c: JJ_BIG_NATURAL_32
			-- Set to high bits of `a_other' in `digit_multiply'
		once
			create Result
		end

	bn_d: JJ_BIG_NATURAL_32
			-- Set to low bits of `a_other' in `digit_multiply'
		once
			create Result
		end

	bn_ac: JJ_BIG_NATURAL_32
			-- First term in `digit_multiply'
		once
			create Result
		end

	bn_bd: JJ_BIG_NATURAL_32
			-- Last term in `digit_multiply'
		once
			create Result
		end

	bn_mid: JJ_BIG_NATURAL_32
			-- Middle term in `digit_multiply'
		once
			create Result
		end

feature {NONE} -- Implementation

	new_big_number (a_value: like digit; a_base: like base): like Current
			-- Create an instance containing `a_value' in `a_base'.
			-- Wraps the creation feature `make_with_value_and_base'.
		do
			create Result.make_with_value_and_base (a_value, a_base)
		end

	new_sub_number (a_start, a_end: INTEGER; other: like Current): like Current
			-- Copy of the digits indexed between `a_start' and `a_end'.min(count)
			-- inclusive withhout leading zeros of digits from `other'.
			-- This wraps `make_from_other', allowing routines to obtain a new
			-- JJ_BIG_NUMBER in places where an object of a deferred class
			-- is needed but cannot be created
		do
			create Result.make_from_other (a_start, a_end, Current)
		end

	power_of_ten_table: HASH_TABLE [JJ_BIG_NATURAL_32, JJ_BIG_NATURAL_32]
			-- Table used by `from_string' to memoize the powers of ten
			-- in the same representation as Current.  It is a value
			-- indexed by a power.
			--     [ the value,  a power]
			-- It is deferred in {JJ_BIG_NATURAL}, because Eiffel does not
			-- allow a once function to have a generic or anchored result.
		once
			create Result.make (50)
		end

end
