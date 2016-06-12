note
	description: "[
		A class for testing each feature of {JJ_BIG_NATURAL_8}.  This class
		grants access to *all* features so that even the implementation
		features, normally exported to {NONE} can be called for testing.
	]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TESTABLE_BIG_NATURAL [G -> JJ_NATURAL]

inherit

	JJ_BIG_NATURAL [G]
		export
			{ANY}
				all
		end

end
