-- Database Connect
use <databasename>;

-- =================================================
--        File: extractmediafeed
--     Created: 11/07/2020
--     Updated: 11/16/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Extract media feed
-- =================================================

-- Procedure Drop
drop procedure if exists extractmediafeed;

-- Procedure Create
delimiter //
create procedure `extractmediafeed`(in optionMode text, in titlelong text, in titleshort text, in actionstatus text, in `limit` text, in sort text)
  begin
    -- Declare variables
    declare omitOptionMode nvarchar(255);
    declare omitTitleLong nvarchar(255);
    declare omitTitleShort nvarchar(255);
    declare omitActionStatus nvarchar(255);
    declare omitLimit nvarchar(255);
    declare omitSort nvarchar(255);
    declare maxLengthOptionMode int;
    declare maxLengthTitleLong int;
    declare maxLengthTitleShort int;
    declare maxLengthActionStatus int;
    declare maxLengthSort int;
    declare lowerLimit int;
    declare upperLimit int;
    declare defaultLimit int;
    declare code varchar(5) default '00000';
    declare msg text;
    declare result text;
    declare successcode varchar(5);
    declare dSQL text;
    declare dSQLWhere text;

    -- Declare exception handler for failed insert
    declare CONTINUE HANDLER FOR SQLEXCEPTION
      begin
        GET DIAGNOSTICS CONDITION 1
          code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
      end;

    -- Set variables
    set omitOptionMode = '[^a-zA-Z]';
    set omitTitleLong = '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
    set omitTitleShort = '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
    set omitActionStatus = '[^0-9]';
    set omitLimit = '[^0-9\-]';
    set omitSort = '[^a-zA-Z]';
    set maxLengthOptionMode = 255;
    set maxLengthTitleLong = 255;
    set maxLengthTitleShort = 255;
    set maxLengthActionStatus = 255;
    set maxLengthSort = 255;
    set lowerLimit = 1;
    set upperLimit = 100;
    set defaultLimit = 25;
    set @dSQL = '';
    set @dSQLWhere = '';
    set successcode = '00000';
    set @titlelong = null;
    set @titleshort = null;
    set @actionstatus = null;
    set @`limit` = null;
    set @sort = null;

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

    -- Check if parameter is not null
    if `limit` is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set `limit` = regexp_replace(regexp_replace(`limit`, omitLimit, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set `limit` = trim(`limit`);

      -- Check if empty string
      if `limit` = '' then
        -- Set parameter to null if empty string
        set `limit` = nullif(`limit`, '');
      end if;
    end if;

    -- Check if parameter is not null
    if sort is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set sort = regexp_replace(regexp_replace(sort, omitSort, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set sort = trim(substring(sort, 1, maxLengthSort));

      -- Check if empty string
      if sort = '' then
        -- Set parameter to null if empty string
        set sort = nullif(sort, '');
      end if;
    end if;

    -- Else check if option mode is extract movie feed
    if optionMode = 'extractMovieFeed' then
      -- Check if limit is given
      if `limit` is null or `limit` not between lowerLimit and upperLimit then
        -- Set limit to default number
        set @`limit` = defaultLimit;
      else
        -- Set limit to user input
        set @`limit` = `limit`;
      end if;

      -- Check if sort is given
      if sort is null or lower(sort) not in ('desc', 'asc') then
        -- Set sort to default sorting
        set @sort = 'asc';
      else
        -- Set sort to user input
        set @sort = sort;
      end if;

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      set @dSQL =
      'select
      mf.titlelong as `Title Long`,
      mf.titleshort as `Title Short`,
      date_format(mf.publish_date, ''%Y-%m-%d %H:%i:%s.%f'') as `Publish Date`,
      cast(mf.actionstatus as char) as `Action Status`
      from moviefeed mf';

      -- Check if where clause is given
      if titlelong is not null then
        -- Set variable
        set @dSQLWhere = 'mf.titlelong = ?';
        set @titlelong = titlelong;
      end if;

      -- Check if where clause is given
      if titleshort is not null then
        -- Check if dynamic SQL is not empty
        if trim(@dSQLWhere) <> trim('') then
          -- Include the next filter into the where clause
          set @dSQLWhere = concat(@dSQLWhere, ' and mf.titleshort = ?');
        else
          -- Include the next filter into the where clause
          set @dSQLWhere = 'mf.titleshort = ?';
        end if;

        -- Set variable
        set @titleshort = titleshort;
      end if;

      -- Check if where clause is given
      if actionstatus is not null then
        -- Check if dynamic SQL is not empty
        if trim(@dSQLWhere) <> trim('') then
          -- Include the next filter into the where clause
          set @dSQLWhere = concat(@dSQLWhere, ' and mf.actionstatus = ?');
        else
          -- Include the next filter into the where clause
          set @dSQLWhere = 'mf.actionstatus = ?';
        end if;

        -- Set variable
        set @actionstatus = actionstatus;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(@dSQLWhere) <> trim('') then
        -- Include the where clause
        set @dSQLWhere = concat(' where ', @dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = concat(@dSQL, @dSQLWhere, ' order by mf.publish_date ', @sort, ', mf.titlelong ', @sort, ', mf.titleshort ', @sort, ', mf.actionstatus ', @sort, ' limit ?');

      -- Prepare the statement
      prepare queryStatement from @dSQL;

      -- Check if parameters were set
      if @titlelong is not null and @titleshort is null and @actionstatus is null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching YNN
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titlelong, @`limit`;
      elseif @titlelong is not null and @titleshort is not null and @actionstatus is null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching YYN
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titlelong, @titleshort, @`limit`;
      elseif @titlelong is not null and @titleshort is null and @actionstatus is not null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching YNY
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titlelong, @actionstatus, @`limit`;
      elseif @titlelong is null and @titleshort is not null and @actionstatus is null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching NYN
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titleshort, @`limit`;
      elseif @titlelong is null and @titleshort is not null and @actionstatus is not null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching NYY
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titleshort, @actionstatus, @`limit`;
      elseif @titlelong is null and @titleshort is null and @actionstatus is not null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching NNY
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @actionstatus, @`limit`;
      elseif @titlelong is not null and @titleshort is not null and @actionstatus is not null then
        -- Else if execute all parameters statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching YYY
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titlelong, @titleshort, @actionstatus, @`limit`;
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching NNN
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @`limit`;
      end if;

      -- Deallocate prepare statement
      deallocate prepare queryStatement;

    -- Else check if option mode is extract tv feed
    elseif optionMode = 'extractTVFeed' then
      -- Check if limit is given
      if `limit` is null or `limit` not between lowerLimit and upperLimit then
        -- Set limit to default number
        set @`limit` = defaultLimit;
      else
        -- Set limit to user input
        set @`limit` = `limit`;
      end if;

      -- Check if sort is given
      if sort is null or lower(sort) not in ('desc', 'asc') then
        -- Set sort to default sorting
        set @sort = 'asc';
      else
        -- Set sort to user input
        set @sort = sort;
      end if;

      -- Select records for processing using the dynamic sql builder containing parameters
      -- Utilize the parentheses for the top portion
      set @dSQL =
      'select
      tvf.titlelong as `Title Long`,
      tvf.titleshort as `Title Short`,
      date_format(tvf.publish_date, ''%Y-%m-%d %H:%i:%s.%f'') as `Publish Date`,
      cast(tvf.actionstatus as char) as `Action Status`
      from tvfeed tvf';

      -- Check if where clause is given
      if titlelong is not null then
        -- Set variable
        set @dSQLWhere = 'tvf.titlelong = ?';
        set @titlelong = titlelong;
      end if;

      -- Check if where clause is given
      if titleshort is not null then
        -- Check if dynamic SQL is not empty
        if trim(@dSQLWhere) <> trim('') then
          -- Include the next filter into the where clause
          set @dSQLWhere = concat(@dSQLWhere, ' and tvf.titleshort = ?');
        else
          -- Include the next filter into the where clause
          set @dSQLWhere = 'tvf.titleshort = ?';
        end if;

        -- Set variable
        set @titleshort = titleshort;
      end if;

      -- Check if where clause is given
      if actionstatus is not null then
        -- Check if dynamic SQL is not empty
        if trim(@dSQLWhere) <> trim('') then
          -- Include the next filter into the where clause
          set @dSQLWhere = concat(@dSQLWhere, ' and tvf.actionstatus = ?');
        else
          -- Include the next filter into the where clause
          set @dSQLWhere = 'tvf.actionstatus = ?';
        end if;

        -- Set variable
        set @actionstatus = actionstatus;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(@dSQLWhere) <> trim('') then
        -- Include the where clause
        set @dSQLWhere = concat(' where ', @dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = concat(@dSQL, @dSQLWhere, ' order by tvf.publish_date ', @sort, ', tvf.titlelong ', @sort, ', tvf.titleshort ', @sort, ', tvf.actionstatus ', @sort, ' limit ?');

      -- Prepare the statement
      prepare queryStatement from @dSQL;

      -- Check if parameters were set
      if @titlelong is not null and @titleshort is null and @actionstatus is null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching YNN
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titlelong, @`limit`;
      elseif @titlelong is not null and @titleshort is not null and @actionstatus is null then
        -- Else if execute one parameter and not the other statement YYN
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titlelong, @titleshort, @`limit`;
      elseif @titlelong is not null and @titleshort is null and @actionstatus is not null then
        -- Else if execute one parameter and not the other statement YNY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titlelong, @actionstatus, @`limit`;
      elseif @titlelong is null and @titleshort is not null and @actionstatus is null then
        -- Else if execute one parameter and not the other statement NYN
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titleshort, @`limit`;
      elseif @titlelong is null and @titleshort is not null and @actionstatus is not null then
        -- Else if execute one parameter and not the other statement NYY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titleshort, @actionstatus, @`limit`;
      elseif @titlelong is null and @titleshort is null and @actionstatus is not null then
        -- Else if execute all parameters statement NNY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @actionstatus, @`limit`;
      elseif @titlelong is not null and @titleshort is not null and @actionstatus is not null then
        -- Else if execute all parameters statement YYY
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titlelong, @titleshort, @actionstatus, @`limit`;
      else
        -- Else execute default statement NNN
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @`limit`;
      end if;

      -- Deallocate prepare statement
      deallocate prepare queryStatement;
    end if;
  end
// delimiter ;