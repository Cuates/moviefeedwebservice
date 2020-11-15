-- Database Connect
use <databasename>;

-- =================================================
--        File: extractmediafeed
--     Created: 11/07/2020
--     Updated: 11/09/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Extract media feed
-- =================================================

-- Procedure Drop
drop procedure if exists extractmediafeed;

-- Procedure Create
delimiter //
create procedure `extractmediafeed`(in optionMode text, in actionnumber text, in actiondescription text, in audioencode text, in dynamicrange text, in resolution text, in streamsource text, in streamdescription text, in videoencode text, in titlelong text, in titleshort text, in actionstatus text, in `limit` text, in sort text)
  begin
    -- Declare variables
    declare dSQL text;
    declare dSQLWhere text;
    declare omitOptionMode nvarchar(255);
    declare omitActionNumber nvarchar(255);
    declare omitActionDescription nvarchar(255);
    declare omitMediaAudioEncode nvarchar(255);
    declare omitMediaDynamicRange nvarchar(255);
    declare omitMediaResolution nvarchar(255);
    declare omitMediaStreamSource nvarchar(255);
    declare omitMediaStreamDescription nvarchar(255);
    declare omitMediaVideoEncode nvarchar(255);
    declare omitTitleLong nvarchar(255);
    declare omitTitleShort nvarchar(255);
    declare omitLimit nvarchar(255);
    declare omitSort nvarchar(255);
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
    declare maxLengthSort int;
    declare lowerLimit int;
    declare upperLimit int;
    declare defaultLimit int;
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

    -- Set variables
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
    set omitLimit = '[^0-9\-]';
    set omitSort = '[^a-zA-Z]';
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
    set maxLengthSort = 255;
    set lowerLimit = 1;
    set upperLimit = 100;
    set defaultLimit = 25;
    set @dSQL = '';
    set @dSQLWhere = '';
    set successcode = '00000';
    set @actionnumber = null;
    set @actiondescription = null;
    set @audioencode = null;
    set @dynamicrange = null;
    set @resolution = null;
    set @streamsource = null;
    set @streamdescription = null;
    set @videoencode = null;
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
    if actionnumber is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set actionnumber = regexp_replace(regexp_replace(actionnumber, omitActionNumber, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set actionnumber = trim(substring(actionnumber, 1, maxLengthActionNumber));

      -- Check if empty string
      if actionnumber = '' then
        -- Set parameter to null if empty string
        set actionnumber = nullif(actionnumber, '');
      end if;
    end if;

    -- Check if parameter is not null
    if actiondescription is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set actiondescription = regexp_replace(regexp_replace(actiondescription, omitActionDescription, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set actiondescription = trim(substring(actiondescription, 1, maxLengthActionDescription));

      -- Check if empty string
      if actiondescription = '' then
        -- Set parameter to null if empty string
        set actiondescription = nullif(actiondescription, '');
      end if;
    end if;

    -- Check if parameter is not null
    if audioencode is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set audioencode = regexp_replace(regexp_replace(audioencode, omitMediaAudioEncode, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set audioencode = trim(substring(audioencode, 1, maxLengthMediaAudioEncode));

      -- Check if empty string
      if audioencode = '' then
        -- Set parameter to null if empty string
        set audioencode = nullif(audioencode, '');
      end if;
    end if;

    -- Check if parameter is not null
    if dynamicrange is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set dynamicrange = regexp_replace(regexp_replace(dynamicrange, omitMediaDynamicRange, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set dynamicrange = trim(substring(dynamicrange, 1, maxLengthMediaDynamicRange));

      -- Check if empty string
      if dynamicrange = '' then
        -- Set parameter to null if empty string
        set dynamicrange = nullif(dynamicrange, '');
      end if;
    end if;

    -- Check if parameter is not null
    if resolution is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set resolution = regexp_replace(regexp_replace(resolution, omitMediaResolution, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set resolution = trim(substring(resolution, 1, maxLengthMediaResolution));

      -- Check if empty string
      if resolution = '' then
        -- Set parameter to null if empty string
        set resolution = nullif(resolution, '');
      end if;
    end if;

    -- Check if parameter is not null
    if streamsource is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set streamsource = regexp_replace(regexp_replace(streamsource, omitMediaStreamSource, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set streamsource = trim(substring(streamsource, 1, maxLengthMediaStreamSource));

      -- Check if empty string
      if streamsource = '' then
        -- Set parameter to null if empty string
        set streamsource = nullif(streamsource, '');
      end if;
    end if;

    -- Check if parameter is not null
    if streamdescription is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set streamdescription = regexp_replace(regexp_replace(streamdescription, omitMediaStreamDescription, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set streamdescription = trim(substring(streamdescription, 1, maxLengthMediaStreamDescription));

      -- Check if empty string
      if streamdescription = '' then
        -- Set parameter to null if empty string
        set streamdescription = nullif(streamdescription, '');
      end if;
    end if;

    -- Check if parameter is not null
    if videoencode is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set videoencode = regexp_replace(regexp_replace(videoencode, omitMediaVideoEncode, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set videoencode = trim(substring(videoencode, 1, maxLengthMediaVideoEncode));

      -- Check if empty string
      if videoencode = '' then
        -- Set parameter to null if empty string
        set videoencode = nullif(videoencode, '');
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

    -- Check if option mode is extract action status
    if optionMode = 'extractActionStatus' then
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
      ast.actionnumber as `Action Status`,
      ast.actiondescription as `Action Description`
      from actionstatus ast';

      -- Check if where clause is given
      if actionnumber is not null then
        -- Set variable
        set @dSQLWhere = 'ast.actionnumber = ?';
        set @actionnumber = actionnumber;
      end if;

      -- Check if where clause is given
      if actiondescription is not null then
        -- Check if dynamic SQL is not empty
        if trim(@dSQLWhere) <> trim('') then
          -- Include the next filter into the where clause
          set @dSQLWhere = concat(@dSQLWhere, ' and ast.actiondescription = ?');
        else
          -- Include the next filter into the where clause
          set @dSQLWhere = 'ast.actiondescription = ?';
        end if;

        -- Set variable
        set @actiondescription = actiondescription;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(@dSQLWhere) <> trim('') then
        -- Include the where clause
        set @dSQLWhere = concat(' where ', @dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = concat(@dSQL, @dSQLWhere, ' order by ast.actionnumber ', @sort, ', ast.actiondescription ', @sort, ' limit ?');

      -- Prepare the statement
      prepare queryStatement from @dSQL;

      -- Check if parameters were set
      if @actionnumber is not null and @actiondescription is null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @actionnumber, @`limit`;
      elseif @actionnumber is null and @actiondescription is not null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @actiondescription, @`limit`;
      elseif @actionnumber is not null and @actiondescription is not null then
        -- Else if execute all parameters statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @actionnumber, @actiondescription, @`limit`;
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @`limit`;
      end if;

      -- Deallocate prepare statement
      deallocate prepare queryStatement;

    -- Else check if option mode is extract media audio encode
    elseif optionMode = 'extractMediaAudioEncode' then
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
      mae.audioencode as `Audio Encode`,
      mae.movieInclude as `Movie Include`,
      mae.tvInclude as `TV Include`
      from mediaaudioencode mae';

      -- Check if where clause is given
      if audioencode is not null then
        -- Set variable
        set @dSQLWhere = 'mae.audioencode = ?';
        set @audioencode = audioencode;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(@dSQLWhere) <> trim('') then
        -- Include the where clause
        set @dSQLWhere = concat(' where ', @dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = concat(@dSQL, @dSQLWhere, ' order by mae.audioencode ', @sort, ' limit ?');

      -- Prepare the statement
      prepare queryStatement from @dSQL;

      -- Check if parameters were set
      if @audioencode is not null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @audioencode, @`limit`;
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @`limit`;
      end if;

      -- Deallocate prepare statement
      deallocate prepare queryStatement;

    -- Else check if option mode is delete temp tv
    elseif optionMode = 'extractMediaDynamicRange' then
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
      mdr.dynamicrange as `Dynamic Range`,
      mdr.movieInclude as `Movie Include`,
      mdr.tvInclude as `TV Include`
      from mediadynamicrange mdr';

      -- Check if where clause is given
      if dynamicrange is not null then
        -- Set variable
        set @dSQLWhere = 'mdr.dynamicrange = ?';
        set @dynamicrange = dynamicrange;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(@dSQLWhere) <> trim('') then
        -- Include the where clause
        set @dSQLWhere = concat(' where ', @dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = concat(@dSQL, @dSQLWhere, ' order by mdr.dynamicrange ', @sort, ' limit ?');

      -- Prepare the statement
      prepare queryStatement from @dSQL;

      -- Check if parameters were set
      if @dynamicrange is not null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @dynamicrange, @`limit`;
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @`limit`;
      end if;

      -- Deallocate prepare statement
      deallocate prepare queryStatement;

    -- Else check if option mode is extract media resolution
    elseif optionMode = 'extractMediaResolution' then
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
      mr.resolution as `Resolution`,
      mr.movieInclude as `Movie Include`,
      mr.tvInclude as `TV Include`
      from mediaresolution mr';

      -- Check if where clause is given
      if resolution is not null then
        -- Set variable
        set @dSQLWhere = 'mr.resolution = ?';
        set @resolution = resolution;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(@dSQLWhere) <> trim('') then
        -- Include the where clause
        set @dSQLWhere = concat(' where ', @dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = concat(@dSQL, @dSQLWhere, ' order by mr.resolution ', @sort, ' limit ?');

      -- Prepare the statement
      prepare queryStatement from @dSQL;

      -- Check if parameters were set
      if @resolution is not null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @resolution, @`limit`;
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @`limit`;
      end if;

      -- Deallocate prepare statement
      deallocate prepare queryStatement;

    -- Else check if option mode is extract media stream source
    elseif optionMode = 'extractMediaStreamSource' then
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
      mss.streamsource as `Stream Source`,
      mss.streamdescription as `Stream Description`,
      mss.movieInclude as `Movie Include`,
      mss.tvInclude as `TV Include`
      from mediastreamsource mss';

      -- Check if where clause is given
      if streamsource is not null then
        -- Set variable
        set @dSQLWhere = 'mss.streamsource = ?';
        set @streamsource = streamsource;
      end if;

      -- Check if where clause is given
      if streamdescription is not null then
        -- Check if dynamic SQL is not empty
        if trim(@dSQLWhere) <> trim('') then
          -- Include the next filter into the where clause
          set @dSQLWhere = concat(@dSQLWhere, ' and mss.streamdescription = ?');
        else
          -- Include the next filter into the where clause
          set @dSQLWhere = 'mss.streamdescription = ?';
        end if;

        -- Set variable
        set @streamdescription = streamdescription;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(@dSQLWhere) <> trim('') then
        -- Include the where clause
        set @dSQLWhere = concat(' where ', @dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = concat(@dSQL, @dSQLWhere, ' order by mss.streamsource ', @sort, ', mss.streamdescription ', @sort, ' limit ?');

      -- Prepare the statement
      prepare queryStatement from @dSQL;

      -- Check if parameters were set
      if @streamsource is not null and @streamdescription is null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @streamsource, @`limit`;
      elseif @streamsource is null and @streamdescription is not null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @streamdescription, @`limit`;
      elseif @streamsource is not null and @streamdescription is not null then
        -- Else if execute all parameters statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @streamsource, @streamdescription, @`limit`;
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @`limit`;
      end if;

      -- Deallocate prepare statement
      deallocate prepare queryStatement;

    -- Else check if option mode is extract media video encode
    elseif optionMode = 'extractMediaVideoEncode' then
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
      mve.videoencode as `Video Encode`,
      mve.movieInclude as `Movie Include`,
      mve.tvInclude as `TV Include`
      from mediavideoencode mve';

      -- Check if where clause is given
      if videoencode is not null then
        -- Set variable
        set @dSQLWhere = 'mve.videoencode = ?';
        set @videoencode = videoencode;
      end if;

      -- Check if dynamic SQL is not empty
      if trim(@dSQLWhere) <> trim('') then
        -- Include the where clause
        set @dSQLWhere = concat(' where ', @dSQLWhere);
      end if;

      -- Set the dynamic string with the where clause and sort option
      set @dSQL = concat(@dSQL, @dSQLWhere, ' order by mve.videoencode ', @sort, ' limit ?');

      -- Prepare the statement
      prepare queryStatement from @dSQL;

      -- Check if parameters were set
      if @videoencode is not null then
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @videoencode, @`limit`;
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @`limit`;
      end if;

      -- Deallocate prepare statement
      deallocate prepare queryStatement;

    -- Else check if option mode is extract movie feed
    elseif optionMode = 'extractMovieFeed' then
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
      mf.actionstatus as `Action Status`
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
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titlelong, @`limit`;
      elseif @titlelong is not null and @titleshort is not null and @actionstatus is null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titlelong, @titleshort, @`limit`;
      elseif @titlelong is not null and @titleshort is null and @actionstatus is not null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titlelong, @actionstatus, @`limit`;
      elseif @titlelong is null and @titleshort is not null and @actionstatus is null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titleshort, @`limit`;
      elseif @titlelong is null and @titleshort is not null and @actionstatus is not null then
        -- Else if execute one parameter and not the other statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titleshort, @actionstatus, @`limit`;
      elseif @titlelong is not null and @titleshort is not null and @actionstatus is not null then
        -- Else if execute all parameters statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
        -- Execute dynamic statement with the parameterized values
        execute queryStatement using @titlelong, @titleshort, @actionstatus, @`limit`;
      else
        -- Else execute default statement
        -- Important Note: Parameterizated values need to match the placeholders they are matching
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
      tvf.actionstatus as `Action Status`
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