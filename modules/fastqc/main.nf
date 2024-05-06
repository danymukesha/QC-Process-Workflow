process FASTQC {

    tag { sample }

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("*_fastqc.{zip,html}")

    """
    fastqc -q ${reads}
    """
}
