pfad=/daten/quellen/hg/

echo "Update von"
date
for i in $(ls $pfad)
do
  echo $i
  cd $pfad$i
  hg pull && hg update
done
