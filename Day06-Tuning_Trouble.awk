#!/bin/awk -f

# Check if all chars in a string are different from each other
function check_characters(s){
    L=length(s);
    for(n=1; n<L; n++){
	for(m=n+1; m<=L; m++){
	    if (substr(s,n,1)==substr(s,m,1)) return 0;
	}
    }
    return 1;
}

BEGIN{
    i=1;
    flag=0;  # It's 0 as long as the marker is not found
    delta=4; # Change from 4 to 14 to solve the two parts of the puzzle
}

{
    while(flag==0){
	# Extract substring of length delta S[i,i+delta]
	S    = substr($1, i, delta);
	# Switch flag to 1 if the marker is found
	flag = check_characters(S);
	# If the marker is found, print how many chars were
	# processed and exit
	if(flag==1) {print i+delta-1; break;}
	# Otherwise, go on with the next substring.
	i+=1;
    }
}
