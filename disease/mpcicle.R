#Modelamiento para el ciclo de la enfermedad, Epifitias de enfermedades de las plantas.
## CICLO DEL NEMATODE CON RESPECTO A LA TEMPERATURA
## Set up the vector of nematode populations

# Cicle vs temperature ----------------------------------------------------


npop <- c(220,180,150,250,270,300,500,580,580,1000,380,100)

## Set up vector of associated months
names(npop) <-c (
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
)

## Set up the bar plots of the nematode populations, try help(barplot) for more information
barplot(
  npop,
  axes=TRUE,
  main="Nematode  Population",
  ylim=c(0,1200),
  col="orange",
  xlab="Month",
  ylab="Nematodes per 100 cc soil")
axis(2,seq(0,1200,by=200)
)

## Set up the new plot to be drawn on top of the barplot, try help(par) for more information
par(new=T)

# This sets the average monthly temperature
# for the line above the population
y <-c (15,17,20,24,26,28,30,31,30,28,19,16)

# This positions the points on the X axis
# correctly in the middle over the top of the bar chart.
y2 <-c (0.5,1.45,2.45,3.5,4.5,5.35,6.5,7.6,8.5,9.55,10.65,11.5)

## Plot the temperature points
plot(
  y2,
  y,
  ylim=c(0,35),
  xlab=NA,
  ylab=NA,
  xlim=c(0,12),
  axes=FALSE,
  type="o",
  pch=22,
  col="mediumblue"
)

axis(
  4,
  seq(0,35,by=5),
  labels=FALSE
)

## Lay out the points for temperature
points(
  y2,
  y,
  pch=22,
  col="mediumblue"
)

## Label the right axis, try help(mtext) for more information
mtext(
  c("0C","5C","10C","15C","20C","25C","30C","35C"),
  4,
  at=seq(0,35,by=5),
  line=.25
)

## Label the right axis, try search(mtext) for more information
mtext(
  "Average Soil Temperature",
  4,
  line=1,
  cex=1
)

## Create a legend
legend(
  "topleft",
  c("Soil Temperature","Nematode Population"),
  pch=c(22,NA),
  lty=c(1,NA),
  col=c("mediumblue",NA),
  inset=0.01
)

## Create an orange rectangle next to the Nematode Population label for the legend
rect(-0.2,32.4,0.4,33.4,col="orange")


# AUDCP -------------------------------------------------------------------
### Calculating the area under the disease progress curve
### to quantify disease progress
### (AUDCP)

#Set up disease severity percent measurements; 
#change these in subsequent analyses to see how it affects
#the AUDPC
ds0<-1
ds1<-2
ds2<-7
ds3<-7.5

#Put these values into a vector without making any changes
disease.severity<-c(ds0,ds1,ds2,ds3)

#Time points at which disease severity
#   measurements are made, 
#change these in subsequent analyses to
#see how it affects the AUDPC Value
t0<-0
t1<-2
t2<-5
t3<-6

#Put time period into a vector
## Do not change these values
time.period<-c(t0,t1,t2,t3)

#Refresh your memory about how the plot function works
help(plot)

#Create the plot of disease severity over time
plot(time.period,
     disease.severity,
     ylim=c(0,(ds3+1)),
     xlim=c(0,(t3+0.5)),
     xlab="Time",
     ylab="Disease Severity (%)",
     type="l",
     pch=19,
     col="mediumblue")

#Add a title and subtitle to our plot
title(main="Illustration of AUDPC Calculation",
      sub="Figure 1")

#Add text to x labels defining time periods
#   defined in text
mtext("=t0",1,at=0.3,1)
mtext("=t1",1,at=2.3,1)
mtext("=t2",1,at=5.3,1)
mtext("=t3",1,at=6.3,1)

#Illustrate the area under disease progress
#   curve with rectangles.
## Do not change these values
rect(t0,0,t1,((ds0+ds1)/2),border="orange")
# Add text to rectangle to describe rectangle
text(1,1,"A1")
#Add segment to Y axis
#And so-on
rect(t1,0,t2,((ds1+ds2)/2),border="orange")
text(((t1+t2)/2),(((ds1+ds2)/2)/2),"S2")
#Draw line to axis and label with value
segments(.4,((ds1+ds2)/2),t2,((ds1+ds2)/2),
         col="black",lty="18")
text(0,((ds1+ds2)/2),((ds1+ds2)/2))
rect(t2,0,t3,((ds2+ds3)/2),border="orange")
text(((t2+t3)/2),(((ds2+ds3)/2)/2),"S3")
segments(0.4,((ds2+ds3)/2),t2,((ds2+ds3)/2),
         col="black",lty="18")
text(0,((ds2+ds3)/2),((ds2+ds3)/2))

#Build a function for AUDPC calculation
#the left curly bracket indicates the beginning
#   of the function
audpc <- function(disease.severity,time.period){
  
  #n is the length of time.period, or
  #  the total number of sample dates
  n <- length(time.period)
  
  #meanvec is the vector (matrix with one dimension)
  #that will contain the mean percent infection
  #it is initialized containing -1 for all entries
  #this sort of initialization is sometimes useful
  #  for debugging
  meanvec <- matrix(-1,(n-1))
  
  #intvec is the vector that will contain the length of
  #   time between sampling dates
  intvec <- matrix(-1,(n-1))
  
  #the loop goes from the first to the penultimate entry
  #the left curly bracket indicates the beginning of
  #   commands in the loop
  for(i in 1:(n-1)){
    
    #the ith entry in meanvec is replaced with the
    #   mean percent infection
    #between sample time i and sample time i+1
    meanvec[i] <- mean(c(disease.severity[i],
                         disease.severity[i+1]))
    
    #the ith entry in intvec is replaced with the length
    # of the time interval between time i and time i+1
    intvec[i] <- time.period[i+1] - time.period[i]
    
    #the right curly bracket ends the loop
  }
  
  #the two vectors are multiplied together
  #  one entry at a time
  infprod <- meanvec * intvec
  
  #the sum of the entries in the resulting vector
  #   gives the AUDPC
  sum(infprod)
  
  #the right curly bracket ends the function
}


#Now apply the function to the example data and put
# the result in a new object called 'AUDPCexample'
audpc(disease.severity,time.period) -> AUDPCexample
#Display AUDPC Value
#Draw rectangle around value
rect(0.1,(ds3+.3),2,(ds3+1),border="black")
#AUDPC Text
text(1.05,(ds3+0.8),"AUDPC")
text(1.05,(ds3+0.5),AUDPCexample)


# AUDCP wheat Puccinia striiformis ------------------------------------------

## Set up vector for Madras AUDPC Chart
daysAfterInoculation <- c(0,10,20,30,40,50,60,70,80,90,100)
severityYear68 <- c(0,0,0,0,3,20,50,80, 90, 100, 100)
severityYear69 <- c( 0,0,0,0,0,0,0,3,6,30,70)
## Set up the line graph for 1968
plot(
  daysAfterInoculation,
  severityYear68,
  type="o",
  pch=22,
  col="mediumblue",
  ylim=c(0,100),
  xlab='Days After Inoculation',
  ylab='% Infection'
)
## Set main title
title(main="Madras Disease Progress")
## Overlay line for 1969 plot
lines(
  daysAfterInoculation,
  severityYear69,
  type="o", col="orange"
)
## Set the legend of the graph in upper left corner
legend(
  "topleft",
  c("1968","1969"),
  pch= c(22,21),
  lty=1,
  col = c("mediumblue","orange"),
  title="Year",
  inset=0.05
)
## Calculate the AUDPC using the function called 'audpc' that
##      was created in the AUDPC exercise of this document
## If you have started a new R session and did not save the
##      function you will need to create it again.
## To check that you do have the function available, try
##      entering the function name, 'audpc', at the command
##      line and R should return the content of the function.
# Calculate the AUDPC for 1968
audpc(severityYear68,daysAfterInoculation)
# Calculate the AUDPC for 1969
audpc(severityYear69,daysAfterInoculation)
