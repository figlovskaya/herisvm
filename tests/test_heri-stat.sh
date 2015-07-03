remove_fractions (){
    awk '{gsub(/0[.][0-9]+/, "0.NNNN"); print}' "$@"
}

# heri-stat
heri-stat golden1.txt result1.txt 2>&1 |
cmp 'heri-stat #1 defaults' \
'Class  1      P, R, F1:  1          2/2      ,  0.6667     2/3      ,  0.8   
Class  2      P, R, F1:  0.5        1/2      ,  0.5        1/2      ,  0.5   
Class  3      P, R, F1:  0.5        1/2      ,  1          1/1      ,  0.6667
Accuracy              :  0.6667     4/6      
Macro average P, R, F1:  0.6667              ,  0.7222              ,  0.6556
'

heri-stat -R golden1.txt result1.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #2 -R' \
'Class  1     	precision	1.0	2/2
Class  1     	recall	0.NNNN	2/3
Class  1     	f1	0.NNNN	
Class  2     	precision	0.NNNN	1/2
Class  2     	recall	0.NNNN	1/2
Class  2     	f1	0.NNNN	
Class  3     	precision	0.NNNN	1/2
Class  3     	recall	1.0	1/1
Class  3     	f1	0.NNNN	
	accuracy	0.NNNN	4/6
Macro average	precision	0.NNNN	
Macro average	recall	0.NNNN	
Macro average	f1	0.NNNN	
'

# heri-stat
heri-stat golden2.txt result2.txt 2>&1 |
cmp 'heri-stat #3 symbolic classes' \
'Class  A      P, R, F1:  1          2/2      ,  0.6667     2/3      ,  0.8   
Class  B      P, R, F1:  0.5        1/2      ,  0.5        1/2      ,  0.5   
Class  C      P, R, F1:  0.5        1/2      ,  1          1/1      ,  0.6667
Accuracy              :  0.6667     4/6      
Macro average P, R, F1:  0.6667              ,  0.7222              ,  0.6556
'

heri-stat -mR golden1.txt result1.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #4 -m' \
'Class  1     	precision	1.0	2/2
Class  1     	recall	0.NNNN	2/3
Class  1     	f1	0.NNNN	
Class  2     	precision	0.NNNN	1/2
Class  2     	recall	0.NNNN	1/2
Class  2     	f1	0.NNNN	
Class  3     	precision	0.NNNN	1/2
Class  3     	recall	1.0	1/1
Class  3     	f1	0.NNNN	
	accuracy	0.NNNN	4/6
Macro average	precision	0.NNNN	
Macro average	recall	0.NNNN	
Macro average	f1	0.NNNN	
'

heri-stat -Rr golden1.txt result1.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #5 -r' \
'Class  1     	precision	1.0	2/2
Class  1     	recall	0.NNNN	2/3
Class  1     	f1	0.NNNN	
Class  2     	precision	0.NNNN	1/2
Class  2     	recall	0.NNNN	1/2
Class  2     	f1	0.NNNN	
Class  3     	precision	0.NNNN	1/2
Class  3     	recall	1.0	1/1
Class  3     	f1	0.NNNN	
	accuracy	0.NNNN	4/6
'

heri-stat -Rc golden1.txt result1.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #6 -s' \
'	accuracy	0.NNNN	4/6
Macro average	precision	0.NNNN	
Macro average	recall	0.NNNN	
Macro average	f1	0.NNNN	
'

heri-stat -Rac golden1.txt result1.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #7 -Ras' \
'Macro average	precision	0.NNNN	
Macro average	recall	0.NNNN	
Macro average	f1	0.NNNN	
'

heri-stat golden3.txt result3.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #8 all equal' \
'Class  A      P, R, F1:  NaN        0/0      ,  0          0/6      ,  NaN   
Class  B      P, R, F1:  0          0/6      ,  NaN        0/0      ,  NaN   
Accuracy              :  0          0/6      
Macro average P, R, F1:  NaN                 ,  NaN                 ,  NaN   
'

heri-stat golden3.txt /dev/null 2>&1 |
remove_fractions |
cmp 'heri-stat #9 bad length' \
'Golden data and predictions should contain the same amount of classes
'

heri-stat golden3.txt bad_file.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #10 bad input' \
"Bad line '' in file 'bad_file.txt'
Bad line 'B C A' in file 'bad_file.txt'
"

heri-stat -1 all_in_one1.txt 2>&1 |
cmp 'heri-stat #11 option -1' \
'Class  1      P, R, F1:  1          2/2      ,  0.6667     2/3      ,  0.8   
Class  2      P, R, F1:  0.5        1/2      ,  0.5        1/2      ,  0.5   
Class  3      P, R, F1:  0.5        1/2      ,  1          1/1      ,  0.6667
Accuracy              :  0.6667     4/6      
Macro average P, R, F1:  0.6667              ,  0.7222              ,  0.6556
'

heri-stat golden2.txt result2.txt 2>&1 |
cmp 'heri-stat #12 symbolic classes and -1' \
'Class  A      P, R, F1:  1          2/2      ,  0.6667     2/3      ,  0.8   
Class  B      P, R, F1:  0.5        1/2      ,  0.5        1/2      ,  0.5   
Class  C      P, R, F1:  0.5        1/2      ,  1          1/1      ,  0.6667
Accuracy              :  0.6667     4/6      
Macro average P, R, F1:  0.6667              ,  0.7222              ,  0.6556
'
