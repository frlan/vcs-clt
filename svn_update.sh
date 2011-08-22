pfad=/daten/quellen/svn/

echo "Update von"
date
for i in $(ls $pfad)
do
  echo $i
  cd $pfad$i
  svn update
done
