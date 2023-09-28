//
//  IncidentList.swift
//  IncidentManagementSystem
//
//  Created by MahmoudFares on 28/09/2023.
//

import SwiftUI

struct IncidentListView: View {
    @State private var searchText = ""
    @State var isPresent: Bool = false
    var body: some View {
        NavigationStack {
            List {
                IncidentCardView(
                    viewState: .init(title: "Generator Maintenance", priority: .medium, status: .close, scheduleOn: "13 Oct 2023", image: "")
                )
                IncidentCardView(
                    viewState: .init(title: "Generator Maintenance", priority: .high, status: .new, scheduleOn: "13 Oct 2023", image: "")
                )
                IncidentCardView(
                    viewState: .init(title: "Generator Maintenance", priority: .high, status: .new, scheduleOn: "13 Oct 2023", image: "")
                )
                .listRowSeparator(.hidden)
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
            }

            .navigationBarTitle("Activity", displayMode: .large)
            .navigationBarItems(trailing:
                Button(action: {
                    // Handle the action when the plus button is tapped
                    // For example, navigate to a new view or show a sheet
                    // You can replace the print statement with your logic
                    isPresent = true
                }) {
                    Image(systemName: "plus.app.fill")
                        .foregroundColor(.black)
                }
            )
            .listStyle(.plain)
            .sheet(isPresented: $isPresent) {
                Text("HEllo")
            }
        }
        .searchable(text: $searchText, prompt: "Search")

    }
}

struct IncidentList_Previews: PreviewProvider {
    static var previews: some View {
        IncidentListView()
    }
}
