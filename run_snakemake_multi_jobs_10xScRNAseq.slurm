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

code_dir=/data/wanglab_mgberis/siyi2023summer_snakemake_10x
#   cd
mkdir /data/wanglab_mgberis/tmp
cd /data/wanglab_mgberis/tmp

#   run snakemake calling slurm
#snakemake --configfile ${code_dir}/config_10x5p.yaml --snakefile ${code_dir}/Snakefile_10x5prime --slurm --profile slurm --default-resources slurm_partition=bigmem
snakemake --configfile ${code_dir}/config_10x3v2or3.yaml --snakefile ${code_dir}/Snakefile_10x3primev2or3 --slurm --profile slurm --default-resources slurm_partition=bigmem
