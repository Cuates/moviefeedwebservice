-- Database Connect
use <databasename>;

-- =================================================
--        File: insertupdatedeletecontrolmediafeed
--     Created: 11/16/2020
--     Updated: 11/16/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert update delete control media feed
-- =================================================

-- Procedure Drop
drop procedure if exists insertupdatedeletecontrolmediafeed;

-- Procedure Create Or Replace
create or replace procedure insertupdatedeletecontrolmediafeed(in optionMode text default null, in actionnumber text default null, in actiondescription text default null, in audioencode text default null, in dynamicrange text default null, in resolution text default null, in streamsource text default null, in streamdescription text default null, in videoencode text default null, in movieinclude text default null, in tvinclude text default null, inout status text default null)
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
    if actionnumberstring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      actionnumberstring := regexp_replace(regexp_replace(actionnumberstring, omitActionNumber, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      actionnumberstring := trim(substring(actionnumberstring, 1, maxLengthActionNumber));

      -- Check if empty string
      if actionnumberstring = '' then
        -- Set parameter to null if empty string
        actionnumberstring := nullif(actionnumberstring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if actiondescriptionstring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      actiondescriptionstring := regexp_replace(regexp_replace(actiondescriptionstring, omitActionDescription, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      actiondescriptionstring := trim(substring(actiondescriptionstring, 1, maxLengthActionDescription));

      -- Check if empty string
      if actiondescriptionstring = '' then
        -- Set parameter to null if empty string
        actiondescriptionstring := nullif(actiondescriptionstring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if audioencodestring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      audioencodestring := regexp_replace(regexp_replace(audioencodestring, omitMediaAudioEncode, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      audioencodestring := trim(substring(audioencodestring, 1, maxLengthMediaAudioEncode));

      -- Check if empty string
      if audioencodestring = '' then
        -- Set parameter to null if empty string
        audioencodestring := nullif(audioencodestring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if dynamicrangestring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      dynamicrangestring := regexp_replace(regexp_replace(dynamicrangestring, omitMediaDynamicRange, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      dynamicrangestring := trim(substring(dynamicrangestring, 1, maxLengthMediaDynamicRange));

      -- Check if empty string
      if dynamicrangestring = '' then
        -- Set parameter to null if empty string
        dynamicrangestring := nullif(dynamicrangestring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if resolutionstring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      resolutionstring := regexp_replace(regexp_replace(resolutionstring, omitMediaResolution, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      resolutionstring := trim(substring(resolutionstring, 1, maxLengthMediaResolution));

      -- Check if empty string
      if resolutionstring = '' then
        -- Set parameter to null if empty string
        resolutionstring := nullif(resolutionstring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if streamsourcestring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      streamsourcestring := regexp_replace(regexp_replace(streamsourcestring, omitMediaStreamSource, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      streamsourcestring := trim(substring(streamsourcestring, 1, maxLengthMediaStreamSource));

      -- Check if empty string
      if streamsourcestring = '' then
        -- Set parameter to null if empty string
        streamsourcestring := nullif(streamsourcestring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if streamdescriptionstring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      streamdescriptionstring := regexp_replace(regexp_replace(streamdescriptionstring, omitMediaStreamDescription, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      streamdescriptionstring := trim(substring(streamdescriptionstring, 1, maxLengthMediaStreamDescription));

      -- Check if empty string
      if streamdescriptionstring = '' then
        -- Set parameter to null if empty string
        streamdescriptionstring := nullif(streamdescriptionstring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if videoencodestring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      videoencodestring := regexp_replace(regexp_replace(videoencodestring, omitMediaVideoEncode, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      videoencodestring := trim(substring(videoencodestring, 1, maxLengthMediaVideoEncode));

      -- Check if empty string
      if videoencodestring = '' then
        -- Set parameter to null if empty string
        videoencodestring := nullif(videoencodestring, '');
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
    end if;
  end; $$
language plpgsql;