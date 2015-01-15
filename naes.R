dev.off()
rm(list=ls())
setwd("/Users/leifurbjarkierlendsson/Dropbox/Applied_Statistics_Shared/Leifur/Applied_statistics/Assignment2")
#dir("/Users/leifurbjarkierlendsson/Dropbox/Applied_Statistics_Shared/Leifur/Applied_statistics/Assignment2")

data.1 <- read.table("campy_pre2002.txt",header=T,sep="\t", fill = TRUE)
data.2 <- read.table("campy_2002-2005.csv",header=T,sep=",")
data.3 <- read.table("campy_2005-.csv",header=T,sep=",")
summary(data.1)

data.1 <- subset(data.1, (!SEKTION=="res" & AKTVNR==5133 & CHR_NR>=10000))
data.2  <- subset(data.2, Chrnr>=10000)
data.3  <- subset(data.3, Chrnr>=10000)

data.1$PRV_DATO  <- as.Date(data.1$PRV_DATO,format="%d %b %Y")
data.2$Prvdato  <- as.Date(data.2$Prvdato,format="%m/%d/%y")
data.3$Provedato  <- as.Date(data.3$Provedato,format="%m/%d/%y")


#"chrnr" "epinr" "jnr" "dyrnr" "matr" "resultat" "prvdato" "region"
data.1 <- data.1[,c("CHR_NR" ,"EPINR", "JNR", "DYRNR", "MATR","BAKTFUND", "PRV_DATO", "region")]
data.2  <- data.2[,c("Chrnr", "Epi.nr", "Jnr", "Dyrnr", "Materialeart", "Resultat", "Prvdato", "region")]
data.3["Dyrnr"] <- NA
data.3  <- data.3[,c("Chrnr", "Epinr", "Jnr","Dyrnr", "Materialeart", "Tolkning", "Provedato", "region")]

column.name  <-  c("chrnr", "epinr", "jnr", "dyrnr", "matr", "resultat", "prvdato", "region")
colnames(data.1) <- column.name
colnames(data.2) <- column.name
colnames(data.3) <- column.name

data <- rbind(data.1, data.2,data.3)

data <- subset(data,(!is.na(epinr) &chrnr>=10000))
data <- subset(data,duplicated(jnr)!=TRUE)

data  <- subset(data, matr =="Kloaksvaber"| matr =="Svaberprøve" | matr =="766" | matr =="772")

data$weeknr  <- as.numeric( format(data$prvdato+3, "%U"))

data  <- subset(data,weeknr%%2==0)

#remove chrnr if it is not repeated at least ten times