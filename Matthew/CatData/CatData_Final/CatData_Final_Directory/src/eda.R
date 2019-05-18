setwd("~/Documents/Class/CatMathSpring/Matthew/CatData/CatData_Final/CatData_Final_Directory")
library('ProjectTemplate')
load.project()

for (dataset in project.info$data)
{
  message(paste('Showing top 5 rows of', dataset))
  print(head(get(dataset)))
}
