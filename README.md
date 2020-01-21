# ![nf-core/nftest](docs/images/nf-core-nftest_logo.png)

read [this](https://apeltzer.github.io/post/01-aws-nfcore/) for AWS

**test **.

[![Build Status](https://travis-ci.com/nf-core/nftest.svg?branch=master)](https://travis-ci.com/nf-core/nftest)
[![Nextflow](https://img.shields.io/badge/nextflow-%E2%89%A519.04.0-brightgreen.svg)](https://www.nextflow.io/)

[![install with bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg)](http://bioconda.github.io/)
[![Docker](https://img.shields.io/docker/automated/nfcore/nftest.svg)](https://hub.docker.com/r/nfcore/nftest)

## Introduction

The pipeline is built using [Nextflow](https://www.nextflow.io), a workflow tool to run tasks across multiple compute infrastructures in a very portable manner. It comes with docker containers making installation trivial and results highly reproducible.

## Quick Start

i. Install [`nextflow`](https://nf-co.re/usage/installation)

ii. Install one of [`docker`](https://docs.docker.com/engine/installation/), [`singularity`](https://www.sylabs.io/guides/3.0/user-guide/) or [`conda`](https://conda.io/miniconda.html)

iii. Download the pipeline and test it on a minimal dataset with a single command

```bash
nextflow run ./  -profile test,<docker/singularity/conda>
```

iv. Start running your own analysis!

```bash
    nextflow run /nfs/code/ngs_variant_calling \
    --input input.tsv \
    --step <align,variantcalling> \
    --tools HaplotypeCaller \  # If variantcalling 
    --genome GRCh38 \
    -profile docker \
```

See [usage docs](docs/usage.md) for all of the available options when running the pipeline.

## Documentation

The stalicla/ngs_variant_calling pipeline comes with documentation about the pipeline, found in the `docs/` directory:

1. [Installation](https://nf-co.re/usage/installation)
2. Pipeline configuration
    * [Local installation](https://nf-co.re/usage/local_installation)
    * [Adding your own system config](https://nf-co.re/usage/adding_own_config)
    * [Reference genomes](https://nf-co.re/usage/reference_genomes)
3. [Running the pipeline](docs/usage.md)
4. [Output and how to interpret the results](docs/output.md)
5. [Troubleshooting](https://nf-co.re/usage/troubleshooting)

<!-- TODO nf-core: Add a brief overview of what the pipeline does and how it works -->

## Credits

This pipeline combines a subset of nf-core/Sarek pipeline with extra steps from GATK CNNFilterVariants


## Contributions and Support

If you would like to contribute to this pipeline, please see the [contributing guidelines](.github/CONTRIBUTING.md).

For further information or help, don't hesitate to get in touch on [Slack](https://nfcore.slack.com/channels/nf-core/nftest) (you can join with [this invite](https://nf-co.re/join/slack)).

## Citation

You can cite the `nf-core` pre-print as follows:  
Ewels PA, Peltzer A, Fillinger S, Alneberg JA, Patel H, Wilm A, Garcia MU, Di Tommaso P, Nahnsen S. **nf-core: Community curated bioinformatics pipelines**. *bioRxiv*. 2019. p. 610741. [doi: 10.1101/610741](https://www.biorxiv.org/content/10.1101/610741v1).
