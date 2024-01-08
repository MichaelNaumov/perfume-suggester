// DateExtensions.swift

import Foundation

extension Date {
    func getCurrentSeason() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: currentDate)

        switch month {
        case 12, 1, 2: // Winter
            return "Winter"
        case 3, 4, 5: // Spring
            return "Spring"
        case 6, 7, 8: // Summer
            return "Summer"
        case 9, 10, 11: // Autumn
            return "Autumn"
        default:
            return "Unknown"
        }
    }

    func getCurrentTimeOfDay() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)

        switch hour {
        case 0..<15:
            return "Day"
        case 16..<23:
            return "Night"
        default:
            return "Day"
        }
    }
}
