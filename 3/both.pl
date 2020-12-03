#!/usr/bin/env swipl
user:file_search_path(adventofcode, AOC) :-
    prolog_load_context(directory, Dir),
    file_directory_name(Dir, AOC).
:- use_module(adventofcode(helpers/readfile)).

count_trees([], _, _, _, Count, Count).

% if our downward velocity is higher than the remaining number of rows, clamp
% it so that we hit our recursion end condition
count_trees(Rows, DX, DY, CurX, Accum, Count) :-
    length(Rows, RemainingRows),
    RemainingRows < DY,
    count_trees(Rows, DX, RemainingRows, CurX, Accum, Count).
    
count_trees([CurrentRow|T], DX, DY, CurX, Accum, Count) :-
    string_chars(CurrentRow, Chars),
    length(Chars, MapW),
    (nth0(CurX, Chars, '#') 
     -> Accum1 is Accum + 1
     ;  Accum1 is Accum),
    length(Prefix, DY), 
    append(Prefix, Rest, [CurrentRow|T]),
    NewX is (CurX + DX) mod MapW,
    count_trees(Rest, DX, DY, NewX, Accum1, Count).

:- initialization(main, main).
main([InputFile]) :-
    read_strings(InputFile, Map),
    count_trees(Map, 1, 1, 0, 0, Trees11),
    writef("Slope 1, 1: %w trees\n", [Trees11]),
    count_trees(Map, 3, 1, 0, 0, Trees31),
    writef("Slope 3, 1: %w trees\n", [Trees31]),
    count_trees(Map, 5, 1, 0, 0, Trees51),
    writef("Slope 5, 1: %w trees\n", [Trees51]),
    count_trees(Map, 7, 1, 0, 0, Trees71),
    writef("Slope 7, 1: %w trees\n", [Trees71]),
    count_trees(Map, 1, 2, 0, 0, Trees12),
    writef("Slope 1, 2: %w trees\n", [Trees12]),
    Result is Trees11 * Trees31 * Trees51 * Trees71 * Trees12,
    writef("Product: %w trees\n", [Result]).
    

