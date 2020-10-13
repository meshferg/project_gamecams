# Cuddeback Cuddelink camera network, using Home unit with WiFi sdcard
I built a Cuddeback game camera network that sends all images to a Home unit. From the Home unit, the images are sent to an FTP server using a wifi enable SD card in the Home unit. Received images trigger a python daemon that then SMS messages the images to my cell phone. This system has been haphazardly described by some posts on habitat-talk.com [here](http://habitat-talk.com/index.php?threads/cuddebacks-cuddelink.7859/page-49#post-182534).

I wanted to receive the images on my cell phone in near realtime, but did not want to use Cuddelink's cell system. (Cell-capable units weren't really available when I built this project 4 seasons ago, anyway.)

Thought I would post info about my setup and build. It may have limited lifespan due to issues with Toshiba's FlashAir cards (see Warnings, below). I will expand the sections of the "data pathway" below into sub-repositories that include hardware and code.

The data pathway is something like this:
```
Cudeback J cameras
	|
Cuddeback Home 1385 unit
	|
Toshiba FlashAir W-04 wifi SDCard [sd_wlan](./sd_wlan/README.md)                             \
	|                                                                                           \
FTP server (CentOS8)	                                                                         | (inside my network)
	|                                                                                           /
Image retriever, parser, formatter, transmitter, SMS trigger (python 3 daemon on CentOS8)    /
	|       |                                         \
  |     SMS compatible image placed on AWS S3 bucketdata decoder (AWS S3)
	|
SMS message sent via twilio
```
## Hardware
 - [Cuddeback Cuddelink J cameras](https://www.cuddeback.com/products/model-j-1415)
 - [Cuddeback Cuddelink Home 1385 receiver](https://www.cuddeback.com/products/cuddelink-home)
 - [Toshiba FlashAir SD card](https://smile.amazon.com/s?k=toshiba+flashair)

## Software/network services
 - [Amazon AWS S3 Boto3 python library](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/quickstart.html)
 - [twilio python library](https://pypi.org/project/twilio/)

## !Warnings! Seriously, read this if you are considering trying this.
 - Toshiba FlashAir cards are discontinued. The Toshiba developer site is gone, but some users are trying resurrect it [privately](https://www.reddit.com/r/flashair_developers/comments/cmbopo/flashairdeveloperscom_is_closing/). You may not be able to find any cards for other than ridiculously high prices. Searching finds other WiFi SD cards (e.g. Voorca, ez Share), but I know nothing about them.
 - My python daemon solution is highly over-engineered. I was doing a lot of playing and learning about some more enterprise-level concepts. I did not use a framework solution (e.g. django, flask, etc.), which would be an obviously useful tool for such a project.
 - The whole WiFi SD Card thing is a ridiculous, but unfortunately necessary, hack just to get the images off of the Home unit in realtime. The entire system would have been a 100x easier build if Cuddeback had in fact enabled the USB port on the Home unit.
 - Every step after the FTP-to-my-CentOS-server step is not really necessary if you just want to get the images. You could skip my entire python daemon and just move the images to a Dropbox folder (MS OneDrive, box.com, email, whatever). (The python daemon is the main guilty party in my over-engineering admission.)
 - My system's geography is unique; it's in my home. I live in location served by FIOS. My home is on high ground, so signals are easily received over distance. My home overlooks the ~20 acres I hunt, and is surrounded by hundreds of acres of conservation land (where I can't hunt, but I can put cameras).
 - Running an old-school FTP server (it's not sftp, FlashAir can't do that) is risky in so many ways. Know what you are doing!!

### Build notes
 
## Software

