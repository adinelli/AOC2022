#!/bin/awk -f

# Compute the score for P2 in a round of Rock-Paper-Scissors game
function RockPaperScissors(P1, P2){
    Pts=0;
    if (P2=="X") {Pts+=1;
	if      (P1=="A") Pts+=3;
	else if (P1=="B") Pts+=0;
	else if (P1=="C") Pts+=6;}
    else if (P2=="Y") {Pts+=2;
	if      (P1=="A") Pts+=6;
	else if (P1=="B") Pts+=3;
	else if (P1=="C") Pts+=0;}
    else if (P2=="Z") {Pts+=3;
	if      (P1=="A") Pts+=0;
	else if (P1=="B") Pts+=6;
	else if (P1=="C") Pts+=3;}
    return Pts;
}

# Compute the score for P2 in a round of Rock-Paper-Scissors game
# where P2 are the indications of what to do (win, lose, draw)
function RockPaperScissors_2(P1, P2){
    Pts=0;
    # I have to lose: A->Z, B->X, C->Y
    if (P2=="X") {Pts+=0;
	if      (P1=="A") Pts+=3;
	else if (P1=="B") Pts+=1;
	else if (P1=="C") Pts+=2;}
    # I have to end in a draw: A->X, B->Y, C->Z
    else if (P2=="Y") {Pts+=3;
	if      (P1=="A") Pts+=1;
	else if (P1=="B") Pts+=2;
	else if (P1=="C") Pts+=3;}
    # I have to win: A->Y, B->Z, C->X
    else if (P2=="Z") {Pts+=6;
	if      (P1=="A") Pts+=2;
	else if (P1=="B") Pts+=3;
	else if (P1=="C") Pts+=1;}
    return Pts;
}

BEGIN{Score=0; Score_2=0;}

{
    Score   += RockPaperScissors($1,$2);
    Score_2 += RockPaperScissors_2($1,$2);
}

END{
    print Score;
    print Score_2;
}
