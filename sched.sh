#!/bin/bash
sed -i -e '/^$/d' /home/vinod/OTHER_PERCE/ls.out
sed -i -e '/^$/d' /home/vinod/OTHER_PERCE/lastday.out
#sed -i -e '/^$/d' /home/vinod/debit/ls.out
tail -n 1 /home/vinod/OTHER_PERCE/ls.out > /home/vinod/OTHER_PERCE/ldtemp1.out
while read b
do
ld="$b"
td=$(date '+%Y-%m-%d %H:%M:%S')
#td="2003-04-21 22:55:02"
#echo $td
#./datediff.sh $ld $td
 #echo $(( ( $(date -ud '2003-08-02 17:24:33' +'%s') - $(date -ud '2003-04-21 22:55:02' +'%s') )/60/60/24 )) days
#echo $(( ($(date --date="td" +%s) - $(date --date="ld" +%s) )/(60*60*24) ))
f=$(( ( $(date -ud "$td" +'%s') - $(date -ud "$ld" +'%s') )/60/60/24 ))
#date -d @$(( $(date -d "$date2" +%s) - $(date -d "$date1" +%s) )) -u +'%H:%M:%S'
#echo $f >>/home/vinod/debit/test2.out
if [[ $f -eq 1 ]]
then
c=1
else
c=$(($f-1))
fi
for ((i=0;i<$c;i++ ))
do
  . /home/vinod/OTHER_PERCE/Other_Stat.sh
done
awk -F'\t' -f /home/vinod/OTHER_PERCE/grt.awk  >> /home/vinod/OTHER_PERCE/week_$(date "+%Y-%m-%d" -d '+ 7day ago')_to_$(date "+%Y-%m-%d" -d '+ 1day ago')/Other_Percent_Sammary.out
awk -F'\t' -f /home/vinod/OTHER_PERCE/gl22.awk  /home/vinod/OTHER_PERCE/week_$(date "+%Y-%m-%d" -d '+ 7day ago')_to_$(date "+%Y-%m-%d" -d '+ 1day ago')/Others_Percent_Details.out | sort -n >>/home/vinod/OTHER_PERCE/week_$(date "+%Y-%m-%d" -d '+ 7day ago')_to_$(date "+%Y-%m-%d" -d '+ 1day ago')/Other_Percent_Sammary.out
awk -F'\t' '{print $2"\t"$6"\t"$10 }' /home/vinod/OTHER_PERCE/week_$(date "+%Y-%m-%d" -d '+ 7day ago')_to_$(date "+%Y-%m-%d" -d '+ 1day ago')/Others_Percent_Details.out | sort -n -k4 >>/home/vinod/OTHER_PERCE/week_$(date "+%Y-%m-%d" -d '+ 7day ago')_to_$(date "+%Y-%m-%d" -d '+ 1day ago')/Other_Percent_Dir.out
#awk 'BEGIN{printf "%-5s\t%-5s\t%-5s\t%-5s\t%-5s\t%-5s\t%-5s\t%-5s\t%-5s\n", "DATE","DIRECTORIES","ORGANIZATION", "CLIENT_TRANS_ID","ITYPE","INS_ID","TRANS_COUNT","OTHER_COUNT","OTHER_WITHOUT_CHEQUE_NUM,"per_cat";}'  >>/home/vinod/OTHER_PERCE/PerfiosInsight_Other_Percentage_week_upto_$d3/Others_Percent_$d.out



done</home/vinod/OTHER_PERCE/ldtemp1.out
