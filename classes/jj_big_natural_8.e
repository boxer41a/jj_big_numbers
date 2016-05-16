note
	description: "[
		Big numbers implmented on eight bits.
		]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	JJ_BIG_NATURAL_8

inherit

	JJ_BIG_NATURAL [NATURAL_8]
		redefine
			base
		end

create
	default_create,
	make_with_value,
	make_with_base,
	make_with_value_and_base,
	from_array,
	from_string,
	make_from_other

create {ARRAYED_LIST}
	make

convert
	from_string ({STRING_8})

feature -- Access

	base: NATURAL_8
			-- The number of unique values for each `digit'; the radix

--	min_base: NATURAL_8
--			-- The minimum allowed for the `base' (i.e. two)
--		once
--			Result := 2
--		end

	zero_value: NATURAL_8 = 0
			-- The number zero in the same type as `base'

	one_value: NATURAL_8 = 1
			-- The number one in the same type as `base'

	two_value: NATURAL_8 = 2
			-- The number two in the same type as `base'

	three_value: NATURAL_8 = 3
			-- The number two in the same type as `base'

	four_value: NATURAL_8 = 4
			-- The number two in the same type as `base'

	five_value: NATURAL_8 = 5
			-- The number two in the same type as `base'

	six_value: NATURAL_8 = 6
			-- The number two in the same type as `base'

	seven_value: NATURAL_8 = 7
			-- The number two in the same type as `base'

	eight_value: NATURAL_8 = 8
			-- The number two in the same type as `base'

	nine_value: NATURAL_8 = 9
			-- The number ten in the same type as `base'

	ten_value: NATURAL_8 = 10
			-- The number two in the same type as `base'

	sixteen_value: NATURAL_8 = 16
			-- The number 16 in the same type as `base'.

	Max_value: JJ_BIG_NATURAL_8
			-- The largest value representable by Current.
			-- Limited by number of INTEGER_32.max_value, because INTEGER_32
			-- is used for `count' from ARRAYED_LIST, which restricts the
			-- number of digits that Current can hold.
			-- This feature is really slow as it needs to create a result
			-- containing INTEGER_32.max_value - 1 items.
		local
			d: NATURAL_8
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

	zero: JJ_BIG_NATURAL_8
			-- Neutral element for "+" and "-"
		once
			create Result
		end

	one: JJ_BIG_NATURAL_8
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
			check attached {NATURAL_8} a_digit as n then
				extend (n)
			end
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
			-- inclusive without leading zeros of digits from `other'.
			-- This wraps `make_from_other', allowing routines to obtain a new
			-- {JJ_BIG_NUMBER} in places where an object of a deferred class
			-- is needed but cannot be created
		do
			create Result.make_from_other (a_start, a_end, other)
		end

	power_of_ten_table: HASH_TABLE [JJ_BIG_NATURAL_8, JJ_BIG_NATURAL_8]
			-- Table used by `from_string' to memoize the powers of ten
			-- in the same representation as Current.  It is a value
			-- indexed by a power.
			--     [ the value,  a power]
			-- It is deferred in {JJ_BIG_NATURAL} and defined in this
			-- class, because Eiffel does not allow a once function to
			-- have a generic or anchored result.
		once
			create Result.make (50)
		end

end
