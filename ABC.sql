-- Get the current date
SET CURRENT_DATE = CURRENT_DATE();

-- Calculate the first day of the month
SET FIRST_DAY_OF_MONTH = DATE_TRUNC('MONTH', $CURRENT_DATE);

-- Find the day of the week for the first day of the month (0=Sunday, 1=Monday, ..., 6=Saturday)
SET FIRST_DAY_OF_WEEK = DAYOFWEEK($FIRST_DAY_OF_MONTH);

-- Calculate the offset to the first Tuesday of the month
SET OFFSET_TO_FIRST_TUESDAY = IFF($FIRST_DAY_OF_WEEK <= 2, 2 - $FIRST_DAY_OF_WEEK, 9 - $FIRST_DAY_OF_WEEK);

-- Calculate the first Tuesday of the month
SET FIRST_TUESDAY = DATEADD('DAY', $OFFSET_TO_FIRST_TUESDAY, $FIRST_DAY_OF_MONTH);

-- Calculate the second Tuesday of the month
SET SECOND_TUESDAY = DATEADD('WEEK', 1, $FIRST_TUESDAY);

-- Check if today is the second Tuesday
IF $CURRENT_DATE = $SECOND_TUESDAY THEN
    -- Create a table if today is the second Tuesday
    CREATE OR REPLACE TABLE example_table (
        id INT,
        name STRING,
        created_at TIMESTAMP
    );

    -- Example result
    SELECT 'Today is the second Tuesday, table created' AS RESULT;
ELSE
    SELECT 'Today is not the second Tuesday, no table created' AS RESULT;
END IF;
