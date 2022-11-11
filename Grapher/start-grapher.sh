#!/bin/sh
whoami
date

cd /home/voldem0rt/Documents/Qt_Projects/Torantula-ng/Torantula-ng/Grapher/

scrapy version
#scrapy
#scrapy list -h
#scrapy crawl -h

#python3 pre-processor.py /home/voldem0rt/Documents/Qt_Projects/Torantula-ng/Torantula-ng/Torantula/Clearscrape/Clearscrape/spiders/pageTexts/scrape_11-10_0833/ /home/voldem0rt/Documents/Qt_Projects/Torantula-ng/Torantula-ng/Torantula/Torantula/spiders/pageTexts/rinsed/

python GraphDataset.py /home/voldem0rt/Documents/Qt_Projects/Torantula-ng/Torantula-ng/Torantula/Clearscrape/Clearscrape/spiders/pageTexts/scrape_11-09_2242/

echo "Note: Results are stored in the Grapher directory"
