note
	description: "[
		A class for testing each feature of {JJ_BIG_NATURAL_8}.  This class
		grants access to *all* features so that even the implementation
		features, normally exported to {NONE} can be called for testing.
	]"
	author: "Jimmy J. Johnson"

class
	TESTABLE_BIG_NUMBER_32

inherit

	BIG_NUMBER_32
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

feature -- Implementation

	number_cache: LINKED_STACK [TESTABLE_BIG_NUMBER_32]
			-- A collection of previously created numbers from which to
			-- select to reduce the number of creations.
			-- I would like this to be a once feature, but a once feature
			-- can not have an anchored result.
		once
			create Result.make
		end

	power_of_ten_table: HASH_TABLE [TESTABLE_BIG_NUMBER_32, TESTABLE_BIG_NUMBER_32]
			-- Table used by `from_string' to memoize the powers of ten in the
			-- same representation as Current.  It contains a value indexed by
			-- a power.
			--     [ the value,  a power]
			-- It is deferred, because Eiffel does not allow a once function
			-- to have a generic or anchored result.
		once
			create Result.make (Default_table_size)
		end

end

