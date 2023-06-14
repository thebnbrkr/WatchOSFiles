
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Plain") {
                testChrono(query: "Show me the data that was recorded on Boxing Day")
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
    
    // Replace "Christmas" with "25th of December"
    let modifiedQuery = query.replacingOccurrences(of: "Christmas", with: "25th of December", options: .caseInsensitive)
    
    // Replace "new year" with "1st of January"
    let finalQuery = modifiedQuery.replacingOccurrences(of: "new year", with: "1st of January", options: .caseInsensitive)
    
    // Replace "Islander Day" with "20th of February"
    let updatedQuery = finalQuery.replacingOccurrences(of: "Islander Day", with: "20th of February", options: .caseInsensitive)
    
    // Replace "Family Day" with "20th of February"
    let finalUpdatedQuery = updatedQuery.replacingOccurrences(of: "Family Day", with: "20th of February", options: .caseInsensitive)
    
    // Replace "Louis Riel Day" with "20th of February"
    let finalQueryWithLouisRielDay = finalUpdatedQuery.replacingOccurrences(of: "Louis Riel Day", with: "20th of February", options: .caseInsensitive)
    
    // Replace "Heritage Day" with "20th of February"
    let finalQueryWithHeritageDay = finalQueryWithLouisRielDay.replacingOccurrences(of: "Heritage Day", with: "20th of February", options: .caseInsensitive)
    
    // Replace "Valentine's Day" with "14th of February"
    let finalQueryWithValentinesDay = finalQueryWithHeritageDay.replacingOccurrences(of: "Valentine's Day", with: "14th of February", options: .caseInsensitive)
    
    // Replace "St. Patrick's Day" with "17th of March"
    let finalQueryWithStPatricksDay = finalQueryWithValentinesDay.replacingOccurrences(of: "St. Patrick's Day", with: "17th of March", options: .caseInsensitive)
    
    // Replace "Good Friday" with "7th of April"
    let finalQueryWithGoodFriday = finalQueryWithStPatricksDay.replacingOccurrences(of: "Good Friday", with: "7th of April", options: .caseInsensitive)
    
    // Replace "Easter Monday" with "10th of April"
    let finalQueryWithEasterMonday = finalQueryWithGoodFriday.replacingOccurrences(of: "Easter Monday", with: "10th of April", options: .caseInsensitive)
    
    // Replace "Mother's Day" with "14th of May"
    let finalQueryWithMothersDay = finalQueryWithEasterMonday.replacingOccurrences(of: "Mother's Day", with: "14th of May", options: .caseInsensitive)
    
    // Replace "Victoria Day" with "22nd of May"
    let finalQueryWithVictoriaDay = finalQueryWithMothersDay.replacingOccurrences(of: "Victoria Day", with: "22nd of May", options: .caseInsensitive)
    
    // Replace "Father's Day" with "18th of June"
    let finalQueryWithFathersDay = finalQueryWithVictoriaDay.replacingOccurrences(of: "Father's Day", with: "18th of June", options: .caseInsensitive)
    
    // Replace "Aboriginal Day" with "21st of June"
    let finalQueryWithAboriginalDay = finalQueryWithFathersDay.replacingOccurrences(of: "Aboriginal Day", with: "21st of June", options: .caseInsensitive)
    
    // Replace "St. Jean Baptiste Day" with "24th of June"
    let finalQueryWithStJeanBaptisteDay = finalQueryWithAboriginalDay.replacingOccurrences(of: "St. Jean Baptiste Day", with: "24th of June", options: .caseInsensitive)
    
    // Replace "Canada Day" with "1st of July"
    let finalQueryWithCanadaDay = finalQueryWithStJeanBaptisteDay.replacingOccurrences(of: "Canada Day", with: "1st of July", options: .caseInsensitive)
    
    // Replace "Civic Holiday" with "7th of August"
    let finalQueryWithCivicHoliday = finalQueryWithCanadaDay.replacingOccurrences(of: "Civic Holiday", with: "7th of August", options: .caseInsensitive)
    
    // Replace "Labour Day" with "4th of September"
    let finalQueryWithLabourDay = finalQueryWithCivicHoliday.replacingOccurrences(of: "Labour Day", with: "4th of September", options: .caseInsensitive)
    
    // Replace "National Day for Truth and Reconciliation" with "30th of September"
    let finalQueryWithNationalDay = finalQueryWithLabourDay.replacingOccurrences(of: "National Day for Truth and Reconciliation", with: "30th of September", options: .caseInsensitive)
    
    // Replace "Truth and Reconciliation Day" with "30th of September"
    let finalQueryWithTruthAndReconciliationDay = finalQueryWithNationalDay.replacingOccurrences(of: "Truth and Reconciliation Day", with: "30th of September", options: .caseInsensitive)
    
    // Replace "Thanksgiving" with "9th of October"
    let finalQueryWithThanksgiving = finalQueryWithTruthAndReconciliationDay.replacingOccurrences(of: "Thanksgiving", with: "9th of October", options: .caseInsensitive)
    
    // Replace "Halloween" with "31st of October"
    let finalQueryWithHalloween = finalQueryWithThanksgiving.replacingOccurrences(of: "Halloween", with: "31st of October", options: .caseInsensitive)
    
    // Replace "Remembrance Day" with "11th of November"
    let finalQueryWithRemembranceDay = finalQueryWithHalloween.replacingOccurrences(of: "Remembrance Day", with: "11th of November", options: .caseInsensitive)
    
    // Replace "Boxing Day" with "26th of December"
    let finalQueryWithBoxingDay = finalQueryWithRemembranceDay.replacingOccurrences(of: "Boxing Day", with: "26th of December", options: .caseInsensitive)
    
    print(chrono.parse(text: finalQueryWithBoxingDay))
    
    if finalQueryWithBoxingDay.lowercased().contains("25th of December") {
        // Extract the year from the current date
        let currentYear = Calendar.current.component(.year, from: Date())
        
        // Set the date components for Christmas
        var christmasComponents = DateComponents(year: currentYear, month: 12, day: 25)
        
        // Check if the query contains "last 25th of December"
        if finalQueryWithBoxingDay.lowercased().contains("last") {
            // Subtract one year from the Christmas year
            christmasComponents.year! -= 1
        }
        
        // Find the date for Christmas
        if let christmasDate = Calendar.current.date(from: christmasComponents) {
            print(christmasDate)
        }
    } else if finalQueryWithBoxingDay.lowercased().contains("1st of January") {
        // Extract the year from the current date
        let currentYear = Calendar.current.component(.year, from: Date())
        
        // Set the date components for New Year
        var newYearComponents = DateComponents(year: currentYear, month: 1, day: 1)
        
        // Check if the query contains "last 1st of January"
        if finalQueryWithBoxingDay.lowercased().contains("last") {
            // Subtract one year from the New Year year
            newYearComponents.year! -= 1
        }
        
        // Find the date for New Year
        if let newYearDate = Calendar.current.date(from: newYearComponents) {
            print(newYearDate)
        }
    } else if finalQueryWithBoxingDay.lowercased().contains("20th of February") {
        // Extract the year from the current date
        let currentYear = Calendar.current.component(.year, from: Date())
        
        // Set the date components for Islander Day
        var islanderDayComponents = DateComponents(year: currentYear, month: 2, day: 20)
        
        // Check if the query contains "last 20th of February"
        if finalQueryWithBoxingDay.lowercased().contains("last") {
            // Subtract one year from the Islander Day year
            islanderDayComponents.year! -= 1
        }
        
        // Find the date for Islander Day
        if let islanderDayDate = Calendar.current.date(from: islanderDayComponents) {
            print(islanderDayDate)
        }
    } else {
        print(chrono.parse(text: finalQueryWithBoxingDay))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
