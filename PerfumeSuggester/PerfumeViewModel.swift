//
//  PerfumeViewModel.swift
//  PerfumeSuggester
//
//  Created by Mykhailo Naumov on 10.12.2023.
//

import Foundation
import SwiftUI

class PerfumeViewModel: ObservableObject {
    @Published var perfumes = [Perfume]()

    func addPerfume(name: String, season: String, timeOfDay: String) {
        perfumes.append(Perfume(name: name, season: season, timeOfDay: timeOfDay))
    }
}
