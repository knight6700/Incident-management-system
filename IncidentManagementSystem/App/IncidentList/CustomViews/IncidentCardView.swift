//
//  IncidentCardView.swift
//  IncidentManagementSystem
//
//  Created by MahmoudFares on 28/09/2023.
//

import SwiftUI

struct IncidentCardView: View {
    var model: IncidentModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ImageView(url: model.image)
                .padding(.top)
            Text(model.title)
                .font(.title)
            taskDetailsView
        }
        .padding([.horizontal, .bottom])
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

extension IncidentCardView {
    var taskDetailsView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Status")
                    .font(.headline)
                Text(model.status.title)
                    .font(.subheadline)
                    .foregroundColor(model.status.color)
            }

            Spacer()

            VStack(alignment: .leading) {
                Text("Priority")
                    .font(.headline)
                Text(model.priority.title)
                    .font(.subheadline)
                    .foregroundColor(model.priority.color)
            }

            Spacer()

            VStack(alignment: .leading) {
                Text("Schedule On")
                    .font(.headline)
                Text(model.scheduleOn)
                    .font(.subheadline)
            }
        }
    }
}

struct IncidentCardView_Previews: PreviewProvider {
    static var previews: some View {
        IncidentCardView(
            model: .init(id: "1", title: "Generator Maintenance", priority: .high, status: .new, scheduleOn: "13 Oct 2023", image: "")
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

struct ImageView: View {
    var url: String
    var placeHolder: String = "briefcase.circle.fill"
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                // Placeholder while the image is loading
                ProgressView()
            case let .success(image):
                // Successfully loaded image
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())

            case .failure:
                // Error state
                Image(systemName: placeHolder)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            @unknown default:
                ProgressView()
            }
        }
    }
}
