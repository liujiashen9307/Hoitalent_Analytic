library(shiny)
library(shinythemes)
library(googleVis)
BG_O<-read.csv("Background.csv")
BG<-c(rep(NA,19))
for(i in 1:19){
  BG[i]<-as.character(BG_O[i,1])
}
shinyUI(
  fluidPage(theme = shinytheme("Journal"),
  headerPanel(h4(strong("Employment Analytic Based on Openning Position on Hoitalent"))),
  sidebarPanel(
    selectInput("BG","Your Background",choices =BG ,selected = BG[1]),
    br(),
    conditionalPanel('input.dataset=="Raw Data Download"',downloadButton('downloadData', 'Download csv File')),
    br(),
    h4("Author:"),
    a(h5("Jiashen Liu"),href="https://nl.linkedin.com/in/jiashen-liu-4658aa112",target="_blank"),
    h4("Data Source:"),
    a(h5("HoiTalent"),href="http://www.hoitalent.com/",target="_blank"),
    h4("Code:"),
    a(h5("GitHub"),href=" ",target="_blank")
    ),
  mainPanel(tabsetPanel(
    id="dataset",
    tabPanel("Analytic Panel",
             h4(strong("Description")),
             h5("With the information of 2368 openning positions on Hoitalent, this app can provide the internation students with descriptive analysis of the basic job requirement. You can view the job with the requirement of a specific background by using the selecting tabs on the left. Also, the data and code (in Python and R) are all available on my Github page. ",align="Justify"),
             h4(strong("The biggest employer?")),
             h5("Description: Charts and table below provide the quantity of positions each company posted on the Website. Some companies keeps providing ample opportunities for graduates with a specific background. So the charts below may offer you a target company when you are looking for job",align="Justify"),
             htmlOutput("Plot1"),
             h5("A detailed table containing the quantity of positions the company posted is provided below. Also, you can see the proportion of the position the Big Five Company posted on the right pie chart.",align="Justify"),
             fluidRow(
               splitLayout(cellwidths=c("50%","50%"),htmlOutput("Table1"),htmlOutput("Plot2"))
             ),
             br(),
             h4(strong("Required Experience")),
             h5("Description:Another frequently-asked question is the years of experience the company requires for a candidate. For some specific majors, having years of experience will make the job searching procedure way easier.",align="Justify"),
             fluidRow(
               splitLayout(cellwidths=c("50%","50%"),
             htmlOutput("plot3"),htmlOutput("plot4"))),
             br(),
             h4(strong("Required Degree")),
             h5("Description: Some people believe that a higher education level will bring to young profesionals a lot of convenience when they are looking for a job. However, the statistics of minimum required degree will somehow overthrow this stereotype.",align="Justify"),
             fluidRow(
               splitLayout(cellwidths=c("50%","50%"),
                           htmlOutput("plot5"),htmlOutput("plot6"))),
             br(),
             h4(strong("Location of Company")),
             h5("Description: Also, People care about the location of company. However, most companies do not provide the specific locations on the website. The classification will look a little bit ambigious",align="Justify"),
             htmlOutput("plot7"),
             br(),
             h4(strong("Type of Job Posted")),
             h5("Description: For fresh graduate, doing an internship before being fully employed is not a bad choice. Also, for students majoring in a specific field, some companies are happy to offer an internship combined with thesis trajectory",align="Justify"),
             fluidRow(
               splitLayout(cellwidths=c("50%","50%"),
                           htmlOutput("plot8"),htmlOutput("plot9"))),
             br(),
             h4(strong("Related Background")),
             h5("Description: Sometimes, the company wants to hire the person that can see the whole picture. Therefore, they intend to employ young professionals with multiple kinds of backgrounds. Exploring the related background the company may be interested in can provide the student with a clear direction.",align="Justify"),
             fluidRow(
               splitLayout(cellwidths=c("50%","50%"),
                           htmlOutput("plot10"),htmlOutput("plot11"))),
             br(),
  
             conditionalPanel("input.BG!='All'", 
             h5("Also, the position of requested background in the website is important. Once the required background is always the first background, then the company may be able to prioritize the candidate with specific background. Meanwhile, once the position of background tags is not among the first tier, then the requirement on specific background is ambigious.",align="Justify"),
                              fluidRow(
                                splitLayout(cellwidths=c("50%","50%"),
                                  htmlOutput("plot14"),plotOutput("plot15")))),
             br(),
             h4(strong("Demand of Languages")),
             h5("Description: It is always advantageous when people can speak multiple kinds of languages. But what kinds of languages will bring to young professionals the most advantage is an interesting questions. Also, with different background, the requirement of languages will be different",align="Justify"),
             fluidRow(
               splitLayout(cellwidths=c("50%","50%"),
                           htmlOutput("plot12"),htmlOutput("plot13"))),
             br(),
             h4(strong("Posted Date")),
             h5("Lastly, we have a look on the posted date of open positions.For some positions asking for a specific background, the company can not receive many applications, therefore the position will remain open for a long period. Also, people can see that there are many 'Zombie' positions on the website. The company may forget to withdraw the link when there is a good candidate already. ",align="Justify"),
             htmlOutput("plot16")
             ),
    tabPanel("Raw Data Download",dataTableOutput("DT"))
  ))
))