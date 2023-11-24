%Exercise 3
lectures(Topics,Names,Surnames):-
    Topics = [BI,PH,MA,N,SH],
    Names = [A,B,C,D,E],
    Surnames = [F,G,H,I,J],
    domain(Topics,1,5),
    domain(Names,1,5),
    domain(Surnames,1,5),
    all_different(Topics),
    all_different(Names),
    all_different(Surnames),

    %Alice Monday
    A #= 1,
    %Charles -> Phisical hygiene not on friday
    C #= PH, CH #\= 5,
    %Jeffereys nutrition
    J #= N,
    %Man modern art 
    (C #= MA) #\/ (D #= MA) #\/ (E #= MA),
    %Itakura (Miss -> woman)
    (I #= A) #\/ (I #= B),
    %Itakura and Study habits consecutive days
    abs(I-SH) #= 1,
    %Haller after Eddie
    E - H #< 0,
    %Duane Felicidad before modern art
    D #= F, D - MD #< 0,


    labeling([],Topics),
    labeling([],Names),
    labeling([],Surnames).

%Exercise 4
%Using facts
grade(danny,fai,20).
grade(danny,fai,20).
grade(toon,plmp,18).
grade(toon,fai,14).
grade(toon,uai,4).

%More examples for testing
grade(juan,plmp,2).
grade(pepe,plmp,20).
grade(pedro,plmp,17).

topscore(Class,Result):-
    findall((N,G),grade(N,Class,G),Grades),
    getHighest(Grades,0,0,Result).

getHighest([(Name,Grade)|T],MaxAcc,_,Result):-
    Grade >= MaxAcc,
    getHighest(T,Grade,Name,Result).
getHighest([(_,Grade)|T],MaxAcc,MaxName,Result):-
    Grade < MaxAcc,
    getHighest(T,MaxAcc,MaxName,Result).
getHighest([],_,MaxName,MaxName).

%Using Lists
%[(danny,fai,20),(danny,fai,20),(toon,plmp,18),(toon,fai,14),(toon,uai,4)]
%More examples for testing
%[(danny,fai,20),(danny,fai,20),(toon,plmp,18),(toon,fai,14),(toon,uai,4),(pepe,plmp,20),(pepe,plmp,20),(pedro,plmp,17)]
topscoreList(List,Class,Result):-
    getTopAcc(List,Class,0,0,Result).

getTopAcc([(Name,C,Grade)|T],Class,MaxAcc,_,Result):-
    Grade >= MaxAcc,
    C = Class,
    getTopAcc(T,Class,Grade,Name,Result).
getTopAcc([(_,C,Grade)|T],Class,MaxAcc,NameAcc,Result):-
    Grade < MaxAcc,
    C = Class,
    getTopAcc(T,Class,MaxAcc,NameAcc,Result).
getTopAcc([(_,C,_)|T],Class,MaxAcc,NameAcc,Result):-
    C \= Class,
    getTopAcc(T,Class,MaxAcc,NameAcc,Result).
getTopAcc([],_,_,NameAcc,NameAcc).

%Exercise 5
%Gets the value in specified index
get([H|_],1,H).
get([_|T],N,Result):-
    Temp is N-1,
    get(T,Temp,Result).
%Sets the specified value on specified index
set([_|T],1,Element,[Element|T]).
set([H|T],N,Element,Result):-
    Temp is N-1,
    set(T,Temp,Element,TempList),
    Result = [H|TempList].
%Returns the length of the list
lengthList([],Acc,Acc).
lengthList([_|T],Acc,Result):-
    Temp is Acc + 1,
    lengthList(T,Temp,Result).
%Copies the value of the index on the next one
copy(List,Index,Result):-
    lengthList(List,0,L),
    Index \= L,
    get(List,Index,Element),
    Set is Index + 1,
    set(List,Set,Element,Result).
copy(List,Index,Result):-
    lengthList(List,0,L),
    Index == L,
    get(List,Index,Element),
    set(List,1,Element,Result).
%Swaps the values of the specified indexes
swap(List,I,J,Result):-
    get(List,I,IElement),
    get(List,J,JElement),
    set(List,I,JElement,Temp),
    set(Temp,J,IElement,Result).
%Returns list with the numbers from 1 to N of the specified length (N)
numberedList(1,Acc,[1|Acc]).
numberedList(N,Acc,Result):-
    Temp is N-1,
    N \= 1,
    numberedList(Temp,[N|Acc],Result).
%Returns one instruction for the specified refisters
getInstruction(Registers,Instruction):-
    member(X,Registers),
    Instruction = c(X).
getInstruction(Registers,Instruction):-
    member(I,Registers),
    member(J,Registers),
    I < J,
    Instruction = s(I,J).
%Returns one instruction sequence of Length N for the specified registers
instructionSequence(RegisterNumbers,1,[Result]):-
    getInstruction(RegisterNumbers,Result).
instructionSequence(RegisterNumbers,N,Result):-
    N \= 1,
    Next is N-1,
    instructionSequence(RegisterNumbers,Next,Temp),
    getInstruction(RegisterNumbers,NewInst),
    Result = [NewInst|Temp].
%Returns all possible sequences of specified Length
allSequences(Registers,N,Result):-
    lengthList(Registers,0,L),
    numberedList(L,[],RegNum),
    findall(Seq,instructionSequence(RegNum,N,Seq),Result).
%Checks if two register lists are the same
equalRegisters([],[]).
equalRegisters([H|T1],[H|T2]):-
    equalRegisters(T1,T2).
%Checks if a squence reaches a solution
validSequence([],RegAcc,FinalReg):-
    equalRegisters(RegAcc,FinalReg).
validSequence([c(N)|T],RegAcc,FinalReg):-
    copy(RegAcc,N,NewReg),
    validSequence(T,NewReg,FinalReg).
validSequence([s(I,J)|T],RegAcc,FinalReg):-
    swap(RegAcc,I,J,NewReg),
    validSequence(T,NewReg,FinalReg).
%Given a set of sequences returns a valid one
checkValidity([H|_],Registers,FinalRegisters,H):-
    validSequence(H,Registers,FinalRegisters).
checkValidity([H|T],Registers,FinalRegisters,Result):-
    not(validSequence(H,Registers,FinalRegisters)),
    checkValidity(T,Registers,FinalRegisters,Result).
%Performs iterative deepening
iterativeDeepening(Depth,Registers,FinalRegisters,Result):-
    allSequences(Registers,Depth,PosSequences),
    checkValidity(PosSequences,Registers,FinalRegisters,Result).
iterativeDeepening(Depth,Registers,FinalRegisters,Result):-
    allSequences(Registers,Depth,PosSequences),
    not(checkValidity(PosSequences,Registers,FinalRegisters,_)),
    NewDepth is Depth+1,
    iterativeDeepening(NewDepth,Registers,FinalRegisters,Result).