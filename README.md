# mk-xhmm - pipeline to discover Copy Number Variants
### Abbreviations
**cnv**: copy number variants
**RD** Read depth as in Depth of coverage
**xhmm** exome hidden Markov model
**NGS** Next Generation Sequencing

## About mk-xhmm
  Copy number varaints are an important genetic component of human diseases. NGS exome or targeted sequencing are among the most commonly used startegies to detect CNVs. It involves detecting changes in the numbe of reads covering the target regions, i.e. changes in the Depth of Coverage (Fowler et al., 2016; Yamamoto et al., 2016). This method is implemented in the program xhmm  (Fromer et al., 2012; Fromer & Purcell, 2014), whch distinguishes copy number from asociated noise associated to RD. Xhmm uses PCA to find how RD varies in multiple samples, and removes the large effects, resulting in a rigurous normalization. After normalization, xhmm applies a hidden Markov Model to discover CNV's where an increase or reduction in RD implies a duplication or deletion. This pipeline automates CNV detection from a sequencing panel. The analysis starts with a BAM file to calculate read depth
 
## Pipeline configuration
   The pipeline is organized in four modules:
   
   001mk-calculate-coverage
   002mk-merge-coverage-center 
   003mk-PCA-Normalizing
   004-get-cnvs
 
### Data formats
 
  * Input data
  	* Sorted BAM file
  	* Reference genome with dictionary from picard 
  	* Parameter file
  	* Configuration file
  * Output data
  	* xcnv file with sample, region and type of cnv detected (i.e. deletion or duplication) plus quality information
  	* vcf file with sample genotypes
  	* multiple intermediate files with RD matrices at different stages of normalization and filtering
  
  
### Software dependencies
 
* [Picard tools](https://github.com/broadinstitute/picard "A set of command line tools in Java for manipulating HTS data.")
* [GATK](https://software.broadinstitute.org/gatk "Genome Analysis Toolkit")
* [xhmm](https://atgu.mgh.harvard.edu/xhmm/ "XHMM exome-Hidden Markov Model")
 
 
````

├── 001mk-calculate-coverage
│   ├── bin
│   │   └── create-targets
│   ├── config.mk
│   ├── data
│   │   └── sample1 -> /media/genomics/disco1/eugenia.bkp/data/cnv_map_files
│   ├── mkfile
│   ├── results
│   │   └── sample1
│   │       ├── CA158-1_S1.sample_interval_statistics
│   │       ├── CA158-1_S1.sample_interval_summary
│   │       ├── CA158-1_S1.sample_statistics
│   │       ├── CA158-1_S1.sample_summary
│   │       ├── CA168-1_S1.sample_interval_statistics
│   │       ├── CA168-1_S1.sample_interval_summary
│   │       ├── CA168-1_S1.sample_statistics
│   │       ├── CA168-1_S1.sample_summary
│   │       ├── CA168-2_S1.sample_interval_statistics
│   │       ├── CA168-2_S1.sample_interval_summary
│   │       ├── CA168-2_S1.sample_statistics
│   │       ├── CA168-2_S1.sample_summary
│   │       ├── CA168-4_S1.sample_interval_statistics
│   │       ├── CA168-4_S1.sample_interval_summary
│   │       ├── CA168-4_S1.sample_statistics
│   │       ├── CA168-4_S1.sample_summary
│   │       ├── CA202-1_S1.sample_interval_statistics
│   │       ├── CA202-1_S1.sample_interval_summary
│   │       ├── CA202-1_S1.sample_statistics
│   │       ├── CA202-1_S1.sample_summary
│   │       ├── CA211-1_S1.sample_interval_statistics
│   │       ├── CA211-1_S1.sample_interval_summary
│   │       ├── CA211-1_S1.sample_statistics
│   │       └── CA211-1_S1.sample_summary
│   └── test -> /media/genomics/disco1/eugenia.bkp/data/cnv_map_files
├── 002mk-merge-coverage-center
│   ├── bin
│   │   └── create-targets
│   ├── config.mk
│   ├── data -> ../001mk-calculate-coverage/results/
│   ├── mkfile
│   └── results
│       ├── sample1.centered
│       ├── sample1.centered.filtered_samples.txt
│       ├── sample1.centered.filtered_targets.txt
│       ├── sample1.RD.txt
│       └── sample1.sample_interval_summary.list
├── 003mk-PCA-Normalizing
│   ├── bin
│   │   └── create-targets
│   ├── config.mk
│   ├── data -> ../002mk-merge-coverage-center/results/
│   ├── mkfile
│   ├── results
│   │   ├── sample1.original.normal_filtered.txt
│   │   ├── sample1.PCA_normalized.num_removed_PC.txt
│   │   ├── sample1.PCA_normalized.txt
│   │   ├── sample1.RD_PCA.PC_LOADINGS.txt
│   │   ├── sample1.RD_PCA.PC_SD.txt
│   │   ├── sample1.RD_PCA.PC.txt
│   │   ├── sample1.zscores.PCA.filtered_samples.txt
│   │   ├── sample1.zscores.PCA.filtered_targets.txt
│   │   └── sample1.zscores.PCA.txt
│   └── test
│       ├── group1.filt_cent.RD.txt -> ../../03mk-filter_and_center/results/group1.filt_cent.RD.txt
│       ├── group1.filt_cent.RD.txt.filtered_samples.txt -> ../../03mk-filter_and_center/results/group1.filt_cent.RD.txt.filtered_samples.txt
│       └── group1.filt_cent.RD.txt.filtered_targets.txt -> ../../03mk-filter_and_center/results/group1.filt_cent.RD.txt.filtered_targets.txt
├── 004-get-cnvs
│   ├── bin
│   │   └── create-targets
│   ├── config.mk
│   ├── data -> ../003mk-PCA-Normalizing/results/
│   ├── mkfile
│   └── results
│       ├── sample1.aux_xcnv
│       ├── sample1.vcf
│       ├── sample1.xcnv
│       ├── sample1.xcnv.build.posteriors.DEL.txt
│       ├── sample1.xcnv.build.posteriors.DIP.txt
│       └── sample1.xcnv.build.posteriors.DUP.txt
├── params.txt
└── README.md

````
## References

(Fowler et al., 2016; Yamamoto et al., 2016). This method is implemented in the program xhmm  (Fromer et al., 2012; Fromer & Purcell, 2014)

* Fowler, A., Mahamdallie, S., Ruark, E., Seal, S., Ramsay, E., Clarke, M., … Rahman, N. (2016). Accurate clinical detection of exon copy number variants in a targeted NGS panel using DECoN. Wellcome Open Research, 1, 20. http://dx.doi.org/10.12688/wellcomeopenres.10069.1
* Fromer, M., Moran, J. L., Chambert, K., Banks, E., Bergen, S. E., Ruderfer, D. M., … Purcell, S. M. (2012). Discovery and Statistical Genotyping of Copy-Number Variation from Whole-Exome Sequencing Depth. The American Journal of Human Genetics, 91(4), 597–607. https://doi.org/10.1016/j.ajhg.2012.08.005
* Fromer, M., & Purcell, S. M. (2014). Using XHMM software to detect copy number variation in whole-exome sequencing data. Current Protocols in Human Genetics, 81, 7.23.1-7.23.21. https://doi.org/10.1002/0471142905.hg0723s81
 * Yamamoto, T., Shimojima, K., Ondo, Y., Imai, K., Chong, P. F., Kira, R., … Okamoto, N. (2016). Challenges in detecting genomic copy number aberrations using next-generation sequencing data and the eXome Hidden Markov Model: a clinical exome-first diagnostic approach. Human Genome Variation, 3, 16025. https://doi.org/10.1038/hgv.2016.25

### Author
Developed by [Eugenia Zarza](https://www.researchgate.net/profile/Eugenia_Zarza) (eugenia.zarza@gmail.com) for [Winter Genomics](http://www.wintergenomics.com/)