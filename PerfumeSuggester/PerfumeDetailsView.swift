// PerfumeDetailsView.swift
import SwiftUI

struct PerfumeDetailsView: View {
    var perfume: Perfume

    var body: some View {
        Text("Perfume Details: \(perfume.name)")
            .navigationTitle(perfume.name)
    }
}
