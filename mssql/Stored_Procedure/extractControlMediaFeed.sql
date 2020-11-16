-- Database Connect
use [Media]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- Procedure Drop
drop procedure if exists dbo.extractControlMediaFeed
go

-- =================================================
--       File: extractControlMediaFeed
--    Created: 11/16/2020
--    Updated: 11/16/2020
-- Programmer: Cuates
--  Update By: Cuates
--    Purpose: Extract Control Media Feed
-- =================================================

-- Procedure Create
create procedure [dbo].[extractControlMediaFeed]
  -- Add the parameters for the stored procedure here
  @optionMode nvarchar(max),
  @actionnumber nvarchar(max) = null,
  @actiondescription nvarchar(max) = null,
  @audioencode nvarchar(max) = null,
  @dynamicrange nvarchar(max) = null,
  @resolution nvarchar(max) = null,
  @streamsource nvarchar(max) = null,
  @streamdescription nvarchar(max) = null,
  @videoencode nvarchar(max) = null,
  @limit nvarchar(max) = null,
  @sort nvarchar(max) = null
as
begin
  -- Set nocount on added to prevent extra result sets from interfering with select statements
  set nocount on

  -- Declare variables
  declare @omitOptionMode as nvarchar(max)
  declare @omitActionNumber as nvarchar(max)
  declare @omitActionDescription as nvarchar(max)
  declare @omitMediaAudioEncode as nvarchar(max)
  declare @omitMediaDynamicRange as nvarchar(max)
  declare @omitMediaResolution as nvarchar(max)
  declare @omitMediaStreamSource as nvarchar(max)
  declare @omitMediaStreamDescription as nvarchar(max)
  declare @omitMediaVideoEncode as nvarchar(max)
  declare @omitLimit as nvarchar(max)
  declare @omitSort as nvarchar(max)
  declare @maxLengthOptionMode as int
  declare @maxLengthActionNumber as int
  declare @maxLengthActionDescription as int
  declare @maxLengthMediaAudioEncode as int
  declare @maxLengthMediaDynamicRange as int
  declare @maxLengthMediaResolution as int
  declare @maxLengthMediaStreamSource as int
  declare @maxLengthMediaStreamDescription as int
  declare @maxLengthMediaVideoEncode as int
  declare @maxLengthTitleLong as int
  declare @maxLengthTitleShort as int
  declare @maxLengthSort as int
  declare @lowerLimit as int
  declare @upperLimit as int
  declare @defaultLimit as int
  declare @dSQL as nvarchar(max)
  declare @dSQLWhere as nvarchar(max) = ''

  -- Set variables
  set @omitOptionMode = N'0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitActionNumber = N'0,1,2,3,4,5,6,7,8,9'
  set @omitActionDescription = N'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitMediaAudioEncode = N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9,.,-'
  set @omitMediaDynamicRange = N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z'
  set @omitMediaResolution = N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9'
  set @omitMediaStreamSource = N'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitMediaStreamDescription = N'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitMediaVideoEncode = N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9'
  set @omitLimit = N'-,0,1,2,3,4,5,6,7,8,9'
  set @omitSort = N'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @maxLengthOptionMode = 255
  set @maxLengthActionNumber = 255
  set @maxLengthActionDescription = 255
  set @maxLengthMediaAudioEncode = 100
  set @maxLengthMediaDynamicRange = 100
  set @maxLengthMediaResolution = 100
  set @maxLengthMediaStreamSource = 100
  set @maxLengthMediaStreamDescription = 100
  set @maxLengthMediaVideoEncode = 100
  set @maxLengthSort = 255
  set @lowerLimit = 1
  set @upperLimit = 100
  set @defaultLimit = 25

  -- Check if parameter is not null
  if @optionMode is not null
    begin
      -- Omit characters
      set @optionMode = dbo.OmitCharacters(@optionMode, @omitOptionMode)

      -- Set character limit
      set @optionMode = trim(substring(@optionMode, 1, @maxLengthOptionMode))

      -- Check if empty string
      if @optionMode = ''
        begin
          -- Set parameter to null if empty string
          set @optionMode = nullif(@optionMode, '')
        end
    end

  -- Check if parameter is not null
  if @actionnumber is not null
    begin
      -- Omit characters
      set @actionnumber = dbo.OmitCharacters(@actionnumber, @omitActionNumber)

      -- Set character limit
      set @actionnumber = trim(substring(@actionnumber, 1, @maxLengthActionNumber))

      -- Check if empty string
      if @actionnumber = ''
        begin
          -- Set parameter to null if empty string
          set @actionnumber = nullif(@actionnumber, '')
        end
    end

  -- Check if parameter is not null
  if @actiondescription is not null
    begin
      -- Omit characters
      set @actiondescription = dbo.OmitCharacters(@actiondescription, @omitActionDescription)

      -- Set character limit
      set @actiondescription = trim(substring(@actiondescription, 1, @maxLengthActionDescription))

      -- Check if empty string
      if @actiondescription = ''
        begin
          -- Set parameter to null if empty string
          set @actiondescription = nullif(@actiondescription, '')
        end
    end

  -- Check if parameter is not null
  if @audioencode is not null
    begin
      -- Omit characters
      set @audioencode = dbo.OmitCharacters(@audioencode, @omitMediaAudioEncode)

      -- Set character limit
      set @audioencode = trim(substring(@audioencode, 1, @maxLengthMediaAudioEncode))

      -- Check if empty string
      if @audioencode = ''
        begin
          -- Set parameter to null if empty string
          set @audioencode = nullif(@audioencode, '')
        end
    end

  -- Check if parameter is not null
  if @dynamicrange is not null
    begin
      -- Omit characters
      set @dynamicrange = dbo.OmitCharacters(@dynamicrange, @omitMediaDynamicRange)

      -- Set character limit
      set @dynamicrange = trim(substring(@dynamicrange, 1, @maxLengthMediaDynamicRange))

      -- Check if empty string
      if @dynamicrange = ''
        begin
          -- Set parameter to null if empty string
          set @dynamicrange = nullif(@dynamicrange, '')
        end
    end

  -- Check if parameter is not null
  if @resolution is not null
    begin
      -- Omit characters
      set @resolution = dbo.OmitCharacters(@resolution, @omitMediaResolution)

      -- Set character limit
      set @resolution = trim(substring(@resolution, 1, @maxLengthMediaResolution))

      -- Check if empty string
      if @resolution = ''
        begin
          -- Set parameter to null if empty string
          set @resolution = nullif(@resolution, '')
        end
    end

  -- Check if parameter is not null
  if @streamsource is not null
    begin
      -- Omit characters
      set @streamsource = dbo.OmitCharacters(@streamsource, @omitMediaStreamSource)

      -- Set character limit
      set @streamsource = trim(substring(@streamsource, 1, @maxLengthMediaStreamSource))

      -- Check if empty string
      if @streamsource = ''
        begin
          -- Set parameter to null if empty string
          set @streamsource = nullif(@streamsource, '')
        end
    end

  -- Check if parameter is not null
  if @streamdescription is not null
    begin
      -- Omit characters
      set @streamdescription = dbo.OmitCharacters(@streamdescription, @omitMediaStreamDescription)

      -- Set character limit
      set @streamdescription = trim(substring(@streamdescription, 1, @maxLengthMediaStreamDescription))

      -- Check if empty string
      if @streamdescription = ''
        begin
          -- Set parameter to null if empty string
          set @streamdescription = nullif(@streamdescription, '')
        end
    end

  -- Check if parameter is not null
  if @videoencode is not null
    begin
      -- Omit characters
      set @videoencode = dbo.OmitCharacters(@videoencode, @omitMediaVideoEncode)

      -- Set character limit
      set @videoencode = trim(substring(@videoencode, 1, @maxLengthMediaVideoEncode))

      -- Check if empty string
      if @videoencode = ''
        begin
          -- Set parameter to null if empty string
          set @videoencode = nullif(@videoencode, '')
        end
    end

  -- Check if parameter is not null
  if @limit is not null
    begin
      -- Omit characters
      set @limit = dbo.OmitCharacters(@limit, @omitLimit)

      -- Set character limit
      set @limit = trim(@limit)

      -- Check if empty string
      if @limit = ''
        begin
          -- Set parameter to null if empty string
          set @limit = nullif(@limit, '')
        end
    end

  -- Check if parameter is not null
  if @sort is not null
    begin
      -- Omit characters
      set @sort = dbo.OmitCharacters(@sort, @omitSort)

      -- Set character limit
      set @sort = trim(substring(@sort, 1, @maxLengthSort))

      -- Check if empty string
      if @sort = ''
        begin
          -- Set parameter to null if empty string
          set @sort = nullif(@sort, '')
        end
    end

  -- Check if option mode is extract action status
  if @optionMode = 'extractActionStatus'
    begin
      -- Check if limit is given
      if @limit is null or @limit not between @lowerLimit and @upperLimit
        begin
          -- Set limit to default number
          set @limit = @defaultLimit
        end

      -- Check if sort is given
      if @sort is null or lower(@sort) not in ('desc', 'asc')
        begin
          -- Set sort to default sorting
          set @sort = 'asc'
        end

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      set @dSQL =
      'select
      top (@_limitString)
      ast.actionnumber as [Action Status],
      ast.actiondescription as [Action Description]
      from dbo.ActionStatus ast'

      -- Check if where clause is given
      if @actionnumber is not null
        begin
          -- Set variable
          set @dSQLWhere = 'ast.actionnumber = (@_actionnumberString)'
        end

      -- Check if where clause is given
      if @actiondescription is not null
        begin
          -- Check if dynamic SQL is not empty
          if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
            begin
              -- Include the next filter into the where clause
              set @dSQLWhere = @dSQLWhere + ' and ast.actiondescription = @_actiondescriptionString'
            end
          else
            begin
              -- Include the next filter into the where clause
              set @dSQLWhere = 'ast.actiondescription = @_actiondescriptionString'
            end
        end

      -- Check if dynamic SQL is not empty
      if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
        begin
          -- Include the where clause
          set @dSQLWhere = ' where ' + @dSQLWhere
        end

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = @dSQL + @dSQLWhere + ' order by ast.actionnumber ' + @sort + ', ast.actiondescription ' + @sort

      -- Execute dynamic statement with the parameterized values
      -- Important Note: Parameterizated values need to match the parameters they are matching at the top of the script
      exec sp_executesql @dSQL,
      N'@_actionnumberString as int, @_actiondescriptionString as nvarchar(255), @_limitString as int',
      @_actionnumberString = @actionnumber, @_actiondescriptionString = @actiondescription, @_limitString = @limit
    end

  -- Else check if option mode is extract media audio encode
  else if @optionMode = 'extractMediaAudioEncode'
    begin
      -- Check if limit is given
      if @limit is null or @limit not between @lowerLimit and @upperLimit
        begin
          -- Set limit to default number
          set @limit = @defaultLimit
        end

      -- Check if sort is given
      if @sort is null or lower(@sort) not in ('desc', 'asc')
        begin
          -- Set sort to default sorting
          set @sort = 'asc'
        end

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      set @dSQL =
      'select
      top (@_limitString)
      mae.audioencode as [Audio Encode],
      mae.movieInclude as [Movie Include],
      mae.tvInclude as [TV Include]
      from dbo.MediaAudioEncode mae'

      -- Check if where clause is given
      if @audioencode is not null
        begin
          set @dSQLWhere = 'mae.audioencode = @_audioencodeString'
        end

      -- Check if dynamic SQL is not empty
      if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
        begin
          -- Include the where clause
          set @dSQLWhere = ' where ' + @dSQLWhere
        end

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = @dSQL + @dSQLWhere + ' order by mae.audioencode ' + @sort

      -- Execute dynamic statement with the parameterized values
      -- Important Note: Parameterizated values need to match the parameters they are matching at the top of the script
      exec sp_executesql @dSQL,
      N'@_audioencodeString nvarchar(100), @_limitString as int',
      @_audioencodeString = @audioencode, @_limitString = @limit
    end

-- Else check if option mode is delete temp tv
  else if @optionMode = 'extractMediaDynamicRange'
    begin
      -- Check if limit is given
      if @limit is null or @limit not between @lowerLimit and @upperLimit
        begin
          -- Set limit to default number
          set @limit = @defaultLimit
        end

      -- Check if sort is given
      if @sort is null or lower(@sort) not in ('desc', 'asc')
        begin
          -- Set sort to default sorting
        set @sort = 'asc'
        end

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      set @dSQL =
      'select
      top (@_limitString)
      mdr.dynamicrange as [Dynamic Range],
      mdr.movieInclude as [Movie Include],
      mdr.tvInclude as [TV Include]
      from dbo.MediaDynamicRange mdr'

      -- Check if where clause is given
      if @dynamicrange is not null
        begin
          -- Set variable
          set @dSQLWhere = 'mdr.dynamicrange = @_dynamicrangeString'
        end

      -- Check if dynamic SQL is not empty
      if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
        begin
          -- Include the where clause
          set @dSQLWhere = ' where ' + @dSQLWhere
        end

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = @dSQL + @dSQLWhere + ' order by mdr.dynamicrange ' + @sort

      -- Execute dynamic statement with the parameterized values
      -- Important Note: Parameterizated values need to match the parameters they are matching at the top of the script
      exec sp_executesql @dSQL,
      N'@_dynamicrangeString nvarchar(100), @_limitString as int',
      @_dynamicrangeString = @dynamicrange, @_limitString = @limit
    end

  -- Else check if option mode is extract media resolution
  else if @optionMode = 'extractMediaResolution'
    begin
      -- Check if limit is given
      if @limit is null or @limit not between @lowerLimit and @upperLimit
        begin
          -- Set limit to default number
          set @limit = @defaultLimit
        end

      -- Check if sort is given
      if @sort is null or lower(@sort) not in ('desc', 'asc')
        begin
          -- Set sort to default sorting
          set @sort = 'asc'
        end

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      set @dSQL =
      'select
      top (@_limitString)
      mr.resolution as [Resolution],
      mr.movieInclude as [Movie Include],
      mr.tvInclude as [TV Include]
      from dbo.MediaResolution mr'

      -- Check if where clause is given
      if @resolution is not null
        begin
          -- Set variable
          set @dSQLWhere = 'mr.resolution = @_resolutionString'
        end

      -- Check if dynamic SQL is not empty
      if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
        begin
          -- Include the where clause
          set @dSQLWhere = ' where ' + @dSQLWhere
        end

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = @dSQL + @dSQLWhere + ' order by mr.resolution ' + @sort

      -- Execute dynamic statement with the parameterized values
      -- Important Note: Parameterizated values need to match the parameters they are matching at the top of the script
      exec sp_executesql @dSQL,
      N'@_resolutionString nvarchar(100), @_limitString as int',
      @_resolutionString = @resolution, @_limitString = @limit
    end

  -- Else check if option mode is extract media stream source
  else if @optionMode = 'extractMediaStreamSource'
    begin
      -- Check if limit is given
      if @limit is null or @limit not between @lowerLimit and @upperLimit
        begin
          -- Set limit to default number
          set @limit = @defaultLimit
        end

      -- Check if sort is given
      if @sort is null or lower(@sort) not in ('desc', 'asc')
        begin
          -- Set sort to default sorting
          set @sort = 'asc'
        end

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      set @dSQL =
      'select
      top (@_limitString)
      mss.streamsource as [Stream Source],
      mss.streamdescription as [Stream Description],
      mss.movieInclude as [Movie Include],
      mss.tvInclude as [TV Include]
      from dbo.MediaStreamSource mss'

      -- Check if where clause is given
      if @streamsource is not null
        begin
          -- Set variable
          set @dSQLWhere = 'mss.streamsource = @_streamsourceString'
        end

      -- Check if where clause is given
      if @streamdescription is not null
        begin
          -- Check if dynamic SQL is not empty
          if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
            begin
              -- Include the next filter into the where clause
              set @dSQLWhere = @dSQLWhere + ' and mss.streamdescription = @_streamdescriptionString'
            end
          else
            begin
              -- Include the next filter into the where clause
              set @dSQLWhere = 'mss.streamdescription = @_streamdescriptionString'
            end
        end

      -- Check if dynamic SQL is not empty
      if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
        begin
          -- Include the where clause
          set @dSQLWhere = ' where ' + @dSQLWhere
        end

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = @dSQL + @dSQLWhere + ' order by mss.streamsource ' + @sort + ', mss.streamdescription ' + @sort

      -- Execute dynamic statement with the parameterized values
      -- Important Note: Parameterizated values need to match the parameters they are matching at the top of the script
      exec sp_executesql @dSQL,
      N'@_streamsourceString as nvarchar(100), @_streamdescriptionString as nvarchar(100), @_limitString as int',
      @_streamsourceString = @streamsource, @_streamdescriptionString = @streamdescription, @_limitString = @limit
    end

  -- Else check if option mode is extract media video encode
  else if @optionMode = 'extractMediaVideoEncode'
    begin
      -- Check if limit is given
      if @limit is null or @limit not between @lowerLimit and @upperLimit
        begin
          -- Set limit to default number
          set @limit = @defaultLimit
        end

      -- Check if sort is given
      if @sort is null or lower(@sort) not in ('desc', 'asc')
        begin
          -- Set sort to default sorting
          set @sort = 'asc'
        end

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      set @dSQL =
      'select
      top (@_limitString)
      mve.videoencode as [Video Encode],
      mve.movieInclude as [Movie Include],
      mve.tvInclude as [TV Include]
      from dbo.MediaVideoEncode mve'

      -- Check if where clause is given
      if @videoencode is not null
        begin
          -- Set variable
          set @dSQLWhere = 'mve.videoencode = @_videoencodeString'
        end

      -- Check if dynamic SQL is not empty
      if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
        begin
          -- Include the where clause
          set @dSQLWhere = ' where ' + @dSQLWhere
        end

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = @dSQL + @dSQLWhere + ' order by mve.videoencode ' + @sort

      -- Execute dynamic statement with the parameterized values
      -- Important Note: Parameterizated values need to match the parameters they are matching at the top of the script
      exec sp_executesql @dSQL,
      N'@_videoencodeString nvarchar(100), @_limitString as int',
      @_videoencodeString = @videoencode, @_limitString = @limit
    end
end