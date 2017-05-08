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

feature -- Status report

	is_verbose: BOOLEAN
			-- Should the report features print extra information?

feature -- Status setting

	set_verbose
			-- Ensure `is_verbose', so `report' features print extra information.
		do
			is_verbose := true
		end

	set_terse
			-- Ensure not `is_verbose', so `report' features print less.
		do
			is_verbose := false
		end

feature -- Basic operations (initialization tests)

	default_create_test
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		deferred
		end

	make_with_value
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		deferred
		end

	from_string
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		local
			fn, str, s: STRING_8
			n: like number_anchor
		do
			n := new_number
			str := n.generating_type + ":  "
			fn := ".from_string "
				-- Base 10 number
			n := new_number_from_string ("3852")
			s := str + fn + "(%"" + n.out + "%") = "
			io.put_string (s + n.out + "%N")
			assert (s + " out_as_stored ", n.out_as_stored ~ "<15,12>")
				-- Number
			n := new_number_from_string ("10,987,654,321")
			s := str + fn + "(%"" + n.out + "%") = "
			io.put_string (s + n.out + "%N")
			assert (s + " out_as_stored ", n.out_as_stored ~ "<2,142,234,76,177>")
				-- Negative number
			n := new_number_from_string ("-00012,34")
			s := str + fn + "(%"" + n.out + "%") = "
			io.put_string (s + n.out + "%N")
			assert (s + " out_as_stored ", n.out_as_stored ~ "-<4,210>")
				-- Failing ? number
			n := new_number_from_string ("33333")
			s := str + fn + "(%"" + n.out + "%") = "
			io.put_string (s + n.out + "%N")
			assert (s + " out_as_stored ", n.out_as_stored ~ "<130,53>")
				-- Number arrived at during failing simple_multiply?
			n := new_number_from_string ("26,558,760")
			s := str + fn + "(%"" + n.out + "%") = "
			io.put_string (s + n.out + "%N")
			assert (s + " out_as_stored ", n.out_as_stored ~ "<1,149,65,40>")
		end

	make_with_array
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		deferred
		end

	set_random
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		deferred
		end

	set_random_with_digit_count
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
		deferred
		end

feature -- Basic operations (constants tests)

	zero_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".zero_word:  "
			n := new_number
			v := n.zero_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "0")
		end

	one_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".one_word:  "
			n := new_number
			v := n.one_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "1")
		end

	two_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".two_word:  "
			n := new_number
			v := n.two_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "2")
		end

	three_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type +".three_word:  "
			n := new_number
			v := n.three_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "3")
		end

	four_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".four_word:  "
			n := new_number
			v := n.four_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "4")
		end

	five_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".five_word:  "
			n := new_number
			v := n.five_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "5")
		end

	six_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".six_word:  "
			n := new_number
			v := n.six_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "6")
		end

	seven_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".seven_word:  "
			n := new_number
			v := n.seven_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "7")
		end

	eight_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".eight_word:  "
			n := new_number
			v := n.eight_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "8")
		end

	nine_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".nine_word:  "
			n := new_number
			v := n.nine_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "9")
		end

	ten_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".ten_word:  "
			n := new_number
			v := n.ten_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "10")
		end

	sixteen_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".sixteen_word:  "
			n := new_number
			v := n.sixteen_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ "16")
		end

	max_word
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			v: like digit_anchor
		do
			str := generating_type + ".max_word:  "
			n := new_number
			v := n.max_word
			io.put_string (str + v.out + "%N")
			assert (str, v.out ~ (n.zero_word - n.one_word).out)
		end

	default_karatsuba_threshold
			-- Tests and demonstrates the corresponding feature
			-- from {JJ_BIG_NATURAL}.
		local
			str: STRING_8
			n: like new_number
			i: INTEGER
		do
			str := generating_type + ".default_karatsuba_threshold:  "
			n := new_number
			i := n.default_karatsuba_threshold
			io.put_string (str + i.out + "%N")
			assert (str, i.out ~ "4")
		end

feature -- Basic operations (Access)

--	base
--			-- Tests and demonstrates the corresponding feature
--			-- from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	min_base
--			-- Tests and demonstrates the corresponding feature
--			-- from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	zero
--			-- Tests and demonstrates the corresponding feature
--			-- from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	one
--			-- Tests and demonstrates the corresponding feature
--			-- from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	karatsuba_threshold
--			-- Tests and demonstrates the corresponding feature
--			-- from {JJ_BIG_NATURAL}.
--		deferred
--		end

feature -- Basic operations (element change tests)

--	set_karatsuba_threshold
--			-- Test the corresponging feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	set_value
--			-- Test the corresponging feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	set_with_string
--			-- Test the corresponging feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	set_base
--			-- Test the corresponging feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	set_value_and_base
--			-- Test the corresponging feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	set_with_array
--			-- Test the corresponging feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

feature -- Basic operations (status setting tests)

--	set_is_negative
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

feature -- Basic operations (status report tests)


--	is_zero
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	is_one
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	is_base
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	is_negative
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	is_same_sign
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	divisible
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

feature -- Basic operations (basic operations tests)

--	negate
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	identity
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	opposite
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	scalar_add
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end


--	scalar_sum
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	add
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	plus
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	subtract
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	minus
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	simple_add
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	simple_subtract
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

feature -- Basic operations (addition and subtraction)

	minus
			-- Tests the corresponding feature.
		local
			fn, str, s: STRING_8
			a, b, n: like new_number
			fac: like new_number
		do
			n := new_number_from_string ("0")
			str := n.generating_type + ":  "
			fn := ".minus"
				-- (578372618996743892774658921536).minus
				-- (578372618990119377281937921536)
				--           = 6624515492721000000
			a := new_number_from_string ("578372618996743892774658921536")
			b := new_number_from_string ("578372618990119377281937921536")
			s := str + "(" + a.out + ")" + fn
			s := s + "(" + b.out + ") = "
			io.put_string (s)
			n := a.minus (b)
			io.put_string (n.out + "%N")
			assert (s, n.out ~ "6624515492721000000")
		end

feature -- Basic operations (multiply)

	multiply
			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
			-- "https://defuse.ca/big-number-calculator.htm".
		local
			fn, str, s: STRING_8
			n: like number_anchor
			fac: like number_anchor
		do
			n := new_number
			str := n.generating_type + ":  "
			fn := ".multiply"
				-- (0).multiply (99)
			n := new_number_from_string ("0")
			fac := new_number_from_string ("99")
			s := n.out + fn + " (" + fac.out + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out + "%N")
			assert (s, n.out ~ "0")
			assert (s + "  fac unchanged", fac.out ~ "99")
				-- (7777777) * (4444) = 7326
			n := new_number_from_string ("7,777,777")
			fac := new_number_from_string ("4,444")
			s := n.out + fn + " (" + fac.out + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out + "%N")
			assert (s, n.out ~ "34564440988")
				-- (4444) * (333) = 1,479,852
			n := new_number_from_string ("4,444")
			fac := new_number_from_string ("333")
			s := n.out + fn + " (" + fac.out + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out + "%N")
			assert (s, n.out ~ "1479852")

				-- (55555) * (333) = 18,499,815.
			n := new_number_from_string ("55,555")
			fac := new_number_from_string ("333")
			s := n.out + fn + " (" + fac.out + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out + "%N")
			assert (s, n.out ~ "18499815")
				-- (-84736487483757564869490010293).multiply (57849399340004949681221)
				--      = -4901954903117222552481914443941818610639794358807753
			n := new_number_from_string ("84,736,487,483,757,564,869,490,010,293")
			n.set_is_negative (true)
			fac := new_number_from_string ("57,849,399,340,004,949,681,221")
			s := n.out + fn + " (" + fac.out + ") = "
			io.put_string (str + s)
			n.multiply (fac)
			io.put_string (n.out + "%N")
			assert (s, n.out ~ "-4901954903117222552481914443941818610639794358807753")
--				-- (76830098273758661872848373648940382626284094938726398738889685720002828459).multiply
--				-- (958373849585736872304958798457775894021348798874729875798378793871119847467)
--				--      =
--			create n.from_string ("76830098273758661872848373648940382626284094938726398738889685720002828459")
--			create fac.from_string ("958373849585736872304958798457775894021348798874729875798378793871119847467")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			io.put_string ("   count = " + n.count.out + "    digit count = " + n.out.count.out)
--			io.put_string ("   bit_count = " + n.bit_count.out + "%N")
--			assert (s, n.out ~ "73631957046672565937925257190591320772352409826806244996676386%
--								%046169314383746193055493848375509280946999333549270158045540%
--								%510952030901985012646663353")


--			create n.from_string ("2113437065")
--			create fac.from_string ("5821885")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--			io.put_string (":  " + n.out + "%N")
--			assert (s, n.out ~ "12304187547167525")


--					-- 250 digits * 300 digits
--				-- (83538405938488853094850398200983583094850394859389
--				--  84983453847598347598370284538474019766117463655588
--				--  36346464647850001918847326255742816363288173654627
--				--  88573746549509289374578585858399020002882618937378
--				--  75867266647389001839253647618277365008917283945943).multiply
--				-- (57758698746572221826111119200011102485746373948473
--				--  39485729874528347587283475498234759238745982734598
--				--  39487539847587276340976823049839485729939283576239
--				--  74827364263562535555428736427784923864863874964687
--				--  63487268762834687573549273049273747277759283748273
--				--  25345726354827368765032648284592774083464597984375)
--				--      =
--			create n.from_string ("83538405938488853094850398200983583094850394859389%
--									%84983453847598347598370284538474019766117463655588%
--									%36346464647850001918847326255742816363288173654627%
--									%88573746549509289374578585858399020002882618937378%
--									%75867266647389001839253647618277365008917283945943")
--			create fac.from_string ("57758698746572221826111119200011102485746373948473%
--										%39485729874528347587283475498234759238745982734598%
--										%39487539847587276340976823049839485729939283576239%
--										%74827364263562535555428736427784923864863874964687%
--										%63487268762834687573549273049273747277759283748273%
--										%25345726354827368765032648284592774083464597984375")
--			s := "(" + n.out + ")" + str + " (" + fac.out + ")"
--			io.put_string (s)
--			n.multiply (fac)
--				-- Avoid multiple calls to n.out.
--			str := n.out
--			io.put_string (":  " + str.out + "%N")
--			io.put_string ("   count = " + n.count.out + "    digit count = " + str.count.out)
--			io.put_string ("   bit_count = " + n.bit_count.out + "%N")
--			assert (s, n.out ~ "4825069622370037571581047969665419797448540415%
--								%208614127393061696951534481046543312526107740%
--								%616881520201220721059058189474027364333280490%
--								%731711579833565141687110565609766141768385838%
--								%181800093879499351395375019465741496786437615%
--								%905097167960518223578143659640699463848834083%
--								%895169532864836580469168509063847997004568761%
--								%222855410335418261681974960860689195201798823%
--								%225258887886846265059106530177085061334147253%
--								%968350106247237989343625852064639555650237796%
--								%312026892273677206316139551013377145009476245%
--								%658014645173303892209806200718548107417653664%
--								%258640625")
		end

--	scalar_multiply
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	scalar_product
--			-- Tests the corresponding feature from {JJ_BIG_NATURAL}.
--		deferred
--		end

feature -- Basic operations (selectively exported)

--	bit_shift_left
--			-- Test and demonstrate feature `bit_shift_left' from
--			-- {JJ_BIG_NATURAL}.
--		deferred
--		end

--	normalize
--			-- Test and demonstrate feature `normalize' from {JJ_BIG_NATURAL}.
--		deferred
--		end

--	divide_two_words_by_one
--			-- Test and demonstrate feature `divide_two_words_by_one' from
--			-- {JJ_BIG_NATURAL}.
--		deferred
--		end

--	scalar_divide
--			-- Test and demonstrate feature `scalar_divide' from {JJ_BIG_NATURAL}.
--			-- I checked the calculations at
--			-- "https://defuse.ca/big-number-calculator.htm".
--		local
--			str, s: STRING_8
--			n: like new_number
--			d: like new_number.digit
--			tup: like new_number.scalar_divide
--		do
--			str := ".scalar_divide:  "
--				-- test number one
--			n := new_number_from_string ("8")
--			d := n.eight_value
--			s := str + "(" + n.out + ").scalar_divide (" + d.out + ")"
--			tup := n.scalar_divide (d)
--			report_tuple (s, tup)
--			assert (s + "  quot", tup.quot.out ~ "1")
--			assert (s + "  rem", tup.rem.out ~ "0")
--				-- test number two
--			n := new_number_from_string ("49")
--			d := n.three_value
--			s := str + "(" + n.out + ").scalar_divide (" + d.out + ")"
--			tup := n.scalar_divide (d)
--			report_tuple (s, tup)
--			assert (s, tup.quot.out ~ "18")
--			assert (s, tup.rem.out ~ "1")
--				-- test number three
--			n := new_number_from_string ("84746229876")
--			d := n.sixteen_value
--			s := str + "(" + n.out + ").scalar_divide (" + d.out + ")"
--			tup := n.scalar_divide (d)
--			report_tuple (s, tup)
--			assert (s, tup.quot.out ~ "5296639367")
--			assert (s, tup.rem.out ~ "4")
--		end

	quotient
		deferred
		end

feature -- Test conversion

--	is_less
--		local
--			a, b: like number
--			e: BOOLEAN
--			n: INTEGER_32
--		do
--			f_name := ".is_less"
--			a := new_number_from_string ("28")
--			b := new_number_from_string ("10")
--			e := false
--			print (class_name + f_name + "%N")
--			print ("%T           a = " + a.out + " < " + b.out + "%N")
--			print ("%T a base = " + a.base.out + "  b.base = " + b.base.out + "%N")
--			print ("%T    expected = " + e.out + "%N")
--			print ("%T         out = " + (a < b).out + "%N")
--			assert (f_name, (a < b) ~ e)
--			print ("%N")
--		end



--	test_conversion_1
--		local
--			n: JJ_BIG_NATURAL_8
--			e: STRING_8
--		do
--			n := "98765"
--			e := "9,8,7,6,5"
--			f_name := ".test_conversion_1"
--			n.set_base (8)
--			print (class_name + f_name + "%N")
--			print ("%T expected = " + e + "%N")
--			print ("%T actual =   " + n.out_as_base (10) + "%N")
--			assert (f_name, n.out_as_base (10) ~ e)
--		end

--	test_conversion_2
--		local
--			n: JJ_BIG_NATURAL_8
--			e: STRING_8
--		do
--			n := "-7"
--			e := "-7"
--			f_name := ".test_conversion_2"
--			n.set_base (3)
--			print (class_name + f_name + "%N")
--			print ("%T expected = " + e + "%N")
--			print ("%T actual =   " + n.out_as_base (10) + "%N")
--			assert (f_name, n.out_as_base (10) ~ e)
--		end

--	test_conversion_3
--		local
--			n: JJ_BIG_NATURAL_8
--			e: STRING_8
--		do
--			n := "32"
--			e := "32"
--			f_name := ".test_conversion_3"
--			n.set_base (8)
--			n.set_base (7)
--			n.set_base (2)
--			print (class_name + f_name + "%N")
--			print ("%T expected = " + e + "%N")
--			print ("%T actual =   " + n.out_as_base (10) + "%N")
--			assert ("f_name", n ~ e)
--		end

--	test_conversion_4
--		local
--			n: JJ_BIG_NATURAL_8
--			e: STRING_8
--		do
--			n := "99"
--			e := "99"
--			f_name := ".test_conversion_4"
--			n.set_base (8)
--			print (class_name + f_name + "%N")
--			print ("%T expected = " + e + "%N")
--			print ("%T actual =   " + n.out_as_base (10) + "%N")
--			assert ("f_name", n ~ e)
--		end

--	test_conversion_5
--		local
--			a, e: JJ_BIG_NATURAL_8
--		do
--			a := "99"
--			e := "99"
--			a.set_base (3)
--			assert ("after conversion", a ~ e)
--		end

--	test_conversion_6
--		local
--			a, e: JJ_BIG_NATURAL_8
--		do
--			a := "99"
--			e := "99"
--			a.set_base (8)
--			a.set_base (3)
--			assert ("after conversion", a ~ e)
--		end

--	test_conversion_9
--		local
--			a, e: JJ_BIG_NATURAL_8
--		do
--			a := "98765"
--			a.set_base (8)
--			a.set_base (2)
--			a.set_base (100)
--			assert ("a after conversions", a.out_as_base (10) ~ "9,8,7,6,5")
--		end

--	digits_multiplied
--		local
--			str, s: STRING_8
--			n: like number
--			tup: like {like number}.digits_multiplied
--			a, b: like number.base
--		do
--			str := generating_type + ".digits_multiplied:  "
--			create n
--				-- 10 * 100
--			a := n.ten_value
--			b := n.ten_value * n.ten_value
--			tup := n.digits_multiplied (a, b)
--			s := str + "10 * 100"
--			io.put_string (s + "10 * 100 -- [" + tup.high.out + ", " + tup.low.out + "] %N")
--			assert (s, "[" + tup.high.out + ", " + tup.low.out + "]" ~ "[7, 104]")
--				-- 11 * 100
--			a := a + n.one_value
--			tup := n.digits_multiplied (a, b)
--				-- 11 * 101
--			b := b + n.one_value
--			tup := n.digits_multiplied (a, b)
--				-- 20 * 101
--			a := a + n.nine_value
--			tup := n.digits_multiplied (a, b)
--				-- 29 * 110
--			a := a + n.nine_value
--			b := b + n.nine_value
--			tup := n.digits_multiplied (a, b)
--				-- 30 * 110
--			a := a + n.one_value
--			tup := n.digits_multiplied (a, b)
--				-- 36 * 107 = 3852  (see Radix conversion paper, example)
--			a := a + n.six_value
--			b := b - n.three_value
--			tup := n.digits_multiplied (a, b)
--				-- 127 * 127
--			a := n.max_word
--			b := n.max_word
--			tup := n.digits_multiplied (a, b)

--			io.new_line
--		end

feature -- Basic operations (tests implementation features)

--	power_of_ten_table
--			-- Tests the existence of the `power_of_ten_table'.
--			-- This test feature must be called before any math operations
--			-- that access the `power_of_ten_table'.
--		deferred
--		end

--	ten_to_the_power
--			-- Tests the intended once-ness of the `power_of_ten_table'
--			-- somewhat tests its memoization usage.
--			-- This test feature must be called before any math operations
--			-- that access the `power_of_ten_table'.
--		deferred
--		end

--	new_value_from_character
--			-- Tests the `new_value_from_character' feature.
--		deferred
--		end

--	bits_utilized
--			-- Tests the `bits_utilized' feature, which gives the
--			-- number of bits used for representing numbers given
--			-- a specific `base'.
--		deferred
--		end

--	new_big_number
--			-- Tests the `new_big_number' feature.
--		deferred
--		end

--	new_sub_number
--			-- Test the `new_sub_number' feature.
--		deferred
--		end

feature {NONE} -- Implementation

	report (a_comment: STRING_8; a_number: like number_anchor)
			-- Display some information (for demo) about `a_number'.
		do
			print (a_number.generating_type + a_comment + "%N")
			print ("          count = " + a_number.count.out + "%N")
--			print ("    digit_count = " + a_number.as_base (a_number.ten_value).count.out + "%N")
			if is_verbose then
				print ("      as_stored = " + a_number.out_as_stored + "%N")
				print ("        as_bits = " + a_number.out_as_bits + "%N")
--				print ("            out = " + a_number.out + "%N")
			end
			print ("  out_formatted = " + a_number.out_formatted + "%N")
		end

	report_properties (a_comment: STRING_8; a_number: like number_anchor)
			-- Display verbose information (for demo) about `a_number'.
		do
			print (a_number.generating_type + a_comment + "  report_properties %N")
			print ("         max_dig_value: " + a_number.max_word.generating_type + " = " + a_number.max_word.out + "%N")
--				print ("            max_value: " + a_number.max_value.generating_type + " = " + a_number.max_value.out + "%N")
			print ("                 zero: " + a_number.zero.generating_type + " = " + a_number.zero.out + "%N")
			print ("                  one: " + a_number.one.generating_type + " = " + a_number.one.out + "%N")
			print ("  karatsuba_threshold: " + a_number.karatsuba_threshold.generating_type + " = " + a_number.karatsuba_threshold.out + "%N")
			print ("           zero_value: " + a_number.zero_word.generating_type + " = " + a_number.zero_word.out + "%N")
			print ("            one_value: " + a_number.one_word.generating_type + " = " + a_number.one_word.out + "%N")
			print ("            two_value: " + a_number.two_word.generating_type + " = " + a_number.two_word.out + "%N")
			print ("          three_value: " + a_number.three_word.generating_type + " = " + a_number.three_word.out + "%N")
			print ("           four_value: " + a_number.four_word.generating_type + " = " + a_number.four_word.out + "%N")
			print ("           five_value: " + a_number.five_word.generating_type + " = " + a_number.five_word.out + "%N")
			print ("            six_value: " + a_number.six_word.generating_type + " = " + a_number.six_word.out + "%N")
			print ("          seven_value: " + a_number.seven_word.generating_type + " = " + a_number.seven_word.out + "%N")
			print ("          eight_value: " + a_number.eight_word.generating_type + " = " + a_number.eight_word.out + "%N")
			print ("           nine_value: " + a_number.nine_word.generating_type + " = " + a_number.nine_word.out + "%N")
			print ("            ten_value: " + a_number.ten_word.generating_type + " = " + a_number.ten_word.out + "%N")
			print ("        sixteen_value: " + a_number.sixteen_word.generating_type + " = " + a_number.sixteen_word.out + "%N")
			print ("                  out: " + a_number.out + "%N")
			print ("        out_formatted: " + a_number.out_formatted + "%N")
			print ("        out_as_stored: " + a_number.out_as_stored + "%N")
			print ("          out_as_bits: " + a_number.out_as_bits + "%N")
		end

--	report_tuple (a_comment: STRING_8; a_tuple: like tuple_anchor)
--			-- Display information about `a_tuple' which contains a quotient
--			-- and a remainder, likely resulting from some division operation.
--		do
--			print (a_tuple.generating_type + a_comment + "%N")
--			print ("  tuple:  [" + a_tuple.quot.out + ", " + a_tuple.rem.out + "] %N")
--		end

--	report_word_tuple (a_comment: STRING_8; a_tuple: like digit_tuple_anchor)
--			-- Display information about `a_tuple' which contains a quotient
--			-- and a remainder, likely resulting from some division operation.
--		do
--			print (a_tuple.generating_type + a_comment + "%N")
--			print ("  tuple:  [" + a_tuple.quot.out + ", " + a_tuple.rem.out + "] %N")
--		end


feature -- Factory access

	new_number: JJ_BIG_NATURAL [like digit_anchor]
			-- Factory and anchor for new big numbers.
		deferred
		end

	new_number_from_string (a_string: STRING_8): like new_number
			-- Create a new big number from the contents of `a_string'.
		deferred
		end

feature {NONE} -- Anchors

--	number: like number_anchor
--			-- Used as handle to obtain values, etc.
--			-- Redefine as once.
--		deferred
--		end

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





