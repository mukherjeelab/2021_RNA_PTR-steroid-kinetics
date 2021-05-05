#! /usr/bin/env bash
#BSUB -n 12 # 
#BSUB -J salmon[1-6]  # job name
#BSUB -R "select[mem>50] rusage[mem=50] span[hosts=1]" 
#BSUB -o logs/salmon_quant_%J.out # write logs with jobnumber appended
#BSUB -e logs/salmon_quant_%J.err # write err logs with jobnumber appended
#BSUB -q rna   # use rna queue (suggested queue)

#just run on t=0 samples
FQS=(
UO_AH_158
UO_AH_159
UO_AH_160
UO_AH_161
UO_AH_162
UO_AH_163
)

# Example bsub script used to quantify transcript abundance with salmon

FQ=${FQS[$(($LSB_JOBINDEX - 1))]}
OUTDIR="salmon_2020_04"
IDX="~neellab/genomes/human/hg38/indices/salmon_extras/gencodev26.primaryTx_rRNA_ERCC"
SALMON="~neellab/genomes/human/hg38/indices/salmon-latest_linux_x86_64/bin/salmon"


mkdir -p $OUTDIR"/"$FQ

r1="~neellab/projects/invitroSteroid/data/fastq/dedup/"$FQ"_R1.fastq.gz"
r2="~neellab/projects/invitroSteroid/data/fastq/dedup/"$FQ"_R2.fastq.gz"

$SALMON quant \
    -i $IDX \
    -l A \
    -p 12 \
    -1 $r1 \
    -2 $r2 \
    --allowDovetail \
    --validateMappings \
    -o $OUTDIR"/"$FQ"/quant" 

