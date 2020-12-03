#!/usr/bin/env swipl
user:file_search_path(adventofcode, AOC) :-
    prolog_load_context(directory, Dir),
    file_directory_name(Dir, AOC).
:- use_module(adventofcode(helpers/readfile)).

count_ch([], _, 0).
count_ch([Ch|T], Ch, N) :-
    count_ch(T, Ch, N1),
    N is N1 + 1.
count_ch([H|T], Ch, N) :-
    H \= Ch,
    count_ch(T, Ch, N).

valid_password(Password) :-
    split_string(Password, " ", " ",  [Rules, Ch, Pass]),
    split_string(Rules, "-", "", [A, B]),
    number_string(Min, A),
    number_string(Max, B),
    string_concat(Character, ':', Ch),
    string_codes(Pass, Passchars),
    string_codes(Character, [Code]),

    count_ch(Passchars, Code, N),
    N >= Min,
    N =< Max.

count_valid_passwords([], N, N).
count_valid_passwords([P|Ps], Accum, Result) :- 
    valid_password(P),
    Accum1 is Accum + 1,
    count_valid_passwords(Ps, Accum1, Result). 
count_valid_passwords([_|Ps], Accum, Result) :-
    count_valid_passwords(Ps, Accum, Result).

:- initialization(main, main).
main([InputFile]) :-
    read_strings(InputFile, Passwords),
    count_valid_passwords(Passwords, 0, N),
    writeln(N).

