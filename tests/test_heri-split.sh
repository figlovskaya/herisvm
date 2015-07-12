# heri-split -- no tests yet

dataset="$tmpdir/dataset"
res_dir="$tmpdir/dir1"

mkdir "$res_dir"

awk '
BEGIN {
   srand()
   for (i=1; i <= 100; ++i){
      print int(rand()*10), "feaures", i
   }
}' > "$dataset"

{ heri-split < /dev/null 2>&1; echo "exit status=$?"; } |
cmp 'heri-split #1.1 error' \
'Options -c and -d are mandatory, see heri-split -h for details
exit status=1
'

{ heri-split -c 3 < /dev/null 2>&1; echo "exit status=$?"; } |
cmp 'heri-split #1.2 error' \
'Options -c and -d are mandatory, see heri-split -h for details
exit status=1
'

{ heri-split -d "$res_dir" < /dev/null 2>&1; echo "exit status=$?"; } |
cmp 'heri-split #1.3 error' \
'Options -c and -d are mandatory, see heri-split -h for details
exit status=1
'

{ heri-split -c 3 -d "$res_dir" "$dataset" 2>&1; echo "exit status=$?"; } |
cmp 'heri-split #2 exit code' \
'exit status=0
'

ls -1 "$res_dir" | sort |
cmp 'heri-split #3 result files' \
'test1.txt
test2.txt
test3.txt
train1.txt
train2.txt
train3.txt
'

for i in 1 2 3; do
    { cat "$res_dir/test${i}.txt" "$res_dir/train${i}.txt" | sort -k3,3n; } |
	cmp2 "heri-split #4.${i} all objects" \
	     "$dataset"
done

{ cat "$res_dir/"test*.txt | sort -k3,3n; } |
cmp2 "heri-split #5 testing sets correctness" \
     "$dataset"
