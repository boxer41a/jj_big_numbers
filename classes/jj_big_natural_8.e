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
	from_integer,
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
			-- Initialize Current with `a_integer'.
		local
			b: INTEGER_32	-- base
			w: INTEGER_32	-- max_word
			x: INTEGER_32
			r: INTEGER_32	-- remainder
		do
			wipe_out
--			default_create
				-- Will not work for {JJ_BIG_NATURAL_32} because
				-- `max_word' is twice as big as largest {INTEGER}.
				-- `b' will go to zero in that case
			w := max_word.as_integer_32
			x := a_integer.abs
			if x > w then
				b := w + 1
				check
					b_not_zero: b >= 1
				end
				from
				until x = 0
				loop
					r := x \\ b
					check
						remainder_small_enough: r <= w
							-- because ...?
					end
					extend (integer_as_word (r))
					x := x // b
				end
			else
				from_value (integer_as_word (a_integer))
			end
			if a_integer < 0 then
				set_is_negative (True)
			end
		ensure then
--			correct_initialization: Current.jj_out ~ a_integer.out
			correct_negative: a_integer < 0 implies Current.is_negative
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

	number_cache: LINKED_STACK [JJ_BIG_NATURAL_8]
			-- A collection of previously created numbers from which to
			-- select to reduce the number of creations.
			-- I would like this to be defined in {JJ_BIG_NATURAL} as a
			-- once feature, but a once feature can not have an anchored
			-- result.
		once
			create Result.make
		end

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

--feature -- export for testing

--	random: JJ_NATURAL_8_RNG
--			-- Used to generate random numbers for placement into Current.
--			-- Deferred, because need to produce the correct type.
--		once
--			create Result
--		end

feature {NONE} -- Implementtion

	integer_as_word (a_integer: INTEGER_32): like word
			-- The equivalent value of `a_integer' in same type as `word'
		do
			Result := a_integer.abs.as_natural_8
		end

end
