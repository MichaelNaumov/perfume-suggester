//
//  Perfume.swift
//  PerfumeSuggester
//
//  Created by Mykhailo Naumov on 10.12.2023.
//

import Foundation

struct Perfume: Identifiable {
    var id = UUID()
    var name: String
    var season: String
    var timeOfDay: String
}
