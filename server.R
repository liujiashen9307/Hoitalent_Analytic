library(shiny)
library(shinythemes)
library(googleVis)
library(sqldf)
library(tm)
library(wordcloud)
Data<-read.csv("Hoi_talent.csv",stringsAsFactors = FALSE)
Data[,5]<-as.Date(Data[,5],format="%d/%m/%Y")
shinyServer(function(input,output){
  Data_File<-reactive({
    if(input$BG=="All"){
      Data<-Data
    }else{
      Index<-c()
      for(i in 1:length(Data[,1])){
        Lst<-Data[i,c(10:27)]
        if(input$BG%in% Lst){
          Index<-append(Index,i)
        }
      }
      Data<-Data[Index,]
    }
    Data
  })
#######Tab 1: Analytic Tab########

output$Plot1<-renderGvis({
  
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT1<-sqldf("SELECT Company, Count(Company) as Count from Data group by Company order by Count desc")
  gvisBarChart(PT1,xvar = "Company",yvar = "Count",options=list(width=1000,height=500,title = "# Positions The Company Posted",colors="['green']"))
})

output$Table1<-renderGvis({
  
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT1<-sqldf("SELECT Company, Count(Company) as Count from Data group by Company order by Count desc")
  gvisTable(PT1,options=list(width=400,height=300,title = "# Positions The Company Posted",colors="['green']"))
})

output$Plot2<-renderGvis({
  
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT1<-sqldf("SELECT Company, Count(Company) as Count from Data group by Company order by Count desc")
  PT1<-PT1[c(1:5),]
  Other<-data.frame(Company="Others",Count=length(Data[,1])-sum(PT1[,2]))
  PT1<-rbind(PT1,Other)
  gvisPieChart(PT1,options=list(width=400,height=300,title = "Proportion of positions the Big Five companies posted"))
})

output$plot3<-renderGvis({
  
  
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT1<-sqldf("SELECT Minimum_Experience, Count(Minimum_Experience) as Count from Data group by Minimum_Experience order by Count desc")
  gvisColumnChart(PT1,xvar = "Minimum_Experience",yvar = "Count",options=list(width=400,height=300,title = "# Positions Requiring Specific Years of Experience",colors="['Red']"))
  
})

output$plot4<-renderGvis({
  
  
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT1<-sqldf("SELECT Minimum_Experience, Count(Minimum_Experience) as Count from Data group by Minimum_Experience order by Count desc")
  gvisPieChart(PT1,options=list(width=400,height=300,title = "Proportion of Positions Requiring Specific Years of Experience"))
  
})
output$plot5<-renderGvis({
  
  
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT1<-sqldf("SELECT Degree, Count(Degree) as Count from Data group by Degree order by Count desc")
  gvisColumnChart(PT1,xvar = "Degree",yvar = "Count",options=list(width=400,height=300,title = "# Positions Requiring Specific Degree",colors="['Yellow']"))
  
})

output$plot6<-renderGvis({
  
  
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT1<-sqldf("SELECT Degree, Count(Degree) as Count from Data group by Degree order by Count desc")
  gvisPieChart(PT1,options=list(width=400,height=300,title = "Proportion of Positions Requiring Specific Degree"))
  
})

output$plot7<-renderGvis({
  
  
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT1<-sqldf("SELECT Location, Count(Location) as Count from Data group by Location order by Count desc")
  gvisColumnChart(PT1,xvar = "Location",yvar = "Count",options=list(width=1000,height=600,title = "# Positions in Specific Locations",colors="['blue']"))
  
})

output$plot8<-renderGvis({
  
  
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT1<-sqldf("SELECT Job_Type, Count(Job_Type) as Count from Data group by Job_Type order by Count desc")
  gvisColumnChart(PT1,xvar = "Job_Type",yvar = "Count",options=list(width=400,height=300,title = "# Specific Kinds of Position",colors="['Orange']"))
  
})

output$plot9<-renderGvis({
  
  
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT1<-sqldf("SELECT Job_Type, Count(Job_Type) as Count from Data group by Job_Type order by Count desc")
  gvisPieChart(PT1,options=list(width=400,height=300,title = "Proportion of Specific Kinds of Position"))
  
})

output$plot10<-renderGvis({
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  Tags<-NULL
  for(i in 1:length(Data[,1])){
    for(j in 10:27){
      if(is.na(Data[i,j])!=TRUE){
        Tags<-append(Data[i,j],Tags)
      }
    }
  }
  TG<-data.frame(Tags=Tags)
  TGs<-sqldf("SELECT Tags as Background, count(Tags) as Count from TG group by Tags order by Count desc")
  gvisColumnChart(TGs,xvar = "Background",yvar = "Count",options=list(width=400,height=300,title = "# Positions Asking for Specific Kinds of Backgrounds",colors="['green']"))
  
})


output$plot11<-renderGvis({
  
  
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT1<-sqldf("SELECT numTags as NumberofBackground, Count(numTags) as Count from Data group by NumberofBackground order by Count desc")
  gvisColumnChart(PT1,xvar = "NumberofBackground",yvar = "Count",options=list(width=400,height=300,title = "# Positions Asking for Specific Number of Kinds of Backgrounds",colors="['purple']"))
  
})

output$plot12<-renderGvis({
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  Tags<-NULL
  for(i in 1:length(Data[,1])){
    for(j in 28:36){
      if(is.na(Data[i,j])!=TRUE){
        Tags<-append(Data[i,j],Tags)
      }
    }
  }
  TG<-data.frame(Tags=Tags)
  TGs<-sqldf("SELECT Tags as Language, count(Tags) as Count from TG group by Language order by Count desc")
  gvisColumnChart(TGs,xvar = "Language",yvar = "Count",options=list(width=400,height=300,title = "# Positions Asking for Specific Kinds of Language",colors="['blue']"))
  
})


output$plot13<-renderGvis({
  
  
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT1<-sqldf("SELECT NumLag as NumberofLanguage, Count(NumLag) as Count from Data group by NumberofLanguage order by Count desc")
  gvisColumnChart(PT1,xvar = "NumberofLanguage",yvar = "Count",options=list(width=400,height=300,title = "# Positions Asking for Specific Number of Kinds of Backgrounds",colors="['red']"))
  
})

output$plot14<-renderGvis({
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  DE<-NULL
  for(i in 1:length(Data[,1])){
    Lst<-Data[i,c(10:27)]
    Ind<-Lst %in% input$BG
    dex<-which(Ind==TRUE)
    DE<-append(DE,dex)
  }
  DE<-data.frame(Position=DE)
  PT1<-sqldf("SELECT Position, Count(Position) as Count from DE group by Position order by Count desc")
  gvisColumnChart(PT1,xvar = "Position",yvar = "Count",options=list(width=400,height=300,title = "Position of specific tag (Lower Position is always Prioritized)",colors="['red']"))
})

output$plot15<-renderPlot({
  
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  
    
    Lst<-c()
  for(i in 1:length(Data[,1])){
    for(j in 10:27){
      if(is.na(Data[i,j])!=TRUE){
        Lst<-append(Lst,Data[i,j])}
    }}
    for(i in 1:length(Lst)){
      if(i==1){
        Txt<-Lst[1]
      }else{
        Txt<-paste(Txt,Lst[i],sep=' ')
      }
    }
    All_Word<-VCorpus(VectorSource(Txt)) 
    All_Word<-tm_map(All_Word, removeWords, stopwords("english"))
    dtm<-DocumentTermMatrix(All_Word)
    freq <- colSums(as.matrix(dtm))
    ord<-order(freq) 
    wf <- data.frame(word=names(freq), freq=freq) 
  
    wordcloud(wf[,"word"], wf[,"freq"],min.freq = 1,main="Word Could of the Required Background") 
})
output$plot16<-renderGvis({
  if(input$BG=="All"){
    Data<-Data
  }else{
    Index<-c()
    for(i in 1:length(Data[,1])){
      Lst<-Data[i,c(10:27)]
      if(input$BG%in% Lst){
        Index<-append(Index,i)
      }
    }
    Data<-Data[Index,]
  }
  PT<-sqldf("SELECT Posted_Date, count(Posted_Date) as Count from Data group by Posted_Date")
  PT[,1]<-as.Date(PT[,1],format="%d/%m/%Y")
  gvisAnnotatedTimeLine(PT, datevar="Posted_Date",numvar="Count",options=list(displayAnnotations=TRUE,width=900, height=500))
})
#######Tab 2: DataTable Output####
  output$DT<-renderDataTable({
    Data_File()
  })
  output$downloadData <- downloadHandler(
    filename = function() { 
      paste(input$BG, '.csv', sep='') 
    },
    content = function(file) {
      write.csv(Data_File(), file)
    })
})


