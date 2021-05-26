---
output:
  html_notebook: default
  html_document: default
---
# Association Rules:-

### Problem Statement:- 

  - Prepare rules for the all the data sets 
    1) Try different values of support and confidence. Observe the change in number of rules for different support,confidence values
    2) Change the minimum length in apriori algorithm
    3) Visulize the obtained rules using different plots 
    
### Reading the Dataset:- 

```{r}
library(readxl)
grocery <- read.csv("~/desktop/Digi 360/Module 15/groceries.csv")
```

```{r}
head(grocery)
```

```{r}
any(is.na(grocery))
```


```{r}
library("arules")
class(grocery) # Groceries is in transactions format
```

```{r}
summary(grocery) 
```



```{r}
library("arulesViz") # for visualizing rules
```

### Building rules using apriori algorithm

```{r}
arules <- apriori(grocery, parameter = list(support=0.002,confidence=0.6,minlen=2))
```

```{r}
arules
```
So total we have 408 rules generated for support=0.002,confidence=0.6,minlen=2.

```{r}
inspect(head(sort(arules,by="lift"))) # to view we use inspect 
```

```{r}
# Viewing rules based on lift value

# Overal quality 
head(quality(arules))
```

### Pruning Reduntant Rules

```{r}
rules.sorted <- sort(arules, by="lift")
```


```{r}
subset.matrix <- is.subset(rules.sorted,rules.sorted)
```

```{r}
subset.matrix[lower.tri(subset.matrix, diag=T)] <- F
```

```{r}
redundant <- apply(subset.matrix, 2, any)
```

```{r}
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned)
```


### Data Visualization

```{r}
plot(rules.pruned)
```

```{r}
plot(rules.pruned,method="grouped")
```

```{r}
plot(rules.pruned[1:20],method = "graph") # for good visualization try plotting only few rules
```

### Changing the support and confidence values

```{r}
arules <- apriori(grocery, parameter = list(support=0.001,confidence=0.6,minlen=2))
```

```{r}
arules
```

So total we have 681 rules generated for support=0.001,confidence=0.6,minlen=2.

```{r}
arules <- apriori(grocery, parameter = list(support=0.001,confidence=1,minlen=2))
```

```{r}
arules
```

So total we have 385 rules generated for support=0.001,confidence=1,minlen=2.

```{r}
arules <- apriori(grocery, parameter = list(support=0.002,confidence=0.6,minlen=4))
```

```{r}
arules
```

So total we have 70 rules generated for support=0.002,confidence=0.6,minlen=4.

### Pruning the reduntant rules

```{r}
rules.sorted <- sort(arules, by="lift")
subset.matrix <- is.subset(rules.sorted,rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- F
redundant <- apply(subset.matrix, 2, any)
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned)
```

```{r}
plot(rules.pruned)
```


```{r}
plot(rules.pruned,method="grouped")
```

```{r}
plot(rules.pruned, method="graph")
```


```{r}
write(arules, file="~/desktop/Digi 360/Module 15/a_rules.csv",sep=",")

getwd()
```

### Conclusion:- 

  - With support=0.002,confidence=0.6,minlen=2, total 408 rules are generated. After pruning reduntant rules, 159 final rules are generated.
  - With support=0.001,confidence=0.6,minlen=2, total 681 rules are generated. 
  - With support=0.001,confidence=1,minlen=2, total 385 rules are generated.
   - With support=0.002,confidence=0.6,minlen=4, total 70 rules are generated. After pruning reduntant rules, 28 final rules are generated.
