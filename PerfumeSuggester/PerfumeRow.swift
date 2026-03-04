// PerfumeRow.swift
import SwiftUI

struct PerfumeRow: View {
    let perfume: Perfume

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(perfume.brand) \(perfume.name)")
                .font(.body)
            Text("\(perfume.seasons.joined(separator: ", ")) · \(perfume.dayTimes.joined(separator: ", "))")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 2)
    }
}
