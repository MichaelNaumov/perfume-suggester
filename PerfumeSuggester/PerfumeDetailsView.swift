// PerfumeDetailsView.swift
import SwiftUI

struct PerfumeDetailsView: View {
    var perfume: Perfume

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            PerfumeDetailRow(title: "Brand", value: perfume.brand)
            PerfumeDetailRow(title: "Seasons", value: perfume.seasons.joined(separator: ", "))
            PerfumeDetailRow(title: "Day Times", value: perfume.dayTimes.joined(separator: ", "))
            Spacer()
        }
        .padding()
        .navigationTitle(perfume.name)
    }
}

struct PerfumeDetailRow: View {
    var title: String
    var value: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
        }
    }
}
