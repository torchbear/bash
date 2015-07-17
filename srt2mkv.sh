#!//bin/bash
# 
# Automatic add subtitles container into MKV/MP4 video in current folder.
#

MKVFILE=$1
SUBFILE=$2

foo=1
shopt -s nullglob
for file in *.m[kp][v4];
do
  ((foo++))
  MKVFILE=$file
done

foosrt=1
for file in *.srt;
do
  ((foosrt++))
  SUBFILE=$file
done

if [ "$foo" -ne "2" ]
then
  echo "invalid  mkv files count found."
  exit
fi

if [ "$foosrt" -ne "2" ]
then
  echo "invalid srt files count found."
  exit
fi


CZE_MKVFILE="cze_"${MKVFILE}

mkvmerge -v -o "${CZE_MKVFILE}" "${MKVFILE}" --sub-charset 0:cp1250 "${SUBFILE}" 
#mkvmerge -v -o "/home/roman/${CZE_MKVFILE}" "${MKVFILE}" --sub-charset 0:utf8 "${SUBFILE}" 

read -p "Do you want to see the output? [Y/n]" -n 1 resp
if [[ $resp =~ ^[Yy]$ ]] | [ -z $resp ]
then
  mplayer "$CZE_MKVFILE"
  read -p "Do you want to remove $MKVFILE and $SUBFILE? [y/N]" -n 1 resp
  echo
  if [[ $resp =~ ^[Yy]$ ]]
  then
    rm -v "$MKVFILE"
    rm -v "$SUBFILE"
  fi
fi
