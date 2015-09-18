data <- read.table("./damage_neighbor_yield.dsv", sep="|", header=TRUE)
f1 <- data[2:4]

f1$log.yield <- logf1$PLANT_YIELD)

f1$log.neighbor<- log(f1$NEIGHBOR_YIELD)
plot(f1)
