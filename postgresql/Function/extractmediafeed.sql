-- Database Connect
\c <databasename>;

-- =================================================
--        File: extractmediafeed
--     Created: 11/10/2020
--     Updated: 11/12/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Extract media feed
-- =================================================

-- Function Drop
drop function if exists extractmediafeed;

-- Function Create Or Replace
create or replace function extractmediafeed(in optionMode text default null, in actionnumber text default null, in actiondescription text default null, in audioencode text default null, in dynamicrange text default null, in resolution text default null, in streamsource text default null, in streamdescription text default null, in videoencode text default null, in titlelong text default null, in titleshort text default null, in actionstatus text default null, in "limit" text default null, in sort text default null)
returns table (actionnumberreturn text,
  actiondescriptionreturn text,
  audioencodereturn text,
  dynamicrangereturn text,
  resolutionreturn text,
  streamsourcereturn text,
  streamdescriptionreturn text,
  videoencodereturn text,
  movieIncludereturn text,
  tvIncludereturn text,
  titlelongreturn text,
  titleshortreturn text,
  publishdatereturn text,
  actionstatusreturn text
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
  declare omitTitleLong varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitTitleShort varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
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
  declare maxLengthTitleLong int := 255;
  declare maxLengthTitleShort int := 255;
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
    if titlelong is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      titlelong := regexp_replace(regexp_replace(titlelong, omitTitleLong, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      titlelong := trim(substring(titlelong, 1, maxLengthTitleLong));

      -- Check if empty string
      if titlelong = '' then
        -- Set parameter to null if empty string
        titlelong := nullif(titlelong, '');
      end if;
    end if;

    -- Check if parameter is not null
    if titleshort is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      titleshort := regexp_replace(regexp_replace(titleshort, omitTitleShort, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      titleshort := trim(substring(titleshort, 1, maxLengthTitleShort));

      -- Check if empty string
      if titleshort = '' then
        -- Set parameter to null if empty string
        titleshort := nullif(titleshort, '');
      end if;
    end if;

    -- Check if parameter is not null
    if actionstatus is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      actionstatus := regexp_replace(regexp_replace(actionstatus, omitActionNumber, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      actionstatus := trim(substring(actionstatus, 1, maxLengthActionNumber));

      -- Check if empty string
      if actionstatus = '' then
        -- Set parameter to null if empty string
        actionstatus := nullif(actionstatus, '');
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
      cast(mae.tvInclude as text),
      '''',
      '''',
      '''',
      ''''
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
      cast(mdr.tvInclude as text),
      '''',
      '''',
      '''',
      ''''
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
      cast(mr.tvInclude as text),
      '''',
      '''',
      '''',
      ''''
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
      cast(mss.tvInclude as text),
      '''',
      '''',
      '''',
      ''''
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
      cast(mve.tvInclude as text),
      '''',
      '''',
      '''',
      ''''
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

    -- Else check if option mode is extract movie feed
    elseif optionMode = 'extractMovieFeed' then
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
      '''',
      '''',
      '''',
      cast(mf.titlelong as text),
      cast(mf.titleshort as text),
      cast(to_char(mf.publish_date, ''YYYY-MM-DD HH24:MI:SS.US'') as text),
      cast(mf.actionstatus as text)
      from moviefeed mf';

      -- Check if where clause is given
      if titlelong is not null then
        -- Set variable
        dSQLWhere := concat('mf.titlelong = $', countInput);

        -- Increment counter
        countInput := countInput + 1;
      end if;

      -- Check if where clause is given
      if titleshort is not null then
        -- Check if dynamic SQL is not empty
        if trim(dSQLWhere) <> trim('') then
          -- Include the next filter into the where clause
          dSQLWhere := concat(dSQLWhere, ' and mf.titleshort = $', countInput);
        else
          -- Include the next filter into the where clause
          dSQLWhere := concat('mf.titleshort = $', countInput);
        end if;

        -- Increment counter
        countInput := countInput + 1;
      end if;

      -- Check if where clause is given
      if actionstatus is not null then
        -- Check if dynamic SQL is not empty
        if trim(dSQLWhere) <> trim('') then
          -- Include the next filter into the where clause
          dSQLWhere := concat(dSQLWhere, ' and mf.actionstatus = $', countInput);
        else
          -- Include the next filter into the where clause
          dSQLWhere := concat('mf.actionstatus = $', countInput);
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
      dSQL := concat(dSQL, dSQLWhere, ' order by mf.publish_date ', sort, ', mf.titlelong ', sort, ', mf.titleshort ', sort, ', mf.actionstatus ', sort, ' limit $', countInput);

      -- Increment counter
      countInput := countInput + 1;

      -- Check if parameters were set
      if titlelong is not null and titleshort is null and actionstatus is null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching YNN
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(titlelong as citext), cast("limit" as int);
      elseif titlelong is not null and titleshort is not null and actionstatus is null then
        -- Else if execute one parameter and not the other statement YYN
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(titlelong as citext), cast(titleshort as citext), cast("limit" as int);
      elseif titlelong is not null and titleshort is null and actionstatus is not null then
        -- Else if execute one parameter and not the other statement YNY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(titlelong as citext), cast(actionstatus as int), cast("limit" as int);
      elseif titlelong is null and titleshort is not null and actionstatus is null then
        -- Else if execute one parameter and not the other statement NYN
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(titleshort as citext), cast("limit" as int);
      elseif titlelong is null and titleshort is not null and actionstatus is not null then
        -- Else if execute one parameter and not the other statement NYY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(titleshort as citext), cast(actionstatus as int), cast("limit" as int);
      elseif titlelong is null and titleshort is null and actionstatus is not null then
        -- Else if execute all parameters statement NNY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(actionstatus as int), cast("limit" as int);
      elseif titlelong is not null and titleshort is not null and actionstatus is not null then
        -- Else if execute all parameters statement YYY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(titlelong as citext), cast(titleshort as citext), cast(actionstatus as int), cast("limit" as int);
      else
        -- Else execute default statement NNN
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast("limit" as int);
      end if;

    -- Else check if option mode is extract tv feed
    elseif optionMode = 'extractTVFeed' then
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
      '''',
      '''',
      '''',
      cast(tvf.titlelong as text),
      cast(tvf.titleshort as text),
      cast(to_char(tvf.publish_date, ''YYYY-MM-DD HH24:MI:SS.US'') as text),
      cast(tvf.actionstatus as text)
      from tvfeed tvf';

      -- Check if where clause is given
      if titlelong is not null then
        -- Set variable
        dSQLWhere := concat('tvf.titlelong = $', countInput);

        -- Increment counter
        countInput := countInput + 1;
      end if;

      -- Check if where clause is given
      if titleshort is not null then
        -- Check if dynamic SQL is not empty
        if trim(dSQLWhere) <> trim('') then
          -- Include the next filter into the where clause
          dSQLWhere := concat(dSQLWhere, ' and tvf.titleshort = $', countInput);
        else
          -- Include the next filter into the where clause
          dSQLWhere := concat('tvf.titleshort = $', countInput);
        end if;

        -- Increment counter
        countInput := countInput + 1;
      end if;

      -- Check if where clause is given
      if actionstatus is not null then
        -- Check if dynamic SQL is not empty
        if trim(dSQLWhere) <> trim('') then
          -- Include the next filter into the where clause
          dSQLWhere := concat(dSQLWhere, ' and tvf.actionstatus = $', countInput);
        else
          -- Include the next filter into the where clause
          dSQLWhere := concat('tvf.actionstatus = $', countInput);
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
      dSQL := concat(dSQL, dSQLWhere, ' order by tvf.publish_date ', sort, ', tvf.titlelong ', sort, ', tvf.titleshort ', sort, ', tvf.actionstatus ', sort, ' limit $', countInput);

      -- Increment counter
      countInput := countInput + 1;

      -- Check if parameters were set
      if titlelong is not null and titleshort is null and actionstatus is null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching YNN
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(titlelong as citext), cast("limit" as int);
      elseif titlelong is not null and titleshort is not null and actionstatus is null then
        -- Else if execute one parameter and not the other statement YYN
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(titlelong as citext), cast(titleshort as citext), cast("limit" as int);
      elseif titlelong is not null and titleshort is null and actionstatus is not null then
        -- Else if execute one parameter and not the other statement YNY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(titlelong as citext), cast(actionstatus as int), cast("limit" as int);
      elseif titlelong is null and titleshort is not null and actionstatus is null then
        -- Else if execute one parameter and not the other statement NYN
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(titleshort as citext), cast("limit" as int);
      elseif titlelong is null and titleshort is not null and actionstatus is not null then
        -- Else if execute one parameter and not the other statement NYY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(titleshort as citext), cast(actionstatus as int), cast("limit" as int);
      elseif titlelong is null and titleshort is null and actionstatus is not null then
        -- Else if execute all parameters statement NNY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(actionstatus as int), cast("limit" as int);
      elseif titlelong is null and titleshort is null and actionstatus is not null then
        -- Else if execute all parameters statement NNY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(actionstatus as int), cast("limit" as int);
      elseif titlelong is not null and titleshort is not null and actionstatus is not null then
        -- Else if execute all parameters statement YYY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        -- Return dynamic sql
        return query execute format(
        '%s',
        dSQL
        ) using cast(titlelong as citext), cast(titleshort as citext), cast(actionstatus as int), cast("limit" as int);
      else
        -- Else execute default statement NNN
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