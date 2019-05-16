setwd("~/Documents/Class/CatMathSpring/Matthew/CatData/HW_7/HW_7_directory")
library('ProjectTemplate')
load.project()

for (dataset in project.info$data)
{
  message(paste('Showing top 5 rows of', dataset))
  print(head(get(dataset)))
}
