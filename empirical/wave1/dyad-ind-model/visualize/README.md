## D3 network visualization


From Nick Kullman, QERM program: 

To make the visualization, we cloned an existing one and then manipulated it to our needs 
(we started [here](http://flowingdata.com/2012/08/02/how-to-make-an-interactive-network-visualization/). 

The CSVs looked like [this](https://github.com/nkullman/QERMCollaborations/blob/master/data/ecosystems_nodes.csv) (for nodes) and 
[this](https://github.com/nkullman/QERMCollaborations/blob/master/data/ecosystems_links.csv) (for links). 

Cole wrote the [R script](https://github.com/nkullman/QERMCollaborations/blob/master/data/create_data_files.R) (which used the jsonlite library) to convert those into the JSON files needed for the viz.
also copied below.

```r
## This script takes the .csv data files and creates the .JSON files that
## the visualization uses.
library('jsonlite')

## Assuming your WD is the data folder! The student nodes are used in each
## of the JSON files, appended to the specific nodes for that file.
student_nodes <- read.table("student_nodes.csv", header=TRUE, sep=",",
                            stringsAsFactors=FALSE)
for(ii in c("methods", "collaborations", "ecosystems")){
    nodes <- read.table(paste0(ii, "_nodes.csv"), header=TRUE, sep=",",
                        stringsAsFactors=FALSE)
    links <- read.table(paste0(ii, "_links.csv"), header=TRUE, sep=",",
                        stringsAsFactors=FALSE)
    ## Merge the nodes for each file, test for missing data, and then
    ## create json and write to file.
    nodes2 <- rbind(student_nodes, nodes)
    which.missing.ids <-
        which(!unique(unlist(links)) %in% unique(nodes2$id))
    if(length(which.missing.ids)>0)
      stop(paste(ii,"IDs in links not in nodes:",
        paste0(unique(unlist(links))[which.missing.ids], collapse=', ')))
    x <- c("{ \"nodes\":", toJSON(nodes2), ", \"links\":", toJSON(links), "}")
    write(x, file=paste0(ii, '.json'))
}
```


