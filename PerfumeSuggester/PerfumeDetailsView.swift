// PerfumeDetailsView.swift
import SwiftUI

struct PerfumeDetailsView: View {
    var perfume: Perfume

    var body: some View {
        VStack {
            Text("Seasons: \(perfume.seasons.joined(separator: ", "))")
                .padding()

            Text("Day Times: \(perfume.dayTimes.joined(separator: ", "))")
                .padding()

            Spacer()
        }
        .navigationTitle(perfume.name)
    }
}
