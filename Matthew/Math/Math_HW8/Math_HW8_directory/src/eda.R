setwd("~/Documents/Class/CatMathSpring/Matthew/Math/Math_HW8/Math_HW8_directory")
library('ProjectTemplate')
load.project()

for (dataset in project.info$data)
{
  message(paste('Showing top 5 rows of', dataset))
  print(head(get(dataset)))
}
