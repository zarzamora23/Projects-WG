#Path to xhmm executable
XHMM=/media/genomics/disco1/Programs/xhmm/statgen-xhmm/xhmm

#PATH to reference genome
REFERENCE=/media/genomics/disco2/Databases/genome_references/hg19/hg19.fa

#Value for variable 'QSOME' or 
#-t --discoverSomeQualThresh=DOUBLE
#                                Quality threshold for discovering a CNV in a 
#                                  sample  (default=`30')

QTHRESHOLD=30

#PARAMETERS Values for XHMM that will be added to the parameter file
# Here we show the default values
#1. Exome-wide CNV rate						1e-08
#2. Mean number of targets in CNV				6
#3. Mean distance between targets within CNV (in KB)		70
#4. Mean of DELETION z-score distribution			-3
#5. Standard deviation of DELETION z-score distribution		1
#6. Mean of DIPLOID z-score distribution			0
#7. Standard deviation of DIPLOID z-score distribution		1
#8. Mean of DUPLICATION z-score distribution			3
#9. Standard deviation of DUPLICATION z-score distribution	1

EXOME_CNV_RATE=1e-04
MEAN_CNV_TARGETS=2
MEAN_TARGET_DIsTANCE_KBs=35
MEAN_DEL_ZSCORE_DIST=-3
SD_DEL_ZSCORE_DIST=1
MEAN_DIP_ZSCORE_DIST=0
SD_DIP_ZSCORE_DIST=1
MEAN_DUP_ZSCORE_DIST=3
SD_DUP_ZSCORE_DIST=1

