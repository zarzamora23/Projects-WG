# mk-create_picard_dict - module to create a sequence dictionaty

## About mk-create_picard_dict
This module implements the CreateSequenceDictionary command to create a sequence dictionary for a reference sequence.

The dictionary is needed by GATK to calculate depth of coverage

## Pipeline configuration

### Data formats:

* Input data

 Reference genome sequence in Fasta format. The reference sequence can be gzipped (both .fasta and .fasta.gz are supported).

* Output data

 A file with ".dict" extension. The output file contains a header but no SAMRecords, and the header contains only sequence records.

### Software dependencies:

* [Picard tools](https://github.com/broadinstitute/picard "A set of command line tools in Java for manipulating HTS data.")

### Module parameters

java -jar picard.jar CreateSequenceDictionary \ 
      R=$prereq \ -> Path to reference genomes directory 
      O=$target \ -> Path to reference genomes directory. GATK requires that the reference and the dictionary are in the same directory

## mk-create_picard_dict directory structure
      