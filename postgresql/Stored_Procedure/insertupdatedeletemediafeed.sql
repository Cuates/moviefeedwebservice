-- Database Connect
use <databasename>;

-- =================================================
--        File: insertupdatedeletemediafeed
--     Created: 11/10/2020
--     Updated: 11/16/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert update delete media feed
-- =================================================

-- Procedure Drop
drop procedure if exists insertupdatedeletemediafeed;

-- Procedure Create Or Replace
create or replace procedure insertupdatedeletemediafeed(in optionMode text default null, in titlelong text default null, in titleshort text default null, in titleshortold text default null, in publishdate text default null, in actionstatus text default null, inout status text default null)
as $$
  -- Declare variables
  declare omitOptionMode varchar(255) := '[^a-zA-Z]';
  declare omitTitleLong varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitTitleShort varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitPublishDate varchar(255) := '[^0-9\-/:. ]';
  declare omitActionStatus varchar(255) := '[^0-9]';
  declare maxLengthOptionMode int := 255;
  declare maxLengthTitleLong int := 255;
  declare maxLengthTitleShort int := 255;
  declare maxLengthPublishDate int := 255;
  declare maxLengthActionNumber int := 255;
  declare titlelongstring text := titlelong;
  declare titleshortstring text := titleshort;
  declare titleshortoldstring text := titleshortold;
  declare publishdatestring text := publishdate;
  declare actionstatusstring text := actionstatus;
  declare code varchar(5) := '00000';
  declare msg text := '';
  declare result text := '';

  begin
    -- Check if parameter is not null
    if optionMode is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      optionMode := regexp_replace(regexp_replace(optionMode, omitOptionMode, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      optionMode := trim(substring(optionMode, 1, maxLengthOptionMode));

      -- Check if empty string
      if optionMode = '' then
        -- Set parameter to null if empty string
        optionMode := nullif(optionMode, '');
      end if;
    end if;

    -- Check if parameter is not null
    if titlelongstring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      titlelongstring := regexp_replace(regexp_replace(titlelongstring, omitTitleLong, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      titlelongstring := trim(substring(titlelongstring, 1, maxLengthTitleLong));

      -- Check if empty string
      if titlelongstring = '' then
        -- Set parameter to null if empty string
        titlelongstring := nullif(titlelongstring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if titleshortstring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      titleshortstring := regexp_replace(regexp_replace(titleshortstring, omitTitleShort, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      titleshortstring := trim(substring(titleshortstring, 1, maxLengthTitleShort));

      -- Check if empty string
      if titleshortstring = '' then
        -- Set parameter to null if empty string
        titleshortstring := nullif(titleshortstring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if titleshortoldstring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      titleshortoldstring := regexp_replace(regexp_replace(titleshortoldstring, omitTitleShort, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      titleshortoldstring := trim(substring(titleshortoldstring, 1, maxLengthTitleShort));

      -- Check if empty string
      if titleshortoldstring = '' then
        -- Set parameter to null if empty string
        titleshortoldstring := nullif(titleshortoldstring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if publishdatestring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      publishdatestring := regexp_replace(regexp_replace(publishdatestring, omitPublishDate, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      publishdatestring := trim(substring(publishdatestring, 1, maxLengthPublishDate));

      -- Check if the parameter cannot be casted into a date time
      if to_timestamp(publishdatestring, 'YYYY-MM-DD HH24:MI:SS') is null then
        -- Set the string as empty to be nulled below
        publishdatestring := '';
      end if;

      -- Check if empty string
      if publishdatestring = '' then
        -- Set parameter to null if empty string
        publishdatestring := nullif(publishdatestring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if actionstatusstring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      actionstatusstring := regexp_replace(regexp_replace(actionstatusstring, omitActionNumber, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      actionstatusstring := trim(substring(actionstatusstring, 1, maxLengthActionNumber));

      -- Check if empty string
      if actionstatusstring = '' then
        -- Set parameter to null if empty string
        actionstatusstring := nullif(actionstatusstring, '');
      end if;
    end if;

    -- Else check if option mode is insert movie feed
    if optionMode = 'insertMovieFeed' then
      -- Check if parameters are null
      if titlelongstring is not null and titleshortstring is not null and publishdatestring is not null and actionstatusstring is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          mf.titlelong
          from moviefeed mf
          where
          mf.titlelong = titlelongstring
          group by mf.titlelong
        ) then
          -- Check if year string is greater than 5 and string is a valid year
          if length(titleshortstring) > 5 and to_timestamp(substring(titleshortstring, length(titleshortstring) - 3, length(titleshortstring)), 'YYYY') is not null then
            -- Check if record exists
            if exists
            (
              -- Select record
              select
              titlelongstring as titlelong
              from actionstatus ast
              join mediaaudioencode mae on mae.movieInclude in ('1') and titlelongstring ilike concat('%', mae.audioencode, '%')
              left join mediadynamicrange mdr on mdr.movieInclude in ('1') and titlelongstring ilike concat('%', mdr.dynamicrange, '%')
              join mediaresolution mr on mr.movieInclude in ('1') and titlelongstring ilike concat('%', mr.resolution, '%')
              left join mediastreamsource mss on mss.movieInclude in ('1') and titlelongstring ilike concat('%', mss.streamsource, '%')
              join mediavideoencode mve on mve.movieInclude in ('1') and titlelongstring ilike concat('%', mve.videoencode, '%')
              where
              ast.actionnumber = actionstatusstring
            ) then
              -- Begin begin/except
              begin
                -- Insert record
                insert into moviefeed
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
                  titlelongstring,
                  titleshortstring,
                  to_timestamp(publishdatestring, 'YYYY-MM-DD HH24:MI:SS.US'),
                  actionstatusstring,
                  cast(current_timestamp as timestamp),
                  cast(current_timestamp as timestamp)
                );

                -- Set message
                result := concat('{"Status": "Success", "Message": "Record(s) inserted"}');
              exception when others then
                -- Caught exception error
                -- Get diagnostics information
                get stacked diagnostics code = returned_sqlstate, msg = message_text;

                -- Set message
                result := concat('{"Status": "Error", "Message": "', msg, '"}');
              -- End begin/except
              end;
            else
                -- Set message
                result := concat('{"Status": "Error", "Message": "Title long does not follow the allowed values"}');
              end if;
          else
            -- Set message
            result := concat('{"Status": "Error", "Message": "Title short does not follow the allowed value"}');
          end if;
        else
          -- Record already exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, title long, title short, publish date, and action status were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is insert tv feed
    elseif optionMode = 'insertTVFeed' then
      -- Check if parameters are null
      if titlelongstring is not null and titleshortstring is not null and publishdatestring is not null and actionstatusstring is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          tf.titlelong
          from tvfeed tf
          where
          tf.titlelong = titlelongstring
          group by tf.titlelong
        ) then
          -- Check if year string is greater than 5 and string is a valid year
          if length(titleshortstring) > 5 and to_timestamp(substring(titleshortstring, length(titleshortstring) - 3, length(titleshortstring)), 'YYYY') is not null then
            -- Check if record exists
            if exists
            (
              -- Select record
              select
              titlelongstring as titlelong
              from actionstatus ast
              join mediaaudioencode mae on mae.movieInclude in ('1') and titlelongstring ilike concat('%', mae.audioencode, '%')
              left join mediadynamicrange mdr on mdr.movieInclude in ('1') and titlelongstring ilike concat('%', mdr.dynamicrange, '%')
              join mediaresolution mr on mr.movieInclude in ('1') and titlelongstring ilike concat('%', mr.resolution, '%')
              left join mediastreamsource mss on mss.movieInclude in ('1') and titlelongstring ilike concat('%', mss.streamsource, '%')
              join mediavideoencode mve on mve.movieInclude in ('1') and titlelongstring ilike concat('%', mve.videoencode, '%')
              where
              ast.actionnumber = actionstatusstring
            ) then
              -- Begin begin/except
              begin
                -- Insert record
                insert into tvfeed
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
                  titlelongstring,
                  titleshortstring,
                  to_timestamp(publishdatestring, 'YYYY-MM-DD HH24:MI:SS.US'),
                  actionstatusstring,
                  cast(current_timestamp as timestamp),
                  cast(current_timestamp as timestamp)
                );

                -- Set message
                result := concat('{"Status": "Success", "Message": "Record(s) inserted"}');
              exception when others then
                -- Caught exception error
                -- Get diagnostics information
                get stacked diagnostics code = returned_sqlstate, msg = message_text;

                -- Set message
                result := concat('{"Status": "Error", "Message": "', msg, '"}');
              -- End begin/except
              end;
            else
              -- Set message
              result := concat('{"Status": "Error", "Message": "Title long does not follow the allowed values"}');
            end if;
          else
            -- Set message
            result := concat('{"Status": "Error", "Message": "Title short does not follow the allowed value"}');
          end if;
        else
          -- Record already exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, title long, title short, publish date, and action status were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is update movie feed
    elseif optionMode = 'updateMovieFeed' then
      -- Check if parameters are null
      if titlelongstring is not null and titleshortstring is not null and publishdatestring is not null and actionstatusstring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mf.titlelong
          from moviefeed mf
          where
          mf.titlelong = titlelongstring
          group by mf.titlelong
        ) then
          -- Check if year string is greater than 5 and string is a valid year
          if length(titleshortstring) > 5 and to_date(substring(titleshortstring, length(titleshortstring) - 3, length(titleshortstring)), 'YYYY') is not null then
            -- Check if record exist
            if exists
            (
              -- Select record
              select
              ast.actionnumber as actionnumber
              from actionstatus ast
              where
              ast.actionnumber = actionstatus
              group by ast.actionnumber
            ) then
              -- Check if record does not exists
              if not exists
              (
                -- Select records
                select
                mf.titlelong
                from moviefeed mf
                where
                mf.titlelong = titlelongstring and
                mf.titleshort = titleshortstring and
                mf.publish_date = publishdatestring and
                mf.actionstatus = actionstatusstring
                group by mf.titlelong
              ) then
                -- Begin begin/except
                begin
                  -- Update record
                  update moviefeed
                  set
                  titleshort = titleshortstring,
                  publish_date = to_timestamp(publishdatestring, 'YYYY-MM-DD HH24:MI:SS.US'),
                  actionstatus = actionstatusstring,
                  modified_date = cast(current_timestamp as timestamp)
                  where
                  moviefeed.titlelong = titlelongstring;

                  -- Set message
                  result := concat('{"Status": "Success", "Message": "Record(s) updated"}');
                exception when others then
                  -- Caught exception error
                  -- Get diagnostics information
                  get stacked diagnostics code = returned_sqlstate, msg = message_text;

                  -- Set message
                  result := concat('{"Status": "Error", "Message": "', msg, '"}');
                -- End begin/except
                end;
              else
                -- Set message
                result := concat('{"Status": "Success", "Message": "Record already exists"}');
              end if;
            else
              -- Set message
              result := concat('{"Status": "Error", "Message": "Action status value is invalid"}');
            end if;
          else
            -- Set message
            result := concat('{"Status": "Error", "Message": "Title short does not follow the allowed value"}');
          end if;
        else
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, title long, title short, publish date, and action status were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is update movie title short
    elseif optionMode = 'updateMovieFeedTitleShort' then
      -- Check if parameters are null
      if titleshortstring is not null and titleshortoldstring is not null then
        -- Check if record does not exist
        if not exists
        (
          -- Select record in question
          select
          mf.titleshort
          from moviefeed mf
          where
          mf.titleshort = titleshortstring
          group by mf.titleshort
        ) then
          -- Check if year string is greater than 5 and string is a valid year
          if length(titleshortstring) > 5 and to_date(substring(titleshortstring, length(titleshortstring) - 3, length(titleshortstring)), 'YYYY') is not null then
            -- Check if record exist
            if exists
            (
              -- Select record in question
              select
              mf.titleshort
              from moviefeed mf
              where
              mf.titleshort = titleshortoldstring
              group by mf.titleshort
            ) then
              -- Begin begin/except
              begin
                -- Update record
                update moviefeed
                set
                titleshort = titleshortstring,
                modified_date = cast(current_timestamp as timestamp)
                where
                moviefeed.titlelong = titleshortoldstring;

                -- Set message
                result := concat('{"Status": "Success", "Message": "Record(s) updated"}');
              exception when others then
                -- Caught exception error
                -- Get diagnostics information
                get stacked diagnostics code = returned_sqlstate, msg = message_text;

                -- Set message
                result := concat('{"Status": "Error", "Message": "', msg, '"}');
              -- End begin/except
              end;
            else
              -- Record does not exist
              -- Set message
              result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
            end if;
          else
            -- Set message
            result := concat('{"Status": "Error", "Message": "Title short does not follow the allowed value"}');
          end if;
        else
          -- Record already exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, title short and title short old were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is update movie feed title short action status
    elseif optionMode = 'updateMovieFeedTitleShortActionStatus' then
      -- Check if parameters are null
      if titleshortstring is not null and actionstatusstring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mf.titleshort
          from moviefeed mf
          where
          mf.titleshort = titleshortstring
          group by mf.titleshort
        ) then
          -- Check if record exist
          if exists
          (
            -- Select record
            select
            ast.actionnumber as actionnumber
            from actionstatus ast
            where
            ast.actionnumber = actionstatus
            group by ast.actionnumber
          ) then
            -- Check if record does not exists
            if not exists
            (
              -- Select records
              select
              mf.titleshort
              from moviefeed mf
              where
              mf.titleshort = titleshortstring and
              mf.actionstatus = actionstatusstring
              group by mf.titleshort
            ) then
              -- Begin begin/except
              begin
                -- Update record
                update moviefeed
                set
                actionstatus = actionstatusstring,
                modified_date = cast(current_timestamp as timestamp)
                where
                moviefeed.titleshort = titleshortstring;

                -- Set message
                result := concat('{"Status": "Success", "Message": "Record(s) updated"}');
              exception when others then
                -- Caught exception error
                -- Get diagnostics information
                get stacked diagnostics code = returned_sqlstate, msg = message_text;

                -- Set message
                result := concat('{"Status": "Error", "Message": "', msg, '"}');
              -- End begin/except
              end;
            else
              -- Set message
              result := concat('{"Status": "Success", "Message": "Record already exists"}');
            end if;
          else
            -- Set message
            result := concat('{"Status": "Error", "Message": "Action status value is invalid"}');
          end if;
        else
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, title short and action status were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is update tv feed
    elseif optionMode = 'updateTVFeed' then
      -- Check if parameters are null
      if titlelongstring is not null and titleshortstring is not null and publishdatestring is not null and actionstatusstring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          tf.titlelong
          from tvfeed tf
          where
          tf.titlelong = titlelongstring
          group by tf.titlelong
        ) then
          -- Check if record exist
          if exists
          (
            -- Select record
            select
            ast.actionnumber as actionnumber
            from actionstatus ast
            where
            ast.actionnumber = actionstatus
            group by ast.actionnumber
          ) then
            -- Check if record does not exists
            if not exists
            (
              -- Select records
              select
              tf.titlelong
              from tvfeed tf
              where
              tf.titlelong = titlelongstring and
              tf.titleshort = titleshortstring and
              tf.publish_date = publishdatestring and
              tf.actionstatus = actionstatusstring
              group by tf.titlelong
            ) then
              -- Begin begin/except
              begin
                -- Update record
                update tvfeed
                set
                titleshort = titleshortstring,
                publish_date = to_timestamp(publishdatestring, 'YYYY-MM-DD HH24:MI:SS.US'),
                actionstatus = actionstatusstring,
                modified_date = cast(current_timestamp as timestamp)
                where
                tvfeed.titlelong = titlelongstring;

                -- Set message
                result := concat('{"Status": "Success", "Message": "Record(s) updated"}');
              exception when others then
                -- Caught exception error
                -- Get diagnostics information
                get stacked diagnostics code = returned_sqlstate, msg = message_text;

                -- Set message
                result := concat('{"Status": "Error", "Message": "', msg, '"}');
              -- End begin/except
              end;
            else
              -- Set message
              result := concat('{"Status": "Success", "Message": "Record already exists"}');
            end if;
          else
            -- Set message
            result := concat('{"Status": "Error", "Message": "Action status value is invalid"}');
          end if;
        else
            -- Record does not exist
            -- Set message
            result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, title long, title short, publish date, and action status were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is update tv feed title short
    elseif optionMode = 'updateTVFeedTitleShort' then
      -- Check if parameters are null
      if titleshortstring is not null and titleshortoldstring is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          tf.titleshort
          from tvfeed tf
          where
          tf.titleshort = titleshortstring
          group by tf.titleshort
        ) then
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            tf.titleshort
            from tvfeed tf
            where
            tf.titleshort = titleshortoldstring
            group by tf.titleshort
          ) then
            -- Begin begin/except
            begin
              -- Update record
              update tvfeed
              set
              titleshort = titleshortstring,
              modified_date = cast(current_timestamp as timestamp)
              where
              tvfeed.titlelong = titleshortoldstring;

              -- Set message
              result := concat('{"Status": "Success", "Message": "Record(s) updated"}');
            exception when others then
              -- Caught exception error
              -- Get diagnostics information
              get stacked diagnostics code = returned_sqlstate, msg = message_text;

              -- Set message
              result := concat('{"Status": "Error", "Message": "', msg, '"}');
            -- End begin/except
            end;
          else
            -- Record does not exist
            -- Set message
            result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
          end if;
        else
          -- Record already exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, title short and title short old were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is update tv feed title short action status
    elseif optionMode = 'updateTVFeedTitleShortActionStatus' then
      -- Check if parameters are null
      if titleshortstring is not null and actionstatusstring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          tf.titleshort
          from tvfeed tf
          where
          tf.titleshort = titleshortstring
          group by tf.titleshort
        ) then
          -- Check if record exist
          if exists
          (
            -- Select record
            select
            ast.actionnumber as actionnumber
            from actionstatus ast
            where
            ast.actionnumber = actionstatus
            group by ast.actionnumber
          ) then
            -- Check if record does not exists
            if not exists
            (
              -- Select records
              select
              tf.titleshort
              from tvfeed tf
              where
              tf.titleshort = titleshortstring and
              tf.actionstatus = actionstatusstring
              group by tf.titleshort
            ) then
              -- Begin begin/except
              begin
                -- Update record
                update tvfeed
                set
                actionstatus = actionstatusstring,
                modified_date = cast(current_timestamp as timestamp)
                where
                tvfeed.titleshort = titleshortstring;

                -- Set message
                result := concat('{"Status": "Success", "Message": "Record(s) updated"}');
              exception when others then
                -- Caught exception error
                -- Get diagnostics information
                get stacked diagnostics code = returned_sqlstate, msg = message_text;

                -- Set message
                result := concat('{"Status": "Error", "Message": "', msg, '"}');
              -- End begin/except
              end;
            else
              -- Set message
              result := concat('{"Status": "Success", "Message": "Record already exists"}');
            end if;
          else
            -- Set message
            result := concat('{"Status": "Error", "Message": "Action status value is invalid"}');
          end if;
        else
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, title short and action status were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Check if option mode is delete  movie feed title long
    elseif optionMode = 'deleteMovieFeed' then
      -- Check if parameters are not null
      if titlelongstring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mf.titlelong
          from moviefeed mf
          where
          mf.titlelong = titlelongstring
          group by mf.titlelong
        ) then
          -- Begin begin/except
          begin
            -- Delete record
            delete
            from moviefeed mf
            where
            mf.titlelong = titlelongstring;

            -- Set message
            result := concat('{"Status": "Success", "Message": "Record(s) deleted"}');
          exception when others then
            -- Caught exception error
            -- Get diagnostics information
            get stacked diagnostics code = returned_sqlstate, msg = message_text;

            -- Set message
            result := concat('{"Status": "Error", "Message": "', msg, '"}');
          -- End begin/except
          end;
        else
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, title long was not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Check if option mode is delete movie feed title short
    elseif optionMode = 'deleteMovieFeedTitleShort' then
      -- Check if parameters are not null
      if titleshortstring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mf.titleshort
          from moviefeed mf
          where
          mf.titleshort = titleshortstring
          group by mf.titleshort
        ) then
          -- Begin begin/except
          begin
            -- Delete record
            delete
            from moviefeed mf
            where
            mf.titleshort = titleshortstring;

            -- Set message
            result := concat('{"Status": "Success", "Message": "Record(s) deleted"}');
          exception when others then
            -- Caught exception error
            -- Get diagnostics information
            get stacked diagnostics code = returned_sqlstate, msg = message_text;

            -- Set message
            result := concat('{"Status": "Error", "Message": "', msg, '"}');
          -- End begin/except
          end;
        else
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, title short was not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Check if option mode is delete tv feed title long
    elseif optionMode = 'deleteTVFeed' then
      -- Check if parameters are not null
      if titlelongstring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          tf.titlelong
          from tvfeed tf
          where
          tf.titlelong = titlelongstring
          group by tf.titlelong
        ) then
          -- Begin begin/except
          begin
            -- Delete record
            delete
            from tvfeed tf
            where
            tf.titlelong = titlelongstring;

            -- Set message
            result := concat('{"Status": "Success", "Message": "Record(s) deleted"}');
          exception when others then
            -- Caught exception error
            -- Get diagnostics information
            get stacked diagnostics code = returned_sqlstate, msg = message_text;

            -- Set message
            result := concat('{"Status": "Error", "Message": "', msg, '"}');
          -- End begin/except
          end;
        else
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, title long was not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Check if option mode is delete tv feed title short
    elseif optionMode = 'deleteTVFeedTitleShort' then
      -- Check if parameters are not null
      if titleshortstring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          tf.titleshort
          from tvfeed tf
          where
          tf.titleshort = titleshortstring
          group by tf.titleshort
        ) then
          -- Begin begin/except
          begin
            -- Delete record
            delete
            from tvfeed tf
            where
            tf.titleshort = titleshortstring;

            -- Set message
            result := concat('{"Status": "Success", "Message": "Record(s) deleted"}');
          exception when others then
            -- Caught exception error
            -- Get diagnostics information
            get stacked diagnostics code = returned_sqlstate, msg = message_text;

            -- Set message
            result := concat('{"Status": "Error", "Message": "', msg, '"}');
          -- End begin/except
          end;
        else
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, title short was not provided"}';
      end if;

      -- Select message
      select
      result into "status";
    end if;
  end; $$
language plpgsql;