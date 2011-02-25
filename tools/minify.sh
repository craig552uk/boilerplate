#!/bin/bash
#
#   Bulk minify script
#   Will minify all css and js scripts without .min.css or .min.js extensions 
#   Will create a minified copy of the file in the appropriate folder
#
#   NOTE: Be sure to run script from script folder
#         ./minify.sh
#
#   Author: Craig Russell
#   Email:  craig@craig-russell.co.uk
#

CSS="css"
JS="js"
FILELIST="minify.$$.tmp"
DN=`dirname $0`

COMPORESSOR="$DN/yuicompressor-2.4.2.jar"

MINCSS="styles.min.css"
MINJS="scripts.min.js"

echo -n "" > "$CSS/$MINCSS"
echo -n "" > "$JS/$MINJS"

ls -I X-* $CSS | grep -v $MINCSS > $FILELIST
while read LINE
do
    OLD="$CSS/$LINE"
    
    echo "$OLD -> $CSS/$MINCSS"
    java -jar $DN/yuicompressor-2.4.2.jar $OLD |sed 's/and/and /g' >> "$CSS/$MINCSS"
    
done < $FILELIST

ls -I X-* $JS | grep -v $MINJS > $FILELIST
while read LINE
do
    OLD="$JS/$LINE"
    
    echo "$OLD -> $JS/$MINJS"
    java -jar $DN/yuicompressor-2.4.2.jar $OLD > "$JS/$MINJS"
    
done < $FILELIST

rm -f $FILELIST
