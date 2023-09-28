//
//  TypesListView.swift
//  IncidentManagementSystem
//
//  Created by MahmoudFares on 28/09/2023.
//

import SwiftUI

struct TypesListView: View {
    var models: [TypesModel]
    var action: (TypesModel) -> Void
    var body: some View {
        List(models) { model in
            // Shadow
            HStack {
                Text(model.name)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(5)
                    .cornerRadius(10) // Corner radius
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                Spacer()
                if model.isSelected {
                    Image(systemName: "checkmark")

                }
            }
                .onTapGesture {
                    action(model)
                }
        }
        
    }
}

struct TypesListView_Previews: PreviewProvider {
    static var previews: some View {
        TypesListView(models: .mockTypes, action: { _ in })
            .environment(\.locale, .init(identifier: "en")) // English language scheme
            .previewDisplayName("English")
        TypesListView(models: .mockTypes, action: { _ in })
            .environment(\.locale, .init(identifier: "ar")) // arabic language scheme
            .previewDisplayName("Arabic")


    }
}
