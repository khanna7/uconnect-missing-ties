## Metrics on Facebook friends for the two waves

Wave 1 analysis in `/home/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/descriptives`.  
Wave 2 analysis in `/home/khanna7/Projects/UConnect/UConnect_FB/Wave_2/descriptives`.

### Wave 1
* Degree distribution for non-participants

```r
>    table(w1.ig.non.particip.degree)
w1.ig.non.particip.degree
     1      2      3      4      5      6      7      8      9     10     11 
139022  22931   7969   3783   2292   1451   1057    723    562    396    315 
    12     13     14     15     16     17     18     19     20     21     22 
   239    176    150    153    111    118     71     82     68     72     65 
    23     24     25     26     27     28     29     30     31     32     33 
    37     70     45     41     40     35     35     31     33     21     29 
    34     35     36     37     38     39     40     41     42     43     44 
    21     17     28     24     27     20     23     20     16     17     21 
    45     46     47     48     49     50     51     52     53     54     55 
    12     15     12     15     16     13      7      7      6      7     10 
    56     57     58     59     60     61     62     63     64     65     66 
    11      7      2     14      9      6      2      7      5      1      9 
    67     68     69     70     71     72     73     74     75     76     78 
     5      3      5      3      4      3      2      1      2      2      1 
    79     80     81     82     83     84     85     87     88     89     91 
     3      2      1      1      1      1      1      1      1      1      1 
   102 
     1 
``` 
587 participants have >= 30 edges, i.e. are connected to ~10% of the sample.    
455 of these participants are in the messaging network.

* Summary statistics for non-participants
```r
## Age
>    summary(non.particip.node.data$fb_age)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
  13.00   20.00   23.00   24.57   26.00   90.00   89556
  
## Sex
>    summary(non.particip.node.data$fb_sex)
          f     m 
  846 92322 89528 
  
  
## In Chicago
length(which(non.particip.node.data$fb_city == "chicago"))
[1] 58270
```

### Wave 2

* Degree distribution for non-participants
```r
>    table(w2.ig.non.particip.degree)
w2.ig.non.particip.degree
     1      2      3      4      5      6      7      8      9     10     11 
181985  34729  13190   6475   3870   2584   1904   1424   1072    892    694 
    12     13     14     15     16     17     18     19     20     21     22 
   469    458    341    300    231    189    174    134    136    118     99 
    23     24     25     26     27     28     29     30     31     32     33 
    96     99     78     73     63     53     51     53     49     40     43 
    34     35     36     37     38     39     40     41     42     43     44 
    38     43     26     36     36     35     35     22     26     21     30 
    45     46     47     48     49     50     51     52     53     54     55 
    18     24     22     24     20     25     22     23     21     17     20 
    56     57     58     59     60     61     62     63     64     65     66 
    17     15     16     16     19     15     14     13     17     13     10 
    67     68     69     70     71     72     73     74     75     76     77 
    14      8     16     13      7     10      7      7     12      3      3 
    78     79     80     81     82     83     84     85     86     87     88 
     5      3      1      4      5     10      3      7      4      7      6 
    89     90     91     92     93     94     95     97     98    100    101 
     6      5      4      3      4      3      4      1      3      3      1 
   102    103    104    105    108    109    110    111    116    121    125 
     2      2      2      3      1      1      2      1      1      1      1
```
744 participants have >= 30 edges, i.e. are connected to ~10% of the sample.    
528 of these participants are in the messaging network.

* Summary statistics for non-participants
```r
## Age
## Output hidden, contained some names
  
## Sex
>    summary(non.particip.node.data$fb_sex)
            f      m 
  1099 127476 124549 
  
## In Chicago
length(which(non.particip.node.data$fb_city == "chicago"))
[1] 77794
```





















