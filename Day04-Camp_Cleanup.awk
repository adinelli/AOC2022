#!/bin/awk -f

function min(x,y) {
    if (x<y) {return x;}
    else {return y;}
}


BEGIN{
    FS=","; pairs=0; 
}

{
    for(n=1;n<=2;n++){
	# Read all fields
	x = $n;
	# Each field must be internally separated by dash
	split(x, A, "-");
	# Create a string with the full list of rooms
	# of the form _n_n+1_n+2_n+3__..._nF_
	# with n1 = A[1] and nF = A[2]
	Rooms[n]="";
	for(j=A[1];j<=A[2];j++) {
	    Rooms[n]=Rooms[n]"_"j;
	}
	Rooms[n]=Rooms[n]"_";

	# Binary version of the strings 000000111110000...
	BinaryRoom[n] = "";
	for(j=1; j<=A[2]; j++) {
	    if(j>=A[1]) {
		BinaryRoom[n]=BinaryRoom[n]"1"
	    }
	    else BinaryRoom[n]=BinaryRoom[n]"0"
	}
    }
    # Check if one of the two strings is fully contained in the other
    if(index(Rooms[1], Rooms[2])!=0 || index(Rooms[2], Rooms[1])!=0) {pairs+=1;};

    # Check if there is overlap between two binary assignments
    K1 = length(BinaryRoom[1]);
    K2 = length(BinaryRoom[2]);
    K  = min(K1,K2);
    # Overlap means that two characters on the same site i must be both 1
    # hence their product is 1
    for(i=1; i<=K; i++) {
	if (substr(BinaryRoom[1], i, 1)*substr(BinaryRoom[2], i, 1)==1) {overlaps+=1; break;}
    }
}

END{
    print pairs;
    print overlaps;
}
