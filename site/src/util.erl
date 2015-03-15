-module(util).
-compile(export_all).

q(Name) -> unicode:characters_to_binary(wf:q(Name)).

parse_date(Date) -> list_to_tuple([ list_to_integer(I) || I <- string:tokens(Date, "-") ]).
