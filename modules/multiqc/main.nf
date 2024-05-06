process MULTIQC {

    input:
    path 'logs/*'
    path config

    output:
    path "multiqc_report.html", emit: html
    path "multiqc_data", emit: data

    """
    multiqc \\
        --config "${config}" \\
        .
    """
}
