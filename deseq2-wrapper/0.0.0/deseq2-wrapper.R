#!/usr/bin/env Rscript
library(R2HTML)
library(DESeq2)

### OPTION PARSING
suppressPackageStartupMessages(library("optparse"))
option_list <- list(
    make_option(c("--factors", "-f")),
    make_option(c("--outdir",  "-o"))
)

opt <- parse_args(OptionParser(option_list=option_list),positional_arguments=T)

factor_names <- strsplit(opt$options$factors,",")[[1]]
nfactors <- length(factor_names)
outdir <- opt$options$outdir

sample_data <- strsplit(opt$args,",")
sample_files <- sapply(sample_data,function(x) x[nfactors + 1])
description <- as.data.frame(sapply(sample_data,function(x) x[1:nfactors]))
colnames(description) <- factor_names
rownames(description) <- NULL

### DATA PROCESSING
loadCounts <- function(sample_files) {
    loadFile <- function(fn) {
        d <- read.table(fn,header=F,sep='\t')
        d[1:(dim(d)[1] - 5),2]
    }
    sapply(sample_files,loadFile)
}

differentialAnalysis <- function(counts, description) {
    DESeq(DESeqDataSetFromMatrix(countData=counts,
                                 colData=description,
                                 design=as.formula(paste("~", paste(colnames(description),sep=" + ")))),
          fitType='local')
}

### OUTPUT
outputForAllCoeffs <- function(dds) {
    for(name in resultsNames(dds)) {
        fn <- paste(outdir,paste(name,"tsv",sep="."),sep='/')
        res <- results(dds,name=name)
        write.table(res,file=fn,row.names=F,sep='\t')
    }
}

html_li <- function(x) paste("<li>", x, "</li>")

html_ul <- function(xs) {
    paste(
        "<ul>", 
        sapply(xs, html_li),
        "</ul>"
    )
}

html_a <- function(href,text) {
    paste("<a href=",
          href,
          ">",
          text,
          "</a>")
}

html_append <- function(x) {
    cat(x,
        file = HTMLGetFile(),
        append = T,
        sep = ""
        )
}


htmlIndex <- function(dds) {
    HTMLStart(outdir=outdir, file="index", extension="html", echo=F, HTMLframe=F, Title="DESeq report")
    HTML.title("DESeq report", HR=1)
    HTML.title("Differentially expressed genes", HR=3)
    html_append(
        html_ul(sapply(resultsNames(dds), function(x) html_a(paste(x,"tsv",sep="."),x)))
    )
    HTMLStop()
}

main <- function() {
    counts <- loadCounts(sample_files)
    dds <- differentialAnalysis(counts, description)
    system(paste("mkdir -p", outdir))
    outputForAllCoeffs(dds)
    htmlIndex(dds)
}


main()
