# nf-core/sarek: Usage

## Table of contents

<!-- Install Atom plugin markdown-toc-auto for this ToC to auto-update on save -->
<!-- TOC START min:2 max:3 link:true asterisk:true update:true -->
* [Table of contents](#table-of-contents)
* [Introduction](#introduction)
* [Running the pipeline](#running-the-pipeline)
  * [Updating the pipeline](#updating-the-pipeline)
  * [Reproducibility](#reproducibility)
* [Main arguments](#main-arguments)
  * [`-profile`](#-profile)
  * [`--input`](#--input)
  * [`--annotateVCF`](#--annotatevcf)
  * [`--noGVCF`](#--nogvcf)
  * [`--skipQC`](#--skipqc)
  * [`--noReports`](#--noreports)
  * [`--nucleotidesPerSecond`](#--nucleotidespersecond)
  * [`--step`](#--step)
  * [`--tools`](#--tools)
  * [`--targetBED`](#--targetbed)
* [Reference genomes](#reference-genomes)
  * [`--genome` (using iGenomes)](#--genome-using-igenomes)
  * [`--bwaIndex`](#--bwaindex)
  * [`--dbsnp`](#--dbsnp)
  * [`--dbsnpIndex`](#--dbsnpindex)
  * [`--dict`](#--dict)
  * [`--fasta`](#--fasta)
  * [`--fastaFai`](#--fastafai)
  * [`--genomeDict`](#--genomedict)
  * [`--genomeFile`](#--genomefile)
  * [`--genomeIndex`](#--genomeindex)
  * [`--germlineResource`](#--germlineresource)
  * [`--germlineResourceIndex`](#--germlineresourceindex)
  * [`--intervals`](#--intervals)
  * [`--knownIndels`](#--knownindels)
  * [`--knownIndelsIndex`](#--knownindelsindex)
  * [`--pon`](#--pon)
  * [`--igenomesIgnore`](#--igenomesignore)
* [Job resources](#job-resources)
  * [Automatic resubmission](#automatic-resubmission)
  * [Custom resource requests](#custom-resource-requests)
* [AWS Batch specific parameters](#aws-batch-specific-parameters)
  * [`--awsqueue`](#--awsqueue)
  * [`--awsregion`](#--awsregion)
* [Other command line parameters](#other-command-line-parameters)
  * [`--outdir`](#--outdir)
  * [`--sequencing_center`](#--sequencing_center)
  * [`--email`](#--email)
  * [`-name`](#-name)
  * [`-resume`](#-resume)
  * [`-c`](#-c)
  * [`--custom_config_version`](#--custom_config_version)
  * [`--custom_config_base`](#--custom_config_base)
  * [`--max_memory`](#--max_memory)
  * [`--max_time`](#--max_time)
  * [`--max_cpus`](#--max_cpus)
  * [`--plaintext_email`](#--plaintext_email)
  * [`--monochrome_logs`](#--monochrome_logs)
  * [`--multiqc_config`](#--multiqc_config)
<!-- TOC END -->

## Introduction

Nextflow handles job submissions on SLURM or other environments, and supervises running the jobs.
Thus the Nextflow process must run until the pipeline is finished.
We recommend that you put the process running in the background through `screen` / `tmux` or similar tool.
Alternatively you can run nextflow within a cluster job submitted your job scheduler.

It is recommended to limit the Nextflow Java virtual machines memory.
We recommend adding the following line to your environment (typically in `~/.bashrc` or `~./bash_profile`):

```bash
NXF_OPTS='-Xms1g -Xmx4g'
```

## Running the pipeline

The typical command for running the pipeline is as follows:

```bash
nextflow run ngs_variant_calling --input sample.tsv -profile docker
```

This will launch the pipeline with the `docker` configuration profile.
See below for more information about profiles.

Note that the pipeline will create the following files in your working directory:

```bash
work            # Directory containing the nextflow working files
results         # Finished results (configurable, see below)
.nextflow_log   # Log file from Nextflow
# Other nextflow hidden files, eg. history of pipeline runs and old logs.
```

The nf-core/varcall pipeline comes with more documentation about running the pipeline, found in the `docs/` directory:
    * [Extra Documentation on variant calling](docs/variantcalling.md)
    

### Reproducibility

It's a good idea to specify a pipeline version when running the pipeline on your data.
This ensures that a specific version of the pipeline code and software are used when you run your pipeline.
If you keep using the same tag, you'll be running the same version of the pipeline, even if there have been changes to the code since.



## Main arguments

### `-profile`

Use this parameter to choose a configuration profile.
Profiles can give configuration presets for different compute environments.
Note that multiple profiles can be loaded, for example: `-profile docker` - the order of arguments is important!

If `-profile` is not specified at all the pipeline will be run locally and expects all software to be installed and available on the `PATH`.

* `awsbatch`
  * A generic configuration profile to be used with AWS Batch.
* `conda`
  * A generic configuration profile to be used with [conda](https://conda.io/docs/)
  * Pulls most software from [Bioconda](https://bioconda.github.io/)
* `docker`
  * A generic configuration profile to be used with [Docker](http://docker.com/)
  * Pulls software from dockerhub: [`nfcore/sarek`](http://hub.docker.com/r/nfcore/sarek/)
* `singularity`
  * A generic configuration profile to be used with [Singularity](http://singularity.lbl.gov/)
  * Pulls software from DockerHub: [`nfcore/sarek`](http://hub.docker.com/r/nfcore/sarek/)
* `test`
  * A profile with a complete configuration for automated testing
  * Includes links to test data so needs no other parameters

### `--input`

Use this to specify the location of your input TSV file, on `mapping`, `recalibrate` and `variantcalling` steps.
For example:

```bash
--input sample.tsv
```

Multiple TSV files can be specified if the path must be enclosed in quotes

Use this to specify the location to a directory on `mapping` step with a single germline sample only.
For example:

```bash
--input PathToDirectory
```

Use this to specify the location of your VCF input file on `annotate` step.
For example:

```bash
--input sample.vcf
```

Multiple VCF files can be specified if the path must be enclosed in quotes

```


### `--noGVCF`

Use this to disable g.vcf from `HaplotypeCaller`.

### `--skipQC`

Use this to disable specific QC and Reporting tools.
Available: `all`, `bamQC`, `BCFtools`, `FastQC`, `MultiQC`, `samtools`, `vcftools`, `versions`
Default: `None`


### `--nucleotidesPerSecond`

Use this to estimate of how many seconds it will take to call variants on any interval, the default value is `1000` is it's not specified in the `<intervals>.bed` file.

### `--step`

Use this to specify the starting step:
Default `mapping`
Available: `mapping`, `recalibrate`, `variantcalling` 

### `--tools`

Use this to specify the tools to run:
Available:  `HaplotypeCaller`

### `--targetBED`

Use this to specify the target BED file for targeted or whole exome sequencing.

## Reference genomes

The pipeline config files come bundled with paths to the illumina iGenomes reference index files.
If running with docker or AWS, the configuration is set up to use the [AWS-iGenomes](https://ewels.github.io/AWS-iGenomes/) resource.


### `--genome` (using iGenomes)

There are 2 different species supported by Varcall in the iGenomes references.
To run the pipeline, you must specify which to use with the `--genome` flag.

You can find the keys to specify the genomes in the [iGenomes config file](../conf/igenomes.config).
Genomes that are supported are:

* Human
  * `--genome GRCh37`
  * `--genome GRCh38`

Note that you can use the same configuration setup to save sets of reference files for your own use, even if they are not part of the iGenomes resource.
See the [Nextflow documentation](https://www.nextflow.io/docs/latest/config.html) for instructions on where to save such a file.

The syntax for this reference configuration is as follows:

```nextflow
params {
  genomes {
    'GRCh38' {
      bwaIndex         = '<path to the bwa indexes>'
      dbsnp            = '<path to the dbsnp file>'
      dbsnpIndex       = '<path to the dbsnp index>'
      dict             = '<path to the dict file>'
      fasta            = '<path to the fasta file>'
      fastaFai         = '<path to the fasta index>'
      intervals        = '<path to the intervals file>'
      knownIndels      = '<path to the knownIndels file>'
      knownIndelsIndex = '<path to the knownIndels index>'
      hapmap           = '<path to the hapmap index>'
      hapmapIndex      = '<path to the hapmapIndex index>'
      onekg            = '<path to the onekg index>'
      onekgIndex       = '<path to the onekgIndex index>'
      mills            = '<path to the mills index>'
      millsIndex       = '<path to the millsIndex index>'

    }
    // Any number of additional genomes, key is used with --genome
  }
}
```


### `--bwaIndex`

If you prefer, you can specify the full path to your reference genome when you run the pipeline:

```bash
--bwaIndex '[path to the bwa indexes]'
```

### `--chrDir`

If you prefer, you can specify the full path to your reference genome when you run the pipeline:

```bash
--chrDir '[path to the Chromosomes folder]'
```

### `--chrLength`

If you prefer, you can specify the full path to your reference genome when you run the pipeline:

```bash
--chrLength '[path to the Chromosomes length file]'
```

### `--dbsnp`

If you prefer, you can specify the full path to your reference genome when you run the pipeline:

```bash
--dbsnp '[path to the dbsnp file]'
```

### `--dbsnpIndex`

If you prefer, you can specify the full path to your reference genome when you run the pipeline:

```bash
--dbsnpIndex '[path to the dbsnp index]'
```

### `--dict`

If you prefer, you can specify the full path to your reference genome when you run the pipeline:

```bash
--dict '[path to the dict file]'
```

### `--fasta`

If you prefer, you can specify the full path to your reference genome when you run the pipeline:

```bash
--fasta '[path to the reference fasta file]'
```

### `--fastaFai`

If you prefer, you can specify the full path to your reference genome when you run the pipeline:

```bash
--fastaFai '[path to the reference index]'
```


### `--germlineResource`

The [germline resource VCF file](https://software.broadinstitute.org/gatk/documentation/tooldocs/current/org_broadinstitute_hellbender_tools_walkers_mutect_Mutect2.php#--germline-resource) (bgzipped and tabixed) needed by GATK4 Mutect2 is a collection of calls that are likely present in the sample, with allele frequencies.
The AF info field must be present.
You can find a smaller, stripped gnomAD VCF file (most of the annotation is removed and only calls signed by PASS are stored) in the iGenomes Annotation/GermlineResource folder.
To add your own germline resource supply

```bash
--germlineResource '[path to my resource.vcf.gz]'
```

### `--germlineResourceIndex`

Tabix index of the germline resource specified at [`--germlineResource`](#--germlineResource).
To add your own germline resource supply

```bash
--germlineResourceIndex '[path to my resource.vcf.gz.idx]'
```

### `--intervals`

If you prefer, you can specify the full path to your reference genome when you run the pipeline:

```bash
--intervals '[path to the intervals file]'
```

### `--knownIndels`

If you prefer, you can specify the full path to your reference genome when you run the pipeline:

```bash
--knownIndels '[path to the knownIndels file]'
```

### `--knownIndelsIndex`

If you prefer, you can specify the full path to your reference genome when you run the pipeline:

```bash
--knownIndelsIndex '[path to the knownIndels index]'
```

### `--igenomesIgnore`

Do not load `igenomes.config` when running the pipeline.
You may choose this option if you observe clashes between custom parameters and those supplied in `igenomes.config`.

## Job resources

### Automatic resubmission

Each step in the pipeline has a default set of requirements for number of CPUs, memory and time.
For most of the steps in the pipeline, if the job exits with an error code of `143` (exceeded requested resources) it will automatically resubmit with higher requests (2 x original, then 3 x original).
If it still fails after three times then the pipeline is stopped.

## AWS Batch specific parameters

Running the pipeline on AWS Batch requires a couple of specific parameters to be set according to your AWS Batch configuration.
Please use the `-awsbatch` profile and then specify all of the following parameters.

### `--awsqueue`

The JobQueue that you intend to use on AWS Batch.

### `--awsregion`

The AWS region to run your job in.
Default is set to `eu-west-1` but can be adjusted to your needs.

Please make sure to also set the `-w/--work-dir` and `--outdir` parameters to a S3 storage bucket of your choice - you'll get an error message notifying you if you didn't.

## Other command line parameters

### `--outdir`

The output directory where the results will be saved.
Default: `results/

### `--sequencing_center`

The sequencing center that will be used in the BAM CN field

### `--email`

Set this parameter to your e-mail address to get a summary e-mail with details of the run sent to you when the workflow exits.
If set in your user config file (`~/.nextflow/config`) then you don't need to specify this on the command line for every run.

### `-name`

Name for the pipeline run.
If not specified, Nextflow will automatically generate a random mnemonic.

This is used in the MultiQC report (if not default) and in the summary HTML / e-mail (always).

**NB:** Single hyphen (core Nextflow option)

### `-resume`

Specify this when restarting a pipeline.
Nextflow will used cached results from any pipeline steps where the inputs are the same, continuing from where it got to previously.

You can also supply a run name to resume a specific run: `-resume [run-name]`.
Use the `nextflow log` command to show previous run names.

**NB:** Single hyphen (core Nextflow option)  <-- Problematic for tower-resume use because the name must be unique 

### `-c`

Specify the path to a specific config file (this is a core NextFlow command).

**NB:** Single hyphen (core Nextflow option)

Note - you can use this to override pipeline defaults.

### `--max_memory`

Use to set a top-limit for the default memory requirement for each process.
Should be a string in the format integer-unit eg. `--max_memory '8.GB'`

### `--max_time`

Use to set a top-limit for the default time requirement for each process.
Should be a string in the format integer-unit eg. `--max_time '2.h'`

### `--max_cpus`

Use to set a top-limit for the default CPU requirement for each process.
Should be a string in the format integer-unit eg. `--max_cpus 1`

### `--plaintext_email`

Set to receive plain-text e-mails instead of HTML formatted.

### `--monochrome_logs`

Set to disable colourful command line output and live life in monochrome.

### `--multiqc_config`

Specify a path to a custom MultiQC configuration file.
