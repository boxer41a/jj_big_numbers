note
	description: "[
		Big numbers implemented on eight bits.
		]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"

class
	JJ_BIG_NATURAL_8

inherit

	JJ_BIG_NATURAL [NATURAL_8]
		redefine
			digit_anchor
		end

create
	default_create,
	from_value,
	from_array,
	from_string

create {ARRAYED_LIST}
	make

convert
	from_string ({STRING_8})

feature -- Constants

	zero_digit: NATURAL_8 = 0
			-- The number zero in the same type as `digit'

	one_digit: NATURAL_8 = 1
			-- The number one in the same type as `digit'

	two_digit: NATURAL_8 = 2
			-- The number two in the same type as `digit'

	three_digit: NATURAL_8 = 3
			-- The number two in the same type as `digit'

	four_digit: NATURAL_8 = 4
			-- The number two in the same type as `digit'

	five_digit: NATURAL_8 = 5
			-- The number two in the same type as `digit'

	six_digit: NATURAL_8 = 6
			-- The number two in the same type as `digit'

	seven_digit: NATURAL_8 = 7
			-- The number two in the same type as `digit'

	eight_digit: NATURAL_8 = 8
			-- The number two in the same type as `digit'

	nine_digit: NATURAL_8 = 9
			-- The number ten in the same type as `digit'

	ten_digit: NATURAL_8 = 10
			-- The number two in the same type as `digit'

	sixteen_digit: NATURAL_8 = 16
			-- The number 16 in the same type as `digit'.

	bit_count_digit: NATURAL_8 = 8
			-- The number of bits in each digit of Current in same type as `digit'.

	max_ten_power: NATURAL_8 = 100
			-- Largest multiple of 10 representable in a digit of Current.

	max_half_digit: NATURAL_8 = 0x0F
			-- The largest value representable in half the number of
			-- bits in Current's representation of a `digit'.

	max_digit: NATURAL_8 = 0xFF
			-- The largest value allowed for a `digit' of Current (i.e. all ones).

feature -- Access

	zero: like Current --JJ_BIG_NATURAL_8
			-- Neutral element for "+" and "-"
			-- Use caution as this object can be modified.
		do
			create Result
		end

	one: like Current -- JJ_BIG_NATURAL_8
			-- Neutral element for "*" and "/"
			-- Use caution as this object can be modified.
		do
			create Result
			Result.put_i_th (one_digit, 1)
		end

feature {NONE} -- Implementation

	new_big_number (a_value: like digit): like Current
			-- Create an instance equivalent to `a_value'.
			-- Wraps the creation feature `from_value'.
		do
			create Result.from_value (a_value)
		end

	power_of_ten_table: HASH_TABLE [JJ_BIG_NATURAL_8, JJ_BIG_NATURAL_8]
			-- Table used by `from_string' to memoize the powers of ten in the
			-- same representation as Current.  It contains a value indexed by
			-- a power.
			--     [ the value,  a power]
			-- It is deferred in {JJ_BIG_NATURAL} and defined in this class,
			-- because Eiffel does not allow a once function to have a generic
			-- or anchored result.
		once
			create Result.make (Default_table_size)
--			Result.compare_objects
		end

	biggest_ten_base: NATURAL_8 = 100
			-- Largest power-of-ten number representable by the type of `base'.
			-- Used in the output functions.

	digit_anchor: NATURAL_8
			-- Used in covariant redefinitions.

end
