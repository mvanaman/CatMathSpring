setwd("~/Documents/Class/CatMathSpring/Matthew/Math/Math_HW6/Math_HW6_directory")
library('ProjectTemplate')
load.project()

for (dataset in project.info$data)
{
  message(paste('Showing top 5 rows of', dataset))
  print(head(get(dataset)))
}
