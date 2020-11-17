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
drop procedure if exists dbo.insertupdatedeleteMediaFeed
go

-- ================================================
--        File: insertupdatedeleteMediaFeed
--     Created: 11/05/2020
--     Updated: 11/17/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert update delete media feed
-- ================================================

-- Procedure Create
create procedure [dbo].[insertupdatedeleteMediaFeed]
  -- Add the parameters for the stored procedure here
  @optionMode nvarchar(max),
  @titlelong nvarchar(max) = null,
  @titleshort nvarchar(max) = null,
  @titleshortold nvarchar(max) = null,
  @publishdate nvarchar(max) = null,
  @actionstatus nvarchar(max) = null
as
begin
  -- Set nocount on added to prevent extra result sets from interfering with select statements
  set nocount on

  -- Declare variables
  declare @omitOptionMode as nvarchar(max)
  declare @omitTitleLong as nvarchar(max)
  declare @omitTitleShort as nvarchar(max)
  declare @omitPublishDate as nvarchar(max)
  declare @omitActionStatus as nvarchar(max)
  declare @omitMovieInclude as nvarchar(max)
  declare @omitTVInclude as nvarchar(max)
  declare @maxLengthOptionMode as int
  declare @maxLengthTitleLong as int
  declare @maxLengthTitleShort as int
  declare @maxLengthActionStatus as int
  declare @maxLengthPublishDate as int
  declare @result as nvarchar(max)

  -- Set variables
  set @omitOptionMode = N'0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitTitleLong = N'-,.,0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,[,],_,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitTitleShort = N'-,.,0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,[,],_,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitPublishDate = N' ,-,/,0,1,2,3,4,5,6,7,8,9,:,.'
  set @omitActionStatus = N'0,1,2,3,4,5,6,7,8,9'
  set @maxLengthOptionMode = 255
  set @maxLengthTitleLong = 255
  set @maxLengthTitleShort = 255
  set @maxLengthPublishDate = 255
  set @maxLengthActionStatus = 255
  set @result = ''

  -- Check if parameter is not null
  if @optionMode is not null
    begin
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set @optionMode = dbo.omitcharacters(@optionMode, @omitOptionMode)

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

  -- Check if parameter is not null
  if @titleshortold is not null
    begin
      -- Omit characters
      set @titleshortold = dbo.OmitCharacters(@titleshortold, @omitTitleShort)

      -- Set character limit
      set @titleshortold = trim(substring(@titleshortold, 1, @maxLengthTitleShort))

      -- Check if empty string
      if @titleshortold = ''
        begin
          -- Set parameter to null if empty string
          set @titleshortold = nullif(@titleshortold, '')
        end
    end

  -- Check if parameter is not null
  if @publishdate is not null
    begin
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set @publishdate = dbo.omitcharacters(@publishdate, @omitPublishDate)

      -- Set character limit
      set @publishdate = trim(substring(@publishdate, 1, @maxLengthPublishDate))

      -- Check if the parameter cannot be casted into a date time
      if try_cast(@publishdate as datetime2(6)) is null
        begin
          -- Set the string as empty to be nulled below
          set @publishdate = ''
        end

      -- Check if empty string
      if @publishdate = ''
        begin
          -- Set parameter to null if empty string
          set @publishdate = nullif(@publishdate, '')
        end
    end

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

  -- Else check if option mode is insert movie feed
  if @optionMode = 'insertMovieFeed'
    begin
      -- Check if parameters are null
      if @titlelong is not null and @titleshort is not null and @publishdate is not null and @actionstatus is not null
        begin
          -- Check if record exist
          if not exists
          (
            -- Select record in question
            select
            mf.titlelong as [titlelong]
            from dbo.MovieFeed mf
            where
            mf.titlelong = @titlelong
            group by mf.titlelong
          )
            begin
              -- Check if year string is greater than 5 and string is a valid year
              if len(@titleshort) > 5 and isdate(substring(@titleshort, len(@titleshort) - 3, len(@titleshort))) = 1
                begin
                  -- Check if record exists
                  if exists
                  (
                    -- Select record
                    select
                    @titlelong as [titlelong]
                    from dbo.ActionStatus ast
                    join dbo.MediaAudioEncode mae on mae.movieInclude in (1) and @titlelong like concat('%', mae.audioencode, '%')
                    left join dbo.MediaDynamicRange mdr on mdr.movieInclude in (1) and @titlelong like concat('%', mdr.dynamicrange, '%')
                    join dbo.MediaResolution mr on mr.movieInclude in (1) and @titlelong like concat('%', mr.resolution, '%')
                    left join dbo.MediaStreamSource mss on mss.movieInclude in (1) and @titlelong like concat('%', mss.streamsource, '%')
                    join dbo.MediaVideoEncode mve on mve.movieInclude in (1) and @titlelong like concat('%', mve.videoencode, '%')
                    where
                    ast.actionnumber = @actionstatus
                  )
                    begin
                      -- Check if record is valid
                      -- Begin the tranaction
                      begin tran
                        -- Begin the try block
                        begin try
                          -- Insert record
                          insert into dbo.MovieFeed
                          (
                            titlelong,
                            titleshort,
                            publish_date,
                            actionstatus,
                            created_date,
                            modified_date
                          )
                          values
                          (
                            @titlelong,
                            @titleshort,
                            cast(@publishdate as datetime2(6)),
                            @actionstatus,
                            cast(getdate() as datetime2(6)),
                            cast(getdate() as datetime2(6))
                          )
                          
                          -- Check if there is trans count
                          if @@trancount > 0
                            begin
                              -- Commit transactional statement
                              commit tran
                            end

                          -- Set message
                          set @result = '{"Status": "Success", "Message": "Record inserted"}'
                        end try
                        -- End try block
                        -- Begin catch block
                        begin catch
                          -- Check if there is trans count
                          if @@trancount > 0
                            begin
                              -- Rollback to the previous state before the transaction was called
                              rollback
                            end

                          -- Set message
                          set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                        end catch
                        -- End catch block
                    end
                  else
                    begin
                      -- Set message
                      set @result = '{"Status": "Error", "Message": "Title long does not follow the allowed values"}'
                    end
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Error", "Message": "Title short does not follow the allowed value"}'
                end
            end
          else
            begin
              -- Record already exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record already exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title long, title short, publish date, and action status were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is insert tv feed
  else if @optionMode = 'insertTVFeed'
    begin
      -- Check if parameters are null
      if @titlelong is not null and @titleshort is not null and @publishdate is not null and @actionstatus is not null
        begin
          -- Check if record exist
          if not exists
          (
            -- Select record in question
            select
            tf.titlelong as [titlelong]
            from dbo.TVFeed tf
            where
            tf.titlelong = @titlelong
            group by tf.titlelong
          )
            begin
              -- Check if record exist
              if exists
              (
                -- Select record
                select
                @titlelong as [titlelong]
                from dbo.ActionStatus ast
                join dbo.MediaAudioEncode mae on mae.tvInclude in (1) and @titlelong like concat('%', mae.audioencode, '%')
                left join dbo.MediaDynamicRange mdr on mdr.tvInclude in (1) and @titlelong like concat('%', mdr.dynamicrange, '%')
                join dbo.MediaResolution mr on mr.tvInclude in (1) and @titlelong like concat('%', mr.resolution, '%')
                left join dbo.MediaStreamSource mss on mss.tvInclude in (1) and @titlelong like concat('%', mss.streamsource, '%')
                join dbo.MediaVideoEncode mve on mve.tvInclude in (1) and @titlelong like concat('%', mve.videoencode, '%')
                where
                ast.actionnumber = @actionstatus
              )
                begin
                  -- Begin the tranaction
                  begin tran
                    -- Begin the try block
                    begin try
                      -- Insert record
                      insert into dbo.TVFeed
                      (
                        titlelong,
                        titleshort,
                        publish_date,
                        actionstatus,
                        created_date,
                        modified_date
                      )
                      values
                      (
                        @titlelong,
                        @titleshort,
                        cast(@publishdate as datetime2(6)),
                        @actionstatus,
                        cast(getdate() as datetime2(6)),
                        cast(getdate() as datetime2(6))
                      )
                      
                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Commit transactional statement
                          commit tran
                        end

                      -- Set message
                      set @result = '{"Status": "Success", "Message": "Record inserted"}'
                    end try
                    -- End try block
                    -- Begin catch block
                    begin catch
                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Rollback to the previous state before the transaction was called
                          rollback
                        end

                      -- Set message
                      set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                    end catch
                    -- End catch block
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Error", "Message": "Title long does not follow the allowed values"}'
                end
            end
          else
            begin
              -- Record already exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record already exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title long, title short, publish date, and action status were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is update movie feed
  else if @optionMode = 'updateMovieFeed'
    begin
      -- Check if parameters are null
      if @titlelong is not null and @titleshort is not null and @publishdate is not null and @actionstatus is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mf.titlelong as [titlelong]
            from dbo.MovieFeed mf
            where
            mf.titlelong = @titlelong
            group by mf.titlelong
          )
            begin
              -- Check if year string is greater than 5 and string is a valid year
              if len(@titleshort) > 5 and isdate(substring(@titleshort, len(@titleshort) - 3, len(@titleshort))) = 1
                begin
                  -- Check if record exist
                  if exists
                  (
                    -- Select record
                    select
                    ast.actionnumber as [actionnumber]
                    from dbo.ActionStatus ast
                    where
                    ast.actionnumber = @actionstatus
                    group by ast.actionnumber
                  )
                    begin
                      -- Check if record does not exist
                      if not exists
                      (
                        -- Select records
                        select
                        mf.titlelong as [titlelong]
                        from dbo.MovieFeed mf
                        where
                        mf.titlelong = @titlelong and
                        mf.titleshort = @titleshort and
                        mf.publish_date = @publishdate and
                        mf.actionstatus = @actionstatus
                        group by mf.titlelong
                      )
                        begin
                          -- Begin the tranaction
                          begin tran
                            -- Begin the try block
                            begin try
                              -- Insert record
                              update dbo.MovieFeed
                              set
                              titleshort = @titleshort,
                              publish_date = cast(@publishdate as datetime2(6)),
                              actionstatus = @actionstatus,
                              modified_date =  cast(getdate() as datetime2(6))
                              where
                              titlelong = @titlelong
                              
                              -- Check if there is trans count
                              if @@trancount > 0
                                begin
                                  -- Commit transactional statement
                                  commit tran
                                end

                              -- Set message
                              set @result = '{"Status": "Success", "Message": "Record updated"}'
                            end try
                            -- End try block
                            -- Begin catch block
                            begin catch
                              -- Check if there is trans count
                              if @@trancount > 0
                                begin
                                  -- Rollback to the previous state before the transaction was called
                                  rollback
                                end

                              -- Set message
                              set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                            end catch
                            -- End catch block
                        end
                      else
                        begin
                          -- Set message
                          set @result = '{"Status": "Success", "Message": "Record already exists"}'
                        end
                    end
                  else
                    begin
                      -- Set message
                      set @result = '{"Status": "Error", "Message": "Action status value is invalid"}'
                    end
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Error", "Message": "Title short does not follow the allowed value"}'
                end
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title long, title short, publish date, and action status were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is update movie title short
  else if @optionMode = 'updateMovieFeedTitleShort'
    begin
      -- Check if parameters are null
      if @titleshort is not null and @titleshortold is not null
        begin
          -- Check if record does not exist
          if not exists
          (
            -- Select record in question
            select
            mf.titleshort as [titleshort]
            from dbo.MovieFeed mf
            where
            mf.titleshort = @titleshort
            group by mf.titleshort
          )
            begin
              -- Check if year string is greater than 5 and string is a valid year
              if len(@titleshort) > 5 and isdate(substring(@titleshort, len(@titleshort) - 3, len(@titleshort))) = 1
                begin
                  -- Check if record exist
                  if exists
                  (
                    -- Select record in question
                    select
                    mf.titleshort as [titleshort]
                    from dbo.MovieFeed mf
                    where
                    mf.titleshort = @titleshortold
                    group by mf.titleshort
                  )
                    begin
                      -- Begin the tranaction
                      begin tran
                        -- Begin the try block
                        begin try
                          -- Insert record
                          update dbo.MovieFeed
                          set
                          titleshort = @titleshort,
                          modified_date = cast(getdate() as datetime2(6))
                          where
                          titleshort = @titleshortold
                          
                          -- Check if there is trans count
                          if @@trancount > 0
                            begin
                              -- Commit transactional statement
                              commit tran
                            end

                          -- Set message
                          set @result = '{"Status": "Success", "Message": "Record(s) updated"}'
                        end try
                        -- End try block
                        -- Begin catch block
                        begin catch
                          -- Check if there is trans count
                          if @@trancount > 0
                            begin
                              -- Rollback to the previous state before the transaction was called
                              rollback
                            end

                          -- Set message
                          set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                        end catch
                        -- End catch block
                    end
                  else
                    begin
                      -- Record does not exist
                      -- Set message
                      set @result = '{"Status": "Success", "Message": "Record does not exist"}'
                    end
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Error", "Message": "Title short does not follow the allowed value"}'
                end
            end
          else
            begin
              -- Record already exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record(s) already exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title short and title short old were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is update movie feed title short action status
  else if @optionMode = 'updateMovieFeedTitleShortActionStatus'
    begin
      -- Check if parameters are null
      if @titleshort is not null and @actionstatus is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mf.titleshort as [titleshort]
            from dbo.MovieFeed mf
            where
            mf.titleshort = @titleshort
            group by mf.titleshort
          )
            begin
              -- Check if record exist
              if exists
              (
                -- Select record
                select
                ast.actionnumber as [actionnumber]
                from dbo.ActionStatus ast
                where
                ast.actionnumber = @actionstatus
                group by ast.actionnumber
              )
                begin
                  -- Check if record does not exists
                  if not exists
                  (
                    -- Select records
                    select
                    mf.titleshort as [titleshort]
                    from dbo.MovieFeed mf
                    where
                    mf.titleshort = @titleshort and
                    mf.actionstatus = @actionstatus
                    group by mf.titleshort
                  )
                    begin
                      -- Begin the tranaction
                      begin tran
                        -- Begin the try block
                        begin try
                          -- Insert record
                          update dbo.MovieFeed
                          set
                          actionstatus = @actionstatus,
                          modified_date = cast(getdate() as datetime2(6))
                          where
                          titleshort = @titleshort
                          
                          -- Check if there is trans count
                          if @@trancount > 0
                            begin
                              -- Commit transactional statement
                              commit tran
                            end

                          -- Set message
                          set @result = '{"Status": "Success", "Message": "Record(s) updated"}'
                        end try
                        -- End try block
                        -- Begin catch block
                        begin catch
                          -- Check if there is trans count
                          if @@trancount > 0
                            begin
                              -- Rollback to the previous state before the transaction was called
                              rollback
                            end

                          -- Set message
                          set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                        end catch
                        -- End catch block
                    end
                  else
                    begin
                      -- Set message
                      set @result = '{"Status": "Success", "Message": "Record(s) already exist"}'
                    end
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Error", "Message": "Action status value is invalid"}'
                end
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title short and action status were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is update tv feed
  else if @optionMode = 'updateTVFeed'
    begin
      -- Check if parameters are null
      if @titlelong is not null and @titleshort is not null and @publishdate is not null and @actionstatus is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            tf.titlelong as [titlelong]
            from dbo.TVFeed tf
            where
            tf.titlelong = @titlelong
            group by tf.titlelong
          )
            begin
              -- Check if record exists
              if exists
              (
                -- Select record
                select
                ast.actionnumber as [actionnumber]
                from dbo.ActionStatus ast
                where
                ast.actionnumber = @actionstatus
                group by ast.actionnumber
              )
                begin
                  -- Check if record does not exist
                  if not exists
                  (
                    -- Select records
                    select
                    tf.titlelong as [titlelong]
                    from dbo.TVFeed tf
                    where
                    tf.titlelong = @titlelong and
                    tf.titleshort = @titleshort and
                    tf.publish_date = @publishdate and
                    tf.actionstatus = @actionstatus
                    group by tf.titlelong
                  )
                    begin
                      -- Begin the tranaction
                      begin tran
                        -- Begin the try block
                        begin try
                          -- Insert record
                          update dbo.TVFeed
                          set
                          titleshort = @titleshort,
                          publish_date = cast(@publishdate as datetime2(6)),
                          actionstatus = @actionstatus,
                          modified_date = cast(getdate() as datetime2(6))
                          where
                          titlelong = @titlelong
                          
                          -- Check if there is trans count
                          if @@trancount > 0
                            begin
                              -- Commit transactional statement
                              commit tran
                            end

                          -- Set message
                          set @result = '{"Status": "Success", "Message": "Record updated"}'
                        end try
                        -- End try block
                        -- Begin catch block
                        begin catch
                          -- Check if there is trans count
                          if @@trancount > 0
                            begin
                              -- Rollback to the previous state before the transaction was called
                              rollback
                            end

                          -- Set message
                          set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                        end catch
                        -- End catch block
                    end
                  else
                    begin
                      -- Set message
                      set @result = '{"Status": "Success", "Message": "Record already exist"}'
                    end
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Error", "Message": "Action status value is invalid"}'
                end
            end
          else
            begin
                -- Record does not exist
                -- Set message
                set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title long, title short, publish date, and action status were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is update tv feed title short
  else if @optionMode = 'updateTVFeedTitleShort'
    begin
      -- Check if parameters are null
      if @titleshort is not null and @titleshortold is not null
        begin
          -- Check if record exist
          if not exists
          (
            -- Select record in question
            select
            tf.titleshort as [titleshort]
            from dbo.TVFeed tf
            where
            tf.titleshort = @titleshort
            group by tf.titleshort
          )
            begin
              -- Check if record exist
              if exists
              (
                -- Select record in question
                select
                tf.titleshort as [titleshort]
                from dbo.TVFeed tf
                where
                tf.titleshort = @titleshortold
                group by tf.titleshort
              )
                begin
                  -- Begin the tranaction
                  begin tran
                    -- Begin the try block
                    begin try
                      -- Insert record
                      update dbo.TVFeed
                      set
                      titleshort = @titleshort,
                      modified_date = cast(getdate() as datetime2(6))
                      where
                      titleshort = @titleshortold
                      
                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Commit transactional statement
                          commit tran
                        end

                      -- Set message
                      set @result = '{"Status": "Success", "Message": "Record(s) updated"}'
                    end try
                    -- End try block
                    -- Begin catch block
                    begin catch
                      -- Check if there is trans count
                      if @@trancount > 0
                        begin
                          -- Rollback to the previous state before the transaction was called
                          rollback
                        end

                      -- Set message
                      set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                    end catch
                    -- End catch block
                end
              else
                begin
                  -- Record does not exist
                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record does not exist"}'
                end
            end
          else
            begin
                -- Record already exist
                -- Set message
                set @result = '{"Status": "Success", "Message": "Record already exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title short and title short old were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is update tv feed title short action status
  else if @optionMode = 'updateTVFeedTitleShortActionStatus'
    begin
      -- Check if parameters are null
      if @titleshort is not null and @actionstatus is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            tf.titleshort as [titleshort]
            from dbo.TVFeed tf
            where
            tf.titleshort = @titleshort
            group by tf.titleshort
          )
            begin
              -- Check if record exists
              if exists
              (
                -- Select record
                select
                ast.actionnumber as [actionnumber]
                from dbo.ActionStatus ast
                where
                ast.actionnumber = @actionstatus
                group by ast.actionnumber
              )
                begin
                  -- Check if record does not exists
                  if not exists
                  (
                    -- Select records
                    select
                    tf.titleshort as [titleshort]
                    from dbo.TVFeed tf
                    where
                    tf.titleshort = @titleshort and
                    tf.actionstatus = @actionstatus
                    group by tf.titleshort
                  )
                    begin
                      -- Begin the tranaction
                      begin tran
                        -- Begin the try block
                        begin try
                          -- Insert record
                          update dbo.TVFeed
                          set
                          actionstatus = @actionstatus,
                          modified_date = cast(getdate() as datetime2(6))
                          where
                          titleshort = @titleshort
                          
                          -- Check if there is trans count
                          if @@trancount > 0
                            begin
                              -- Commit transactional statement
                              commit tran
                            end

                          -- Set message
                          set @result = '{"Status": "Success", "Message": "Record(s) updated"}'
                        end try
                        -- End try block
                        -- Begin catch block
                        begin catch
                          -- Check if there is trans count
                          if @@trancount > 0
                            begin
                              -- Rollback to the previous state before the transaction was called
                              rollback
                            end

                          -- Set message
                          set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                        end catch
                        -- End catch block
                    end
                  else
                    begin
                      -- Set message
                      set @result = '{"Status": "Success", "Message": "Record(s) already exists"}'
                    end
                end
              else
                begin
                  -- Set message
                  set @result = '{"Status": "Error", "Message": "Action status value is invalid"}'
                end
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title short and action status were not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Check if option mode is delete  movie feed
  else if @optionMode = 'deleteMovieFeed'
    begin
      -- Check if parameters are not null
      if @titlelong is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mf.titlelong as [titlelong]
            from dbo.MovieFeed mf
            where
            mf.titlelong = @titlelong
            group by mf.titlelong
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Delete record
                  delete
                  from dbo.MovieFeed
                  where
                  titlelong = @titlelong

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record deleted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title long was not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Check if option mode is delete movie feed title short
  else if @optionMode = 'deleteMovieFeedTitleShort'
    begin
      -- Check if parameters are not null
      if @titleshort is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mf.titleshort as [titleshort]
            from dbo.MovieFeed mf
            where
            mf.titleshort = @titleshort
            group by mf.titleshort
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Delete record
                  delete
                  from dbo.MovieFeed
                  where
                  titleshort = @titleshort

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record(s) deleted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title short was not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Check if option mode is delete tv feed
  else if @optionMode = 'deleteTVFeed'
    begin
      -- Check if parameters are not null
      if @titlelong is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            tf.titlelong as [titlelong]
            from dbo.TVFeed tf
            where
            tf.titlelong = @titlelong
            group by tf.titlelong
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Delete record
                  delete
                  from dbo.TVFeed
                  where
                  titlelong = @titlelong

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record deleted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title long was not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end

  -- Check if option mode is delete tv feed title short
  else if @optionMode = 'deleteTVFeedTitleShort'
    begin
      -- Check if parameters are not null
      if @titleshort is not null
        begin
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            tf.titleshort as [titleshort]
            from dbo.TVFeed tf
            where
            tf.titleshort = @titleshort
            group by tf.titleshort
          )
            begin
              -- Begin the tranaction
              begin tran
                -- Begin the try block
                begin try
                  -- Delete record
                  delete
                  from dbo.TVFeed
                  where
                  titleshort = @titleshort

                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Commit transactional statement
                      commit tran
                    end

                  -- Set message
                  set @result = '{"Status": "Success", "Message": "Record(s) deleted"}'
                end try
                -- End try block
                -- Begin catch block
                begin catch
                  -- Check if there is trans count
                  if @@trancount > 0
                    begin
                      -- Rollback to the previous state before the transaction was called
                      rollback
                    end

                  -- Set message
                  set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
                end catch
                -- End catch block
            end
          else
            begin
              -- Record does not exist
              -- Set message
              set @result = '{"Status": "Success", "Message": "Record does not exist"}'
            end
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title short was not provided"}'
        end

      -- Select message
      select
      @result as [status]
    end
end
GO