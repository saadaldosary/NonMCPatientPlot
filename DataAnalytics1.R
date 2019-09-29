library(dplyr)
library(ggplot2)



#prepration 

#assigning the data sets to a new variable 
drg2011_h <- AldosaryF_IPPS_2011

#Grouping the drg and state in the 2011 dataset in a new frame  
drg2011_h <- group_by(drg2011_h, drg, state)

#summrizing the the variables fro 2011 dataset by avgcovcharges/avgtotpayments/avgmcpayments
drg2011_s <- summarize(drg2011_h, discharges_s=sum(discharges_h),avgcovcharges_s=weighted.mean(avgcovcharges_h,discharges_h),avgtotpayments_s=weighted.mean(avgtotpayments_h,discharges_h),avgmcpayments_s=weighted.mean(avgmcpayments_h,discharges_h))

#assigning the data sets to a new variable 
drg2012_h <- AldosaryF_IPPS_2012

#Grouping the drg and state in the 2012 dataset in a new fram 
drg2012_h <- group_by(drg2012_h,drg,state)

##summrizing the the variables fro 2012 dataset by avgcovcharges/avgtotpayments/avgmcpayments
drg2012_s <- summarize(drg2012_h, discharges_s=sum(discharges_h),avgcovcharges_s=weighted.mean(avgcovcharges_h,discharges_h),avgtotpayments_s=weighted.mean(avgtotpayments_h,discharges_h),avgmcpayments_s=weighted.mean(avgmcpayments_h,discharges_h))

#Substituting avgtotpayment from avgmcpayments and assign it to a new variable (paymentDiff_h) for the frams drg2012_h  
drg2011_h <- mutate(drg2011_h, paymentDiff_h = avgtotpayments_h - avgmcpayments_h)

#Substituting avgtotpayment from avgmcpayments and assign it to a new variable (paymentDiff_s) for the framand drg2012_s
drg2011_s <- mutate(drg2011_s, paymentDiff_s = avgtotpayments_s - avgmcpayments_s)

# we repeate the same for the 2012 dataset
drg2012_h <- mutate(drg2012_h, paymentDiff_h = avgtotpayments_h - avgmcpayments_h)
drg2012_s <- mutate(drg2012_s, paymentDiff_s = avgtotpayments_s - avgmcpayments_s)

#drg2011_d <- AldosaryF_IPPS_2011
#drg2011_d <- mutate(drg2011_d, paymentDiff_d = avgtotpayments_d - avgmcpayment_d)

#visualization:

# creating a new variable and assinging the ggplot to it.  the first X will be the drg and the difference from totpayment and mcpayment
# the Y is is the difference between totpayment and mcpayment
diff2011_h <- ggplot(drg2011_h, aes(x=reorder(drg,paymentDiff_h),y=paymentDiff_h))

# applying the ggplot histogram and flipping it 
diff2011_h + geom_bar(stat = "identity") + coord_flip()

diff2011_h + geom_bar(stat = "identity")
#another graph type
diff2011_h + geom_point(size=4) + coord_flip()


