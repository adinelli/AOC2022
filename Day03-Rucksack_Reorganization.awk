#!/bin/awk -f

# Find the only common character between 2 strings
function common_char(s1, s2) {
    for(j=1; j<=length(s1); j++) {
	for(i=1; i<=length(s2); i++) {
	    if (substr(s1,j,1)==substr(s2,i,1)) return substr(s1,j,1);
		}
    }
    return "";
}



# Find the only common character among 3 strings
function common_char_3(s1, s2, s3) {
    for(j=1; j<=length(s1); j++) {
	for(i=1; i<=length(s2); i++) {
	    # If we find a common char between s1 and s2,
	    # check if it's also present in s3
	    if (substr(s1,j,1)==substr(s2,i,1)) {
		c=substr(s1,j,1);
		for (k=1; k<=length(s3); k++) {
		    if(substr(s3,k,1)==c) return c;
		}
	    }
	}
    }
    return "";
}

	
BEGIN{
    # Priority of letters. Ordering follows ASCII code. Charachters
    # (a,...,z) correspond to (97,...,122) in ASCII.
    # Their priority should go from 1,...,26
    for(n=97; n<=122; n++) {
	val = n-97+1;
	ord[sprintf("%c", n)] = val;
    }
    # Charachters (A,...,Z) correspond to (65,...,90) in ASCII.
    # Their priority should go from 27,...,55
    for(n=65; n<=90; n++) {
	val = n-65+27;
	ord[sprintf("%c", n)] = val;
    }

    Points=0;
    Badge=0;
    S1=""; S2=""; S3=""; iread=0;
}

{
    # Split each line in two
    S=$1; L  = length(S);
    s1 = substr(S, 1,     L/2);
    s2 = substr(S, L/2+1, L/2);
    # Common charachter
    c  = common_char(s1,s2)
    Points+=ord[c];

    # Second part
    if(iread==0)      {S1=$1; iread+=1;}
    else if(iread==1) {S2=$1; iread+=1;}
    else if(iread==2) {S3=$1;
	# Now that all strings have been grouped,
	# compare them
	C3 = common_char_3(S1,S2,S3);
	Badge+=ord[C3];
	# Reset the line counter
	iread=0;
	# Reset the strings
	S1=""; S2=""; S3="";}
}

END{
    print Points;
    print Badge;
}
