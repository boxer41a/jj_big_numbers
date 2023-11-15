note
	description: "[
		A pseudorandom number generator based on the Mersenne Twister algorithm 
		originally described in "Mersenne Twister:  A 623-Dimensionally Equi-
		distributed Uniform Pseudorandom Number Generator" by Makoto Matsumoto
		and Takuji Nishimura.
		
		It generates 32-bit natural numbers.
	]"
	author: "Jimmy J. Johnson"

class
	JJ_RANDOM_32

inherit

	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Set up Current.
		do
			create mt.make_filled (seed.zero, 1, n)
			set_seed (Default_seed)
			index := n
			lower := seed.zero
			upper := seed.max_value
		ensure then
			mt_array_sized_correctly: mt.count = n
			seed_is_default: seed = Default_seed
			initial_index_set: index = n
		end

feature -- Access

	item: NATURAL_32
			-- The random number corresponding to the current `index'.
			-- This feature is called "extract_number()" on wiki.
		local
			y: like item
		do
			y := mt[index]
			y := y.bit_xor (y.bit_shift_right (u).bit_and (d))
			y := y.bit_xor (y.bit_shift_left (s).bit_and (b))
			y := y.bit_xor (y.bit_shift_left (t).bit_and (c))
			y := y.bit_xor (y.bit_shift_right (z))
			Result := y
			if is_constrained then
				Result := Result \\ (upper - lower + seed.one) + lower
			end
		ensure
			index_unchanged: index = old index
			is_constrained_implication: is_constrained implies
								( (Result >= lower and Result < upper) or else
								  ((lower = upper) implies Result = lower) )
		end

	seed: NATURAL_32
			-- The seed used to initialize the generator.

	Default_seed: NATURAL_32 = 5489
			-- The default value used for the `seed'.

	lower: like item
			-- The smallest value returned by `item'.
			-- See `set_range'.

	upper: like item
			-- The upper constraint for the possible values of `item'.
			-- See `set_range'.

feature -- Element change

	set_range (a_lower, a_upper: like item)
			-- Set `lower' and `upper' such that a call to `item' returns
			-- a number in the closed interval [`lower', `upper'].
		require
			lower_smaller_than_upper: lower <= upper
		local
			o_low, o_up: like item
		do
			o_low := lower
			o_up := upper
			lower := a_lower
			upper := a_upper
			if lower > seed.zero or upper < seed.max_value then
				is_constrained := true
			else
				is_constrained := false
			end
			if lower /= o_low or upper /= o_up then
					-- The interval changed, so ensure `item' is in range.
				forth
			end
		ensure
			lower_set: lower = a_lower
			upper_set: upper = a_upper
			implication: (a_lower /= 0 or a_upper /= seed.max_value) implies is_constrained
		end

	set_seed (a_seed: like seed)
			-- Set the seed and reinitialize the generator.
			-- Make sure it is not zero and is an odd number.  (An even number
			-- probably would work, but I recommend using an odd number.)
		require
			non_zero: a_seed /= seed.zero
			not_even: a_seed \\ (seed.one + seed.one) = seed.one
		do
			seed := a_seed
			initialize
		ensure
			seed_assigned: seed = a_seed
		end

feature -- Basic operations

	show
			-- For testing
		local
			i: INTEGER
		do
			io.put_string ("{" + generating_type + "} lower/up = " + lower.out + "/" + upper.out + "%N")
			from i := 1
			until i > mt.count
			loop
				io.put_string ("{" + i.out + "," + mt.item (i).out + "}%T")
				i := i + 1
			end
			io.new_line
		end

	forth
			-- Increase the `index' by one.
		do
			if index = n then
				twist
			else
				index := index + 1
			end
		ensure
			index_incremented: ((old index = n) implies index = 1) or else
								 index = old index + 1
		end

feature -- Status report

	is_constrained: BOOLEAN
			-- Should the numbers returned by `item' be restricted to a
			-- reduced range (i.e. other than [1, max_value]?

feature -- Implementation

	integer_to_word (a_value: INTEGER): like item
			-- Convert `a_value' to the correct type.
			-- Needed by this class and maybe convenient to others.
		do
			Result := a_value.as_NATURAL_32
		end

feature {NONE} -- Implementation

	initialize
			-- Reset the generator from `seed'.
		local
			i: INTEGER

			p, q: like item
			hex: STRING_8
		do
			mt[1] := seed
			from i := 2
			until i > n
			loop
				mt[i] := f
						* ((mt[i - 1]).bit_xor ((mt[i - 1]).bit_shift_right (w - 2)))
						+ integer_to_word (i)
				i := i + 1
			end
		end

	twist
			-- Generate the next `n' values in the series `mt'.
		local
			i: INTEGER
			x, xa: like item
			two: like item

			j: INTEGER
			p, q: like item
		do
			two := seed.one + seed.one
			from i := 1
			until i > n
			loop
					-- for testing
				x := mt[i]
				j := ((i + 1) \\ n) + 1
				p := mt[j]
				p := p.bit_and (lower_mask)
				q := mt[i].bit_and (upper_mask)
					-- end testing code
				x := mt[i].bit_and (upper_mask) + (mt[((i + 1) \\ n) + 1]).bit_and (lower_mask)
				xa := x.bit_shift_right (1)
				if (x \\ two) /= seed.zero then
					xa := xa.bit_xor (a)
				end
				mt[i] := (mt[((i + m) \\ n) + 1]).bit_xor (xA)
				i := i + 1
			end
			index := 1
		ensure
			index_set: index = 1
		end

feature {NONE} -- Implementation

	mt: ARRAY [like item]
			-- State array of the generator.

feature {NONE} -- Implementation (constants)

	index: INTEGER
			-- A value between 1 and `n' for access a particular number
			-- from the series.

	w: INTEGER = 32
			-- Word size (i.e. the number of bits in a word).

	n: INTEGER = 624
			-- The degree of recurrence.

	m: INTEGER = 397
			-- Middle word, an offset used in the recurrence relation
			-- defining the series.

	r: INTEGER = 31
			-- The separation point of one word, or the number of bits
			-- of the lower bitmask, 0 <= r <= w - 1.

	s: INTEGER = 7
			-- A bit shift.

	t: INTEGER  = 15
			-- A bit shift.

	u: INTEGER = 11
			-- A bit shift.

	z: INTEGER = 18
			-- A tempering bitmask.
			-- Was called "l" (i.e. elle) in the original and on Wiki, but
			-- an elle looks too much like a one.

	a: NATURAL_32 = 0x9908B0DF
			-- The coefficients of the rational normal form twist matrix.

	b: NATURAL_32 = 0x9D2C5680
			-- A tempering bitmask.

	c: NATURAL_32 = 0xEFC60000
			-- A tempering bitmask.

	d: NATURAL_32 = 0xFFFFFFFF
			-- A tempering bitmask.

	f: NATURAL_32 = 1812433253
			-- Another parameter.

	lower_mask: NATURAL_32 = 0x7FFFFFFF
			-- Mask to obtain the lower `r' bits of a particular
			-- value from `mt'.

	upper_mask: NATURAL_32 = 0xFFFF8000
			-- Mask to obtain the upper `w' - `r' bits of a particular
			-- value from `mt'.

invariant

	valid_item: item >= lower and item <= upper

	index_big_enough: index >= 1
	index_small_enough: index <= n

	lower_big_enough: lower >= seed.zero				-- Obviously, its a NATURAL.
	lower_small_enough: lower <= seed.max_value		-- Obviously, its a NATURAL.

	upper_big_enough: upper >= seed.zero				-- Obviously, it a NATURAL.
	upper_small_enough: upper <= seed.max_value		-- Obviously, its a NATURAL.

	lower_smaller_than_upper: lower <= upper

	is_constrained_implication: is_constrained implies (lower > seed.zero or upper < seed.max_value)
	reduced_range_implication: (lower > seed.zero or upper < seed.max_value) implies is_constrained

end
