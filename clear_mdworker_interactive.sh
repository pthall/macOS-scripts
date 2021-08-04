#!/bin/bash                                                                                                              

# Use this command to delete all empty dirs older than 7 days

DAYS=7
CDIR=`ls -d /private/var/folders/*/*/C/com.apple.metadata.mdworker`
echo "Working on $CDIR..."
echo "...this may take awhile..."
COUNT=`find $CDIR -empty -mtime +${DAYS} -ls | wc -l`
echo "===> This user has $COUNT empty directories older than $DAYS days there."

CMD="find $CDIR -empty -mtime +$DAYS -delete"
echo "...about to run this command:"
echo " $CMD"

echo
echo "===> REALLY DELETE all empty directories older than $DAYS days there?"
echo "(Answer 1 or 2)"

select ANS in "Yes" "No"; do
   case $ANS in
      Yes ) $CMD; echo "Done."; break;;
      No ) echo "OK, aborted."; exit;;
      * ) echo "OK, aborted."; exit;;
   esac
done
