% Καλούμε τον ανελκυστήρα σε συγκεκριμένο όροφο
callElevator(Floor) :-
    called(Floor),
    write('O Anelkistiras exei idi kalestei se auto ton orofo').
callElevator(Floor) :-
    assert(called(Floor)).

% Μετακινούμε τον ανελκυστήρα σε συγκεκριμένο όροφο 
moveElevator(Floor) :-
    at(_, Floor), % remove the Passengers variable
    write('Elevator already at this floor.').
moveElevator(Floor) :-
    at(_, CurrentFloor), % remove the Passengers variable
    retract(at(_, CurrentFloor)), % remove the Passengers variable
    assert(at(_, Floor)), % remove the Passengers variable
    write('O anelkistiras metakinithike ston orofo'), write(Floor).


% Μπαινουν επιβάτες μεσα
pickUpPassengers(Floor) :-
    at(Passengers, Floor),
    Passengers >= 3,
    write('To asanser einai gemato').
pickUpPassengers(Floor) :-
    at(Passengers, Floor),
    waiting(Waiting, Floor),
    Passengers + Waiting < 3,
    retract(waiting(Waiting, Floor)),
    NewPassengers is Passengers + Waiting,
    assert(at(NewPassengers, Floor)),
    write('Mpikan'), write(Waiting), write(' epivates ston orofo '), write(Floor).

% Κατεβαίνουν επιβάτες στον προορισμό τους
dropOffPassengers(Floor) :-
    at(Passengers, Floor),
    Passengers = 0,
    write('To asanser einai adeio').
dropOffPassengers(Floor) :-
    at(Passengers, Floor),
    Passengers > 0,
    findall(Passenger, (inElevator(Passenger), destination(Passenger, Floor)), PassengersToDropOff),
    length(PassengersToDropOff, NumToDropOff),
    retract(at(Passengers, Floor)),
    NewPassengers is Passengers - NumToDropOff,
    assert(at(NewPassengers, Floor)),
    maplist(retract, PassengersToDropOff),
    write('katevikan'), write(NumToDropOff), write(' epivates ston orofo '), write(Floor).
