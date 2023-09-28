//
//  DropDownPlaceHolder.swift
//  IncidentManagementSystem
//
//  Created by MahmoudFares on 28/09/2023.
//

import SwiftUI

struct DropDownPlaceHolderView: View {
    var text: String
    var image: String = "chevron.down"
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(.black)
                .lineLimit(1)
            Spacer()
            Image(systemName: image)
                .foregroundColor(.black)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1) // Customize border color and width
        )
    }
}
