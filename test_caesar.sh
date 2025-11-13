#!/bin/sh

WORKSPACE=/tmp/caesar.$(id -u)

error() {
    echo 1>&2 "ERROR: $@"
    [ -r $WORKSPACE/test ] && cat $WORKSPACE/test
    exit 1
}

cleanup() {
    rm -fr $WORKSPACE
    exit $1
}

mkdir $WORKSPACE

trap "cleanup 0" EXIT
trap "cleanup 1" INT TERM

cat > $WORKSPACE/input0 <<EOF
It is better to create than to learn! Creating is the essence of life.
I came, I saw, I conquered.
Experience is the teacher of all things.
Men willingly believe what they wish.
EOF

cat > $WORKSPACE/output0 <<EOF
Vg vf orggre gb perngr guna gb yrnea! Perngvat vf gur rffrapr bs yvsr.
V pnzr, V fnj, V pbadhrerq.
Rkcrevrapr vf gur grnpure bs nyy guvatf.
Zra jvyyvatyl oryvrir jung gurl jvfu.
EOF

cat > $WORKSPACE/output1 <<EOF
Sd sc loddob dy mbokdo drkx dy vokbx! Mbokdsxq sc dro occoxmo yp vspo.
S mkwo, S ckg, S myxaeobon.
Ohzobsoxmo sc dro dokmrob yp kvv drsxqc.
Wox gsvvsxqvi lovsofo grkd droi gscr.
EOF

./caesar.sh < $WORKSPACE/input0 | diff -y - $WORKSPACE/output0 > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failed Encryption Test"
fi

./caesar.sh < $WORKSPACE/output0 | diff -y - $WORKSPACE/input0 > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failed Decryption Test"
fi

./caesar.sh 10 < $WORKSPACE/input0 | diff -y - $WORKSPACE/output1 > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failed Encryption Test"
fi

./caesar.sh 16 < $WORKSPACE/output1 | diff -y - $WORKSPACE/input0 > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failed Decryption Test"
fi

echo "caesar.sh test succesful!"
exit 0
