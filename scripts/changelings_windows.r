######################
### To generate Sankey and the HTML output from the R markdown file
### This script calls the COVID19_assignmentThroughTime_report.Rmd to generate both the sankey and html report
### Please refer to the input settings in the Rmd file
#####################

library(rmarkdown)
require(googleVis)
require(ggplot2)
require(ggrepel)
require(dplyr)
require(openxlsx)
require(here)

########
### Set your own input directory, example data is in the data folder
########
inputDir=here("data")

########
### lineage heirarchy file from Adrian Zetner, using one version as an example
########
linheirfile=here("data","lineage-hierarchy.csv")

########
## Acquiring folder names of pangolin results under the specified inputDir
## Example folder names start with the string "pangolin_analysis" followed by the _year_month_day
########
folderString="pangolin_analysis_" ## The folder name pattern for identification, and to be removed for label later on
timev<-dir(inputDir,pattern=folderString)
timevclean<-substr(gsub(paste0(folderString,"20"),"",timev),1,8) ## narrowing down to the last two digits of year, month_day
print(timevclean)

## should there be two runs on the same day, chose the later one by default
repDates<-names(which(table(timevclean)>1))
if(length(repDates)>0){
	toskip<-sapply(repDates,function(y){ tmp<-which(y==timevclean);tmp[-length(tmp)]})
	timev<-timev[-toskip]
	timevclean<-timevclean[-toskip]
}


########
### select the subset of data to compare: choose one of the following, last5 is chosen by default
########
#selectT<-1:length(timev); typeselect="" # Plot all time points within the inputDir folder, no filter
#selectT<-sort(c(1,4,6,10,13,15,23)); typeselect="sampled" ## select a sub-sample
lastn=5 ## select the last n time points
selectT <- (length(timev)-(lastn-1)):length(timev); typeselect=paste0("last",lastn) 



########
## By default: the output directory is the latest pangolin output folder within your selected runs through name sorting
## You can set your own
########
outputDir=here(inputDir,tail(timev[selectT],1))



########
## You can choosing to show all lineages or a subset of lineages that had changes
########
# all
linFocus <- NULL;linFocusName=""
# Subset: If you only want to examine samples that have been assigned to a subset of lineages at time points selected. Use the script below
#linFocus <- c("AY.74","B.1.617.2","AY.45"); linFocusName=paste0("_",paste(linFocus,collapse="_"))


### maximum Sankey pixel in height
minSankeyPx=400 ## min 400px, modify if plot is too squished
maxSankeyPx=5000 ## max 5000px, otherwise it's too long.



########
### run the Rmd file, saving both sankey plot and the html report in the output directory
### Please note the report is meant for all lineages and not a subset of lineages. When running a lineage subset, the html report file name has the lineages added to it.
########
render(here("scripts","COVID19_assignmentThroughTime_report.Rmd"),output_file=paste0("changeLings_report_",typeselect,linFocusName,".html"), output_dir = outputDir, params = list(output_dir = outputDir))

