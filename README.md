# 🧬A snakemake pipline-- quantify hERV, transgenes and genome from 10x scRNAseq

> 💡 **Tip: [Please find **👉 MY BLOG** for an introduction to the project, along with the detailed mathematical and biological reasoning behind the code in this repository.](https://myhugoblog)**


## 📑 Table of Contents
- [📘 Introduction & Reasoning](#-introduction--reasoning-complete-version-is-here)
- [💡 Usage Example](#-usage-example)
  - [💻 LSF Scheduler on High-performance Cluster](#-lsf-scheduler-on-high-performance-cluster)
    - [1. Configure LSF Parameters and Working Directory](#1-configure-lsf-parameters-and-working-directory)
    - [2. Wrangle File Input](#2-wrangle-file-input)
    - [3. Other Parameters](#3-other-parameters)
    - [4. Output File](#4-output-file)
  - [🧾 Other Usage Examples](#-other-usage-examples)

## 📘Introduction & Reasoning (complete version is [here](myhugoblod))

Briefly, we use `Starsolo` to quantify the hERV and transgenes from 10x single-cell RNAseq because
- **EM algorithm implenmented**: EM algorithm is advantageous in dealing with  multimaping, which is commonly seen for hERV and transgene quantification. Specifically, EM is mathmatically well suitable for estimating parameters in Gaussian Mixture Models, which is similar to the model describing multimapping
- **"Compatibility with CellRanger"**: Star is the foundation of alignment in CellRanger and Starsolo produces nearly identical gene counts in the same format as the 10x CellRanger, which matters! While CellRanger is not a gold standard, a substantial and growing body of biological interpretations is derived from data processed by it. Aligning with CellRanger enables more meaningful comparisons with such datasets. This is particularly crucial when data integration is required, as no current method can fully correct for technical artifacts without distorting true biological signals.

The github repo also contains usage examples as described below.

## 💡usage example

### 💻 Snakemake schedules and executes Multiple Jobs on clusters using SLURM

We need first set up profile as demonstrated in [Snakemake documents](https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles). Then specify below SLURM parameters in a bash file as [example](https://github.com/jliu678/snakemake-pipline_quantify-hERV-trangene_10x-scRNAseq/blob/main/run_snakemake_multi_jobs_10xScRNAseq.slurm)

```bash
#!/bin/bash

#SBATCH --partition=long
#SBATCH --job-name=snakemake_multi
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=2
#SBATCH --mem=10G
#SBATCH --output=/data/wanglab_mgberis/_OUT.%x.%j
#SBATCH --error=/data/wanglab_mgberis/_ERR.%x.%j
#SBATCH --mail-type=begin
#SBATCH --mail-type=end

# sometimes slurm cannot communicate between different nodes, and failed.
# Better to run the below on login node, probably without sourcing user bashrc

#   mamba activate snakemake
source /PHShome/${USER}/.bashrc
conda activate snakemake

#   Load a suitable module for snakemake
module load STAR

code_dir=/data/mgberis/snakemake_10x
#   cd
mkdir /data/wanglab_mgberis/tmp
cd /data/wanglab_mgberis/tmp

#   run snakemake calling slurm
#snakemake --configfile ${code_dir}/config_10x5p.yaml --snakefile ${code_dir}/Snakefile_10x5prime --slurm --profile slurm --default-resources slurm_partition=bigmem
snakemake --configfile ${code_dir}/config_10x3v2or3.yaml --snakefile ${code_dir}/Snakefile_10x3primev2or3 --slurm --profile slurm --default-resources slurm_partition=bigmem
```

### 🧾 Snakemake executing on one job in clusters using SLURM

Please see exmaple [here](https://github.com/jliu678/snakemake-pipline_quantify-hERV-trangene_10x-scRNAseq/edit/main/run_snakemake_single_job_10xScRNAseq.slurm)
