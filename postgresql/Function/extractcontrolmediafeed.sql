-- Database Connect
\c <databasename>;

-- =================================================
--        File: extractcontrolmediafeed
--     Created: 11/16/2020
--     Updated: 11/16/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Extract control media feed
-- =================================================

-- Function Drop
drop function if exists extractcontrolmediafeed;

-- Function Create Or Replace
create or replace function extractcontrolmediafeed(in optionMode text default null, in actionnumber text default null, in actiondescription text default null, in audioencode text default null, in dynamicrange text default null, in resolution text default null, in streamsource text default null, in streamdescription text default null, in videoencode text default null, in "limit" text default null, in sort text default null)
returns table (actionnumberreturn text,
  actiondescriptionreturn text,
  audioencodereturn text,
  dynamicrangereturn text,
  resolutionreturn text,
  streamsourcereturn text,
  streamdescriptionreturn text,
  videoencodereturn text,
  movieIncludereturn text,
  tvIncludereturn text
)
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
  declare omitLimit varchar(255) := '[^0-9\-]';
  declare omitSort varchar(255) := '[^a-zA-Z]';
  declare maxLengthOptionMode int := 255;
  declare maxLengthActionNumber int := 255;
  declare maxLengthActionDescription int := 255;
  declare maxLengthMediaAudioEncode int := 100;
  declare maxLengthMediaDynamicRange int := 100;
  declare maxLengthMediaResolution int := 100;
  declare maxLengthMediaStreamSource int := 100;
  declare maxLengthMediaStreamDescription int := 100;
  declare maxLengthMediaVideoEncode int := 100;
  declare maxLengthSort int := 255;
  declare lowerLimit int := 1;
  declare upperLimit int := 100;
  declare defaultLimit int := 25;
  declare dSQL text := '';
  declare dSQLWhere text := '';
  declare countInput int := 0;

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
    if actionnumber is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      actionnumber := regexp_replace(regexp_replace(actionnumber, omitActionNumber, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      actionnumber := trim(substring(actionnumber, 1, maxLengthActionNumber));

      -- Check if empty string
      if actionnumber = '' then
        -- Set parameter to null if empty string
        actionnumber := nullif(actionnumber, '');
      end if;
    end if;

    -- Check if parameter is not null
    if actiondescription is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      actiondescription := regexp_replace(regexp_replace(actiondescription, omitActionDescription, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      actiondescription := trim(substring(actiondescription, 1, maxLengthActionDescription));

      -- Check if empty string
      if actiondescription = '' then
        -- Set parameter to null if empty string
        actiondescription := nullif(actiondescription, '');
      end if;
    end if;

    -- Check if parameter is not null
    if audioencode is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      audioencode := regexp_replace(regexp_replace(audioencode, omitMediaAudioEncode, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      audioencode := trim(substring(audioencode, 1, maxLengthMediaAudioEncode));

      -- Check if empty string
      if audioencode = '' then
        -- Set parameter to null if empty string
        audioencode := nullif(audioencode, '');
      end if;
    end if;

    -- Check if parameter is not null
    if dynamicrange is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      dynamicrange := regexp_replace(regexp_replace(dynamicrange, omitMediaDynamicRange, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      dynamicrange := trim(substring(dynamicrange, 1, maxLengthMediaDynamicRange));

      -- Check if empty string
      if dynamicrange = '' then
        -- Set parameter to null if empty string
        dynamicrange := nullif(dynamicrange, '');
      end if;
    end if;

    -- Check if parameter is not null
    if resolution is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      resolution := regexp_replace(regexp_replace(resolution, omitMediaResolution, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      resolution := trim(substring(resolution, 1, maxLengthMediaResolution));

      -- Check if empty string
      if resolution = '' then
        -- Set parameter to null if empty string
        resolution := nullif(resolution, '');
      end if;
    end if;

    -- Check if parameter is not null
    if streamsource is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      streamsource := regexp_replace(regexp_replace(streamsource, omitMediaStreamSource, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      streamsource := trim(substring(streamsource, 1, maxLengthMediaStreamSource));

      -- Check if empty string
      if streamsource = '' then
        -- Set parameter to null if empty string
        streamsource := nullif(streamsource, '');
      end if;
    end if;

    -- Check if parameter is not null
    if streamdescription is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      streamdescription := regexp_replace(regexp_replace(streamdescription, omitMediaStreamDescription, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      streamdescription := trim(substring(streamdescription, 1, maxLengthMediaStreamDescription));

      -- Check if empty string
      if streamdescription = '' then
        -- Set parameter to null if empty string
        streamdescription := nullif(streamdescription, '');
      end if;
    end if;

    -- Check if parameter is not null
    if videoencode is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      videoencode := regexp_replace(regexp_replace(videoencode, omitMediaVideoEncode, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      videoencode := trim(substring(videoencode, 1, maxLengthMediaVideoEncode));

      -- Check if empty string
      if videoencode = '' then
        -- Set parameter to null if empty string
        videoencode := nullif(videoencode, '');
      end if;
    end if;

    -- Check if parameter is not null
    if "limit" is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      "limit" := regexp_replace(regexp_replace("limit", omitLimit, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      "limit" := trim("limit");

      -- Check if empty string
      if "limit" = '' then
        -- Set parameter to null if empty string
        "limit" := nullif("limit", '');
      end if;
    end if;

    -- Check if parameter is not null
    if sort is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      sort := regexp_replace(regexp_replace(sort, omitSort, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      sort := trim(substring(sort, 1, maxLengthSort));

      -- Check if empty string
      if sort = '' then
        -- Set parameter to null if empty string
        sort := nullif(sort, '');
      end if;
    end if;

    -- Check if option mode is extract action status
    if optionMode = 'extractActionStatus' then
      -- Increment counter
      countInput := countInput + 1;

      -- Check if limit is given
      if "limit" is null or cast("limit" as int) not between lowerLimit and upperLimit then
        -- Set limit to default number
        "limit" := defaultLimit;
      end if;

      -- Check if sort is given
      if sort is null or lower(sort) not in ('desc', 'asc') then
        -- Set sort to default sorting
        sort := 'asc';
      end if;

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      dSQL :=
      'select
      cast(ast.actionnumber as text),
      cast(ast.actiondescription as text),
      '''',
      '''',
      '''',
      '''',
      '''',
      '''',
      '''',
      ''''
      from actionstatus ast';

      -- Check if where clause is given
      if actionnumber is not null then
        -- Set variable
        dSQLWhere := concat('ast.actionnumber = $', countInput);

        -- Increment counter
        countInput := countInput + 1;
      end if;

      -- Check if where clause is given
      if actiondescription is not null then
        -- Check if dynamic SQL is not empty
        if trim(dSQLWhere) <> trim('') then
          -- Include the next filter into the where clause
          dSQLWhere := concat(dSQLWhere, ' and ast.actiondescription = $', countInput);

          -- Increment counter
          countInput := countInput + 1;
        else
          -- Include the next filter into the where clause
          dSQLWhere := concat('ast.actiondescription = $', countInput);

          -- Increment counter
          countInput := countInput + 1;
        end if;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(dSQLWhere) <> trim('') then
        -- Include the where clause
        dSQLWhere := concat(' where ', dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      dSQL := concat(dSQL, dSQLWhere, ' order by ast.actionnumber ', sort, ', ast.actiondescription ', sort, ' limit $', countInput);

      -- Increment counter
      countInput := countInput + 1;

      -- Check if parameters were set
      if actionnumber is not null and actiondescription is null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(actionnumber as int), cast("limit" as int);
      elseif actionnumber is null and actiondescription is not null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(actiondescription as varchar(255)), cast("limit" as int);
      elseif actionnumber is not null and actiondescription is not null then
        -- Else if execute all parameters statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(actionnumber as int), cast(actiondescription as varchar(255)), cast("limit" as int);
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast("limit" as int);
      end if;

    -- Else check if option mode is extract media audio encode
    elseif optionMode = 'extractMediaAudioEncode' then
      -- Increment counter
      countInput := countInput + 1;

      -- Check if limit is given
      if "limit" is null or cast("limit" as int) not between lowerLimit and upperLimit then
        -- Set limit to default number
        "limit" := defaultLimit;
      else
        -- Set limit to user input
        "limit" := "limit";
      end if;

      -- Check if sort is given
      if sort is null or lower(sort) not in ('desc', 'asc') then
        -- Set sort to default sorting
        sort := 'asc';
      else
        -- Set sort to user input
        sort := sort;
      end if;

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      dSQL :=
      'select
      '''',
      '''',
      cast(mae.audioencode as text),
      '''',
      '''',
      '''',
      '''',
      '''',
      cast(mae.movieInclude as text),
      cast(mae.tvInclude as text)
      from mediaaudioencode mae';

      -- Check if where clause is given
      if audioencode is not null then
        -- Set variable
        dSQLWhere := concat('mae.audioencode = $', countInput);

        -- Increment counter
        countInput := countInput + 1;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(dSQLWhere) <> trim('') then
        -- Include the where clause
        dSQLWhere := concat(' where ', dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      dSQL := concat(dSQL, dSQLWhere, ' order by mae.audioencode ', sort, ' limit $', countInput);

      -- Increment counter
      countInput := countInput + 1;

      -- Check if parameters were set
      if audioencode is not null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(audioencode as citext), cast("limit" as int);
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast("limit" as int);
      end if;

    -- Else check if option mode is delete temp tv
    elseif optionMode = 'extractMediaDynamicRange' then
      -- Increment counter
      countInput := countInput + 1;

      -- Check if limit is given
      if "limit" is null or cast("limit" as int) not between lowerLimit and upperLimit then
        -- Set limit to default number
        "limit" := defaultLimit;
      else
        -- Set limit to user input
        "limit" := "limit";
      end if;

      -- Check if sort is given
      if sort is null or lower(sort) not in ('desc', 'asc') then
        -- Set sort to default sorting
        sort := 'asc';
      else
        -- Set sort to user input
        sort := sort;
      end if;

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      dSQL :=
      'select
      '''',
      '''',
      '''',
      cast(mdr.dynamicrange as text),
      '''',
      '''',
      '''',
      '''',
      cast(mdr.movieInclude as text),
      cast(mdr.tvInclude as text)
      from mediadynamicrange mdr';

      -- Check if where clause is given
      if dynamicrange is not null then
        -- Set variable
        dSQLWhere := concat('mdr.dynamicrange = $', countInput);

        -- Increment counter
        countInput := countInput + 1;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(dSQLWhere) <> trim('') then
        -- Include the where clause
        dSQLWhere := concat(' where ', dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      dSQL := concat(dSQL, dSQLWhere, ' order by mdr.dynamicrange ', sort, ' limit $', countInput);

      -- Increment counter
      countInput := countInput + 1;

      -- Check if parameters were set
      if dynamicrange is not null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(dynamicrange as citext), cast("limit" as int);
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast("limit" as int);
      end if;

    -- Else check if option mode is extract media resolution
    elseif optionMode = 'extractMediaResolution' then
      -- Increment counter
      countInput := countInput + 1;

      -- Check if limit is given
      if "limit" is null or cast("limit" as int) not between lowerLimit and upperLimit then
        -- Set limit to default number
        "limit" := defaultLimit;
      else
        -- Set limit to user input
        "limit" := "limit";
      end if;

      -- Check if sort is given
      if sort is null or lower(sort) not in ('desc', 'asc') then
        -- Set sort to default sorting
        sort := 'asc';
      else
        -- Set sort to user input
        sort := sort;
      end if;

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      dSQL :=
      'select
      '''',
      '''',
      '''',
      '''',
      cast(mr.resolution as text),
      '''',
      '''',
      '''',
      cast(mr.movieInclude as text),
      cast(mr.tvInclude as text)
      from mediaresolution mr';

      -- Check if where clause is given
      if resolution is not null then
        -- Set variable
        dSQLWhere := concat('mr.resolution = $', countInput);

        -- Increment counter
        countInput := countInput + 1;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(dSQLWhere) <> trim('') then
        -- Include the where clause
        dSQLWhere := concat(' where ', dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      dSQL := concat(dSQL, dSQLWhere, ' order by mr.resolution ', sort, ' limit $', countInput);

      -- Increment counter
      countInput := countInput + 1;

      -- Check if parameters were set
      if resolution is not null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(resolution as citext), cast("limit" as int);
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast("limit" as int);
      end if;

    -- Else check if option mode is extract media stream source
    elseif optionMode = 'extractMediaStreamSource' then
      -- Increment counter
      countInput := countInput + 1;

      -- Check if limit is given
      if "limit" is null or cast("limit" as int) not between lowerLimit and upperLimit then
        -- Set limit to default number
        "limit" := defaultLimit;
      else
        -- Set limit to user input
        "limit" := "limit";
      end if;

      -- Check if sort is given
      if sort is null or lower(sort) not in ('desc', 'asc') then
        -- Set sort to default sorting
        sort := 'asc';
      else
        -- Set sort to user input
        sort := sort;
      end if;

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      dSQL :=
      'select
      '''',
      '''',
      '''',
      '''',
      '''',
      cast(mss.streamsource as text),
      cast(mss.streamdescription as text),
      '''',
      cast(mss.movieInclude as text),
      cast(mss.tvInclude as text)
      from mediastreamsource mss';

      -- Check if where clause is given
      if streamsource is not null then
        -- Set variable
        dSQLWhere := concat('mss.streamsource = $', countInput);

        -- Increment counter
        countInput := countInput + 1;
      end if;

      -- Check if where clause is given
      if streamdescription is not null then
        -- Check if dynamic SQL is not empty
        if trim(dSQLWhere) <> trim('') then
          -- Include the next filter into the where clause
          dSQLWhere := concat(dSQLWhere, ' and mss.streamdescription = $', countInput);
        else
          -- Include the next filter into the where clause
          dSQLWhere := concat('mss.streamdescription = $', countInput);
        end if;

        -- Increment counter
        countInput := countInput + 1;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(dSQLWhere) <> trim('') then
        -- Include the where clause
        dSQLWhere := concat(' where ', dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      dSQL := concat(dSQL, dSQLWhere, ' order by mss.streamsource ', sort, ', mss.streamdescription ', sort, ' limit $', countInput);

      -- Increment counter
      countInput := countInput + 1;

      -- Check if parameters were set
      if streamsource is not null and streamdescription is null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(streamsource as citext), cast("limit" as int);
      elseif streamsource is null and streamdescription is not null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(streamdescription as citext), cast("limit" as int);
      elseif streamsource is not null and streamdescription is not null then
        -- Else if execute all parameters statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(streamsource as citext), cast(streamdescription as citext), cast("limit" as int);
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast("limit" as int);
      end if;

    -- Else check if option mode is extract media video encode
    elseif optionMode = 'extractMediaVideoEncode' then
      -- Increment counter
      countInput := countInput + 1;

      -- Check if limit is given
      if "limit" is null or cast("limit" as int) not between lowerLimit and upperLimit then
        -- Set limit to default number
        "limit" := defaultLimit;
      else
        -- Set limit to user input
        "limit" := "limit";
      end if;

      -- Check if sort is given
      if sort is null or lower(sort) not in ('desc', 'asc') then
        -- Set sort to default sorting
        sort := 'asc';
      else
        -- Set sort to user input
        sort := sort;
      end if;

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      dSQL :=
      'select
      '''',
      '''',
      '''',
      '''',
      '''',
      '''',
      '''',
      cast(mve.videoencode as text),
      cast(mve.movieInclude as text),
      cast(mve.tvInclude as text)
      from mediavideoencode mve';

      -- Check if where clause is given
      if videoencode is not null then
        -- Set variable
        dSQLWhere := concat('mve.videoencode = $', countInput);

        -- Increment counter
        countInput := countInput + 1;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(dSQLWhere) <> trim('') then
        -- Include the where clause
        dSQLWhere := concat(' where ', dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      dSQL := concat(dSQL, dSQLWhere, ' order by mve.videoencode ', sort, ' limit $', countInput);

      -- Increment counter
      countInput := countInput + 1;

      -- Check if parameters were set
      if videoencode is not null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(videoencode as citext), cast("limit" as int);
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast("limit" as int);
      end if;
    end if;
  end; $$
language plpgsql;