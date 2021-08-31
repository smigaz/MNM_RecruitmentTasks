myString<-"aCABbaccad"


countLetters<-function(x){
  vector<-strsplit(x, "")[[1]]
  lastMess<-""
  counters<-c()
  mess<-"case is the same"
  for(i in 1:length(vector)){
    if(vector[i]==toupper(vector[i])){vector[i]<-tolower(vector[i]);mess<-"case is ignored"}
  }
  countTable<-as.data.frame(table(vector))
  for(i in 1:nrow(countTable)){
    lastMess<-paste(lastMess,countTable[i,1]," occurs ",countTable[i,2]," times,")
  }
  lastMess<-paste(lastMess,mess)
  return(lastMess)
}

countLetters(myString)


        