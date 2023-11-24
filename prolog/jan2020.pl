%Exercise 2
element(X, [X|_T]).
element(X, [Y|_T]):-
    element(X,Y).
element(X, [_Y|T]):-
    element(X,T).

Exercise 3
clock_round(N,Sum,Xs):-
    length(Xs,N),
    domain(Xs,1,N),
    all_different(Xs),
    anti_rot(Xs),
    check_sums(Xs,Sum),
    get_last_element(Xs,L),
    get_sec_to_last_elemt(Xs,Sl),
    get_head(Xs,H),
    get_second(Xs,S),
    Check1 #= L+Sl+H,
    Check2 #= L+H+S,
    Check1 #=< Sum,
    Check2 #=< Sum,
    labeling([],Xs).
    
anti_rot([H|_]):-
    H #= 5.
get_head([H|_],H).
get_second([_,S|_],S).
get_last_element([_|T],R):-
    get_last_element(T,R).
get_last_element([X],X).
%Returns second to last element
get_sec_to_last_elemt([_,H2|T],R):-
    get_sec_to_last_elemt([H2|T],R).
get_sec_to_last_elemt([H1,_|[]],H1).
%Checks the sums of all trios
check_sums([X1,X2,X3,X4|T],Sum):-
    Check #= X1 + X2 + X3,
    Check #=< Sum,
    write(Check),
    check_sums([X2,X3,X4|T],Sum).
check_sums([X1,X2,X3|[]],Sum):-
    Check #= X1 + X2 + X3,
    Check #=< Sum,
    write(Check).

%exercise 4  w<90 v>40
item(ax,50,40).
item(book,50,50).
item(box,10,5).
item(laptop,99,60).

find_set(Acc,AccW,AccV,W,V,Result):-
    AccW < W,
    AccV > V,
    Result = Acc.
find_set(Acc,AccW,AccV,W,V,Result):-
    item(Name,ItemW,ItemV),
    NewW is AccW + ItemW,
    NewV is AccV + ItemV,
    not_in(Name,Acc),
    find_set([Name|Acc],NewW,NewV,W,V,Result).

%Finds the price of a set
price_of_set([H|T],Acc,Result):-
    item(H,_,ItemPrice),
    Temp is Acc + ItemPrice,
    price_of_set(T,Temp,Result).
price_of_set([],Acc,Acc).

highest_collection(Result):-
    findall(L,find_set([],0,0,90,40,L),R),
    highest_price(R,0,[],Result).

highest_price([H|T],MaxAcc,_,Result):-
    price_of_set(H,0,Price),
    Price >= MaxAcc,
    highest_price(T,Price,H,Result).
highest_price([H|T],MaxAcc,ListAcc,Result):-
    price_of_set(H,0,Price),
    Price < MaxAcc,
    highest_price(T,MaxAcc,ListAcc,Result).
highest_price([],_,ListAcc,ListAcc).
%Negative member
not_in(E,[H|T]):-
    E \= H,
    not_in(E,T).
not_in(_,[]).

%exercise 5 [[c,e],[a,d,g],[b,c,f],[a,d,f],[b,g],[d,e,g]]
isCovered(I,[H|_],O):-
    m(I,H),
    O = H.
isCovered(I,[_|T],O):-
    isCovered(I,T,O).

residual(Is,Os,O,NIs,NOs):-
    removeItems(Is,O,NIs),
    removeOptions(Os,O,NOs).

removeOption([H|T],I,R):-
    m(I,H),
    removeOption(T,I,R).
removeOption([H|T],I,R):-
    not(m(I,H)),
    removeOption(T,I,Temp),
    R = [H|Temp].
removeOption([],_,[]).

removeOptions(Os,[H|T],R):-
    removeOption(Os,H,Temp),
    removeOptions(Temp,T,R).
removeOptions(Os,[],Os).

removeItems(Is,[],Is).
removeItems(Is,[H|T],R):-
    remove(H,Is,Temp),
    removeItems(Temp,T,R).

remove(I,[I|T],T).
remove(I,[H|T],R):-
    I \= H,
    remove(I,T,Temp),
    R = [H|Temp].

m(H,[H|_]).
m(E,[_|T]):-
    member(E,T).

findexactcovering([H|T],Os,Acc,Result):-
    isCovered(H,Os,O),
    residual([H|T],Os,O,NIs,NOs),
    findexactcovering(NIs,NOs,[O|Acc],Result).
findexactcovering([],_,Acc,Acc).
