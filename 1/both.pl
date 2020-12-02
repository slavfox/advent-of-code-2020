#!/usr/bin/env swipl
user:file_search_path(adventofcode, AOC) :-
    prolog_load_context(directory, Dir),
    file_directory_name(Dir, AOC).
:- use_module(adventofcode(helpers/readfile)).

product_n_2020([], _, Result, 2020, Result).
product_n_2020([N|Ns], Input, PartialProduct, PartialSum, Result) :-
    member(N, Input),
    N =< 2020 - PartialSum,
    NewProduct is PartialProduct * N,
    NewSum is PartialSum + N,
    product_n_2020(Ns, Input, NewProduct, NewSum, Result).

product_n_2020(N, Numbers, Product) :-
    length(Factors, N),
    product_n_2020(Factors, Numbers, 1, 0, Product).

:- initialization(main, main).
main([Count, InputFile]) :-
    atom_number(Count, N),
    read_numbers(InputFile, Numbers),
    product_n_2020(N, Numbers, Product),
    writeln(Product).

