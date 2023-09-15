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
drop procedure if exists dbo.extractMediaFeed
go

-- =================================================
--               File: extractMediaFeed
--        Created: 10/28/2020
--        Updated: 09/15/2023
--  Programmer: Cuates
--    Update By: Cuates
--        Purpose: Extract Media Feed
-- =================================================

-- Procedure Create
create procedure [dbo].[extractMediaFeed]
  -- Add the parameters for the stored procedure here
  @optionMode nvarchar(max),
  @titlelong nvarchar(max) = null,
  @titleshort nvarchar(max) = null,
  @actionstatus nvarchar(max) = null,
  @limit nvarchar(max) = null,
  @sort nvarchar(max) = null
as
begin
  -- Set nocount on added to prevent extra result sets from interfering with select statements
  set nocount on

  -- Declare variables
  declare @omitOptionMode as nvarchar(max)
  declare @omitTitleLong as nvarchar(max)
  declare @omitTitleShort as nvarchar(max)
  declare @omitInfoUrl as nvarchar(max)
  declare @omitActionStatus as nvarchar(max)
  declare @omitLimit as nvarchar(max)
  declare @omitSort as nvarchar(max)
  declare @maxLengthOptionMode as int
  declare @maxLengthActionDescription as int
  declare @maxLengthMediaAudioEncode as int
  declare @maxLengthMediaDynamicRange as int
  declare @maxLengthMediaResolution as int
  declare @maxLengthMediaStreamSource as int
  declare @maxLengthMediaStreamDescription as int
  declare @maxLengthMediaVideoEncode as int
  declare @maxLengthTitleLong as int
  declare @maxLengthTitleShort as int
  declare @maxLengthInfoUrl as int
  declare @maxLengthActionStatus as int
  declare @maxLengthSort as int
  declare @lowerLimit as int
  declare @upperLimit as int
  declare @defaultLimit as int
  declare @dSQL as nvarchar(max)
  declare @dSQLWhere as nvarchar(max) = ''

  -- Set variables
  set @omitOptionMode = N'0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitTitleLong = N'-,.,0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,[,],_,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitTitleShort = N'-,.,0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,[,],_,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitInfoUrl = N'-,.,/,%,?,=,&,:,0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,[,],_,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitActionStatus = N'0,1,2,3,4,5,6,7,8,9'
  set @omitLimit = N'-,0,1,2,3,4,5,6,7,8,9'
  set @omitSort = N'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @maxLengthOptionMode = 255
  set @maxLengthTitleLong = 255
  set @maxLengthTitleShort = 255
  set @maxLengthInfoUrl = 8000
  set @maxLengthActionStatus = 255
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
  if @titlelong is not null
    begin
      -- Omit characters
      set @titlelong = dbo.OmitCharacters(@titlelong, @omitTitleLong)

      -- Set character limit
      set @titlelong = trim(substring(@titlelong, 1, @maxLengthTitleLong))

      -- Check if empty string
      if @titlelong = ''
        begin
          -- Set parameter to null if empty string
          set @titlelong = nullif(@titlelong, '')
        end
    end

  -- Check if parameter is not null
  if @titleshort is not null
    begin
      -- Omit characters
      set @titleshort = dbo.OmitCharacters(@titleshort, @omitTitleShort)

      -- Set character limit
      set @titleshort = trim(substring(@titleshort, 1, @maxLengthTitleShort))

      -- Check if empty string
      if @titleshort = ''
        begin
          -- Set parameter to null if empty string
          set @titleshort = nullif(@titleshort, '')
        end
    end

  ---- Check if parameter is not null
  --if @infourl is not null
  --  begin
  --    -- Omit characters
  --    set @infourl = dbo.OmitCharacters(@infourl, @omitInfoUrl)

  --    -- Set character limit
  --    set @infourl = trim(substring(@infourl, 1, @maxLengthInfoUrl))

  --    -- Check if empty string
  --    if @infourl = ''
  --      begin
  --        -- Set parameter to null if empty string
  --        set @infourl = nullif(@infourl, '')
  --      end
  --  end

  -- Check if parameter is not null
  if @actionstatus is not null
    begin
      -- Omit characters
      set @actionstatus = dbo.OmitCharacters(@actionstatus, @omitActionStatus)

      -- Set character limit
      set @actionstatus = trim(substring(@actionstatus, 1, @maxLengthActionStatus))

      -- Check if empty string
      if @actionstatus = ''
        begin
          -- Set parameter to null if empty string
          set @actionstatus = nullif(@actionstatus, '')
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

  -- Else check if option mode is extract movie feed
  if @optionMode = 'extractMovieFeed'
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
      mf.titlelong as [titlelong],
      mf.titleshort as [titleshort],
	  mf.info_url as [infourl],
      format(mf.publish_date, ''yyyy-MM-dd HH:mm:ss.ffffff'',''en-us'') as [publishdate],
      cast(mf.actionstatus as nvarchar(255)) as [actionstatus]
      from dbo.MovieFeed mf'

      -- Check if where clause is given
      if @titlelong is not null
        begin
          -- Set variable
          set @dSQLWhere = 'mf.titlelong = @_titlelongString'
        end

      -- Check if where clause is given
      if @titleshort is not null
        begin
          -- Check if dynamic SQL is not empty
          if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
            begin
              -- Include the next filter into the where clause
              set @dSQLWhere = @dSQLWhere + ' and mf.titleshort = @_titleshortString'
            end
          else
            begin
              -- Include the next filter into the where clause
              set @dSQLWhere = 'mf.titleshort = @_titleshortString'
            end
        end

      -- Check if where clause is given
      if @actionstatus is not null
        begin
          -- Check if dynamic SQL is not empty
          if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
            begin
              -- Include the next filter into the where clause
              set @dSQLWhere = @dSQLWhere + ' and mf.actionstatus = (@_actionstatusString)'
            end
          else
            begin
              -- Include the next filter into the where clause
              set @dSQLWhere = 'mf.actionstatus = (@_actionstatusString)'
            end
        end

      -- Check if dynamic SQL is not empty
      if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
        begin
          -- Include the where clause
          set @dSQLWhere = ' where ' + @dSQLWhere
        end

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = @dSQL + @dSQLWhere + ' order by mf.publish_date ' + @sort + ', mf.titlelong ' + @sort + ', mf.titleshort ' + @sort + ', mf.actionstatus ' + @sort

      -- Execute dynamic statement with the parameterized values
      -- Important Note: Parameterizated values need to match the parameters they are matching at the top of the script
      exec sp_executesql @dSQL,
      N'@_titlelongString as nvarchar(255), @_titleshortString as nvarchar(255), @_actionstatusString int, @_limitString as int',
      @_titlelongString = @titlelong, @_titleshortString = @titleshort, @_actionstatusString = @actionstatus, @_limitString = @limit
    end

  -- Else check if option mode is extract tv feed
  else if @optionMode = 'extractTVFeed'
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
      tvf.titlelong as [titlelong],
      tvf.titleshort as [titleshort],
	  tvf.info_url as [infourl],
      format(tvf.publish_date, ''yyyy-MM-dd HH:mm:ss.ffffff'',''en-us'') as [publishdate],
      cast(tvf.actionstatus as nvarchar(255)) as [actionstatus]
      from dbo.TVFeed tvf'

      -- Check if where clause is given
      if @titlelong is not null
        begin
          -- Set variable
          set @dSQLWhere = 'tvf.titlelong = @_titlelongString'
        end

      -- Check if where clause is given
      if @titleshort is not null
        begin
          -- Check if dynamic SQL is not empty
          if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
            begin
              -- Include the next filter into the where clause
              set @dSQLWhere = @dSQLWhere + ' and tvf.titleshort = @_titleshortString'
            end
          else
            begin
              -- Include the next filter into the where clause
              set @dSQLWhere = 'tvf.titleshort = @_titleshortString'
            end
        end

      -- Check if where clause is given
      if @actionstatus is not null
        begin
          -- Check if dynamic SQL is not empty
          if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
            begin
              -- Include the next filter into the where clause
              set @dSQLWhere = @dSQLWhere + ' and tvf.actionstatus = (@_actionstatusString)'
            end
          else
            begin
              -- Include the next filter into the where clause
              set @dSQLWhere = 'tvf.actionstatus = (@_actionstatusString)'
            end
        end

      -- Check if dynamic SQL is not empty
      if ltrim(rtrim(@dSQLWhere )) <> ltrim(rtrim(''))
        begin
          -- Include the where clause
          set @dSQLWhere = ' where ' + @dSQLWhere
        end

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = @dSQL + @dSQLWhere + ' order by tvf.publish_date ' + @sort + ', tvf.titlelong ' + @sort + ', tvf.titleshort ' + @sort + ', tvf.actionstatus ' + @sort

      -- Execute dynamic statement with the parameterized values
      -- Important Note: Parameterizated values need to match the parameters they are matching at the top of the script
      exec sp_executesql @dSQL,
      N'@_titlelongString as nvarchar(255), @_titleshortString as nvarchar(255), @_actionstatusString int, @_limitString as int',
      @_titlelongString = @titlelong, @_titleshortString = @titleshort, @_actionstatusString = @actionstatus, @_limitString = @limit
    end
end
