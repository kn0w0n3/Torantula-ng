#!/bin/sh
date
scrapy version

#Uncomment to list srapy info in the gui console
#scrapy
#scrapy list -h
#scrapy crawl -h

cd /home/voldem0rt/Documents/Qt_Projects/Torantula-ng/Torantula-ng/Torantula/Torantula/spiders/

scrapy crawl clear --logfile=clearLogScan.log -a sites=/home/voldem0rt/Documents/Qt_Projects/Torantula-ng/Torantula-ng/Torantula/Clearscrape/Clearscrape/spiders/startingListURLS.txt -a tor=False -a db=True

