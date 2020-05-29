note
	description: "[
		A class for testing the features of {JJ_BIG_NATURL_32}.
	]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTABLE_BIG_NATURAL_32

inherit

	TESTABLE_BIG_NATURAL [NATURAL_32]

	JJ_BIG_NATURAL_32
		export
			{ANY}
				all
		redefine
			number_cache,
			power_of_ten_table
		end

create
	default_create,
	from_value,
	from_array,
	from_string

feature

	number_cache: LINKED_STACK [TESTABLE_BIG_NATURAL_32]
			-- A collection of previously created numbers from which to
			-- select to reduce the number of creations.
			-- I would like this to be defined in {JJ_BIG_NATURAL} as a
			-- once feature, but a once feature can not have an anchored
			-- result.
		once
			create Result.make
		end

	power_of_ten_table: HASH_TABLE [TESTABLE_BIG_NATURAL_32, TESTABLE_BIG_NATURAL_32]
			-- Table used by `from_string' to memoize the powers of ten in the
			-- same representation as Current.  It contains a value indexed by
			-- a power.
			--     [ the value,  a power]
			-- It is deferred in {JJ_BIG_NATURAL} and defined in this class,
			-- because Eiffel does not allow a once function to have a generic
			-- or anchored result.
		once
			create Result.make (Default_table_size)
		end


end
