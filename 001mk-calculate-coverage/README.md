# 001mk-calculate-coverage - module to calculate depth of read coverage
## About 001mk-calculate-coverage

mk module for calculating the depth of coverage for one BAM file at a time.
This is the first step to detect copy nomber variants (CNVs)
The script takes one sorted BAM file and calculates the depth of coverage with GATK.
 It also requires an interval file (*.bed) for the target loci or the exome, and a reference file with a piccard dictionary

## Module description

  This tool processes bam files to determine coverage at different levels of partitioning and aggregation. Coverage can be analyzed per locus, per interval, per gene, or in tota

## Pipeline configuration

### Data formats:

* Input
  	* One or more bam files (with proper headers) to be analyzed for coverage statistics
  	* Reference genome with picard dictionary
  
 * Output
	*  Tables pertaining to different coverage summaries. Suffix on the table files declares the contents:
		*  **_summary**: total, mean, median, quartiles, and threshold proportions, aggregated over all bases
		*  **_statistics**: coverage histograms (# locus with X coverage), aggregated over all bases
		* **_interval_statistics**: 2x2 table of # of intervals covered to >= X depth in >=Y samples
		*  **_interval_summary**: total, mean, median, quartiles, and threshold proportions, aggregated per interval
    
   
### Software dependencies
 
* [GATK](https://software.broadinstitute.org/gatk "Genome Analysis Toolkit")

## Configuration file

The config.mk file contains important information regarding executables and reference genome. Modify it if needed

_note_: Make sure there is a reference dictionary with the same root name and in the same location as the reference genome file 

## Module parameters

````bash
java -Xmx3072m -jar $GATK \
	#Assess sequence coverage by a wide array of metrics, partitioned by sample, read group, or library
                -T DepthOfCoverage \
	#Input BAM file
                -I $prereq \
	#Regions of interest
                -L $INTERVALS \
	#Path to reference genome - from config file
                -R $REFERENCE \
	#Type of read downsampling to employ at a given locus
                -dt BY_SAMPLE 
	#Target coverage threshold for downsampling to coverage
                -dcov 5000 
	#Set the minimum level of logging
                -l INFO 
	#Do not output depth of coverage at each base
                --omitDepthOutputAtEachBase 
	#Do not calculate per-sample per-depth counts of loci
                --omitLocusTable \
	#Minimum quality of bases to count towards depth
                --minBaseQuality 0 \
	#Minimum mapping quality of reads to count towards depth
               --minMappingQuality 20 \
	#Starting (left endpoint) and end (right endpoint) for granular binning
               --start 1 --stop 5000 \
	#Number of bins to use for granular binning
               --nBins 200 \
	#Include sites where the reference is N
                --includeRefNSites \
	#How should overlapping reads from the same fragment be handled?
                --countType COUNT_FRAGMENTS \
	#path to output files and prefix to be used
                -o results/$stem.build \
````

## mk-xhmm directory structure

.
├── bin
│   └── create-targets
├── config.mk
├── data
│   └── sample1 -> /media/genomics/disco1/eugenia.bkp/data/cnv_map_files
├── mkfile
├── results
│   └── sample1
│       ├── CA158-1_S1.sample_interval_statistics
│       ├── CA158-1_S1.sample_interval_summary
│       ├── CA158-1_S1.sample_statistics
│       ├── CA158-1_S1.sample_summary
│       ├── CA168-1_S1.sample_interval_statistics
│       ├── CA168-1_S1.sample_interval_summary
│       ├── CA168-1_S1.sample_statistics
│       ├── CA168-1_S1.sample_summary
│       ├── CA168-2_S1.sample_interval_statistics
│       ├── CA168-2_S1.sample_interval_summary
│       ├── CA168-2_S1.sample_statistics
│       ├── CA168-2_S1.sample_summary
│       ├── CA168-4_S1.sample_interval_statistics
│       ├── CA168-4_S1.sample_interval_summary
│       ├── CA168-4_S1.sample_statistics
│       ├── CA168-4_S1.sample_summary
│       ├── CA202-1_S1.sample_interval_statistics
│       ├── CA202-1_S1.sample_interval_summary
│       ├── CA202-1_S1.sample_statistics
│       ├── CA202-1_S1.sample_summary
│       ├── CA211-1_S1.sample_interval_statistics
│       ├── CA211-1_S1.sample_interval_summary
│       ├── CA211-1_S1.sample_statistics
│       └── CA211-1_S1.sample_summary
└── test -> /media/genomics/disco1/eugenia.bkp/data/cnv_map_files

## References

[GATK Depth of Coverage](https://software.broadinstitute.org/gatk/documentation/tooldocs/3.8-0/org_broadinstitute_gatk_tools_walkers_coverage_DepthOfCoverage.php)

[GATK Command line](https://software.broadinstitute.org/gatk/documentation/tooldocs/3.8-0/org_broadinstitute_gatk_engine_CommandLineGATK.php)

[xhmm tutorial](http://atgu.mgh.harvard.edu/xhmm/tutorial.shtml)


### Author
Developed by [Eugenia Zarza](https://www.researchgate.net/profile/Eugenia_Zarza) (eugenia.zarza@gmail.com) for [Winter Genomics](http://www.wintergenomics.com/)