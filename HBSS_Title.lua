local function givetitle()
    local currentDate = os.date("*t")
    local month = currentDate.month
    local day = currentDate.day
    local year = currentDate.year
    local function getEasterDate(year)
        local a = year % 19
        local b = math.floor(year / 100)
        local c = year % 100
        local d = math.floor(b / 4)
        local e = b % 4
        local f = math.floor((b + 8) / 25)
        local g = math.floor((b - f + 1) / 3)
        local h = (19 * a + b - d - g + 15) % 30
        local i = math.floor(c / 4)
        local k = c % 4
        local l = (32 + 2 * e + 2 * i - h - k) % 7
        local m = math.floor((a + 11 * h + 22 * l) / 451)
        local month = math.floor((h + l - 7 * m + 114) / 31)
        local day = ((h + l - 7 * m + 114) % 31) + 1
        return month, day
    end
    
    local easterMonth, easterDay = getEasterDate(year)
    
    -- Check for special dates
    if month == 4 and day == 1 then
        return "Sand.cc"  -- April Fools C:<
    elseif month == 1 and day == 1 then
        return "Gravel.cc Happy New Year!"  -- New Year's Day!
    elseif month == 12 and day == 25 then
        return "Gravel.cc :] Merry Xmas!"  -- Christmas :D
    elseif month == 10 and day == 31 then
        return "Gravel.cc >:3 Spooky!"  -- Halloween D:
    elseif month == 2 and day == 14 then
        return "Gravel.cc <3"  -- Valentine's Day :3
    elseif month == 3 and day == 17 then
        return "Gravel.cc luc :]"  -- St. Patrick's Day :]
    elseif month == 7 and day == 4 then
        return "Gravel.cc :o USA"  -- Independence Day :7
    elseif month == 11 and day == 11 then
        return "Gravel.cc o7 Remembrance"  -- Remembrance/Veterans Day
    elseif month == easterMonth and day == easterDay then
        return "Gravel.cc :3 Egg"  -- Easter :o
    elseif month == 11 and day >= 22 and day <= 28 then
  
        local firstDayOfMonth = os.date("*t", os.time{year=year, month=11, day=1}).wday
        local thanksgivingDay = 22 + ((11 - firstDayOfMonth) % 7)
        if day == thanksgivingDay then
            return "Gravel.cc gObble c:"  -- Thanksgiving :D
        end
    elseif month == 5 and day >= 25 and day <= 31 then
        -- Memorial Day (last Monday of May)
        local lastDayOfMonth = os.date("*t", os.time{year=year, month=5, day=31}).wday
        local memorialDay = 31 - ((lastDayOfMonth - 1) % 7)
        if day == memorialDay then
            return "Gravel.cc o7 Remembrance"
        end
    end
    
    return "Gravel.cc"
end

return givetitle()
