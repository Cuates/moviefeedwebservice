# MSSQL Function, Index, Stored Procedure, Table, and or View
> MSSQL database schema for this project

## Table of Contents
* [Important Note](#important-note)
* [Dependent MSSQL Function](#dependent-mssql-function)
* [Stored Procedure Usage](#stored-procedure-usage)

### **Important Note**
* This project was written with SQL Server 2019 methods

### Dependent MSSQL Function
* [Omit Characters](https://github.com/Cuates/omitcharactersmssql)

### Stored Procedure Usage
* `exec dbo.extractMediaFeed @optionMode = 'extractActionStatus', @actionnumber = 'actionNumberValue', @actiondescription = 'actionDescription', @limit = '25', @sort = 'desc'`
* `exec dbo.extractMediaFeed @optionMode = 'extractMediaAudioEncode', @audioencode = 'audioEncodeValue', @limit = '25', @sort = 'desc'`
* `exec dbo.extractMediaFeed @optionMode = 'extractMediaDynamicRange', @dynamicrange = 'dynamicRangeValue', @limit = '25', @sort = 'desc'`
* `exec dbo.extractMediaFeed @optionMode = 'extractMediaResolution', @resolution = 'resolutionValue', @limit = '25', @sort = 'desc'`
* `exec dbo.extractMediaFeed @optionMode = 'extractMediaStreamSource', @streamsource = 'streamSourceValue', @streamdescription = 'streamDescriptionValue', @limit = '25', @sort = 'desc'`
* `exec dbo.extractMediaFeed @optionMode = 'extractMediaVideoEncode', @videoencode = 'videoEncodeValue', @limit = '25', @sort = 'desc'`
* `exec dbo.extractMediaFeed @optionMode = 'extractMovieFeed', @titlelong = 'titleLongValue', @titleshort = 'titleShortValue', @actionstatus = 'actionStatusValue', @limit = '25', @sort = 'desc'`
* `exec dbo.extractMediaFeed @optionMode = 'extractTVFeed', @titlelong = 'titleLongValue', @titleshort = 'titleShortValue', @actionstatus = 'actionStatusValue', @limit = '25', @sort = 'desc'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'deleteActionStatus', @actionnumber = 'actionNumberValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'deleteMediaAudioEncode', @audioencode = 'audioEncodeValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'deleteMediaDynamicRange', @dynamicrange = 'dynamicRangeValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'deleteMediaResolution', @resolution = 'resolutionValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'deleteMediaStreamSource', @streamsource = 'streamSourceValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'deleteMediaVideoEncode', @videoencode = 'videoEncode'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'deleteMovieFeedTitleLong', @titlelong = 'titleLongValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'deleteMovieFeedTitleShort', @titleshort = 'titleShortValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'deleteTVFeedTitleLong', @titlelong = 'titleLongValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'deleteTVFeedTitleShort', @titleshort = 'titleShortValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'insertActionStatus', @actionnumber = 'actionNumberValue', @actiondescription = 'actionDescriptionValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'insertMediaAudioEncode', @audioencode = 'audioEncodeValue', @movieinclude = 'movieIncludeValue', @tvinclude = 'tvIncludeValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'insertMediaDynamicRange', @dynamicrange = 'dynamicRangeValue', @movieinclude = 'movieIncludeValue', @tvinclude = 'tvIncludeValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'insertMediaResolution', @resolution = 'resolutionValue', @movieinclude = 'movieIncludeValue', @tvinclude = 'tvIncludeValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'insertMediaStreamSource', @streamsource = 'streamSourceValue', @streamdescription = 'streamDescriptionValue', @movieinclude = 'movieIncludeValue', @tvinclude = 'tvIncludeValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'insertMediaVideoEncode', @videoencode = 'videoEncodeValue', @movieinclude = 'movieIncludeValue', @tvinclude = 'tvIncludeValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'insertMovieFeed', @titlelong = 'titleLongValue', @titleshort = 'titleShortValue', @publishdate = 'publishDateValue', @actionstatus = 'actionStatusValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'insertTVFeed', @titlelong = 'titleLongValue', @titleshort = 'titleShortValue', @publishdate = 'publishDateValue', @actionstatus = 'actionStatusValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'updateActionStatus', @actionnumber = 'actionNumberValue', @actiondescription = 'actionDescriptionValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'updateMediaAudioEncode', @audioencode = 'audioEncodeValue', @movieinclude = 'movieIncludeValue', @tvinclude = 'tvIncludeValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'updateMediaDynamicRange', @dynamicrange = 'dynamicRangeValue', @movieinclude = 'movieIncludeValue', @tvinclude = 'tvIncludeValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'updateMediaResolution', @resolution = 'resolutionValue', @movieinclude = 'movieIncludeValue', @tvinclude = 'tvIncludeValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'updateMediaResolution', @streamsource = 'streamSourceValue', @streamdescription = 'streamDescriptionValue', @movieinclude = 'movieIncludeValue', @tvinclude = 'tvIncludeValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'updateMediaVideoEncode', @videoencode = 'videoEncodeValue', @movieinclude = 'movieIncludeValue', @tvinclude = 'tvIncludeValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'updateMovieFeed', @titlelong = 'titleLongValue', @titleshort = 'titleShortValue', @publishdate = 'publishDateValue', @actionstatus = 'actionStatusValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'updateMovieFeedTitleShort', @titleshort = 'titleShortValue', @titleshortold = 'titleShortOldValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'updateMovieFeedTitleShortActionStatus', @titleshort = 'titleShortValue', @actionstatus = 'actionStatusValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'updateTVFeed', @titlelong = 'titleLongValue', @titleshort = 'titleShortValue', @publishdate = 'publishDateValue', @actionstatus = 'actionStatusValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'updateTVFeedTitleShort', @titleshort = 'titleShortValue', @titleshortold = 'titleShortOldValue'`
* `exec dbo.insertupdatedeleteMediaFeed @optionMode = 'updateTVFeedTitleShortActionStatus', @titleshort = 'titleShortValue', @actionstatus = 'actionStatusValue'`


* `exec dbo.extractNewsFeed @optionMode = 'extractNewsFeed', @title = 'titleValue', @imageurl = 'imageUrlValue', @feedurl = 'feedUrlValue', @actualurl = 'actualUrlValue', @limit = '25', @sort = 'desc'`
* `exec dbo.insertupdatedeleteNewsFeed @optionMode = 'deleteNewsFeed', @title = 'titleValue'`
* `exec dbo.insertupdatedeleteNewsFeed @optionMode = 'insertNewsFeed', @title = 'titleValue', @imageurl = 'imageUrlValue', @feedurl = 'feedUrlValue', @acutalurl = 'actualUrlValue', @publishdate = 'publishDateValue'`
* `exec dbo.insertupdatedeleteNewsFeed @optionMode = 'updateNewsFeed', @title = 'titleValue', @imageurl = 'imageUrlValue', @feedurl = 'feedUrlValue', @acutalurl = 'actualUrlValue', @publishdate = 'publishDateValue'`
