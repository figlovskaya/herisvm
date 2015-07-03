remove_fractions (){
    awk '{gsub(/0[.][0-9]+/, "0.NNNN"); print}' "$@"
}

# heri-stat
heri-stat golden1.txt result1.txt 2>&1 |
cmp 'heri-stat #1' \
'Class  1      P, R, F1:  1      (    2/2    ),  0.6667 (    2/3    ),  0.8   
Class  2      P, R, F1:  0.5    (    1/2    ),  0.5    (    1/2    ),  0.5   
Class  3      P, R, F1:  0.5    (    1/2    ),  1      (    1/1    ),  0.6667
Accuracy              :  0.6667 (    4/6    )
Macro average P, R, F1:  0.6667              ,  0.7222              ,  0.6556
'

heri-stat -R golden1.txt result1.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #2' \
'Class  1     	precision	1.0	(    2/2    )
Class  1     	recall	0.NNNN	(    2/3    )
Class  1     	f1	0.NNNN	
Class  2     	precision	0.NNNN	(    1/2    )
Class  2     	recall	0.NNNN	(    1/2    )
Class  2     	f1	0.NNNN	
Class  3     	precision	0.NNNN	(    1/2    )
Class  3     	recall	1.0	(    1/1    )
Class  3     	f1	0.NNNN	
	accuracy	0.NNNN	(    4/6    )
Macro average	precision	0.NNNN	
Macro average	recall	0.NNNN	
Macro average	f1	0.NNNN	
'
