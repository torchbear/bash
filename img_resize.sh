#
# Rename & resize all JPG/jpg files in current directory into 'resized' directory
# - no params neeeded

# delete old resized directory and create a new one
if [ -d ./resized ]
then
  rm -r resized
fi
mkdir resized

# copy all JPG/jpg files into resized directory
echo "Copying"
for f in *.[jJ][pP][gG];
do
  cp -v $f resized/;
done

# change dir
cd resized

# change all files to lowercase 
rename 'y/A-Z/a-z/' *

# rename all jpg files to idx.jpg name
echo "Renaming"
idx=1
for file in *.jpg; 
do
  mv -v $file ${idx}.jpg;
  ((idx++));
done

# convert all files to the same resolution 1600x1200
echo "Resizing"
foo=1
for file in *.jpg; 
do 
  convert $file -resize 1600x1200 ./$file;
  echo "file $file resized to 1600x1200";
done
