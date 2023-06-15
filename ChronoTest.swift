import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Plain") {
                testChrono(query: "Show me the data for Easter 2021")
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)
            .border(.pink)
        }
        .padding()
    }
}

func testChrono(query: String) {
    let chrono = Chrono()
    
    let replacements: [(pattern: String, replacement: String)] = [
        ("(?i)new\\s+year(\'?s?)?(day)?", "1st of January"),
        ("(?i)chirstmas", "25th of December"),
        ("(?i)islander\\s+day", "20th of February"),
        ("(?i)family\\s+day", "20th of February"),
        ("(?i)louis\\s+riel\\s+day", "20th of February"),
        ("(?i)heritage\\s+day", "20th of February"),
        ("(?i)valentine(\'?s)?\\s+day", "14th of February"),
        ("(?i)st\\.\\s+patrick(\'?s)?\\s+day", "17th of March"),
        ("(?i)good\\s+friday", "7th of April"),
        ("(?i)mother(\'?s)?\\s+day", "14th of May"),
        ("(?i)victoria\\s+day", "22nd of May"),
        ("(?i)father(\'?s)?\\s+day", "18th of June"),
        ("(?i)aboriginal\\s+day", "21st of June"),
        ("(?i)st\\.\\s+jean\\s+baptiste\\s+day", "24th of June"),
        ("(?i)canada\\s+day", "1st of July"),
        ("(?i)civic\\s+holiday", "7th of August"),
        ("(?i)labour\\s+day", "4th of September"),
        ("(?i)national\\s+day\\s+for\\s+truth\\s+and\\s+reconciliation", "30th of September"),
        ("(?i)truth\\s+and\\s+reconciliation\\s+day", "30th of September"),
        ("(?i)thanksgiving", "second Monday of October"),
        ("(?i)halloween", "31st of October"),
        ("(?i)remembrance\\s+day", "11th of November"),
        ("(?i)boxing\\s+day", "26th of December"),
        ("(?i)easter", calculateEasterDate())
    ]
    
    var modifiedQuery = query
    
    for replacement in replacements {
        modifiedQuery = modifiedQuery.replacingOccurrences(
            of: replacement.pattern,
            with: replacement.replacement,
            options: .regularExpression,
            range: nil
        )
    }
    
    print(chrono.parse(text: modifiedQuery))
    
    if let year = extractYear(from: modifiedQuery) {
        if let date = calculateEasterDate(forYear: year) {
            print(date)
        }
    }
}

func extractYear(from query: String) -> Int? {
    let regex = try? NSRegularExpression(pattern: "\\d{4}")
    let range = NSRange(location: 0, length: query.utf16.count)
    let matches = regex?.matches(in: query, range: range)
    
    guard let firstMatch = matches?.first else {
        return nil
    }
    
    return Int((query as NSString).substring(with: firstMatch.range))
}

func calculateEasterDate() -> String {
    let year = Calendar.current.component(.year, from: Date())
    if let easterDate = calculateEasterDate(forYear: year) {
        return "\(easterDate.day)th of \(getMonthName(easterDate.month))"
    }
    return ""
}

func calculateEasterDate(forYear year: Int) -> (day: Int, month: Int)? {
    // Algorithm to calculate Easter date
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
    
    return (day, month)
}

func getMonthName(_ month: Int) -> String {
    let formatter = DateFormatter()
    return formatter.monthSymbols[month - 1]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



