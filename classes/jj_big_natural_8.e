note
	description: "[
		Big numbers implemented on eight bits.
		]"
	author: "Jimmy J. Johnson"

class
	JJ_BIG_NATURAL_8

inherit

	JJ_BIG_NATURAL [NATURAL_8]

create
	default_create,
	from_value,
	from_array,
	from_string,
	make_random,
	make_random_with_digit_count

create {ARRAYED_LIST}
	make

convert
	from_string ({STRING_8})

feature -- Initialization

	set_with_integer (a_integer: INTEGER)
			-- Make Current equivalent to `a_integer'.
		local
			b: like word
			x, r: INTEGER
		do
			if a_integer < max_word then
				set_value (a_integer.to_natural_8)
			else
				wipe_out
				b := max_word + 1
				from x := a_integer
				until x = 0
				loop
					r := x \\ b
					extend (x.to_natural_8)
					x := x // b
				end
			end
		end

feature -- Constants

	bits_per_word: INTEGER_32 = 8
			-- The number of bits in each word of Current in same type as `word'.

	zero_word: NATURAL_8 = 0
			-- The number zero in the same type as `word'

	one_word: NATURAL_8 = 1
			-- The number one in the same type as `word'

	two_word: NATURAL_8 = 2
			-- The number two in the same type as `word'

	three_word: NATURAL_8 = 3
			-- The number two in the same type as `word'

	four_word: NATURAL_8 = 4
			-- The number two in the same type as `word'

	five_word: NATURAL_8 = 5
			-- The number two in the same type as `word'

	six_word: NATURAL_8 = 6
			-- The number two in the same type as `word'

	seven_word: NATURAL_8 = 7
			-- The number two in the same type as `word'

	eight_word: NATURAL_8 = 8
			-- The number two in the same type as `word'

	nine_word: NATURAL_8 = 9
			-- The number ten in the same type as `word'

	ten_word: NATURAL_8 = 10
			-- The number two in the same type as `word'

	sixteen_word: NATURAL_8 = 16
			-- The number 16 in the same type as `word'.

	max_ten_power: NATURAL_8 = 100
			-- Largest multiple of 10 representable in a word of Current.

	max_half_word: NATURAL_8 = 0x0F
			-- The largest value representable in half the number of
			-- bits in Current's representation of a `word'.

	max_word: NATURAL_8 = 0xFF
			-- The largest value allowed for a `word' of Current (i.e. all ones).

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
			Result.put_i_th (one_word, 1)
		end

feature {NONE} -- Implementation

	new_big_number (a_value: like word): like Current
			-- Factory method to create an instance equivalent to `a_value'.
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

feature -- export for testing

	random: JJ_RANDOM_8
			-- Used to generate random numbers for placement into Current.
			-- Deferred, because need to produce the correct type.
		once
			create Result
		end

end
