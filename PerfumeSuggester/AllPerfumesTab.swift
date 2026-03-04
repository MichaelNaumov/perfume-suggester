// AllPerfumesTab.swift
import SwiftUI

struct AllPerfumesTab: View {
    @ObservedObject var viewModel: PerfumeViewModel

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("\(viewModel.perfumes.count) Perfumes")) {
                    ForEach(viewModel.perfumes) { perfume in
                        NavigationLink(destination: PerfumeDetailsView(perfume: perfume)) {
                            PerfumeRow(perfume: perfume)
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.removePerfumes(atOffsets: indexSet)
                    }
                }
            }
            .navigationTitle("All Perfumes")
        }
        .tabItem {
            Label("All Perfumes", systemImage: "list.bullet")
        }
    }
}
