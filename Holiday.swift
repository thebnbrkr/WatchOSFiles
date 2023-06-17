import Foundation

struct HolidayRegex {
    let pattern: String
    let holiday: String
    
    init(pattern: String, holiday: String) {
        self.pattern = pattern
        self.holiday = holiday
    }
}

struct Holiday {
    let name: String
    let day: Int?
    let month: Int?
    
    init(name: String, day: Int? = nil, month: Int? = nil) {
        self.name = name
        self.day = day
        self.month = month
    }
}

let holidayRegexes: [HolidayRegex] = [
    HolidayRegex(pattern: #"(?i)\b(?:new\s*year['s]*(?:\s*day)?)\b"#, holiday: "New Year's Day"),
    HolidayRegex(pattern: #"(?i)\b(?:valentine['s]?\s*day|v[\w\s]*?day)\b"#, holiday: "Valentine's Day"),
//    HolidayRegex(pattern: #"martin\s+luther(\\s+king)?(\\s+jr\.)?(\\s+junior)?(\\s+day)?"#, holiday: "Martin Luther King Day"),
//    HolidayRegex(pattern: #"president('s)?\s+day"#, holiday: "Presidents Day"),
    HolidayRegex(pattern: #"(?i)\b(?:easter|eastar|eester|eester\s+day|eesther|eater)\b"#, holiday: "Easter"),
    HolidayRegex(pattern: #"(?i)\b(?:mother['s]?\s*day|mum['s]?\s*day|mama['s]?\s*day|mummy['s]?\s*day)\b"#, holiday: "Mother's Day"),
    HolidayRegex(pattern: #"(?i)\b(?:father['s]?\s*day|dad['s]?\s*day|daddy['s]?\s*day|papa['s]?\s*day)\b"#, holiday: "Father's Day"),
//    HolidayRegex(pattern: #"memorial\s+day"#, holiday: "Memorial Day"),
    HolidayRegex(pattern: #"(?i)\b(?:labor['s]?\s*day|labour['s]?\s*day)\b"#, holiday: "Labor Day"),
//   HolidayRegex(pattern: #"columbus('s)?\s+day"#, holiday: "Columbus Day"),
    HolidayRegex(pattern: #"(?i)\b(?:halloween|hall[o0]we[e3]n|all\s*hallow['s]*\s*eve|all\s*saint['s]*\s*eve"#, holiday: "Halloween"),
//  HolidayRegex(pattern: #"veteran('s)?\s+day"#, holiday: "Veterans Day"),
    HolidayRegex(pattern: #"(?i)\b(?:thanksgiving|thanks[\s-]?giving|thanksgivings|thanks[\s-]?givings|thanksgiving[\s-]?day|thanksgivings[\s-]?day|thanksgiving[\s-]?holiday|thanksgivings[\s-]?holiday)\b"#, holiday: "Thanksgiving"),
    HolidayRegex(pattern: #"(?i)\b(?:christmas|xmas|x-mas|christmastime)\b"#, holiday: "Christmas"),
    HolidayRegex(pattern: #"(?i)\b(?:boxing['\s]*day)\b"#, holiday: "Boxing Day"),
    HolidayRegex(pattern: #"(?i)\b(?:canadian\s*)?heritage\s*day\b"#, holiday: "Canadian Heritage Day"),
    HolidayRegex(pattern: #"(?i)\b(?:victoria('s)?|queen\s*vic('s)?)\s*day\b"#, holiday: "Victoria's Day"),
    HolidayRegex(pattern: #"(?i)\b(?:st\.?\s*patrick['s]?\s*day|st\.?\s*paddy['s]?\s*day|st\.?\s*pattys?\s*day)\b"#, holiday: "St. Patrick's Day"),
    HolidayRegex(pattern: #"(?i)\b(?:national\s*day\s*for\s*(?:truth\s+and\s+reconciliation|truth\s+day))\b"#, holiday: "National Day for Truth and Reconciliation"),
    HolidayRegex(pattern: #"(?i)\b(?:remembrance['\s]*day|remembering['\s]*day)\b"#, holiday: "Remembrance Day"),
    HolidayRegex(pattern: #"(?i)\b(?:st\.?\s*jean\s*baptiste['\s]*day)\b"#, holiday: "St. Jean Baptiste Day"),
    HolidayRegex(pattern: #"(?i)\b(?:aboriginal['\s]*day)\b"#, holiday: "Aboriginal Day")


]

let holidays: [Holiday] = [
    Holiday(name: "New Year's Day", day: 1, month: 1),
    Holiday(name: "Valentine's Day", day: 14, month: 2),
 //   Holiday(name: "Martin Luther King Day", day: nil, month: 1),
 //   Holiday(name: "Presidents Day", day: nil, month: 2),
    Holiday(name: "Easter", day: nil, month: nil),
    Holiday(name: "Mothers Day", day: nil, month: 5),
//    Holiday(name: "Memorial Day", day: nil, month: 5),
    Holiday(name: "Fathers Day", day: nil, month: 6),
//    Holiday(name: "Independence Day", day: 4, month: 7),
    Holiday(name: "Labor Day", day: nil, month: 9),
//    Holiday(name: "Columbus Day", day: nil, month: 10),
    Holiday(name: "Halloween", day: 31, month: 10),
//    Holiday(name: "Veterans Day", day: 11, month: 11),
    Holiday(name: "Thanksgiving", day: nil, month: 11),
    Holiday(name: "Christmas", day: 25, month: 12),
    Holiday(name: "Canadian Heritage Day", day: nil, month: 2),
    Holiday(name: "Victoria's Day", day: nil, month: 5),
    Holiday(name: "St. Patrick's Day", day: 17, month: 3),
    Holiday(name: "Boxing Day", day: 26, month: 12),
    Holiday(name: "Truth National Day for Truth and Reconciliation", day: 30, month: 9),
    Holiday(name: "Remembrance Day", day: 11, month: 11),
    Holiday(name: "St. Jean Baptiste Day", day: 24, month: 6),
    Holiday(name: "Aboriginal Day", day: 21, month: 6)



]

func checkForHoliday(query: String) -> String? {
    for holidayRegex in holidayRegexes {
        if let range = query.range(of: holidayRegex.pattern, options: .regularExpression) {
            return holidayRegex.holiday
        }
    }
    return nil
}

func getHolidayDetails(holidayName: String) -> Holiday? {
    return holidays.first { $0.name == holidayName }
}

func calculateHolidayDate(holiday: Holiday, query: String) -> (day: Int, month: Int, year: Int)? {
    let currentYear = getCurrentYear()!
    let currentMonth = getCurrentMonth()!
    let currentDay = getCurrentDay()!
    
    let year = getYear(query: query)
    
    if let day = holiday.day, let month = holiday.month {
        if year > currentYear || (year == currentYear && month > currentMonth) || (year == currentYear && month == currentMonth && day > currentDay) {
            return (day, month, year - 1) // Last year's date
        } else {
            return (day, month, year)
        }
    }
    
    // Handle specific holidays with custom calculations
    switch holiday.name {
    case "Easter":
        if year == currentYear {
            return calculateEasterDate(year: year)
        } else {
            return calculateEasterDate(year: year - 1)
        }
    case "Mothers Day":
        return calculateMothersDayDate(year: year)
    case "Fathers Day":
        return calculateFathersDayDate(year: year)
    case "Thanksgiving":
        return calculateThanksgivingDate(year: year)
    case "Canadian Heritage Day":
        return calculateThirdMondayInFebruary(year: year)
    case "Labor Day":
        if let laborDayDate = calculateLaborDay(year: year) {
            return laborDayDate
        }
    case "Christmas":
        if year > currentYear || (year == currentYear && 12 > currentMonth) || (year == currentYear && 12 == currentMonth && 25 > currentDay) {
            return (25, 12, year - 1) // Last year's date
        } else {
            return (25, 12, year)
        }
    case "Valentine's Day":
        if year > currentYear || (year == currentYear && 12 > currentMonth) || (year == currentYear && 12 == currentMonth && 25 > currentDay) {
            return (14, 2, year - 1) // Last year's date
        } else {
            return (14, 2, year)
        }
    case "Halloween":
        if year > currentYear || (year == currentYear && 12 > currentMonth) || (year == currentYear && 12 == currentMonth && 25 > currentDay) {
            return (14, 2, year - 1) // Last year's date
        } else {
            return (14, 2, year)
        }
    case "St. Patrick's Day":
        if year > currentYear || (year == currentYear && 12 > currentMonth) || (year == currentYear && 12 == currentMonth && 25 > currentDay) {
            return (17, 3, year - 1) // Last year's date
        } else {
            return (17, 3, year)
        }
    case "New Year's Day":
        if year > currentYear || (year == currentYear && 12 > currentMonth) || (year == currentYear && 12 == currentMonth && 25 > currentDay) {
            return (17, 3, year - 1) // Last year's date
        } else {
            return (17, 3, year)
        }
    case "Boxing Day":
        if year > currentYear || (year == currentYear && 12 > currentMonth) || (year == currentYear && 12 == currentMonth && 25 > currentDay) {
            return (26, 12, year - 1) // Last year's date
        } else {
            return (26, 12, year)
        }
    case "National Day for Truth and Reconciliation":
        if year > currentYear || (year == currentYear && 12 > currentMonth) || (year == currentYear && 12 == currentMonth && 25 > currentDay) {
            return (30, 9, year - 1) // Last year's date
        } else {
            return (30, 9, year)
        }
    case "Remembrance Day":
        if year > currentYear || (year == currentYear && 12 > currentMonth) || (year == currentYear && 12 == currentMonth && 25 > currentDay) {
            return (11, 11, year - 1) // Last year's date
        } else {
            return (11, 11, year)
        }
    case "St. Jean Baptiste Day":
        if year > currentYear || (year == currentYear && 12 > currentMonth) || (year == currentYear && 12 == currentMonth && 25 > currentDay) {
            return (24, 6, year - 1) // Last year's date
        } else {
            return (24, 6, year)
        }
    case "Aboriginal Day":
        if year > currentYear || (year == currentYear && 12 > currentMonth) || (year == currentYear && 12 == currentMonth && 25 > currentDay) {
            return (21, 6, year - 1) // Last year's date
        } else {
            return (21, 6, year)
        }

    default:
        return nil
    }
    
    return nil
}


func getYear(query: String) -> Int {
    let yearRegex = try! NSRegularExpression(pattern: "(20[0-9]{2})", options: [])
    let range = NSRange(query.startIndex..<query.endIndex, in: query)
    
    if let match = yearRegex.firstMatch(in: query, options: [], range: range) {
        let matchedYear = (query as NSString).substring(with: match.range)
        return Int(matchedYear)!
    } else {
        return getCurrentYear()!
    }
}

func getCurrentYear() -> Int? {
    let calendar = Calendar.current
    return calendar.component(.year, from: Date())
}

func getCurrentMonth() -> Int? {
    let calendar = Calendar.current
    return calendar.component(.month, from: Date())
}

func getCurrentDay() -> Int? {
    let calendar = Calendar.current
    return calendar.component(.day, from: Date())
}

func calculateEasterDate(year: Int) -> (day: Int, month: Int, year: Int)? {
    if year < 1583 || year > 3999 {
        return nil
    }
    
    let a = year % 19
    let b = year / 100
    let c = year % 100
    let d = b / 4
    let e = b % 4
    let f = (b + 8) / 25
    let g = (b - f + 1) / 3
    let h = (19 * a + b - d - g + 15) % 30
    let i = c / 4
    let k = c % 4
    let l = (32 + 2 * e + 2 * i - h - k) % 7
    let m = (a + 11 * h + 22 * l) / 451
    let n = h + l - 7 * m + 114
    let month = n / 31
    let day = (n % 31) + 1
    
    return (day, month, year)
}

func calculateValentinesDayDate() -> (day: Int, month: Int, year: Int) {
    let calendar = Calendar.current
    let currentDate = Date()
    let currentYear = calendar.component(.year, from: currentDate)
    
    var dateComponents = DateComponents()
    dateComponents.year = currentYear
    dateComponents.month = 2
    dateComponents.day = 14
    
    if let valentinesDayDate = calendar.date(from: dateComponents), valentinesDayDate > currentDate {
        return (14, 2, currentYear - 1)
    } else {
        return (14, 2, currentYear)
    }
}

func calculateThirdMondayInFebruary(year: Int) -> (day: Int, month: Int, year: Int)? {
    let calendar = Calendar.current
    
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = 2
    
    guard let february = calendar.date(from: dateComponents) else {
        return nil
    }
    
    let weekdayRange = calendar.range(of: .weekday, in: .month, for: february)!
    let weekdayCount = weekdayRange.count
    
    dateComponents.weekday = 2 // Monday (Third Monday of February)
    dateComponents.weekdayOrdinal = 3
    
    guard let thirdMondayOfFebruary = calendar.date(from: dateComponents) else {
        return nil
    }
    
    let currentDate = Date()
    if thirdMondayOfFebruary > currentDate {
        dateComponents.year = year - 1 // Calculate the third Monday of February of the previous year
        guard let previousYearFebruary = calendar.date(from: dateComponents) else {
            return nil
        }
        let day = calendar.component(.day, from: previousYearFebruary)
        let month = calendar.component(.month, from: previousYearFebruary)
        return (day, month, year - 1)
    } else {
        let day = calendar.component(.day, from: thirdMondayOfFebruary)
        let month = calendar.component(.month, from: thirdMondayOfFebruary)
        return (day, month, year)
    }
}



func calculateMothersDayDate(year: Int) -> (day: Int, month: Int, year: Int)? {
    let calendar = Calendar.current
    
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = 5
    dateComponents.day = 1
    
    if let firstDayOfMay = calendar.date(from: dateComponents) {
        let weekday = calendar.component(.weekday, from: firstDayOfMay)
        
        var daysToAdd: Int
        if weekday == 1 {
            daysToAdd = 7
        } else {
            daysToAdd = 15 - weekday
        }
        
        if let mothersDayDate = calendar.date(byAdding: .day, value: daysToAdd, to: firstDayOfMay) {
            let currentDate = Date()
            
            if mothersDayDate > currentDate {
                dateComponents.year = year - 1
                dateComponents.month = 5
                
                if let previousYearFirstDayOfMay = calendar.date(from: dateComponents) {
                    let previousWeekday = calendar.component(.weekday, from: previousYearFirstDayOfMay)
                    
                    var previousDaysToAdd: Int
                    if previousWeekday == 1 {
                        previousDaysToAdd = 7
                    } else {
                        previousDaysToAdd = 15 - previousWeekday
                    }
                    
                    if let previousYearMothersDayDate = calendar.date(byAdding: .day, value: previousDaysToAdd, to: previousYearFirstDayOfMay) {
                        let day = calendar.component(.day, from: previousYearMothersDayDate)
                        let month = calendar.component(.month, from: previousYearMothersDayDate)
                        let year = calendar.component(.year, from: previousYearMothersDayDate)
                        return (day, month, year)
                    }
                }
            } else {
                let day = calendar.component(.day, from: mothersDayDate)
                let month = calendar.component(.month, from: mothersDayDate)
                return (day, month, year)
            }
        }
    }
    
    return nil
}

func calculateThanksgivingDate(year: Int) -> (day: Int, month: Int, year: Int)? {
    let calendar = Calendar.current
    
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = 10
    
    guard let october = calendar.date(from: dateComponents) else {
        return nil
    }
    
    let weekdayRange = calendar.range(of: .weekday, in: .month, for: october)!
    let weekdayCount = weekdayRange.count
    
    dateComponents.weekday = 5 // Thursday (Thanksgiving is always on the fourth Thursday of November)
    dateComponents.weekdayOrdinal = 4
    
    guard let fourthThursdayOfNovember = calendar.date(from: dateComponents) else {
        return nil
    }
    
    let currentDate = Date()
    if fourthThursdayOfNovember > currentDate {
        dateComponents.year = year - 1 // Calculate Thanksgiving of the previous year
        guard let previousYearNovember = calendar.date(from: dateComponents) else {
            return nil
        }
        let day = calendar.component(.day, from: previousYearNovember)
        let month = calendar.component(.month, from: previousYearNovember)
        return (day, month, year - 1)
    } else {
        let day = calendar.component(.day, from: fourthThursdayOfNovember)
        let month = calendar.component(.month, from: fourthThursdayOfNovember)
        return (day, month, year)
    }
}

func calculateVictoriasDayDate(year: Int) -> (day: Int, month: Int, year: Int)? {
    let calendar = Calendar.current
      
      var startDateComponents = DateComponents(year: year, month: 5, day: 17)
      var endDateComponents = DateComponents(year: year, month: 5, day: 24)
      
      // Find the start and end dates within the given year
      guard let startDate = calendar.date(from: startDateComponents),
            let endDate = calendar.date(from: endDateComponents) else {
          return nil
      }
      
      // Find the first Monday between the start and end dates
      var currentDate = startDate
      while currentDate <= endDate {
          if calendar.component(.weekday, from: currentDate) == 2 {
              // Found a Monday
              let day = calendar.component(.day, from: currentDate)
              let month = calendar.component(.month, from: currentDate)
              return (day, month, year)
          }
          currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
      }
    return nil
}

func calculateFathersDayDate(year: Int) -> (day: Int, month: Int, year: Int)? {
    let calendar = Calendar.current
    var dateComponents = DateComponents(year: year, month: 6, day: 1)
    
    guard let firstDayOfJune = calendar.date(from: dateComponents) else {
        return nil
    }
    
    let weekday = calendar.component(.weekday, from: firstDayOfJune)
    let daysToAdd = weekday == 1 ? 14 : 22 - weekday
    
    guard let fathersDayDate = calendar.date(byAdding: .day, value: daysToAdd, to: firstDayOfJune) else {
        return nil
    }
    
    let currentDate = Date()
    
    if fathersDayDate > currentDate {
        dateComponents.year = year - 1
        
        guard let previousYearFirstDayOfJune = calendar.date(from: dateComponents) else {
            return nil
        }
        
        let previousWeekday = calendar.component(.weekday, from: previousYearFirstDayOfJune)
        let previousDaysToAdd = previousWeekday == 1 ? 14 : 22 - previousWeekday
        
        guard let previousYearFathersDayDate = calendar.date(byAdding: .day, value: previousDaysToAdd, to: previousYearFirstDayOfJune) else {
            return nil
        }
        
        let day = calendar.component(.day, from: previousYearFathersDayDate)
        let month = calendar.component(.month, from: previousYearFathersDayDate)
        let year = calendar.component(.year, from: previousYearFathersDayDate)
        return (day, month, year)
    } else {
        let day = calendar.component(.day, from: fathersDayDate)
        let month = calendar.component(.month, from: fathersDayDate)
        return (day, month, year)
    }
}


func calculateLaborDay(year: Int) -> (day: Int, month: Int, year: Int)? {
    let calendar = Calendar.current
    
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = 9
    dateComponents.day = 1
    
    if let firstDayOfSeptember = calendar.date(from: dateComponents) {
        let weekday = calendar.component(.weekday, from: firstDayOfSeptember)
        
        var daysToAdd: Int
        if weekday == 1 {
            daysToAdd = 9
        } else {
            daysToAdd = 9 - weekday
        }
        
        if let laborDayDate = calendar.date(byAdding: .day, value: daysToAdd, to: firstDayOfSeptember) {
            let currentDate = Date()
            
            if laborDayDate > currentDate {
                dateComponents.year = year - 1
                dateComponents.month = 9
                
                if let previousYearFirstDayOfSeptember = calendar.date(from: dateComponents) {
                    let previousWeekday = calendar.component(.weekday, from: previousYearFirstDayOfSeptember)
                    
                    var previousDaysToAdd: Int
                    if previousWeekday == 1 {
                        previousDaysToAdd = 9
                    } else {
                        previousDaysToAdd = 9 - previousWeekday
                    }
                    
                    if let previousYearLaborDayDate = calendar.date(byAdding: .day, value: previousDaysToAdd, to: previousYearFirstDayOfSeptember) {
                        let day = calendar.component(.day, from: previousYearLaborDayDate)
                        let month = calendar.component(.month, from: previousYearLaborDayDate)
                        let year = calendar.component(.year, from: previousYearLaborDayDate)
                        return (day, month, year)
                    }
                }
            } else {
                let day = calendar.component(.day, from: laborDayDate)
                let month = calendar.component(.month, from: laborDayDate)
                return (day, month, year)
            }
        }
    }
    
    return nil
}

func testHolidayParsing() {
    var query = "Compare my average daily step count to the average on canadian Remembrance Day 2020"
    query = query.lowercased()
    
    if let matchedHoliday = checkForHoliday(query: query) {
        print("Holiday mentioned: \(matchedHoliday)")
        if let holiday = getHolidayDetails(holidayName: matchedHoliday) {
            if let holidayDate = calculateHolidayDate(holiday: holiday, query: query) {
                let currentDate = Date()
                let calendar = Calendar.current
                let currentComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
                
                if currentComponents.year! == holidayDate.year && currentComponents.month! == holidayDate.month && currentComponents.day! < holidayDate.day {
                    print("\(matchedHoliday) date: \(holidayDate.month)/\(holidayDate.day)/\(holidayDate.year - 1)")
                } else {
                    print("\(matchedHoliday) date: \(holidayDate.month)/\(holidayDate.day)/\(holidayDate.year)")
                }
            } else {
                print("No date found for the holiday.")
            }
        } else {
            print("No details found for the holiday.")
        }
    } else {
        print("No holiday mentioned.")
    }
}

// Test the holiday parsing
//testHolidayParsing()
