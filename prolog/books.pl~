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

