#!/bin/awk -f

function AddRow(Matrix, K, M) {
    for(y=1; y<=M; y++){
	Matrix[K+1][y]=" ";
    }
    return K+1;
}

function PrintMatrix(Matrix, K, M){
    for(x=1; x<=K; x++){
	for(y=1; y<=M; y++) {
	    printf Matrix[x][y];
	}
    printf "\n";
    }
    printf "\n";
}
    
function PrintReversedMatrix(Matrix, K, M){
    for(x=1; x<=K; x++){
	for(y=1; y<=M; y++) {
	    printf Matrix[K+1-x][y];
	}
    printf "\n";
    }
    printf "\n";
}
    

BEGIN{
    FS="";
    delta=4; flag=1; row=1; instr=0;
}

{
    # If we find the "basis of the piramid" 1 2 3 ... 
    # stop storing the matrix (flag==0);
    # Measure the size of the matrix so far.
    if($2=="1" && instr==0) {flag=0; K=row-1; M=col;}
    
    # Otherwise (flag==1) store the matrix elements
    if(flag==1){
	for(i=2; i<=NF; i+=delta) {
	    col=1+(i-2)/delta;
	    if ($i==" ") {piles[row][col]=" ";}
	    else {piles[row][col]=$i;}
	}
	row+=1;
    }

    if(NF<2) {instr=1; FS=" ";
	# The matrix we've read has K rows and M columns.
	# Reverse matrix with respect to rows
	for(k=1; k<=K; k++){
	    for(j=1; j<=M; j++) {
		Piles[k][j] = piles[K+1-k][j];
	    }
	}
    }

    # Read instructions and apply them
    if(NF>2 && instr==1){
	quantity=$2;
	start=$4;
	end=$6;
	# What is the height j of the starting pile?
	j=K;
	while(Piles[j][start]==" ") {j-=1};
	# What is the height l of the ending pile?
	l=K;
	while(Piles[l][end]==" ") {l-=1};
	# Do we have enough rows K to fit quantity
	# in the ending pile, that's already l tall?
	while(l+quantity>K) {
	    # if not, we add rows
	    K=AddRow(Piles, K, M);
	}
        
	# Now we can move.
	# Take k on top of the start pile, and l over the
	# top of the end pile
        k=j; h=l+1;
	for(n=0; n<quantity; n++){
	    # Move k from start-pile over the l^th block
	    # in the end pile
	    Piles[h][end]=Piles[k][start];
	    # k now has left a void
	    Piles[k][start]=" ";
	    # Now go up in the start pile and in the end pile
	    k-=1; h+=1;
	}
    }
}

END{
    for(j=1; j<=M; j++){
	k=K;
	while(Piles[k][j]==" ") {k-=1};
	printf Piles[k][j];
    }
    printf "\n"
}
