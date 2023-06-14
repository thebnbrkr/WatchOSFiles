import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Plain") {
                testChrono(query: "Show me the data that was recorded on Thanksgiving 2019")
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
        ("Christmas", "25th of December"),
        ("new year", "1st of January"),
        ("Islander Day", "third Monday of February"),
        ("Family Day", "third Monday of February"),
        ("Louis Riel Day", "third Monday of February"),
        ("Heritage Day", "third Monday of February"),
        ("Valentine's Day", "14th of February"),
        ("St\\. Patrick's Day", "17th of March"),
        ("Good Friday", "7th of April"),
        ("Easter Monday", "10th of April"),
        ("Mother's Day", "second Sunday of May"),
        ("Victoria Day", "third Monday of May"),
        ("Father's Day", "third Sunday of June"),
        ("Aboriginal Day", "21st of June"),
        ("St\\. Jean Baptiste Day", "24th of June"),
        ("Canada Day", "1st of July"),
        ("Civic Holiday", "first Monday of August"),
        ("Labour Day", "first Monday September"),
        ("National Day for Truth and Reconciliation", "30th of September"),
        ("Truth and Reconciliation Day", "30th of September"),
        ("Thanksgiving", "second Monday of October"),
        ("Halloween", "31st of October"),
        ("Remembrance Day", "11th of November"),
        ("Boxing Day", "26th of December")
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
        if let date = getDateForYear(year, modifiedQuery.lowercased().contains("last")) {
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

func getDateForYear(_ year: Int, _ isLastYear: Bool) -> Date? {
    let currentDate = Date()
    var dateComponents = Calendar.current.dateComponents([.day, .month], from: currentDate)
    dateComponents.year = year - (isLastYear ? 1 : 0)
    
    return Calendar.current.date(from: dateComponents)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

