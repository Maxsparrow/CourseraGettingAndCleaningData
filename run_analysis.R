features = read.table('features.txt', , stringsAsFactors = F)
indexes <- grep(pattern = "\\bmean()\\b|\\bstd()\\b", x = features[,2])
data <- rbind(read.table('train/X_train.txt'), read.table('test/X_test.txt'))
data <- data[, indexes]

activities <- read.table('activity_labels.txt')
labels <- rbind(read.table('test/y_test.txt'), read.table('train/y_train.txt'))
labels <- activities[labels[,1],2]

data <- cbind(data, labels)

names(data) <- c(features[indexes,2], 'activity')

write.csv(file='tidy_dataset.csv', x=data)

list <- lapply(activities[, 2], function(x) { colMeans(data[which(data$activity==x),1:66]) })
independent <- cbind(data.frame(matrix(unlist(list), nrow=length(list), byrow=T)), activities[,2])
names(independent) <- c(features[indexes,2], 'activity')

write.csv(file='independent_tidy_dataset.csv', x=independent)


