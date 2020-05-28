# install.packages("arules")
# install.packages("arulesViz", dependencies = TRUE)

# Import libraries
library(arules)
library(arulesViz)

# Import dataset
# dataset = read.csv('../datasets/Grocery.csv', header = FALSE)

# Read transactions
basket = arules::read.transactions('../datasets/Grocery.csv', sep = ',', rm.duplicates = TRUE)
arules::summary(basket)

png(filename="../img/grocery_item_relative_freq_R.png")
arules::itemFrequencyPlot(basket, topN = 25, type="relative", main='relative freq of items of grocery (R)')
dev.off()

png(filename="../img/grocery_item_absolute_freq_R.png")
arules::itemFrequencyPlot(basket, topN = 25, type="absolute", main="absolute freq of items of grocery (R)")
dev.off()

# Association Learning
rules = arules::apriori(data = basket, parameter = list(support=0.004, confidence=0.25))
rules_sort = arules::sort(rules, by=list('lift', 'confidence'))

arules::inspect(rules_sort[1:50])

# Visualization plots
png(filename="../img/grocery_graph_R.png")
plot(rules_sort[1:30], method = "graph", control = list(type="items"), main = "graph for top 30 rules")
dev.off()

png(filename="../img/grocery_matrix_R.png")
plot(rules_sort[1:50], method = "matrix")
dev.off()

png(filename="../img/grocery_scatterplot_R.png")
plot(rules_sort[1:50], method = "scatterplot", main = "scatterplot for top 50 rules")
dev.off()

png(filename="../img/grocery_paracoord_R.png")
plot(rules_sort[1:50], method = "paracoord", main = "paracoord for top 50 rules")
dev.off()

png(filename="../img/grocery_grouped_matrix_R.png")
plot(rules_sort[1:25], method = "grouped matrix", main = "grouped matrix for top 25 rules")
dev.off()
