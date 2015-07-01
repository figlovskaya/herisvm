#!/bin/sh

LC_ALL=C
export LC_ALL

: ${DIFF_PROG:=diff -U20}
: ${TMPDIR:=/tmp}

PATH=$OBJDIR_scripts:$PATH

#
print_args (){
    for i in "$@"; do
	printf " '%s'" "$i"
    done
}

runtest (){
    prog="$1"
    shift

    "$prog" "$@" 2>&1
}

tmpdir="$TMPDIR/herisvm.$$"
mkdir -m 0700 "$tmpdir" || exit 60

tmpfn1="$tmpdir/1"
tmpfn2="$tmpdir/2"
tmpfn3="$tmpdir/3"
tmpfn4="$tmpdir/4"
tmpex="$tmpdir/5"

trap "rm -rf $tmpdir" 0

echo > $tmpex

cmp (){
    # $1 - progress message
    # $2 - expected text
    printf '    %s... ' "$1" 1>&2

    cat > "$tmpfn2"
    printf '%s' "$2" > "$tmpfn1"

    if $DIFF_PROG "$tmpfn1" "$tmpfn2" > "$tmpfn3"; then
	echo ok
    else
	echo FAILED
	awk '{print "   " $0}' "$tmpfn3"
	rm -f $tmpex
    fi
}

# real tests
tests='
heri-stat
heri-split
heri-eval
'

for t in ${TESTS-$tests}; do
    . ./test_$t.sh
done

test -f "$tmpex"
exit $?
