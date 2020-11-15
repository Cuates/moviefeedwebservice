-- Database Connect
use <databasename>;

-- =================================================
--        File: insertupdatedeletemediafeed
--     Created: 11/06/2020
--     Updated: 11/15/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert update delete media feed
-- =================================================

-- Procedure Drop
drop procedure if exists insertupdatedeletemediafeed;

-- Procedure Create
delimiter //
create procedure `insertupdatedeletemediafeed`(in optionMode text, in actionnumber text, in actiondescription text, in audioencode text, in dynamicrange text, in resolution text, in streamsource text, in streamdescription text, in videoencode text, in titlelong text, in titleshort text, in titleshortold text, in publishdate text, in actionstatus text, in movieinclude text, in tvinclude text)
  begin
    -- Declare variables
    declare omitOptionMode varchar(255);
    declare omitActionNumber varchar(255);
    declare omitActionDescription varchar(255);
    declare omitMediaAudioEncode varchar(255);
    declare omitMediaDynamicRange varchar(255);
    declare omitMediaResolution varchar(255);
    declare omitMediaStreamSource varchar(255);
    declare omitMediaStreamDescription varchar(255);
    declare omitMediaVideoEncode varchar(255);
    declare omitTitleLong varchar(255);
    declare omitTitleShort varchar(255);
    declare omitPublishDate varchar(255);
    declare omitMovieInclude varchar(255);
    declare omitTVInclude varchar(255);
    declare maxLengthOptionMode int;
    declare maxLengthActionDescription int;
    declare maxLengthMediaAudioEncode int;
    declare maxLengthMediaDynamicRange int;
    declare maxLengthMediaResolution int;
    declare maxLengthMediaStreamSource int;
    declare maxLengthMediaStreamDescription int;
    declare maxLengthMediaVideoEncode int;
    declare maxLengthTitleLong int;
    declare maxLengthTitleShort int;
    declare maxLengthActionNumber int;
    declare maxLengthPublishDate int;
    declare maxLengthMovieInclude int;
    declare maxLengthTVInclude int;
    declare code varchar(5) default '00000';
    declare msg text;
    declare result text;
    declare successcode varchar(5);

    -- Declare exception handler for failed insert
    declare CONTINUE HANDLER FOR SQLEXCEPTION
      begin
        GET DIAGNOSTICS CONDITION 1
          code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
      end;

    -- Set variable
    set omitOptionMode = '[^a-zA-Z]';
    set omitActionNumber = '[^0-9]';
    set omitActionDescription = '[^a-zA-Z]';
    set omitMediaAudioEncode = '[^a-zA-Z0-9.\-]';
    set omitMediaDynamicRange = '[^a-zA-Z]';
    set omitMediaResolution = '[^a-zA-Z0-9]';
    set omitMediaStreamSource = '[^a-zA-Z]';
    set omitMediaStreamDescription = '[^a-zA-Z]';
    set omitMediaVideoEncode = '[^a-zA-Z0-9]';
    set omitTitleLong = '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
    set omitTitleShort = '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
    set omitPublishDate = '[^0-9\-/:. ]';
    set omitMovieInclude = '[^01]';
    set omitTVInclude = '[^01]';
    set maxLengthOptionMode = 255;
    set maxLengthActionNumber = 255;
    set maxLengthActionDescription = 255;
    set maxLengthMediaAudioEncode = 100;
    set maxLengthMediaDynamicRange = 100;
    set maxLengthMediaResolution = 100;
    set maxLengthMediaStreamSource = 100;
    set maxLengthMediaStreamDescription = 100;
    set maxLengthMediaVideoEncode = 100;
    set maxLengthTitleLong = 255;
    set maxLengthTitleShort = 255;
    set maxLengthPublishDate = 255;
    set maxLengthMovieInclude = 1;
    set maxLengthTVInclude = 1;
    set successcode = '00000';

    -- Check if parameter is not null
    if optionMode is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set optionMode = regexp_replace(regexp_replace(optionMode, omitOptionMode, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set optionMode = trim(substring(optionMode, 1, maxLengthOptionMode));

      -- Check if empty string
      if optionMode = '' then
        -- Set parameter to null if empty string
        set optionMode = nullif(optionMode, '');
      end if;
    end if;

    -- Check if parameter is not null
    if titleLong is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set titlelong = regexp_replace(regexp_replace(titlelong, omitTitleLong, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set titlelong = trim(substring(titlelong, 1, maxLengthTitleLong));

      -- Check if empty string
      if titlelong = '' then
        -- Set parameter to null if empty string
        set titlelong = nullif(titlelong, '');
      end if;
    end if;

    -- Check if parameter is not null
    if titleShort is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set titleshort = regexp_replace(regexp_replace(titleshort, omitTitleShort, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set titleshort = trim(substring(titleshort, 1, maxLengthTitleShort));

      -- Check if empty string
      if titleshort = '' then
        -- Set parameter to null if empty string
        set titleshort = nullif(titleshort, '');
      end if;
    end if;

    -- Check if parameter is not null
    if publishdate is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set publishdate = regexp_replace(regexp_replace(publishdate, omitPublishDate, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set publishdate = trim(substring(publishdate, 1, maxLengthPublishDate));

      -- Check if the parameter cannot be casted into a date time
      if str_to_date(publishdate, '%Y-%m-%d %H:%i:%S') is null then
        -- Set the string as empty to be nulled below
        set publishdate = '';
      end if;

      -- Check if empty string
      if publishdate = '' then
        -- Set parameter to null if empty string
        set publishdate = nullif(publishdate, '');
      end if;
    end if;

    -- Check if parameter is not null
    if actionstatus is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set actionstatus = regexp_replace(regexp_replace(actionstatus, omitActionNumber, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set actionstatus = trim(substring(actionstatus, 1, maxLengthActionNumber));

      -- Check if empty string
      if actionstatus = '' then
        -- Set parameter to null if empty string
        set actionstatus = nullif(actionstatus, '');
      end if;
    end if;

    -- Check if parameter is not null
    if movieinclude is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set movieinclude = regexp_replace(regexp_replace(movieinclude, omitMovieInclude, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set movieinclude = trim(substring(movieinclude, 1, maxLengthMovieInclude));

      -- Check if empty string
      if movieinclude = '' then
        -- Set parameter to null if empty string
        set movieinclude = nullif(movieinclude, '');
      end if;
    end if;

    -- Check if parameter is not null
    if tvinclude is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set tvinclude = regexp_replace(regexp_replace(tvinclude, omitTVInclude, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set tvinclude = trim(substring(tvinclude, 1, maxLengthTVInclude));

      -- Check if empty string
      if tvinclude = '' then
        -- Set parameter to null if empty string
        set tvinclude = nullif(tvinclude, '');
      end if;
    end if;

    -- Check if option mode is insert action status
    if optionMode = 'insertActionStatus' then
      -- Check if parameters are null
      if actionnumber is not null and actiondescription is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          ast.actionnumber
          from actionstatus ast
          where
          ast.actionnumber = actionnumber
          group by ast.actionnumber
        ) then
          -- Start the tranaction
          start transaction;
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
              actionnumber,
              actiondescription,
              current_timestamp(6),
              current_timestamp(6)
            );

            -- Check whether the insert was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) inserted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record already exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, action number and action description were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is insert media audio encode
    elseif optionMode = 'insertMediaAudioEncode' then
      -- Check if parameters are null
      if audioencode is not null and movieinclude is not null and tvinclude is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          mae.audioencode
          from mediaaudioencode mae
          where
          mae.audioencode = audioencode
          group by mae.audioencode
        ) then
          -- Start the tranaction
          start transaction;
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
              audioencode,
              movieinclude,
              tvinclude,
              current_timestamp(6),
              current_timestamp(6)
            );

            -- Check whether the insert was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) inserted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record already exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, audio encode, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is insert media dynamic range
    elseif optionMode = 'insertMediaDynamicRange' then
      -- Check if parameters are null
      if dynamicrange is not null and movieinclude is not null and tvinclude is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          mdr.dynamicrange
          from mediadynamicrange mdr
          where
          mdr.dynamicrange = dynamicrange
          group by mdr.dynamicrange
        ) then
          -- Start the tranaction
          start transaction;
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
              dynamicrange,
              movieinclude,
              tvinclude,
              current_timestamp(6),
              current_timestamp(6)
            );

            -- Check whether the insert was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) inserted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
            -- Record already exist
            -- Set message
            set result = '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, dynamic range, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is insert media resolution
    elseif optionMode = 'insertMediaResolution' then
      -- Check if parameters are null
      if resolution is not null and movieinclude is not null and tvinclude is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          mr.resolution
          from mediaresolution mr
          where
          mr.resolution = resolution
          group by mr.resolution
        ) then
          -- Start the tranaction
          start transaction;
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
              resolution,
              movieinclude,
              tvinclude,
              current_timestamp(6),
              current_timestamp(6)
            );

            -- Check whether the insert was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) inserted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record already exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, resolution, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is insert media stream source
    elseif optionMode = 'insertMediaStreamSource' then
      -- Check if parameters are null
      if streamsource is not null and streamdescription is not null and movieinclude is not null and tvinclude is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          mss.streamsource
          from mediastreamsource mss
          where
          mss.streamsource = streamsource
          group by mss.streamsource
        ) then
          -- Start the tranaction
          start transaction;
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
              streamsource,
              streamdescription,
              movieinclude,
              tvinclude,
              current_timestamp(6),
              current_timestamp(6)
            );

            -- Check whether the insert was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) inserted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record already exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, stream source, stream description, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is insert media video encode
    elseif optionMode = 'insertMediaVideoEncode' then
      -- Check if parameters are null
      if videoencode is not null and movieinclude is not null and tvinclude is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          mve.videoencode
          from mediavideoencode mve
          where
          mve.videoencode = videoencode
          group by mve.videoencode
        ) then
          -- Start the tranaction
          start transaction;
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
              videoencode,
              movieinclude,
              tvinclude,
              current_timestamp(6),
              current_timestamp(6)
            );

            -- Check whether the insert was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) inserted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record already exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, video encode, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is insert movie feed
    elseif optionMode = 'insertMovieFeed' then
      -- Check if parameters are null
      if titlelong is not null and titleshort is not null and publishdate is not null and actionstatus is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          mf.titlelong
          from moviefeed mf
          where
          mf.titlelong = titlelong
          group by mf.titlelong
        ) then
          -- Start the tranaction
          start transaction;
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
              titlelong,
              titleshort,
              publishdate,
              actionstatus,
              current_timestamp(6),
              current_timestamp(6)
            );

            -- Check whether the insert was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) inserted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record already exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, title long, title short, publish date, and action status were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is insert tv feed
    elseif optionMode = 'insertTVFeed' then
      -- Check if parameters are null
      if titlelong is not null and titleshort is not null and publishdate is not null and actionstatus is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          tf.titlelong
          from tvfeed tf
          where
          tf.titlelong = titlelong
          group by tf.titlelong
        ) then
          -- Start the tranaction
          start transaction;
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
              titlelong,
              titleshort,
              publishdate,
              actionstatus,
              current_timestamp(6),
              current_timestamp(6)
            );

            -- Check whether the insert was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) inserted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record already exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, title long, title short, publish date, and action status were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update action status
    elseif optionMode = 'updateActionStatus' then
      -- Check if parameters are null
      if actionnumber is not null and actiondescription is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          ast.actionnumber
          from actionstatus ast
          where
          ast.actionnumber = actionnumber
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
            ast.actionnumber = actionnumber and
            ast.actiondescription = actiondescription
            group by ast.actionnumber
          ) then
            -- Start the tranaction
            start transaction;
              -- Update record
              update actionstatus ast
              set
              ast.actiondescription = actiondescription,
              ast.modified_date = current_timestamp(6)
              where
              ast.actionnumber = actionnumber;

              -- Check whether the update was successful
              if code = successcode then
                -- Commit transactional statement
                commit;

                -- Set message
                set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
              else
                -- Rollback to the previous state before the transaction was called
                rollback;

                -- Set message
                set result = concat('{"Status": "Error", "Message": "', msg, '"}');
              end if;
          else
            -- Set message
            set result = concat('{"Status": "Success", "Message": "Record already exists"}');
          end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, action number and action description were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update media audio encode
    elseif optionMode = 'updateMediaAudioEncode' then
      -- Check if parameters are null
      if audioencode is not null and movieinclude is not null and tvinclude is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mae.audioencode
          from mediaaudioencode mae
          where
          mae.audioencode = audioencode
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
            mae.audioencode = audioencode and
            mae.movieinclude = movieinclude and
            mae.tvinclude = tvinclude
            group by mae.audioencode
          ) then
            -- Start the tranaction
            start transaction;
              -- Update record
              update mediaaudioencode mae
              set
              mae.movieInclude = movieinclude,
              mae.tvInclude = tvinclude,
              mae.modified_date = current_timestamp(6)
              where
              mae.audioencode = audioencode;

              -- Check whether the update was successful
              if code = successcode then
                -- Commit transactional statement
                commit;

                -- Set message
                set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
              else
                -- Rollback to the previous state before the transaction was called
                rollback;

                -- Set message
                set result = concat('{"Status": "Error", "Message": "', msg, '"}');
              end if;
          else
            -- Set message
            set result = concat('{"Status": "Success", "Message": "Record already exists"}');
          end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, audio encode, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update media dynamic range
    elseif optionMode = 'updateMediaDynamicRange' then
      -- Check if parameters are null
      if dynamicrange is not null and movieinclude is not null and tvinclude is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mdr.dynamicrange
          from mediadynamicrange mdr
          where
          mdr.dynamicrange = dynamicrange
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
            -- Start the tranaction
            start transaction;
              -- Update record
              update mediadynamicrange mdr
              set
              mdr.movieInclude = movieinclude,
              mdr.tvInclude = tvinclude,
              mdr.modified_date = current_timestamp(6)
              where
              mdr.dynamicrange = dynamicrange;

              -- Check whether the update was successful
              if code = successcode then
                -- Commit transactional statement
                commit;

                -- Set message
                set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
              else
                -- Rollback to the previous state before the transaction was called
                rollback;

                -- Set message
                set result = concat('{"Status": "Error", "Message": "', msg, '"}');
              end if;
          else
            -- Set message
            set result = concat('{"Status": "Success", "Message": "Record already exists"}');
          end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, dynamic range, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update media resolution
    elseif optionMode = 'updateMediaResolution' then
      -- Check if parameters are null
      if resolution is not null and movieinclude is not null and tvinclude is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mr.resolution
          from mediaresolution mr
          where
          mr.resolution = resolution
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
            mr.resolution = resolution and
            mr.movieinclude = movieinclude and
            mr.tvinclude = tvinclude
            group by mr.resolution
          ) then
            -- Start the tranaction
            start transaction;
              -- Update record
              update mediaresolution mr
              set
              mr.movieInclude = movieinclude,
              mr.tvInclude = tvinclude,
              mr.modified_date = current_timestamp(6)
              where
              mr.resolution = resolution;

              -- Check whether the update was successful
              if code = successcode then
                -- Commit transactional statement
                commit;

                -- Set message
                set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
              else
                -- Rollback to the previous state before the transaction was called
                rollback;

                -- Set message
                set result = concat('{"Status": "Error", "Message": "', msg, '"}');
              end if;
          else
            -- Set message
            set result = concat('{"Status": "Success", "Message": "Record already exists"}');
          end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, resolution, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update media stream source
    elseif optionMode = 'updateMediaStreamSource' then
      -- Check if parameters are null
      if streamsource is not null and streamdescription is not null and movieinclude is not null and tvinclude is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mss.streamsource
          from mediastreamsource mss
          where
          mss.streamsource = streamsource
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
            mss.streamsource = streamsource and
            mss.streamdescription = streamdescription and
            mss.movieinclude = movieinclude and
            mss.tvinclude = tvinclude
            group by mss.streamsource
          ) then
            -- Start the tranaction
            start transaction;
              -- Update record
              update mediastreamsource mss
              set
              mss.streamdescription = streamdescription,
              mss.movieInclude = movieinclude,
              mss.tvInclude = tvinclude,
              mss.modified_date = current_timestamp(6)
              where
              mss.streamsource = streamsource;

              -- Check whether the update was successful
              if code = successcode then
                -- Commit transactional statement
                commit;

                -- Set message
                set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
              else
                -- Rollback to the previous state before the transaction was called
                rollback;

                -- Set message
                set result = concat('{"Status": "Error", "Message": "', msg, '"}');
              end if;
          else
            -- Set message
            set result = concat('{"Status": "Success", "Message": "Record already exists"}');
          end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, stream source, stream description, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update media video encode
    elseif optionMode = 'updateMediaVideoEncode' then
      -- Check if parameters are null
      if videoencode is not null and movieinclude is not null and tvinclude is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mve.videoencode
          from mediavideoencode mve
          where
          mve.videoencode = videoencode
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
            mve.videoencode = videoencode and
            mve.movieInclude = movieInclude and
            mve.tvInclude = tvinclude
            group by mve.videoencode
          ) then
            -- Start the tranaction
            start transaction;
              -- Update record
              update mediavideoencode mve
              set
              mve.movieInclude = movieinclude,
              mve.tvInclude = tvinclude,
              mve.modified_date = current_timestamp(6)
              where
              mve.videoencode = videoencode;

              -- Check whether the update was successful
              if code = successcode then
                -- Commit transactional statement
                commit;

                -- Set message
                set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
              else
                -- Rollback to the previous state before the transaction was called
                rollback;

                -- Set message
                set result = concat('{"Status": "Error", "Message": "', msg, '"}');
              end if;
          else
            -- Set message
            set result = concat('{"Status": "Success", "Message": "Record already exists"}');
          end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, video encode, movie include, and tv include were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update movie feed
    elseif optionMode = 'updateMovieFeed' then
      -- Check if parameters are null
      if titlelong is not null and titleshort is not null and publishdate is not null and actionstatus is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mf.titlelong
          from moviefeed mf
          where
          mf.titlelong = titlelong
          group by mf.titlelong
        ) then
          -- Check if record does not exists
          if not exists
          (
            -- Select records
            select
            mf.titlelong
            from moviefeed mf
            where
            mf.titlelong = titlelong and
            mf.titleshort = titleshort and
            mf.publish_date = publishdate and
            mf.actionstatus = actionstatus
            group by mf.titlelong
          ) then
            -- Start the tranaction
            start transaction;
              -- Update record
              update moviefeed mf
              set
              mf.titleshort = titleshort,
              mf.publish_date = publishdate,
              mf.actionstatus = actionstatus,
              mf.modified_date = current_timestamp(6)
              where
              mf.titlelong = titlelong;

              -- Check whether the update was successful
              if code = successcode then
                -- Commit transactional statement
                commit;

                -- Set message
                set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
              else
                -- Rollback to the previous state before the transaction was called
                rollback;

                -- Set message
                set result = concat('{"Status": "Error", "Message": "', msg, '"}');
              end if;
          else
            -- Set message
            set result = concat('{"Status": "Success", "Message": "Record already exists"}');
          end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, title long, title short, publish date, and action status were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update movie title short
    elseif optionMode = 'updateMovieFeedTitleShort' then
      -- Check if parameters are null
      if titleshort is not null and titleshortold is not null then
        -- Check if record does not exist
        if not exists
        (
          -- Select record in question
          select
          mf.titleshort
          from moviefeed mf
          where
          mf.titleshort = titleshort
          group by mf.titleshort
        ) then
          -- Check if record exist
          if exists
          (
            -- Select record in question
            select
            mf.titleshort
            from moviefeed mf
            where
            mf.titleshort = titleshortold
            group by mf.titleshort
          ) then
            -- Start the tranaction
            start transaction;
              -- Update record
              update moviefeed mf
              set
              mf.titleshort = titleshort,
              mf.modified_date = current_timestamp(6)
              where
              mf.titlelong = titleshortold;

              -- Check whether the update was successful
              if code = successcode then
                -- Commit transactional statement
                commit;

                -- Set message
                set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
              else
                -- Rollback to the previous state before the transaction was called
                rollback;

                -- Set message
                set result = concat('{"Status": "Error", "Message": "', msg, '"}');
              end if;
          else
            -- Record does not exist
            -- Set message
            set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
          end if;
        else
          -- Record already exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, title short and title short old were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update movie feed title short action status
    elseif optionMode = 'updateMovieFeedTitleShortActionStatus' then
      -- Check if parameters are null
      if titleshort is not null and actionstatus is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mf.titleshort
          from moviefeed mf
          where
          mf.titleshort = titleshort
          group by mf.titleshort
        ) then
          -- Check if record does not exists
          if not exists
          (
            -- Select records
            select
            mf.titleshort
            from moviefeed mf
            where
            mf.titleshort = titleshort and
            mf.actionstatus = actionstatus
            group by mf.titleshort
          ) then
            -- Start the tranaction
            start transaction;
              -- Update record
              update moviefeed
              set
              mf.actionstatus = actionstatus,
              mf.modified_date = current_timestamp(6)
              where
              mf.titleshort = titleshort;

              -- Check whether the update was successful
              if code = successcode then
                -- Commit transactional statement
                commit;

                -- Set message
                set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
              else
                -- Rollback to the previous state before the transaction was called
                rollback;

                -- Set message
                set result = concat('{"Status": "Error", "Message": "', msg, '"}');
              end if;
          else
            -- Set message
            set result = concat('{"Status": "Success", "Message": "Record already exists"}');
          end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, title short and action status were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update tv feed
    elseif optionMode = 'updateTVFeed' then
      -- Check if parameters are null
      if titlelong is not null and titleshort is not null and publishdate is not null and actionstatus is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          tf.titlelong
          from tvfeed tf
          where
          tf.titlelong = titlelong
          group by tf.titlelong
        ) then
          -- Check if record does not exists
          if not exists
          (
            -- Select records
            select
            tf.titlelong
            from tvfeed tf
            where
            tf.titlelong = titlelong and
            tf.titleshort = titleshort and
            tf.publish_date = publishdate and
            tf.actionstatus = actionstatus
            group by tf.titlelong
          ) then
            -- Start the tranaction
            start transaction;
              -- Update record
              update tvfeed tf
              set
              tf.titleshort = titleshort,
              tf.publish_date = publishdate,
              tf.actionstatus = actionstatus,
              tf.modified_date = current_timestamp(6)
              where
              tf.titlelong = titlelong;

              -- Check whether the update was successful
              if code = successcode then
                -- Commit transactional statement
                commit;

                -- Set message
                set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
              else
                -- Rollback to the previous state before the transaction was called
                rollback;

                -- Set message
                set result = concat('{"Status": "Error", "Message": "', msg, '"}');
              end if;
          else
            -- Set message
            set result = concat('{"Status": "Success", "Message": "Record already exists"}');
          end if;
        else
            -- Record does not exist
            -- Set message
            set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, title long, title short, publish date, and action status were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update tv feed title short
    elseif optionMode = 'updateTVFeedTitleShort' then
      -- Check if parameters are null
      if titleshort is not null and titleshortold is not null then
        -- Check if record exist
        if not exists
        (
          -- Select record in question
          select
          tf.titleshort
          from tvfeed tf
          where
          tf.titleshort = titleshort
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
            tf.titleshort = titleshortold
            group by tf.titleshort
          ) then
            -- Start the tranaction
            start transaction;
              -- Update record
              update tvfeed tf
              set
              tf.titleshort = titleshort,
              tf.modified_date = current_timestamp(6)
              where
              tf.titlelong = titleshortold;

              -- Check whether the update was successful
              if code = successcode then
                -- Commit transactional statement
                commit;

                -- Set message
                set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
              else
                -- Rollback to the previous state before the transaction was called
                rollback;

                -- Set message
                set result = concat('{"Status": "Error", "Message": "', msg, '"}');
              end if;
          else
            -- Record does not exist
            -- Set message
            set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
          end if;
        else
          -- Record already exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) already exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, title short and title short old were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update tv feed title short action status
    elseif optionMode = 'updateTVFeedTitleShortActionStatus' then
      -- Check if parameters are null
      if titleshort is not null and actionstatus is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          tf.titleshort
          from tvfeed tf
          where
          tf.titleshort = titleshort
          group by tf.titleshort
        ) then
          -- Check if record does not exists
          if not exists
          (
            -- Select records
            select
            tf.titleshort
            from tvfeed tf
            where
            tf.titleshort = titleshort and
            tf.actionstatus = actionstatus
            group by tf.titleshort
          ) then
            -- Start the tranaction
            start transaction;
              -- Update record
              update tvfeed tf
              set
              tf.actionstatus = actionstatus,
              tf.modified_date = current_timestamp(6)
              where
              tf.titleshort = titleshort;

              -- Check whether the update was successful
              if code = successcode then
                -- Commit transactional statement
                commit;

                -- Set message
                set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
              else
                -- Rollback to the previous state before the transaction was called
                rollback;

                -- Set message
                set result = concat('{"Status": "Error", "Message": "', msg, '"}');
              end if;
          else
            -- Set message
            set result = concat('{"Status": "Success", "Message": "Record already exists"}');
          end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, title short and action status were not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is delete action status
    elseif optionMode = 'deleteActionStatus' then
      -- Check if parameters are not null
      if actionnumber is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          ast.actionnumber
          from actionstatus ast
          where
          ast.actionnumber = actionnumber
          group by ast.actionnumber
        ) then
          -- Start the tranaction
          start transaction;
            -- Delete record
            delete ast
            from actionstatus ast
            where
            ast.actionnumber = actionnumber;

            -- Check whether the update was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) deleted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, action number was not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Check if option mode is delete media audio encode
    elseif optionMode = 'deleteMediaAudioEncode' then
      -- Check if parameters are not null
      if audioencode is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mae.audioencode
          from mediaaudioencode mae
          where
          mae.audioencode = audioencode
          group by mae.audioencode
        ) then
          -- Start the tranaction
          start transaction;
            -- Delete record
            delete mae
            from mediaaudioencode mae
            where
            mae.audioencode = audioencode;

            -- Check whether the update was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) deleted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, audio encode was not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Check if option mode is delete media dynamic range
    elseif optionMode = 'deleteMediaDynamicRange' then
      -- Check if parameters are not null
      if dynamicrange is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mdr.dynamicrange
          from mediadynamicrange mdr
          where
          mdr.dynamicrange = dynamicrange
          group by mdr.dynamicrange
        ) then
          -- Start the tranaction
          start transaction;
            -- Delete record
            delete mdr
            from mediadynamicrange mdr
            where
            mdr.dynamicrange = dynamicrange;

            -- Check whether the update was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) deleted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, dynamic range was not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Check if option mode is delete media resolution
    elseif optionMode = 'deleteMediaResolution' then
      -- Check if parameters are not null
      if resolution is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mr.resolution
          from mediaresolution mr
          where
          mr.resolution = resolution
          group by mr.resolution
        ) then
          -- Start the tranaction
          start transaction;
            -- Delete record
            delete mr
            from mediaresolution mr
            where
            mr.resolution = resolution;

            -- Check whether the update was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) deleted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, resolution was not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Check if option mode is delete media stream source
    elseif optionMode = 'deleteMediaStreamSource' then
      -- Check if parameters are not null
      if streamsource is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mss.streamsource
          from mediastreamsource mss
          where
          mss.streamsource = streamsource
          group by mss.streamsource
        ) then
          -- Start the tranaction
          start transaction;
            -- Delete record
            delete mss
            from mediastreamsource mss
            where
            mss.streamsource = streamsource;

            -- Check whether the update was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) deleted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, stream source was not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Check if option mode is delete media video encode
    elseif optionMode = 'deleteMediaVideoEncode' then
      -- Check if parameters are not null
      if videoencode is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mve.videoencode
          from mediavideoencode mve
          where
          mve.videoencode = videoencode
          group by mve.videoencode
        ) then
          -- Start the tranaction
          start transaction;
            -- Delete record
            delete mve
            from mediavideoencode mve
            where
            mve.videoencode = videoencode;

            -- Check whether the update was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) deleted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, video encode was not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Check if option mode is delete  movie feed title long
    elseif optionMode = 'deleteMovieFeed' then
      -- Check if parameters are not null
      if titlelong is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mf.titlelong
          from moviefeed mf
          where
          mf.titlelong = titlelong
          group by mf.titlelong
        ) then
          -- Start the tranaction
          start transaction;
            -- Delete record
            delete mf
            from moviefeed mf
            where
            mf.titlelong = titlelong;

            -- Check whether the update was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) deleted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, title long was not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Check if option mode is delete movie feed title short
    elseif optionMode = 'deleteMovieFeedTitleShort' then
      -- Check if parameters are not null
      if titleshort is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          mf.titleshort
          from moviefeed mf
          where
          mf.titleshort = titleshort
          group by mf.titleshort
        ) then
          -- Start the tranaction
          start transaction;
            -- Delete record
            delete mf
            from moviefeed mf
            where
            mf.titleshort = titleshort;

            -- Check whether the update was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) deleted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, title short was not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Check if option mode is delete tv feed title long
    elseif optionMode = 'deleteTVFeed' then
      -- Check if parameters are not null
      if titlelong is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          tf.titlelong
          from tvfeed tf
          where
          tf.titlelong = titlelong
          group by tf.titlelong
        ) then
          -- Start the tranaction
          start transaction;
            -- Delete record
            delete tf
            from tvfeed tf
            where
            tf.titlelong = titlelong;

            -- Check whether the update was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) deleted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, title long was not provided"}';
      end if;

      -- Select message
      select
      result as `status`;

    -- Check if option mode is delete tv feed title short
    elseif optionMode = 'deleteTVFeedTitleShort' then
      -- Check if parameters are not null
      if titleshort is not null then
        -- Check if record exist
        if exists
        (
          -- Select record in question
          select
          tf.titleshort
          from tvfeed tf
          where
          tf.titleshort = titleshort
          group by tf.titleshort
        ) then
          -- Start the tranaction
          start transaction;
            -- Delete record
            delete tf
            from tvfeed tf
            where
            tf.titleshort = titleshort;

            -- Check whether the update was successful
            if code = successcode then
              -- Commit transactional statement
              commit;

              -- Set message
              set result = concat('{"Status": "Success", "Message": "Record(s) deleted"}');
            else
              -- Rollback to the previous state before the transaction was called
              rollback;

              -- Set message
              set result = concat('{"Status": "Error", "Message": "', msg, '"}');
            end if;
        else
          -- Record does not exist
          -- Set message
          set result = '{"Status": "Success", "Message": "Record(s) does not exist"}';
        end if;
      else
        -- Set message
        set result = '{"Status": "Error", "Message": "Process halted, title short was not provided"}';
      end if;

      -- Select message
      select
      result as `status`;
    end if;
  end
// delimiter ;