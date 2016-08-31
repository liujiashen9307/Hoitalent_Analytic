# -*- coding: utf-8 -*-
####Scripts that can be used to scrape basic info of all available jobs on Hoitalent##
####Only first 20 pages are considered due to the effectiveness of info##
import requests
from bs4 import BeautifulSoup
import csv
url1='http://www.hoitalent.com/user/login?destination=node'
data={'edit-name':"liujiashen9307@gmail.com", 'edit-pass': 'ljs19930725'}
headers={
"Accept": "*/*",
"Accept-Language": "en-US,en;q=0.5",
"Accept-Encoding": "gzip, deflate",
"Referer": "http://www.hoitalent.com/job_position",
"User-Agent": "Mozilla/5.0 (Windows NT 6.3; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0",
"Connection":"keep-alive"
}
res1=requests.post(url1,data=data,headers=headers)
key_word=input("Please type in the keywords of the job you want to apply.")
url_O="http://www.hoitalent.com/search?keys="+key_word+"&"
Final_Dataset=[["Job","Company","Job Type","Minimum Experience","Link",'Posted','Background','Language','Location','Degree','Salary']]
for i in range(0,310):
    print('page'+str(i))
    url=url_O+"page="+str(i)
    response=requests.get(url,cookies=res1.cookies,headers=headers)
    content=response.content
    parser=BeautifulSoup(content,"html.parser")
    for j in range(3,13):
        select=parser.select('div.job-position-teaser')[j]
        Info=select.getText()
        Info=Info.split("\n")
            #####Website####
        Website=select.select('a')[0]
        Website="http://www.hoitalent.com"+Website.get('href')
        Required_info=[]
        index=[1,6,11,18]
        for each in index:
            Required_info.append(Info[each])         
        Required_info.append(Website)
        response_D=requests.get(Website)
        content_D=response_D.content
        parser_D=BeautifulSoup(content_D,"html.parser")
        All_Info=parser_D.select('.company-des-area-ul > li')
        if len(All_Info)>4:
            Published_Date=All_Info[6].getText()
            Language=All_Info[5].select('div .words-pitches')
            LG=[]
            for each in Language:
                LG.append(each.getText())
            Background=All_Info[0].select('div .words-pitches')
            BG=[]
            for every in Background:
                BG.append(every.getText())
            Location_Salary=parser_D.select('.company-des-area-ul > li')
            Location=Location_Salary[2].getText()
            Salary=Location_Salary[7].getText()
            Degree=Location_Salary[3].getText()
            Required_info.append(Published_Date)
            Required_info.append(BG)
            Required_info.append(LG)
            Required_info.append(Location)
            Required_info.append(Degree)
            Required_info.append(Salary)
        else:
            Required_info.append("NonAvailable")
            Required_info.append("NonAvailable")
            Required_info.append("NonAvailable")
            Required_info.append("NonAvailable")
            Required_info.append("NonAvailable")
            Required_info.append("NonAvailable")            
        Final_Dataset.append(Required_info)
####Write File to Csv File###
with open('Hoi_Talent.csv', 'w', newline='') as csvfile:
    spamwriter = csv.writer(csvfile, delimiter=',',
                                    quoting=csv.QUOTE_MINIMAL)
    for each in Final_Dataset:
        try:
            spamwriter.writerow(each)
        except Exception:
            continue
                 
            