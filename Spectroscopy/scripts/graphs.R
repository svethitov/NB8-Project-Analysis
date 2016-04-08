library(ggplot2)
library(reshape2)

gettingData <- function(file, separator = ";") {
  data <- read.csv(file, sep = separator)
  data <- data[complete.cases(data),]
  colnames(data) <- c("wl", seq(1, length(data) - 1, 1))
  numberColumns <- ncol(data)
  data$mean <- apply(data[c(-1)],1,mean)
  data$sd <- apply(data[seq(2,numberColumns,1)],1,sd)
  
  return(data)
}

subsetting <- function(data, label) {
  data <- data[c("wl", "mean","sd")]
  data$sample <- as.character(label)
  return(data)
}

data_ethanol <- gettingData("data/160408_TiO_NPs_in_EtOH.csv")
data_toluene <- gettingData("data/160408_TiO_NPs_in_Toluene.csv")

data_ethanol <- subsetting(data_ethanol, "Ethanol")
data_toluene <- subsetting(data_toluene, "Toluene")

data <- cbind(data_ethanol[c("mean","sd")], data_toluene[c("mean", "sd")])
