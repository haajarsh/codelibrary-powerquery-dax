let
    StartDate = #date(2010,1,1),
    EndDate = #date(2019,12,31),

    //Get Number of Days
    GetDateCount = Duration.Days(EndDate-StartDate) + 1 ,                                  
    GetDateList = List.Dates(StartDate,GetDateCount,#duration(1,0,0,0)),
    #"Converted to Table" = Table.FromList(GetDateList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Renamed Columns" = Table.RenameColumns(#"Converted to Table",{{"Column1", "Date"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Date", type date}}),
    YearNumber = Table.AddColumn(#"Changed Type", "Year", each Date.Year([Date])),
    QuarternNumber = Table.AddColumn(YearNumber,"Quarter", each Date.QuarterOfYear([Date])),
    WeekNumber = Table.AddColumn(QuarternNumber, "Week Number", each Date.WeekOfYear([Date])),
    MonthNumber = Table.AddColumn(WeekNumber, "Month Number", each Date.Month([Date])),
    MonthName = Table.AddColumn(MonthNumber, "Month", each Date.MonthName([Date])),
    DayofWeek = Table.AddColumn(MonthName, "Day of Week", each Date.ToText([Date], "dddd"))


    in
    DayofWeek
