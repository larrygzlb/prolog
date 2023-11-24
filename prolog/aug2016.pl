Exercise 3
voices(Voices,Names,Surnames):-
    Voices = [S,M,T1,T2,B],
    Names = [C,JP,L,P,V],
    Surnames = [K,R1,R2,U,W],
    domain(Voices,1,5),
    domain(Names,1,5),
    domain(Surnames,1,5),
    all_different(Voices),
    all_different(Names),
    all_different(Surnames),

    ((P #= 1) #/\ (B #= 2)) #\/ ((P #= 2) #/\ (B#=1)),
    (T1 #= 2) #\/ (T1 #= 3) #\/ (T2 #= 2) #\/ (T2 #= 3),
    R1 #\= 5,
    R2 #\= 5,
    ((K #= M) #/\ ((T1 #= 5) #\/ (T2 #= 5))) #\/ ((K #= 5) #/\ ((T1 #= M) #\/ (T2 #= M))),
    (R1 #= 3) #\/ (R2 #= 3),
    C #\= 3,
    W #\= C,
    U #\= B,
    U #\= M,
    V #\= 3,
    T1 #\= L,
    T2 #\= L,
    T1 #\= V,
    T2 #\= V,
    JP #\= 3,
    C #\= 5,
    B #\= R1,
    B #\= R2,

    labeling([],Voices),
    labeling([],Names),
    labeling([],Surnames).

%Exercise 4 
% (nil-[f(a,b)]+(nil-[21,22,23]+nil))-[root,1,2]+((nil-[a]+nil)-[child,4]+nil)
% No difference lists
preorder((Left-SomeList+Right), ValueList):-
    preorder(Left,LeftList),
    preorder(Right,RightList),
    append([SomeList],LeftList,Temp),
    append(Temp,RightList,ValueList).
preorder(nil,[]).

%With difference lists NOT DONE BECAUSE I DO NOT UNDERSTAND THEM
preorder((Left-SomeList+Right), ValueList):-
    preorder(Left,LeftList),
    preorder(Right,RightList),
    append([SomeList],LeftList,Temp),
    append(Temp,RightList,ValueList).
preorder(nil,[]).

%Exercise 5 I think this exercise is not complete another page migth be missing
% Use a list for the tour
distance(heverlee,leuven-city-center,10).
distance(leuven-station,leuven-city-center,8).
distance(a,b,2).
distance(c,b,4).

stop(heverlee,4).
stop(leuven-station,10).
stop(leuven-city-center,10).
stop(a,1).
stop(c,1).

% [leuven-station,leuven-city-center,heverlee]
costBus(Tour,Result):-
    costBusAcc(Tour,0,Result).

costBusAcc([_],Acc,Acc).
costBusAcc([S1,S2|T],Acc,Result):-
    distance(S1,S2,Dist),
    Temp is Acc + Dist,
    costBusAcc([S2|T],Temp,Result).
costBusAcc([S1,S2|T],Acc,Result):-
    distance(S2,S1,Dist),
    Temp is Acc + Dist,
    costBusAcc([S2|T],Temp,Result).
