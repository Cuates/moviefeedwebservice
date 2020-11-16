-- Database Connect
use <databasename>;

-- =================================================
--        File: insertupdatedeletemediafeed
--     Created: 11/10/2020
--     Updated: 11/15/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert update delete media feed
-- =================================================

-- Procedure Drop
drop procedure if exists insertupdatedeletemediafeed;

-- Procedure Create Or Replace
create or replace procedure insertupdatedeletemediafeed(in optionMode text default null, in actionnumber text default null, in actiondescription text default null, in audioencode text default null, in dynamicrange text default null, in resolution text default null, in streamsource text default null, in streamdescription text default null, in videoencode text default null, in titlelong text default null, in titleshort text default null, in titleshortold text default null, in publishdate text default null, in actionstatus text default null, in movieinclude text default null, in tvinclude text default null, inout status text default null)
as $$
  -- Declare variables
  declare omitOptionMode varchar(255) := '[^a-zA-Z]';
  declare omitActionNumber varchar(255) := '[^0-9]';
  declare omitActionDescription varchar(255) := '[^a-zA-Z]';
  declare omitMediaAudioEncode varchar(255) := '[^a-zA-Z0-9.\-]';
  declare omitMediaDynamicRange varchar(255) := '[^a-zA-Z]';
  declare omitMediaResolution varchar(255) := '[^a-zA-Z0-9]';
  declare omitMediaStreamSource varchar(255) := '[^a-zA-Z]';
  declare omitMediaStreamDescription varchar(255) := '[^a-zA-Z]';
  declare omitMediaVideoEncode varchar(255) := '[^a-zA-Z0-9]';
  declare omitTitleLong varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitTitleShort varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitPublishDate varchar(255) := '[^0-9\-/:. ]';
  declare omitMovieInclude varchar(255) := '[^01]';
  declare omitTVInclude varchar(255) := '[^01]';
  declare maxLengthOptionMode int := 255;
  declare maxLengthActionNumber int := 255;
  declare maxLengthActionDescription int := 255;
  declare maxLengthMediaAudioEncode int := 100;
  declare maxLengthMediaDynamicRange int := 100;
  declare maxLengthMediaResolution int := 100;
  declare maxLengthMediaStreamSource int := 100;
  declare maxLengthMediaStreamDescription int := 100;
  declare maxLengthMediaVideoEncode int := 100;
  declare maxLengthTitleLong int := 255;
  declare maxLengthTitleShort int := 255;
  declare maxLengthPublishDate int := 255;
  declare maxLengthMovieInclude int := 1;
  declare maxLengthTVInclude int := 1;
  declare actionnumberstring text := actionnumber;
  declare actiondescriptionstring text := actiondescription;
  declare audioencodestring text := audioencode;
  declare dynamicrangestring text := dynamicrange;
  declare resolutionstring text := resolution;
  declare streamsourcestring text := streamsource;
  declare streamdescriptionstring text := streamdescription;
  declare videoencodestring text := videoencode;
  declare titlelongstring text := titlelong;
  declare titleshortstring text := titleshort;
  declare titleshortoldstring text := titleshortold;
  declare publishdatestring text := publishdate;
  declare actionstatusstring text := actionstatus;
  declare movieincludestring text := movieinclude;
  declare tvincludestring text := tvinclude;
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

    -- Check if parameter is not null
    if movieincludestring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      movieincludestring := regexp_replace(regexp_replace(movieincludestring, omitMovieInclude, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      movieincludestring := trim(substring(movieincludestring, 1, maxLengthMovieInclude));

      -- Check if empty string
      if movieincludestring = '' then
        -- Set parameter to null if empty string
        movieincludestring := nullif(movieincludestring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if tvincludestring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      tvincludestring := regexp_replace(regexp_replace(tvincludestring, omitTVInclude, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      tvincludestring := trim(substring(tvincludestring, 1, maxLengthTVInclude));

      -- Check if empty string
      if tvincludestring = '' then
        -- Set parameter to null if empty string
        tvincludestring := nullif(tvincludestring, '');
      end if;
    end if;

    -- Check if option mode is insert action status
    if optionMode = 'insertActionStatus' then
      -- Check if parameters are null
      if actionnumberstring is not null and actiondescriptionstring is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          ast.actionnumber
          from actionstatus ast
          where
          ast.actionnumber = actionnumberstring
          group by ast.actionnumber
        ) then
          -- Begin begin/except
          begin
            -- Insert record
            insert into actionstatus
            (
              actionnumber,
              actiondescription,
              created_date,
              modified_date
            )
            values
            (
              actionnumberstring,
              actiondescriptionstring,
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
          -- Record already exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, action number and action description were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is insert media audio encode
    elseif optionMode = 'insertMediaAudioEncode' then
      -- Check if parameters are null
      if audioencodestring is not null and movieincludestring is not null and tvincludestring is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          mae.audioencode
          from mediaaudioencode mae
          where
          mae.audioencode = audioencodestring
          group by mae.audioencode
        ) then
          -- Begin begin/except
          begin
            -- Insert record
            insert into mediaaudioencode
            (
              audioencode,
              movieInclude,
              tvInclude,
              created_date,
              modified_date
            )
            values
            (
              audioencodestring,
              movieincludestring,
              tvinclude,
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
          -- Record already exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, audio encode, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is insert media dynamic range
    elseif optionMode = 'insertMediaDynamicRange' then
      -- Check if parameters are null
      if dynamicrangestring is not null and movieincludestring is not null and tvincludestring is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          mdr.dynamicrange
          from mediadynamicrange mdr
          where
          mdr.dynamicrange = dynamicrangestring
          group by mdr.dynamicrange
        ) then
          -- Begin begin/except
          begin
            -- Insert record
            insert into mediadynamicrange
            (
              dynamicrange,
              movieInclude,
              tvInclude,
              created_date,
              modified_date
            )
            values
            (
              dynamicrangestring,
              movieincludestring,
              tvincludestring,
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
            -- Record already exist
            -- Set message
            result := '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, dynamic range, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is insert media resolution
    elseif optionMode = 'insertMediaResolution' then
      -- Check if parameters are null
      if resolutionstring is not null and movieincludestring is not null and tvincludestring is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          mr.resolution
          from mediaresolution mr
          where
          mr.resolution = resolutionstring
          group by mr.resolution
        ) then
          -- Begin begin/except
          begin
            -- Insert record
            insert into mediaresolution
            (
              resolution,
              movieInclude,
              tvInclude,
              created_date,
              modified_date
            )
            values
            (
              resolutionstring,
              movieincludestring,
              tvincludestring,
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
          -- Record already exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, resolution, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is insert media stream source
    elseif optionMode = 'insertMediaStreamSource' then
      -- Check if parameters are null
      if streamsourcestring is not null and streamdescriptionstring is not null and movieincludestring is not null and tvincludestring is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          mss.streamsource
          from mediastreamsource mss
          where
          mss.streamsource = streamsourcestring
          group by mss.streamsource
        ) then
          -- Begin begin/except
          begin
            -- Insert record
            insert into mediastreamsource
            (
              streamsource,
              streamdescription,
              movieInclude,
              tvInclude,
              created_date,
              modified_date
            )
            values
            (
              streamsourcestring,
              streamdescriptionstring,
              movieincludestring,
              tvincludestring,
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
          -- Record already exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, stream source, stream description, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is insert media video encode
    elseif optionMode = 'insertMediaVideoEncode' then
      -- Check if parameters are null
      if videoencodestring is not null and movieincludestring is not null and tvincludestring is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          mve.videoencode
          from mediavideoencode mve
          where
          mve.videoencode = videoencodestring
          group by mve.videoencode
        ) then
          -- Begin begin/except
          begin
            -- Insert record
            insert into mediavideoencode
            (
              videoencode,
              movieInclude,
              tvInclude,
              created_date,
              modified_date
            )
            values
            (
              videoencodestring,
              movieincludestring,
              tvincludestring,
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
          -- Record already exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, video encode, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is insert movie feed
    elseif optionMode = 'insertMovieFeed' then
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
                  publishdatestring,
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
                  publishdatestring,
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

    -- Else check if option mode is update action status
    elseif optionMode = 'updateActionStatus' then
      -- Check if parameters are null
      if actionnumberstring is not null and actiondescriptionstring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          ast.actionnumber
          from actionstatus ast
          where
          ast.actionnumber = actionnumberstring
          group by ast.actionnumber
        ) then
          -- Check if record does not exists
          if not exists
          (
            -- Select records
            select
            ast.actionnumber
            from actionstatus ast
            where
            ast.actionnumber = actionnumberstring and
            ast.actiondescription = actiondescriptionstring
            group by ast.actionnumber
          ) then
            -- Begin begin/except
            begin
              -- Update record
              update actionstatus
              set
              actiondescription = actiondescriptionstring,
              modified_date = cast(current_timestamp as timestamp)
              where
              actionstatus.actionnumber = actionnumberstring;

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
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, action number and action description were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is update media audio encode
    elseif optionMode = 'updateMediaAudioEncode' then
      -- Check if parameters are null
      if audioencodestring is not null and movieincludestring is not null and tvincludestring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mae.audioencode
          from mediaaudioencode mae
          where
          mae.audioencode = audioencodestring
          group by mae.audioencode
        ) then
          -- Check if record does not exists
          if not exists
          (
            -- Select records
            select
            mae.audioencode
            from mediaaudioencode mae
            where
            mae.audioencode = audioencodestring and
            mae.movieinclude = movieincludestring and
            mae.tvinclude = tvincludestring
            group by mae.audioencode
          ) then
            -- Begin begin/except
            begin
              -- Update record
              update mediaaudioencode
              set
              movieInclude = movieincludestring,
              tvInclude = tvincludestring,
              modified_date = cast(current_timestamp as timestamp)
              where
              mediaaudioencode.audioencode = audioencodestring;

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
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, audio encode, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is update media dynamic range
    elseif optionMode = 'updateMediaDynamicRange' then
      -- Check if parameters are null
      if dynamicrangestring is not null and movieincludestring is not null and tvincludestring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mdr.dynamicrange
          from mediadynamicrange mdr
          where
          mdr.dynamicrange = dynamicrangestring
          group by mdr.dynamicrange
        ) then
          -- Check if record does not exists
          if not exists
          (
            -- Select records
            select
            mdr.dynamicrange
            from mediadynamicrange mdr
            where
            mdr.dynamicrange = dynamicrange and
            mdr.movieinclude = movieinclude and
            mdr.tvinclude = tvinclude
            group by mdr.dynamicrange
          ) then
            -- Begin begin/except
            begin
              -- Update record
              update mediadynamicrange
              set
              movieInclude = movieincludestring,
              tvInclude = tvincludestring,
              modified_date = cast(current_timestamp as timestamp)
              where
              mediadynamicrange.dynamicrange = dynamicrangestring;

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
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, dynamic range, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is update media resolution
    elseif optionMode = 'updateMediaResolution' then
      -- Check if parameters are null
      if resolutionstring is not null and movieincludestring is not null and tvincludestring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mr.resolution
          from mediaresolution mr
          where
          mr.resolution = resolutionstring
          group by mr.resolution
        ) then
          -- Check if record does not exists
          if not exists
          (
            -- Select records
            select
            mr.resolution
            from mediaresolution mr
            where
            mr.resolution = resolutionstring and
            mr.movieinclude = movieincludestring and
            mr.tvinclude = tvincludestring
            group by mr.resolution
          ) then
            -- Begin begin/except
            begin
              -- Update record
              update mediaresolution
              set
              movieInclude = movieincludestring,
              tvInclude = tvincludestring,
              modified_date = cast(current_timestamp as timestamp)
              where
              mediaresolution.resolution = resolutionstring;

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
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, resolution, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is update media stream source
    elseif optionMode = 'updateMediaStreamSource' then
      -- Check if parameters are null
      if streamsourcestring is not null and streamdescriptionstring is not null and movieincludestring is not null and tvincludestring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mss.streamsource
          from mediastreamsource mss
          where
          mss.streamsource = streamsourcestring
          group by mss.streamsource
        ) then
          -- Check if record does not exists
          if not exists
          (
            -- Select records
            select
            mss.streamsource
            from mediastreamsource mss
            where
            mss.streamsource = streamsourcestring and
            mss.streamdescription = streamdescriptionstring and
            mss.movieinclude = movieincludestring and
            mss.tvinclude = tvincludestring
            group by mss.streamsource
          ) then
            -- Begin begin/except
            begin
              -- Update record
              update mediastreamsource
              set
              streamdescription = streamdescriptionstring,
              movieInclude = movieincludestring,
              tvInclude = tvincludestring,
              modified_date = cast(current_timestamp as timestamp)
              where
              mediastreamsource.streamsource = streamsourcestring;

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
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, stream source, stream description, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is update media video encode
    elseif optionMode = 'updateMediaVideoEncode' then
      -- Check if parameters are null
      if videoencodestring is not null and movieincludestring is not null and tvincludestring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mve.videoencode
          from mediavideoencode mve
          where
          mve.videoencode = videoencodestring
          group by mve.videoencode
        ) then
          -- Check if record does not exists
          if not exists
          (
            -- Select records
            select
            mve.videoencode
            from mediavideoencode mve
            where
            mve.videoencode = videoencodestring and
            mve.movieInclude = movieincludestring and
            mve.tvInclude = tvincludestring
            group by mve.videoencode
          ) then
            -- Begin begin/except
            begin
              -- Update record
              update mediavideoencode
              set
              movieInclude = movieincludestring,
              tvInclude = tvincludestring,
              modified_date = cast(current_timestamp as timestamp)
              where
              mediavideoencode.videoencode = videoencodestring;

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
          -- Record does not exist
          -- Set message
          result := '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        result := '{"Status": "Error", "Message": "Process halted, video encode, movie include, and tv include were not provided"}';
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
                  publish_date = publishdatestring,
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
                publish_date = publishdatestring,
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

    -- Else check if option mode is delete action status
    elseif optionMode = 'deleteActionStatus' then
      -- Check if parameters are not null
      if actionnumberstring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          ast.actionnumber
          from actionstatus ast
          where
          ast.actionnumber = actionnumberstring
          group by ast.actionnumber
        ) then
          -- Begin begin/except
          begin
            -- Delete record
            delete
            from actionstatus ast
            where
            ast.actionnumber = actionnumberstring;

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
        result := '{"Status": "Error", "Message": "Process halted, action number was not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Check if option mode is delete media audio encode
    elseif optionMode = 'deleteMediaAudioEncode' then
      -- Check if parameters are not null
      if audioencodestring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mae.audioencode
          from mediaaudioencode mae
          where
          mae.audioencode = audioencodestring
          group by mae.audioencode
        ) then
          -- Begin begin/except
          begin
            -- Delete record
            delete
            from mediaaudioencode mae
            where
            mae.audioencode = audioencodestring;

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
        result := '{"Status": "Error", "Message": "Process halted, audio encode was not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Check if option mode is delete media dynamic range
    elseif optionMode = 'deleteMediaDynamicRange' then
      -- Check if parameters are not null
      if dynamicrangestring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mdr.dynamicrange
          from mediadynamicrange mdr
          where
          mdr.dynamicrange = dynamicrangestring
          group by mdr.dynamicrange
        ) then
          -- Begin begin/except
          begin
            -- Delete record
            delete
            from mediadynamicrange mdr
            where
            mdr.dynamicrange = dynamicrangestring;

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
        result := '{"Status": "Error", "Message": "Process halted, dynamic range was not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Check if option mode is delete media resolution
    elseif optionMode = 'deleteMediaResolution' then
      -- Check if parameters are not null
      if resolutionstring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mr.resolution
          from mediaresolution mr
          where
          mr.resolution = resolutionstring
          group by mr.resolution
        ) then
          -- Begin begin/except
          begin
            -- Delete record
            delete
            from mediaresolution mr
            where
            mr.resolution = resolutionstring;

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
        result := '{"Status": "Error", "Message": "Process halted, resolution was not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Check if option mode is delete media stream source
    elseif optionMode = 'deleteMediaStreamSource' then
      -- Check if parameters are not null
      if streamsourcestring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mss.streamsource
          from mediastreamsource mss
          where
          mss.streamsource = streamsourcestring
          group by mss.streamsource
        ) then
          -- Begin begin/except
          begin
            -- Delete record
            delete
            from mediastreamsource mss
            where
            mss.streamsource = streamsourcestring;

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
        result := '{"Status": "Error", "Message": "Process halted, stream source was not provided"}';
      end if;

      -- Select message
      select
      result into "status";

    -- Check if option mode is delete media video encode
    elseif optionMode = 'deleteMediaVideoEncode' then
      -- Check if parameters are not null
      if videoencodestring is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mve.videoencode
          from mediavideoencode mve
          where
          mve.videoencode = videoencodestring
          group by mve.videoencode
        ) then
          -- Begin begin/except
          begin
            -- Delete record
            delete
            from mediavideoencode mve
            where
            mve.videoencode = videoencodestring;

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
        result := '{"Status": "Error", "Message": "Process halted, video encode was not provided"}';
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