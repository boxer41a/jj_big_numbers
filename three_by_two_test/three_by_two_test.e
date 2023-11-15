note
	description: "[
		Class to test the `divide_three_halves_by_two' from the
		{JJ_BIG_NATURAL} class.  The function was failing on some
		inputs.  This test is to find a pattern and solution.
	]"
	author: "Jimmy J.Johnson"

class THREE_BY_TWO_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run the tests
		local
			fd: FORMAT_DOUBLE
			r: REAL_64
			i, t, p: INTEGER
			a, a3, b: NATURAL_8
			tup: like div_three_halves_by_two
		do
				-- Clear console
			from i := 1
			until i >= 20
			loop
				io.new_line
				i := i + 1
			end
			io.put_string ("Begin test %N")
			create counts.make_filled (0, 0, 4)
				-- Step through possible values
			from b := half_base
			until b = zero_digit
			loop
				from a3 := one_digit
				until a3 > max_half_digit
				loop
					from a := max_half_digit + 1
					until a = zero_digit
					loop
						test (a, a3, b)
						a := a + one_digit
					end
					a3 := a3 + one_digit
				end
				b := b + one_digit
			end
			from i := 0
			until i > 4
			loop
				t := t + counts [i]
				i := i + 1
			end
			create fd.make (4, 2)
			io.put_string ("Total tested:  " + t.out + "%N")
			from i := 0
			until i > 4
			loop
				r := counts[i] / t * 100
				io.put_string ("   " + i.out + ":  " + counts[i].out)
				io.put_string ("%T " + fd.formatted (r) + "%% %N")
				i := i + 1
			end
			io.put_string ("end test %N")
		end

feature -- Access

	digit: NATURAL_8

	big_number: JJ_BIG_NATURAL_8
		attribute
			create Result
		end

feature -- Basic operations

	test (a, a3, b: like digit)
			-- Run a test on these values.
		local
			tup: like div_three_halves_by_two
			x, y, q, r : NATURAL_32
		do
			x := a
			x := x.bit_shift_left (4)
			x := x + a3
			y := b
			q := x // y
			r := x \\ y
			tup := div_three_halves_by_two (a, a3, b)
			if not (tup.quot ~ q) then
				io.put_string ("(" + a.out + ", " + a3.out + ", " + b.out + ")")
				io.put_string ("  expected:  " + x.out + " / " + y.out + " = ")
				io.put_string (q.out + " rem " + r.out)
				io.put_string ("%T  actual:  [" + tup.quot.out + "," + tup.rem.out + "]")
				io.put_string ("   ERROR")
				io.new_line
					-- Call again, so we can step into the failing case.
				tup := div_three_halves_by_two (a, a3, b)
			else
--				io.put_string ("   error")
			end
		end

	div_three_halves_by_two (A, a3, B: like digit): TUPLE [quot: like digit; rem: like big_number]
			-- Divide three half-digits, "a1" and "a2" (contained in `A') and
			-- `a3' by two half-digits, "b1" and "b2" (contained in `B'), in
			-- such a way that the computations fit into the representati
			-- (i.e. the number of bits) of a digit.
			-- If ""q in line (6) does not fit into a halfdigit, return a one
			-- in the `over' value of the result.  This is easier than another
			-- feature called DivThreeHalvesByTwoSpecial as mentioned by B & Z.
			-- See "Fast Recursive Division" by Burnikel and Ziegler, p 3 to top p 4.
		local
			a1, a2, b1, b2: like digit
			tup: TUPLE [b1, b2: like digit]
			q, c, ca: like digit
			D, R: like big_number
		do
			tup := as_half_digits (A)
			a1 := tup.b1
			a2 := tup.b2
			tup := as_half_digits (B)
			b1 := tup.b1
			b2 := tup.b2
				-- Version modeled after Colin Plumb's C code
			q := a // tup.b1	-- Line 6
			c := a \\ tup.b1	-- Same as "c := A - q * b1" (i.e. remainder).
--			d := q * tup.b2		-- Error:  this line can cause overflow !!!
			create D.from_value (q)
			D.scalar_multiply (tup.b2)
				-- Add half-word of numerator to remainder.
			ca := as_full_digit (c, a3)
				-- Do equivlent of "R := ca - D
			D.negate
			R := D.scalar_sum (ca)
--			R := CA - D
			if R.is_negative then
				counts[1] := counts[01] + 1
				q := q - 1
				R.scalar_add (b)
				if R.is_negative then
					counts[2] := counts[2] + 1
					q := q - 1
					R.scalar_add (b)
					if R.is_negative then
						counts[3] := counts[3] + 1
						q := q - 1
						R.scalar_add (b)
						if R.is_negative then
							counts[4] := counts[4] + 1
							q := q - 1
							R.scalar_add (b)
						end
					end
				end
			else
				counts[0] := counts[0] + 1
			end
			Result := [q, R]
--				-- Multiply by "guessed" quotient and correct if necessary.			
--				-- Digits can never be negative, so in order to perform the test
--				-- "if (R < 0)" on lines 10 and 13 of Burnikel's algoritm page 3,
--				-- we use temporary, `r', which is [c, a3], and check it against
--				-- `d'.  Instead of subtracting d from R, which would not work,
--				-- we subtract `d' from `r' only after adding `b' to it (once or
--				-- twice), which prevents integer underflow.
--			if d > d.zero and d < q then
--					-- We know that d produced overflow (a number not representable
--					-- in the number of available bits), so handle this case specially.
--						--	d = 256 - q * b2
--				q := q - one_digit - one_digit
--				r := Max_digit - ca + 1 + d
--				r := r - b
--				r := b - r
--			elseif ca < d then
--				q := q - one_digit
--				r := ca + b
--				if r >= b and r < d then
--					q := q - one_digit
--					r := r + b
--				end
--			end
--			r := r - d
--				-- No longer need `B' so reuse the `tup' variable.
----			tup := as_half_digits (q)
----			Result := [tup.b1, tup.b2, r]
--			Result := [zero_digit, q, r]
--			check
--				valid_overflow: Result.over <= one_digit
--			end
----			Result := [q, r]
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
		require
			high_small_enough: a_high <= max_half_digit
			low_small_enough: a_low <= max_half_digit
		do
			Result := a_high.bit_shift_left ({like digit}.bit_count // 2) + a_low
		end

	max_digit: NATURAL_8 = 255

	max_half_digit: NATURAL_8 = 15
			-- The largest value representable in half the number of
			-- bits in Currents representation of a `digit'.

	half_base: NATURAL_8 = 128

	zero_digit: NATURAL_8 = 0

	one_digit: NATURAL_8 = 1
			-- The number one in the same type as `base'.

	five_digit: NATURAL_8 = 5

	counts: ARRAY [INTEGER]

end
