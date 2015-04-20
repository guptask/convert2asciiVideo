rm -rf tmp
rm -f ascii_$1_.mp4
mkdir tmp
mkdir tmp/img
mkdir tmp/ascii
ffmpeg -i $1 tmp/img/img%d.jpg

i=1
for file in tmp/img/*
do
    echo "Frame $i"
    jp2a -i  tmp/img/img$i.jpg --output=tmp/ascii/ascii$i.txt
    convert -font Courier -pointsize 6 tmp/ascii/ascii$i.txt tmp/ascii/ascii$i.jpg
    mogrify -trim tmp/ascii/ascii$i.jpg
    rm tmp/ascii/ascii$i.txt
    i=$((i+1))
done
ffmpeg -r 20 -qscale 1 -i tmp/ascii/ascii%d.jpg ascii_$1_.mp4
