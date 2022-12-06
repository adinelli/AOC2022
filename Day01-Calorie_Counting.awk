#!/usr/bin/awk -f

# Return the maximum between two numbers
function max(x,y) {
    if (x>y) return x;
    else return y;
}

# Assuming M[0] > M[1] > M[2], return the three maximum elements in
# [M, y]
function max3(M, y) {
    x1 = M[0];
    x2 = M[1];
    x3 = M[2];
    if (y > M[0])      {M[0]=y; M[1]=x1; M[2]=x2;}
    else if (y > M[1]) {M[1]=y; M[2]=x2;}
    else if (y > M[2]) {M[2]=y;}
}

BEGIN{
    i=0;
    for(j=0; j<3; j++) {MaxCal[j]=0};
}

{
    if(NF>0)       {Calories[i]+=$1}
    else if(NF==0) {max3(MaxCal, Calories[i]); i+=1};
}


END{
    # Don't forget the last line!
    max3(MaxCal, Calories[i]);
    # Solve the enigma
    print MaxCal[0];
    print MaxCal[0]+MaxCal[1]+MaxCal[2];
}
