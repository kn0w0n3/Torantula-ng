# Torantula | TOR Scraper
The Darknet Weathermap
![torantula-ng-11-9-22](https://user-images.githubusercontent.com/22214754/200957504-ec995cf2-80e1-4c4c-b444-70e7e174b1bf.gif)                        
  
This project contains several tools for scraping a vast amount of web sites and processing the downloaded HTML, with the intention of classifying the crawled domains automatically and eventually generating real-time content reports.      

**Torantula** is a web-scraper with the capability to crawl through the Tor network and download the HTML and links on each page it visits. Thus, the scraper can collect data from clear-net sites *and* Tor Hidden Services, and should never get banned from sites on either.

The **Pre-Processor** takes an output directory from Torantula as input, concatenates all the text found on a domain together, then performs several formatting and Natural-Language Processing functions on the text, including removing HTML elements and JavaScript, stemming, and language detection.

Finally, the utility within **Grapher** takes an output directory from Torantula as input as well, and generates *.json* and *.gexf* graph files for rendering by by a graphing application

## Requirements

* Python 2.7
* A Ubuntu-based Linux distribution is **HIGHLY RECOMMENDED**

## Examples of usage
### Torantula

Navigate all the way down to the /spiders/ directory from /Torantula/. To run the crawler on a list of sites specified in sites.txt:

`scrapy crawl dark -a sites=sites.txt`

The output will be a /scrape_month-date_time/ directory in Torantula/.../spiders/pageTexts structured as follows:

* scrape_month-date_time
    * randomDomain
        * main.txt
        * login.txt
        * found_links.txt
    * anotherDomain
        * main.txt
        * article.txt
        * found_links.txt
    * yetAnotherDomain...

Read Torantula's log file as a scrape is occuring:

`tail -f --retry /tmp/ScrapyResults.txt`

### Pre-Processor

Within /pre-processor/, run the following on a Torantula output directory:

`python pre-processor.py /pathTo/scrape_month-date_time/ /output/directory/`

The output will be a similar directory structure to that output by the crawler.



### Grapher
Generate domain connectivity graphs in .json and .gexf formats based on the data collected by Torantula for rendering by another application.

`python dataset.py /path/to/scrape_month-date_time/`

The output will be .json and .gexf files in /Grapher/

## Installation

It's **HIGHLY RECOMMENDED** that all python packages be installed in a *virtual environment* [
Python Virtual Environments with virtualenv](http://python-guide-pt-br.readthedocs.io/en/latest/dev/virtualenvs/)

Project Python Packages:

```
pip install scrapy networkx
pip install beautifulsoup4 nltk
```


Database Packages:
```
sudo apt-get install mysql-server && sudo apt-get install libmysqlclient-dev
pip install mysqlclient
```

Tor integration packages:
```
sudo apt-get install privoxy
sudo apt-get install tor
```

There is an easier way to install all necessary Python packages at once. Find pyreqs.txt within the top of the project, and run:

`pip install -r pyreqs.txt`



## Configuration
### Torantula

#### Sites to start scraping:
Torantula will start scraping from a user-defined set of sites but will also scrape from other sites discovered during the crawl. Sites to start scrapes from should be placed within .txt files in Torantula/.../spiders/

#### Ignore Domains:
Torantula automatically filters out requests and responses from encountered top-level domains once they have been visited enough times (defined within Torantula/.../spiders/domaincount.py).

* Any domains you want the spider to automatically ignore can be placed within /spiders/ignoreDomains.txt

#### Bad Keywords:
Torantula will automatically throw out content that contains certain keywords and ignore domains that contain those keywords for the rest of the scraping session.

* place strings that indicate content to be filtered within /spiders/keywords.txt

#### Settings:

Torantula has a vast amount of customizable settings within settings.py
* Within SCRAPY SPEED SETTINGS, download timings and concurrent request parameters can be configured, based on network and system capability.
* Within CRAWL BEHAVIOR, the depth_limit of scrapes can be modified, as well as if the scraper should prioritize depth-first or breadth-first crawls. If you're doing a more focused crawl, retries and redirects can be modified as necessary.

## Tests

#### Grapher

#### Torantula

[find virginia tech steam tunnels site for testing tor integration]

#### Pre-processor

## Package Information

#### Scrapy
The Python framework on which Torantula was built

[Main page](https://scrapy.org/)

[Documentation](https://doc.scrapy.org/en/latest/index.html)

#### Privoxy
The socket proxy which routes Torantula's requests through the Tor network

[Main page](https://www.privoxy.org/)

[Documentation]()

#### Tor
#### Networkx
#### NLTK
#### Beautifulsoup
#### MySQL

## Contributors

Oliver Hui - 2016 - Torantula base design and implementation

Joshua McGiff - 2017 - Pre-processor and data storage/handling

John-Luke Navarro -2017 - Torantula extensive development and data graphing

## License

## Scrapy Example Issues  

1) Invalid Syntax.   

![scrapy-tutorial-invalid-syntax-11-5-22](https://user-images.githubusercontent.com/22214754/200114785-b88022ed-1ad7-495f-9e62-3761b405050a.png)  

Remove the f in: filename = f'quotes-{page}.html'   

The new line shoul dlook like this: filename = 'quotes-{page}.html'   

2) cannot import name suppress  
   
https://stackoverflow.com/questions/68288772/using-python2-and-scrapy-importerror-cannot-import-name-suppress      

![issue-fix-one-11-4-22](https://user-images.githubusercontent.com/22214754/200114314-f59923af-d0fb-41b3-93b8-bf5bab2558a9.png)  

# Ubuntu 20.04 Errors

1) No module name MySQLdb

Solution: 
$ sudo add-apt-repository 'deb http://archive.ubuntu.com/ubuntu bionic main'  
$ sudo apt update  
$ sudo apt install -y python-mysqldb  

# Developed with:      

![github-linux-logo-kernel-corn](https://user-images.githubusercontent.com/22214754/196063512-495e0624-c344-4b32-9507-0f4fbc85a633.png)      

# **Operating System:**  

![ubuntu-logo-with-os-info-w3](https://user-images.githubusercontent.com/22214754/196061656-421dd522-86bc-4596-aa12-04a51b8627d3.png)              

# **IDE:**     
![QtLogo](https://user-images.githubusercontent.com/22214754/179895211-d52559ab-35df-4fcc-bf69-7377739330d4.png)  
Qt Creator 4.12.3  
Based on Qt 5.14.2 (MSVC 2017, 32 bit)  
Built on Jun 16 2020 01:19:17  
From revision 48e46132e3  
https://www.qt.io/ 

Framework:  
Qt framework 5.15.0 

# **Database:**        
![sqlitefg](https://user-images.githubusercontent.com/22214754/179894516-3059e142-fb38-40bc-a32c-65500a223eb1.png)    
https://www.sqlite.org/index.html    
https://sqlitestudio.pl  

# **Programming Languages:**  
![python-logo-trans-450x150](https://user-images.githubusercontent.com/22214754/200187037-b4005612-358b-4af8-be9d-a5aedd9bb85a.png)  


