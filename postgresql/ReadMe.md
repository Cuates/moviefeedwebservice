# MariaDB Function, Index, Stored Procedure, Table, and or View
> PostgreSQL database schema for this project

## Table of Contents
* [Important Note](#important-note)
* [Stored Procedure Usage](#stored-procedure-usage)
* [Function Usage](#function-usage)

### **Important Note**
* This project was written with PostgreSQL 13 methods

### Stored Procedure Usage
* `call insertupdatedeletemediafeed ('deleteActionStatus', 'actionNumberValue', '', '', '', '', '', '', '', '', '', '', '', '', '', '')`
* `call insertupdatedeletemediafeed ('deleteMediaAudioEncode', '', '', 'audioEncodeValue', '', '', '', '', '', '', '', '', '', '', '', '')`
* `call insertupdatedeletemediafeed ('deleteMediaDynamicRange', '', '', '', 'dynamicRangeValue', '', '', '', '', '', '', '', '', '', '', '')`
* `call insertupdatedeletemediafeed ('deleteMediaResolution', '', '', '', '', 'resolutionValue', '', '', '', '', '', '', '', '', '', '')`
* `call insertupdatedeletemediafeed ('deleteMediaStreamSource', '', '', '', '', '', 'streamSourceValue', '', '', '', '', '', '', '', '', '')`
* `call insertupdatedeletemediafeed ('deleteMediaVideoEncode', '', '', '', '', '', '', '', 'videoEncode', '', '', '', '', '', '', '')`
* `call insertupdatedeletemediafeed ('deleteMovieFeed', '', '', '', '', '', '', '', '', 'titleLongValue', '', '', '', '', '', '')`
* `call insertupdatedeletemediafeed ('deleteMovieFeedTitleShort', '', '', '', '', '', '', '', '', '', 'titleShortValue', '', '', '', '', '')`
* `call insertupdatedeletemediafeed ('deleteTVFeed', '', '', '', '', '', '', '', '', 'titleLongValue', '', '', '', '', '', '')`
* `call insertupdatedeletemediafeed ('deleteTVFeedTitleShort', '', '', '', '', '', '', '', '', '', 'titleShortValue', '', '', '', '', '')`
* `call insertupdatedeletemediafeed ('insertActionStatus', 'actionNumberValue', 'actionDescriptionValue', '', '', '', '', '', '', '', '', '', '', '', '', '')`
* `call insertupdatedeletemediafeed ('insertMediaAudioEncode', '', '', 'audioEncodeValue', '', '', '', '', '', '', '', '', '', '', 'movieIncludeValue', 'tvIncludeValue')`
* `call insertupdatedeletemediafeed ('insertMediaDynamicRange', '', '', '', 'dynamicRangeValue', '', '', '', '', '', '', '', '', '', 'movieIncludeValue', 'tvIncludeValue')`
* `call insertupdatedeletemediafeed ('insertMediaResolution', '', '', '', '', '', 'resolutionValue', '', '', '', '', '', '', '', '', 'movieIncludeValue', 'tvIncludeValue')`
* `call insertupdatedeletemediafeed ('insertMediaStreamSource', '', '', '', '', '', '', 'streamSourceValue', 'streamDescriptionValue', '', '', '', '', '', 'movieIncludeValue', 'tvIncludeValue')`
* `call insertupdatedeletemediafeed ('insertMediaVideoEncode', '', '', '', '', '', '', '', '', 'videoEncodeValue', '', '', '', '', 'movieIncludeValue', 'tvIncludeValue')`
* `call insertupdatedeletemediafeed ('insertMovieFeed', '', '', '', '', '', '', '', 'titleLongValue', 'titleShortValue', '', 'publishDateValue', 'actionStatusValue', '', '', '')`
* `call insertupdatedeletemediafeed ('insertTVFeed', '', '', '', '', '', '', '', 'titleLongValue', 'titleShortValue', '', 'publishDateValue', 'actionStatusValue', '', '', '')`
* `call insertupdatedeletemediafeed ('updateActionStatus', 'actionNumberValue', 'actionDescriptionValue', '', '', '', '', '', '', '', '', '', '', '', '', '')`
* `call insertupdatedeletemediafeed ('updateMediaAudioEncode', '', '', 'audioEncodeValue', '', '', '', '', '', '', '', '', '', '', 'movieIncludeValue', 'tvIncludeValue')`
* `call insertupdatedeletemediafeed ('updateMediaDynamicRange', '', '', '', 'dynamicRangeValue', '', '', '', '', '', '', '', '', '', 'movieIncludeValue', 'tvIncludeValue')`
* `call insertupdatedeletemediafeed ('updateMediaResolution', '', '', '', '', 'resolutionValue', '', '', '', '', '', '', '', '', 'movieIncludeValue', 'tvIncludeValue')`
* `call insertupdatedeletemediafeed ('updateMediaResolution', '', '', '', '', '', 'streamSourceValue', 'streamDescriptionValue', '', '', '', '', '', '', 'movieIncludeValue', 'tvIncludeValue')`
* `call insertupdatedeletemediafeed ('updateMediaVideoEncode', '', '', '', '', '', '', '', 'videoEncodeValue', '', '', '', '', '', 'movieIncludeValue', 'tvIncludeValue')`
* `call insertupdatedeletemediafeed ('updateMovieFeed', '', '', '', '', '', '', '', '', 'titleLongValue', 'titleShortValue', '', 'publishDateValue', 'actionStatusValue', '', '')`
* `call insertupdatedeletemediafeed ('updateMovieFeedTitleShort', '', '', '', '', '', '', '', '', '', 'titleShortValue', 'titleShortOldValue', '', '', '', '')`
* `call insertupdatedeletemediafeed ('updateMovieFeedTitleShortActionStatus', '', '', '', '', '', '', '', '', '', 'titleShortValue', '', '', 'actionStatusValue', '', '')`
* `call insertupdatedeletemediafeed ('updateTVFeed', '', '', '', '', '', '', '', '', 'titleLongValue', 'titleShortValue', '', 'publishDateValue', 'actionStatusValue', '', '')`
* `call insertupdatedeletemediafeed ('updateTVFeedTitleShort', '', '', '', '', '', '', '', '', '', 'titleShortValue', 'titleShortOldValue', '', '', '', '')`
* `call insertupdatedeletemediafeed ('updateTVFeedTitleShortActionStatus', '', '', '', '', '', '', '', '', '', 'titleShortValue', '', '', 'actionStatusValue', '', '')`

### Function Usage
* `select actionnumberreturn as "Action Number", actiondescriptionreturn as "Action Description" from extractmediafeed ('extractActionStatus', 'actionNumberValue', 'actionDescription', '', '', '', '', '', '', '', '', '', 'limitValue', 'sortValue')`
* `select audioencodereturn as "Audio Encode", movieincludereturn as "Movie Include", tvincludereturn as "TV Include" from extractmediafeed ('extractMediaAudioEncode', '', '', 'audioEncodeValue', '', '', '', '', '', '', '', '', 'limitValue', 'sortValue')`
* `select dynamicrangereturn as "Dynamic Range", movieincludereturn as "Movie Include", tvincludereturn as "TV Include" from extractmediafeed ('extractMediaDynamicRange', '', '', '', 'dynamicRangeValue', '', '', '', '', '', '', '', 'limitValue', 'sortValue')`
* `select resolutionreturn as "Resolution", movieincludereturn as "Movie Include", tvincludereturn as "TV Include" from extractmediafeed ('extractMediaResolution', '', '', '', '', 'resolutionValue', '', '', '', '', '', '', 'limitValue', 'sortValue')`
* `select streamsourcereturn as "Stream Source", streamdescriptionreturn as "Stream Description", movieincludereturn as "Movie Include", tvincludereturn as "TV Include" from extractmediafeed ('extractMediaStreamSource', '', '', '', '', '', 'streamSourceValue', 'streamDescriptionValue', '', '', '', '', 'limitValue', 'sortValue')`
* `select videoencodereturn as "Video Encode", movieincludereturn as "Movie Include", tvincludereturn as "TV Include" from extractmediafeed ('extractMediaVideoEncode', '', '', '', '', '', '', '', 'videoEncodeValue', '', '', '', 'limitValue', 'sortValue')`
* `select titlelongreturn as "Title Long", titleshortreturn as "Title Short", publishdatereturn as "Publish Date", actionstatusreturn as "Action Status" from extractmediafeed ('extractMovieFeed', '', '', '', '', '', '', '', '', 'titleLongValue', 'titleShortValue', 'actionStatusValue', '', 'limitValue', 'sortValue')`
* `select titlelongreturn as "Title Long", titleshortreturn as "Title Short", publishdatereturn as "Publish Date", actionstatusreturn as "Action Status" from extractmediafeed ('extractTVFeed', '', '', '', '', '', '', '', '', 'titleLongValue', 'titleShortValue', 'actionStatusValue', '', 'limitValue', 'sortValue')`
