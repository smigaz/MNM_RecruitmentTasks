BiocManager::install("vcfR")
library(vcfR)
vcf<- read.vcfR("C:/Users/smiga/Downloads/tumor_vs_normal.strelka.somatic.snvs.vcf.gz")
vcf@fix<-vcf@fix[vcf@fix[,"FILTER"]=="PASS",]

write.vcf(vcf,"C:/Users/smiga/Downloads/PASS.vcf.gz")

#I would use the LINUX environment, but I had internet problems and couldn't
#download the hg19 genome version. I would use the following commands
#java –jar ~/Downloads/snpEff/snpEff.jar /home/asmigas/Mapowanie/hg38.fa PASS.vcf.gz> PASS.Anno.VarScan.vcf
#Then I would load the annotated vcf file again into R and use the new information to complete the task