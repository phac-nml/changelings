# changelings: CHANGing of LINeaGes through time
## Reporting Pangolin COVID19 Lineage assignment changes through time: Compatible with pangolin v3 (pangoLEARN) and v4 (UShER or pangoLEARN).
The Pangolin lineage assignment of a sequence can sometimes change through time due to creation of new lineages, changes in the pangoLEARN models or UShER, etc.
The markdown file provided can be called to generate the Sankey visualization of changes in Pangolin lineage assignment through time using Google Visualization, and report changes in counts and proportions of lineages in an html report file. Note that this is for examining changes in lineage assignment specifically, and is not for demonstrating the total counts of samples through time. An example of the output is illustrated in the figure below.

<img src="scripts/output.png" alt="Output" width="1200"/>

### Usage in Windows:
  * Downloading the github project
  * Installation of packages in RStudio: install.packages(c("googleVis", "ggrepel","ggplot2","dplyr","grid","rmarkdown","here"), repos="http://cran.us.r-project.org")
  * See the changeLings_windows.r file as an example to call the markdown file to generate both the Sankey plot and document report 
  * Lineages of interest can be specified with the linFocus parameter to generate subsetted Sankey plots and changelings report.

### Usage in Linux: 
#### Environment setup on linux
```
conda create -y -n changelings -c conda-forge r-base pandoc r-stringi
conda activate changelings
R --vanilla
```
Install required packages in R
```
install.packages(c("googleVis", "ggrepel","ggplot2","dplyr","rmarkdown","openxlsx"), repos="http://cran.us.r-project.org")
```

#### A simplified run of changelings in Linux
Within your changelings directory, run the script on the example data under data folder to obtain the changelings of the last two runs (by default)
```
git clone https://github.com/phac-nml/changelings.git
conda activate changelings
Rscript scripts/changelings.r
```
Alternatively, specify to run the last five runs according to the dates in the folder name.
```
Rscript scripts/changelings.r 5
```
 
### Input: 
  See the data folder for examples of the data input format. The following parameters can be specified in scripts/changelings.r for customization.

  * inputDir = the folder that stores pangolin results (lineage_report.csv) from different runs in sub-folders in the "pangolin_analysis_year_month_day" format, additional characters after 'day' are skipped.

  * outputDir = the output direcotory, defaulted to be the latest pangolin prediction folder under inputDir
  
  * selectT = the indices of the runs to plot, all or a subset. See changelings.r or changelings_windows.r for examples.
  
  * typeselect = the corresponding output name for the selectT set
  
  * linFocus = specify the specific lineages to be examined or use NULL for all lineages
    + if you wanted to examine changes in all lineages within time points of interest, set linFocus = NULL 
    + if you only want to examine samples that have been assigned to specific lineages, set linFocus = c("AY.74","B.1.617.2","AY.45") for example. Names of output files will  trail with concatenated targeted lineages for identification
  
  * minSankeyPx, maxSankeyPx = minimum or maximum pixel in Sankey height, defaulted to be 400 or 5000, respectively
  
  * linheirfile = the file used to determine the state of change for the lineage pairs: eg. parent, child, siblings, etc. This file along it's info file require a continual update due to new lineage designations. Credit: Adrian Zetner.
  
### Output: 
   (Sample output can be viewed in data\pangolin_analysis_2021_11_17, which was used as the outputDir -- the latest pangolin result folder within the selected timeframe -- by default.)
  
  * changeLings_sankey_lastn.HTML: Sankey plot as partially illustrated in Figure A.
  
  * changeLings_report_lastn.html: Other analytical plots for proportion/count of changes and flagging lineages with changes. 
    + Scatter plot of consecutive assignment changes in counts versus percentage (Figure B). A binomial test was conducted per lineage to test for significant changes in assignment with the observed ratio set as 10%, followed by multiple hypothesis testing correction. The coloring reflects the significance. See the report for more information.
    + Bar plot and Pie chart showing at most top 50 pairs of lineage changes between two time points along with the change type (Figure C)
	
  * changeLings_lastn.xlsx: An Excel table listing the consecutive lineage changes and the corresponding frequency.
 
### Contact
Questions or comments can be directed to Julie Chih-yu Chen chih-yu.chenATphac-aspc.gc.ca

