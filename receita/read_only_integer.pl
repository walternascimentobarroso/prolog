% Validating the data entries.
read_only_integer(X):- repeat,
			read(X),
			integer(X),
			!.

