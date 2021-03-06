#!/usr/bin/env Rscript
# author: mdijkstra
# version: 19mar12
# modified: 20140130
# modified by: mdijkstra

debug = F
library(stringr)

# Set the location of this .R script as	work dir!
getMyLocation = function()
{
        thisfile = NULL
        # This file may be 'sourced'
    for (i in -(1:sys.nframe())) {
      if (identical(sys.function(i), base::source)) thisfile = (normalizePath(sys.frame(i)$ofile))
    }

    if (!is.null(thisfile)) return(dirname(thisfile))

    # But it may also be called from the command line
    cmdArgs <- commandArgs(trailingOnly = FALSE)
    cmdArgsTrailing <- commandArgs(trailingOnly = TRUE)
    cmdArgs <- cmdArgs[seq.int(from=1, length.out=length(cmdArgs) - length(cmdArgsTrailing))]
    res <- gsub("^(?:--file=(.*)|.*)$", "\\1", cmdArgs)

    # If multiple --file arguments are given, R uses the last one
    res <- tail(res[res != ""], 1)
    if (length(res) > 0) return(dirname(res))

    # Both are not the case. Maybe we are in an R GUI?
    return(NULL)
}
if (!is.null(getMyLocation())) setwd(getMyLocation())


source('readCommandLineArgs.R')
source('createSNPTableFunctions.R')

# type table
write(mat2Latex(addHeader(readTables(type), sample),'Functional type'), typetableout)

# class table
write(mat2Latex(addHeader(readTables(class), sample),'Functional class'), classtableout) 

# impact table
write(mat2Latex(addHeader(readTables(impact), sample),'Functional impact'), impacttableout)