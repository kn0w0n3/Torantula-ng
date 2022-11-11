#!/bin/sh
sleep 0.5
whoami
date +"%Y%d%d_%H:%M:%S" 
scrapy version

#Uncomment to list srapy info in the gui console
#scrapy
#scrapy list -h
#scrapy crawl -h

cd /home/voldem0rt/Documents/Qt_Projects/Torantula-ng/Torantula-ng/Torantula/Torantula/spiders/

scrapy crawl dark --logfile=darkScanLog.log -a sites=/home/voldem0rt/Documents/Qt_Projects/Torantula-ng/Torantula-ng/Torantula/Torantula/spiders/sites.txt -a tor=True -a db=True

echo "Spider done crawling" 
date +"%Y/%d/%d %H:%M:%S" 









