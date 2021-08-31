x<-"abcdef"


uppercaseElements<-function(stringData){
  vector1<-strsplit(stringData, "")[[1]]
  vector2<-strsplit(stringData, "")[[1]]
  for(i in 1:length(vector1)){
    if( i%%2==0){
      vector1[i]<-toupper(vector1[i])
    }else{vector2[i]<-toupper(vector2[i])}
  }
  vector1<-paste(vector1,collapse = "")
  vector2<-paste(vector2,collapse = "")
  newlist<-c(vector1,vector2)
  return(newlist)
}


uppercaseElements(x)
