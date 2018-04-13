module RecipesHelper

require "date"

def set_days(youbi)
    todayNum = Date.today.wday
    case todayNum
        when 0 then
        sun = Date.today
        mon = Date.today + 1
        tue = Date.today + 2
        wed = Date.today + 3
        thu = Date.today + 4
        fri = Date.today + 5
        sat = Date.today + 6
        when 1 then
        sun = Date.today + 6
        mon = Date.today
        tue = Date.today + 1
        wed = Date.today + 2
        thu = Date.today + 3
        fri = Date.today + 4
        sat = Date.today + 5
        when 2 then
        sun = Date.today + 5
        mon = Date.today + 6
        tue = Date.today
        wed = Date.today + 1
        thu = Date.today + 2
        fri = Date.today + 3
        sat = Date.today + 4
        when 3 then
        sun = Date.today + 4
        mon = Date.today + 5
        tue = Date.today + 6
        wed = Date.today
        thu = Date.today + 1
        fri = Date.today + 2
        sat = Date.today + 3
        when 4 then
        sun = Date.today + 3
        mon = Date.today + 4
        tue = Date.today + 5
        wed = Date.today + 6
        thu = Date.today
        fri = Date.today + 1
        sat = Date.today + 2
        when 5 then
        sun = Date.today + 2
        mon = Date.today + 3
        tue = Date.today + 4
        wed = Date.today + 5
        thu = Date.today + 6
        fri = Date.today
        sat = Date.today + 1
        when 6 then
        sun = Date.today + 1
        mon = Date.today + 2
        tue = Date.today + 3
        wed = Date.today + 4
        thu = Date.today + 5
        fri = Date.today + 6
        sat = Date.today
    end
    
    case youbi
        when 0 then
        return sun
        when 1 then
        return mon
        when 2 then
        return tue
        when 3 then
        return wed
        when 4
        return thu
        when 5 then
        return fri
        when 6 then
        return sat
    end
end
end
