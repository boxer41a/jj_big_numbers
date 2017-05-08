note
	description: "[
		A class for testing the features of {JJ_BIG_NATURL_8}.
	]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTABLE_BIG_NATURAL_8

inherit

	TESTABLE_BIG_NATURAL [NATURAL_8]

	JJ_BIG_NATURAL_8
		export
			{ANY}
				all
		redefine
			power_of_ten_table
		end

create
	default_create,
	from_value,
--	make_with_base,
--	make_with_value_and_base,
	from_array,
	from_string

feature

	power_of_ten_table: HASH_TABLE [TESTABLE_BIG_NATURAL_8, TESTABLE_BIG_NATURAL_8]
			-- Table used by `from_string' to memoize the powers of ten in the
			-- same representation as Current.  It contains a value indexed by
			-- a power.
			--     [ the value,  a power]
			-- It is deferred in {JJ_BIG_NATURAL} and defined in this class,
			-- because Eiffel does not allow a once function to have a generic
			-- or anchored result.
		once
			create Result.make (50)
		end


end
