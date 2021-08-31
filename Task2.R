BiocManager::install("vcfR")
BiocManager::install("ggplot2")
library(vcfR)
library(ggplot2)

vcf<- read.vcfR("C:/Users/smiga/Downloads/tumor_vs_normal.manta.somatic.vcf.gz")
data<-as.matrix(vcf@fix[,"INFO"])

#the number of breakends
counterBND<-0
for(i in 1:nrow(data)){
  if(length(grep("SVTYPE=BND",data[i]))!=0){counterBND<-counterBND+1}
}

#a boxplots of the deletion length per each chromosome
chromosomes<-unique(vcf@fix[,"CHROM"])
chrMatrix<-c()
for(j in 1:length(chromosomes)){
  chrData<-vcf@fix[vcf@fix[,"CHROM"]==chromosomes[j],]
  chrSummary<-c()
  
for(i in 1:nrow(chrData)){
  if(length(grep("SVTYPE=DEL",chrData[i,"INFO"]))!=0){
    vector<-strsplit(chrData[i,"INFO"], ";")[[1]]
    vector2<-vector[grepl("SVLEN=", vector, fixed = TRUE)]
    vector3<-as.numeric(strsplit(vector2, "-")[[1]][2])
    chrSummary<-as.data.frame(rbind(chrSummary,c(chromosomes[j],vector3)))
    
  }
}
  chrMatrix<-rbind(chrMatrix,chrSummary)
}

chrMatrix<-as.data.frame(chrMatrix)
chrMatrix$V2<-as.numeric(chrMatrix$V2)

colnames(chrMatrix)<-c("Chr","Deletions")


p <- ggplot(chrMatrix, aes(x=Chr, y=Deletions)) + 
  geom_boxplot(fill="slateblue", alpha=0.2)+ylab("The length of the deletion")+xlab("Chromosome number")
p


#Count how many variants failed to pass the filtering. Make a piechart of most frequent reasons to fail.
data3<-vcf@fix[vcf@fix[,"FILTER"]!="PASS",]

# Find the variant with the widest confidence interval around POS;
data3<-as.matrix(vcf@fix)
max<-0
variantNR<-c()
for(i in 1:nrow(data3)){
  if(length(grep("CIPOS=",data3[i,"INFO"]))!=0){
    vector<-strsplit(data3[i,"INFO"], ";")[[1]]
    vector2<-vector[grepl("CIPOS=", vector, fixed = TRUE)]
    vector2<-gsub("\\,", ".", vector2)
    vector3<-as.numeric(strsplit(vector2, "=")[[1]][2])
    if(vector3>=max){max<-vector3}
  }}

#variants with the widest confidence interval around POS
maxPOS<-vcf@fix[grepl(gsub("\\.", ",",paste("CIPOS=",max,sep = "")),vcf@fix[,"INFO"]),]

#What type of stractural variant represented by ID MantaBND:28842:0:1:0:0:0:0
struct<-vcf@fix[grepl("MantaBND:28842:0:1:0:0:0:0",vcf@fix[,"ID"]),]
vector<-strsplit(vcf@fix[grepl("MantaBND:28842:0:1:0:0:0:0",vcf@fix[,"ID"]),"INFO"], ";")[[1]]
vector2<-vector[grepl("SVTYPE=", vector, fixed = TRUE)]
#It's  a breakend
