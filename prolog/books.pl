book(1,'The art of Prolog',400).
book(23,'The mistery of Strawberries',42).
person('Statler').
person('Waldorf').
author('Statler',1).
author('Waldorf',23).
hates('Statler',1).
owns('Waldorf',23).


brochure(ISBN):-
    book(ISBN,_,Pages),
    Pages < 100.

hatedbook(Title):-
	book(ISBN,Title,_),
	hates(Person,ISBN),
	author(Person,ISBN).

proud_author(Person):-
author(Person,Book),
owns(Person,Book).

livro(X, Y, Z) :- book(X, Y, Z).
pessoa(X) :- person(X).
autor(X, Y) :- author(X, Y).
odeia(X, Y) :- hates(X, Y).
possui(X, Y) :- owns(X, Y).


reverse('').  % the base case
reverse(Word):-  % the recursive case
	split_string(Word,First,Rest),
	reverse(Rest),
	write(First).

split_string(Word,First,Rest):-
	First is 