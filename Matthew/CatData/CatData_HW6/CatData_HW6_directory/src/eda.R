setwd("~/Documents/Class/CatMathSpring/Matthew/CatData/CatData_HW6/CatData_HW6_directory")
library('ProjectTemplate')
load.project()

for (dataset in project.info$data)
{
  message(paste('Showing top 5 rows of', dataset))
  print(head(get(dataset)))
}
