// DateExtensions.swift

import Foundation

extension Date {
    func getCurrentSeason() -> String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)

        switch month {
        case 12, 1, 2:  return "Winter"
        case 3, 4, 5:   return "Spring"
        case 6, 7, 8:   return "Summer"
        case 9, 10, 11: return "Autumn"
        default:        return "Any"
        }
    }

    func getCurrentTimeOfDay() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)

        switch hour {
        case 6..<20: return "Day"
        default:     return "Night"
        }
    }
}
