#sed '/^$/d' lastday.out
#sed '/^$/d' ls.out

tail -n 1 /home/vinod/OTHER_PERCE/lastday.out >/home/vinod/OTHER_PERCE/ldtemp.out
while read a
	do
		d=$(date '+%Y-%m-%d' -d "$a + day" )
		d2=$(date '+%d-%m-%Y' -d "$a + day" )
                #d3=$(date '+%Y-%m-%d' -d "$a + 7day" )
	done</home/vinod/OTHER_PERCE/ldtemp.out
echo $('date' -d "$d" '+%Y-%m-%d %H:%M:%S') >>/home/vinod/OTHER_PERCE/ls.out
echo "$d" >> /home/vinod/OTHER_PERCE/lastday.out
rm /home/vinod/OTHER_PERCE/ldtemp.out

d4=$(date "+%Y-%m-%d" -d '+ 1day ago')
d3=$(date "+%Y-%m-%d" -d '+ 7day ago')
#mkdir -p /home/vinod/OTHER_PERCE/PerfiosInsight_Other_Percentage_week_$d3_$d4
mkdir -p /home/vinod/OTHER_PERCE/week_$(date "+%Y-%m-%d" -d '+ 7day ago')_to_$(date "+%Y-%m-%d" -d '+ 1day ago')

#d=$1
#d2=$2

#echo The last date run is "$1" >> /home/ram3_complete/last_date.log

>/home/vinod/OTHER_PERCE/k1.log
>/home/vinod/OTHER_PERCE/k2.log
>/home/vinod/OTHER_PERCE/k3.log
#>final.out
cd /media/panda/kubera*
sed -e '/analyzeKL("Icici*/!d' $(pwd)/kubera.$d2.log >>/home/vinod/OTHER_PERCE/k1.log
sed -e 's/.*("\([A-Za-z]*\)", "\([0-9]*\)")/\1\t\2/g' /home/vinod/OTHER_PERCE/k1.log >>/home/vinod/OTHER_PERCE/k2.log

awk -F'\t' '{ print $2 }' /home/vinod/OTHER_PERCE/k2.log >>/home/vinod/OTHER_PERCE/k3.log 
#awk -F'\t' 'FNR == 1{ print $1 }' k2.log >>org.out 

#awk 'BEGIN{printf "%-5s\t%-5s\t%-5s\t%-5s\t%-5s\t%-5s\t%-5s\t%-5s\t%-5s\n", "DATE","DIRECTORIES","ORGANIZATION", "CLIENT_TRANS_ID","ITYPE","INS_ID","TRANS_COUNT","OTHER_COUNT","OTHER_WITHOUT_CHEQUE_NUM,"per_cat";}'  >>/home/vinod/OTHER_PERCE/PerfiosInsight_Other_Percentage_week_upto_$d3/Others_Percent_$d.out

cd /home/vinod/OTHER_PERCE
while read line 
do 
	l="${line}"
	#echo $l
	#echo $d
	#echo $d2

	cd /media/panda/appserver-data/$d*


	sed -e 's/\t\t/\tNA\t/g' /media/panda/appserver-data/$d*/$line/xns1.out >> /home/vinod/OTHER_PERCE/xns.out

	awk -F'\t' '$NF == "Others"{ ++i
if ($2 == "NA")
{ j++
}

 }
	END{ printf "%s\t%s\t%s\t",FNR,i,j;
	if ( FNR != 0 )
		{
			printf "%s\n", i/FNR }
		else
			printf "%s\n","0"}' /home/vinod/OTHER_PERCE/xns.out >> /home/vinod/OTHER_PERCE/x.out




			sed -i -e '/^$/d' /home/vinod/OTHER_PERCE/x.out
			#awk -F'\t' 'END{ print FNR }' /home/ram3_complete/xns.out >>x.out



			awk -F'\t' 'FNR!=1{print $12}' /media/panda/appserver-data/$d*/$line/personal.dat >>/home/vinod/OTHER_PERCE/p.out
			sed -i -e '/^$/d' /home/vinod/OTHER_PERCE/p.out
			awk -F'\t'  'FNR!=1{print $1,"\t",$3}' /media/panda/appserver-data/$d*/$line/summary.dat >> /home/vinod/OTHER_PERCE/s.out
			sed -i -e '/^$/d' /home/vinod/OTHER_PERCE/s.out

			echo -e -n $d2"\t"$PWD'\'${line} >> /home/vinod/OTHER_PERCE/date_dir.out

			sed -i -e '/^$/d' /home/vinod/OTHER_PERCE/date_dir.out

			awk -F'\t' 'FNR == 1{print $1}' /home/vinod/OTHER_PERCE/k2.log >> /home/vinod/OTHER_PERCE/ins_name.out
			sed -i -e '/^$/d' /home/vinod/OTHER_PERCE/ins_name.out
			#cd /home/ram3_complete/ram_3
			#awk -f /home/ram3_complete/r.awk /home/sample.log >> /home/final.out
			awk -f /home/vinod/OTHER_PERCE/r.awk /home/vinod/OTHER_PERCE/k4.log >>/home/vinod/OTHER_PERCE/final0.out
			sort -u  /home/vinod/OTHER_PERCE/final0.out >> /home/vinod/OTHER_PERCE/final1.out

			sed -e 's/\/media\/panda\/appserver-data\///g' /home/vinod/OTHER_PERCE/final1.out >>/home/vinod/OTHER_PERCE/final2.out
			sort -u  /home/vinod/OTHER_PERCE/final2.out >> /home/vinod/OTHER_PERCE/week_$(date "+%Y-%m-%d" -d '+ 7day ago')_to_$(date "+%Y-%m-%d" -d '+ 1day ago')/Others_Percent_Details.out
                       sed -i -e 's/\t\t/\t0\t/g' /home/vinod/OTHER_PERCE/week_$(date "+%Y-%m-%d" -d '+ 7day ago')_to_$(date "+%Y-%m-%d" -d '+ 1day ago')/Others_Percent_Details.out

			rm /home/vinod/OTHER_PERCE/date_dir.out
			rm /home/vinod/OTHER_PERCE/ins_name.out
			rm /home/vinod/OTHER_PERCE/s.out
			rm /home/vinod/OTHER_PERCE/p.out
			rm /home/vinod/OTHER_PERCE/xns.out
			 rm /home/vinod/OTHER_PERCE/x.out
			 rm /home/vinod/OTHER_PERCE/final0.out
			 rm /home/vinod/OTHER_PERCE/final1.out
			  rm /home/vinod/OTHER_PERCE/final2.out
		done </home/vinod/OTHER_PERCE/k3.log


		rm /home/vinod/OTHER_PERCE/k1.log
	          rm /home/vinod/OTHER_PERCE/k3.log
		rm /home/vinod/OTHER_PERCE/k2.log
		#awk -F'\t' -f /home/vinod/OTHER_PERCE/grt.awk  >> /home/vinod/OTHER_PERCE/PerfiosInsight_Other_Percentage_week_$d4_$d3/Other_Percent_stat.out
		#awk -F'\t' -f /home/vinod/OTHER_PERCE/gl22.awk  /home/vinod/OTHER_PERCE/PerfiosInsight_Other_Percentage_week_$d4_$d3/Others_Percent.out | sort -n >>/home/vinod/OTHER_PERCE/PerfiosInsight_Other_Percentage_week_$d4_$d3/Other_Percent_stat.out
