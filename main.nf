params.datadir = "$launchDir/data"
params.outdir = "$launchDir/results"
params.reads = "${params.datadir}/*_R{1,2}.fastq.gz"
params.multiqc_config = './assets/multiqc_config.yaml'

include { FASTQC as FASTQC_RAW } from './modules/fastqc'
include { FASTQC as FASTQC_TRIMMED } from './modules/fastqc'
include { SICKLE_PE } from './modules/sickle'
include { MULTIQC } from './modules/multiqc'


workflow {

    reads = Channel.fromFilePairs( params.reads )

    multiqc_config = file( params.multiqc_config )

    FASTQC_RAW( reads )
    SICKLE_PE( reads )
    FASTQC_TRIMMED( SICKLE_PE.out.trimmed )

    Channel.empty()
        .mix( FASTQC_RAW.out )
        .mix( SICKLE_PE.out.log )
        .mix( FASTQC_TRIMMED.out )
        .map { sample, files -> files }
        .collect()
        .set { log_files }

    MULTIQC( log_files, multiqc_config )
}
