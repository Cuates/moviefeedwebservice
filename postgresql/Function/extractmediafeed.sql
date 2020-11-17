-- Database Connect
\c <databasename>;

-- =================================================
--        File: extractmediafeed
--     Created: 11/10/2020
--     Updated: 11/17/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Extract media feed
-- =================================================

-- Function Drop
drop function if exists extractmediafeed;

-- Function Create Or Replace
create or replace function extractmediafeed(in optionMode text default null, in titlelong text default null, in titleshort text default null, in actionstatus text default null, in "limit" text default null, in sort text default null)
returns table (titlelongreturn text,
  titleshortreturn text,
  publishdatereturn text,
  actionstatusreturn text
)
as $$
  -- Declare variables
  declare omitOptionMode varchar(255) := '[^a-zA-Z]';
  declare omitTitleLong varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitTitleShort varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitActionStatus varchar(255) := '[^0-9]';
  declare omitLimit varchar(255) := '[^0-9\-]';
  declare omitSort varchar(255) := '[^a-zA-Z]';
  declare maxLengthOptionMode int := 255;
  declare maxLengthTitleLong int := 255;
  declare maxLengthTitleShort int := 255;
  declare maxLengthActionStatus int := 255;
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
      actionstatus := regexp_replace(regexp_replace(actionstatus, omitActionStatus, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      actionstatus := trim(substring(actionstatus, 1, maxLengthActionStatus));

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

    -- Else check if option mode is extract movie feed
    if optionMode = 'extractMovieFeed' then
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