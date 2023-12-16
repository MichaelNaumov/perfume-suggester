// AllPerfumesTab.swift
import SwiftUI

struct AllPerfumesTab: View {
    @ObservedObject var viewModel: PerfumeViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.perfumes.sorted(by: { $0.brand < $1.brand })) { perfume in
                    NavigationLink(
                        destination: PerfumeDetailsView(perfume: perfume),
                        label: {
                            Text("\(perfume.brand) \(perfume.name) - \(perfume.seasons.joined(separator: ", ")), \(perfume.dayTimes.joined(separator: ", "))")
                        }
                    )
                }
                .onDelete { indexSet in
                    // Handle perfume deletion here
                    viewModel.removePerfumes(atOffsets: indexSet)
                }
            }
            .navigationTitle("All Perfumes")
        }
        .tabItem {
            Label("All Perfumes", systemImage: "list.bullet")
        }
    }
}
