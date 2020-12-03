-- Database Connect
-- use <databasename>;

-- =================================================
--        File: insertupdatedeletemediafeed
--     Created: 11/06/2020
--     Updated: 12/02/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert update delete media feed
-- =================================================

-- Procedure Drop
drop procedure if exists insertupdatedeletemediafeed;

-- Procedure Create
delimiter //
create procedure `insertupdatedeletemediafeed`(in optionMode text, in titlelong text, in titleshort text, in titleshortold text, in publishdate text, in actionstatus text)
  begin
    -- Declare variables
    declare omitOptionMode varchar(255);
    declare omitTitleLong varchar(255);
    declare omitTitleShort varchar(255);
    declare omitPublishDate varchar(255);
    declare omitActionStatus varchar(255);
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
    declare maxLengthActionStatus int;
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
    set omitTitleLong = '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
    set omitTitleShort = '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
    set omitPublishDate = '[^0-9\-/:. ]';
    set omitActionStatus = '[^0-9]';
    set maxLengthOptionMode = 255;
    set maxLengthTitleLong = 255;
    set maxLengthTitleShort = 255;
    set maxLengthPublishDate = 255;
    set maxLengthActionStatus = 255;
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
    if titlelong is not null then
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
    if titleshort is not null then
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
    if titleshortold is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set titleshortold = regexp_replace(regexp_replace(titleshortold, omitTitleShort, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set titleshortold = trim(substring(titleshortold, 1, maxLengthTitleShort));

      -- Check if empty string
      if titleshortold = '' then
        -- Set parameter to null if empty string
        set titleshortold = nullif(titleshortold, '');
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
      set actionstatus = regexp_replace(regexp_replace(actionstatus, omitActionStatus, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set actionstatus = trim(substring(actionstatus, 1, maxLengthActionStatus));

      -- Check if empty string
      if actionstatus = '' then
        -- Set parameter to null if empty string
        set actionstatus = nullif(actionstatus, '');
      end if;
    end if;

    -- Else check if option mode is insert movie feed
    if optionMode = 'insertMovieFeed' then
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
          -- Check if year string is greater than 5 and string is a valid year
          if char_length(titleshort) > 5 and str_to_date(substring(titleshort, char_length(titleshort) - 3, char_length(titleshort)), '%Y') is not null then
            -- Check if record exists
            if exists
            (
              -- Select record
              select
              titlelong as `titlelong`
              from actionstatus ast
              join mediaaudioencode mae on mae.movieInclude in (1) and titlelong like concat('%', mae.audioencode, '%')
              left join mediadynamicrange mdr on mdr.movieInclude in (1) and titlelong like concat('%', mdr.dynamicrange, '%')
              join mediaresolution mr on mr.movieInclude in (1) and titlelong like concat('%', mr.resolution, '%')
              left join mediastreamsource mss on mss.movieInclude in (1) and titlelong like concat('%', mss.streamsource, '%')
              join mediavideoencode mve on mve.movieInclude in (1) and titlelong like concat('%', mve.videoencode, '%')
              where
              ast.actionnumber = actionstatus
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
                  lower(titleshort),
                  date_format(publishdate, '%Y-%m-%d %H:%i:%s.%f'),
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
              -- Set message
              set result = concat('{"Status": "Error", "Message": "Title long and action number does not follow the allowed values"}');
            end if;
          else
            -- Set message
            set result = concat('{"Status": "Error", "Message": "Title short does not follow the allowed value"}');
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
          -- Check if record exists
          if exists
          (
            -- Select record
            select
            titlelong as `titlelong`
            from actionstatus ast
            join mediaaudioencode mae on mae.tvInclude in (1) and titlelong like concat('%', mae.audioencode, '%')
            left join mediadynamicrange mdr on mdr.tvInclude in (1) and titlelong like concat('%', mdr.dynamicrange, '%')
            join mediaresolution mr on mr.tvInclude in (1) and titlelong like concat('%', mr.resolution, '%')
            left join mediastreamsource mss on mss.tvInclude in (1) and titlelong like concat('%', mss.streamsource, '%')
            join mediavideoencode mve on mve.tvInclude in (1) and titlelong like concat('%', mve.videoencode, '%')
            where
            ast.actionnumber = actionstatus
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
                lower(titleshort),
                date_format(publishdate, '%Y-%m-%d %H:%i:%s.%f'),
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
            -- Set message
            set result = concat('{"Status": "Error", "Message": "Title long and or action status does not follow the allowed values"}');
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
          -- Check if year string is greater than 5 and string is a valid year
          if char_length(titleshort) > 5 and str_to_date(substring(titleshort, char_length(titleshort) - 3, char_length(titleshort)), '%Y') is not null then
            -- Check if record exists
            if exists
            (
              -- Select record
              select
              titlelong as `titlelong`
              from actionstatus ast
              join mediaaudioencode mae on mae.movieInclude in (1) and titlelong like concat('%', mae.audioencode, '%')
              left join mediadynamicrange mdr on mdr.movieInclude in (1) and titlelong like concat('%', mdr.dynamicrange, '%')
              join mediaresolution mr on mr.movieInclude in (1) and titlelong like concat('%', mr.resolution, '%')
              left join mediastreamsource mss on mss.movieInclude in (1) and titlelong like concat('%', mss.streamsource, '%')
              join mediavideoencode mve on mve.movieInclude in (1) and titlelong like concat('%', mve.videoencode, '%')
              where
              ast.actionnumber = actionstatus
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
                  mf.titleshort = lower(titleshort),
                  mf.publish_date = date_format(publishdate, '%Y-%m-%d %H:%i:%s.%f'),
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
              -- Set message
              set result = concat('{"Status": "Error", "Message": "Title long and or action status does not follow the allowed values"}');
            end if;
          else
            -- Set message
            set result = concat('{"Status": "Error", "Message": "Title short does not follow the allowed value"}');
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
          -- Check if year string is greater than 5 and string is a valid year
          if char_length(titleshort) > 5 and str_to_date(substring(titleshort, char_length(titleshort) - 3, char_length(titleshort)), '%Y') is not null then
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
                mf.titleshort = lower(titleshort),
                mf.modified_date = current_timestamp(6)
                where
                mf.titleshort = titleshortold;

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
            -- Set message
            set result = concat('{"Status": "Error", "Message": "Title short does not follow the allowed value"}');
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
          -- Check if record exist
          if exists
          (
            -- Select record
            select
            ast.actionnumber as `actionnumber`
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
              mf.titleshort = titleshort and
              mf.actionstatus = actionstatus
              group by mf.titleshort
            ) then
              -- Start the tranaction
              start transaction;
                -- Update record
                update moviefeed mf
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
            -- Set message
            set result = concat('{"Status": "Error", "Message": "Action status value is invalid"}');
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
          -- Check if record exists
          if exists
          (
            -- Select record
            select
            titlelong as `titlelong`
            from actionstatus ast
            join mediaaudioencode mae on mae.tvInclude in (1) and titlelong like concat('%', mae.audioencode, '%')
            left join mediadynamicrange mdr on mdr.tvInclude in (1) and titlelong like concat('%', mdr.dynamicrange, '%')
            join mediaresolution mr on mr.tvInclude in (1) and titlelong like concat('%', mr.resolution, '%')
            left join mediastreamsource mss on mss.tvInclude in (1) and titlelong like concat('%', mss.streamsource, '%')
            join mediavideoencode mve on mve.tvInclude in (1) and titlelong like concat('%', mve.videoencode, '%')
            where
            ast.actionnumber = actionstatus
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
                tf.titleshort = lower(titleshort),
                tf.publish_date = date_format(publishdate, '%Y-%m-%d %H:%i:%s.%f'),
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
            -- Set message
            set result = concat('{"Status": "Error", "Message": "Title long and or action status does not follow the allowed values"}');
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
              tf.titleshort = lower(titleshort),
              tf.modified_date = current_timestamp(6)
              where
              tf.titleshort = titleshortold;

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
          -- Check if record exist
          if exists
          (
            -- Select record
            select
            ast.actionnumber as `actionnumber`
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
            -- Set message
            set result = concat('{"Status": "Error", "Message": "Action status value is invalid"}');
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