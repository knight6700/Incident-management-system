//
//  IncidentList.swift
//  IncidentManagementSystem
//
//  Created by MahmoudFares on 28/09/2023.
//

import SwiftUI

struct IncidentListView: View {
    @ObservedObject var viewModel: IncidentListViewModel = .init()
    var body: some View {
        NavigationStack {
            List(viewModel.state.searchResults) { model in
                IncidentCardView(model: model)
                    .listRowSeparator(.hidden)
                    .listRowSeparatorTint(.clear)
                    .listRowBackground(Color.clear)
                    .redacted(reason: viewModel.state.isLoading ? .placeholder : .init())
            }
            .navigationBarTitle("Activity", displayMode: .large)
            .navigationBarItems(trailing: addNewActivityButton)
            .listStyle(.plain)
            .sheet(isPresented: $viewModel.state.isPresent) {
                CreateIncidentRepostView(viewModel: viewModel.reportViewModel)
            }
        }
        .alert(item: $viewModel.alertItem) {
            Alert(title: $0.title, message: $0.message, dismissButton: $0.dismissButton)
        }
        .scrollIndicators(.hidden)
        .searchable(text: $viewModel.state.searchText) {
            ForEach(viewModel.state.searchResults, id: \.self) { result in
                searchResultView(result: result)
            }
        }
        
        .onAppear {
            viewModel.trigger(.load)
        }
    }
}

extension IncidentListView {
    var addNewActivityButton: some View {
        Button(action: {
            viewModel.trigger(.present)
        }) {
            Image(systemName: "doc.fill.badge.plus")
                .foregroundColor(.black)
        }
    }

    func searchResultView(result: IncidentModel) -> some View {
        ForEach(viewModel.state.searchResults, id: \.self) { result in
            Text("Are you looking for \(result.title)?").searchCompletion(result.title)
                .foregroundColor(.black)
        }
    }
}

struct IncidentList_Previews: PreviewProvider {
    static var previews: some View {
        IncidentListView()
    }
}
