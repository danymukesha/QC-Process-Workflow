process SICKLE_PE {

    tag { sample }

    input:
    tuple val(sample), path(reads, stageAs: 'reads/*')

    output:
    tuple val(sample), path("*.trimmed.fastq.gz"), emit: trimmed
    tuple val(sample), path("${sample}.singles.fastq.gz"), emit: singles
    tuple val(sample), path("${sample}.log"), emit: log

    script:
    def (fq1, fq2) = reads

    """
    sickle pe \\
        -t sanger \\
        -g \\
        -f "${fq1}" \\
        -r "${fq2}" \\
        -o "${sample}_R1.trimmed.fastq.gz" \\
        -p "${sample}_R2.trimmed.fastq.gz" \\
        -s "${sample}.singles.fastq.gz" \\
        1> "${sample}.log"
    """
}
