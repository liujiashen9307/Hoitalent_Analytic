Data<-read.csv("Hoi_Talent.csv",stringsAsFactors = FALSE)
Data<-data.frame(Data,numTags=NA,NumLag=NA)
Value<-Data[1,13]
LG<-Data[,c(28:36)]
aa<-data.frame(LG=NA)
for(i in 1:9){
  Unique<-data.frame(LG=unique(LG[,i]))
  aa<-rbind(Unique,aa)
}
aa<-aa[-c(1,3,5,7,10,14,21,30,46),1]
cc<-unique(aa)
LG<-data.frame(LG=rep(NA,14))
for(i in 1:length(cc)){
  LG[i,1]<-as.character(cc[i])
}
LG<-data.frame(LG=LG[c(1:13),])
for(i in 1:2368){
  Lst<-Data[i,c(10:27)]
  CC<-BG_O[,1] %in% Lst
  CM<-sum(CC,na.rm = TRUE)
  Data[i,"numTags"]<-CM
  Lst2<-Data[i,c(28:36)]
  CCC<-LG[,1] %in% Lst2
  CM2<-sum(CCC,na.rm = TRUE)
  Data[i,"NumLag"]<-CM2
}
for(i in 1:2368){
  for(j in (10+Data[i,37]):27){
    Data[i,j]<-NA
  }
}
for(i in 1:2368){
  for(j in (28+Data[i,38]):36){
    Data[i,j]<-NA
  }
}
write.csv(Data,"Hoi_Talent.csv")
