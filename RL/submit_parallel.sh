#!bin/bash

for L in 12
do

for i in 2 # 1: cont actions; 2: bang-bang
do
	for k in $(seq 1 1 10) # of total ramp times
	do
		#for j in $(seq 1 1 10) # of random realisations
		#do

		echo "#!/bin/bash -login" >> submission.sh	
        	echo "#$ -t 1-10" >> submission.sh # job array loop over number of realisations
		echo "#$ -P fheating" >> submission.sh #evolve is name of job
 		echo "#$ -N jobRL_${L}_${i}_${k}_${SGE_TASK_ID}" >> submission.sh #evolve is name of job
		echo "#$ -l h_rt=12:00:00">> submission.sh #336
        	#echo "#$ -pe omp 4">> submission.sh #request more processors
        	echo "#$ -m ae" >> submission.sh #a (abort) e(exit)
        	#echo "#$-l mem_per_core=4G" >> submission.sh # more memory
        	#echo "#$ -M mbukov@bu.edu" >> submission.sh
        	echo "#$ -m n" >> submission.sh # disable emails
        	echo "source activate py27" >> submission.sh # requires conda env called 'ED' with quspin
        	echo "~/.conda/envs/py27/bin/python main_RL.py $i ${SGE_TASK_ID} $k $L" >> submission.sh
        
        	qsub submission.sh
        	rm submission.sh
        
        	sleep 1.0 #wait for half a second
	    
	    	#done

	done


done
done
