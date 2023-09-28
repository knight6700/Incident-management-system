import Foundation
import SwiftUI

struct IncidentModel: Identifiable, Hashable, Equatable {
    let id: String
    let title: String
    let priority: Priority
    let status: TaskStatus
    let scheduleOn: String
    let image: String
}

extension Priority {
    var color: Color {
        switch self {
        case .high:
            return .red
        case .low:
            return .yellow
        case .medium:
            return .green
        }
    }

    var title: String {
        rawValue.capitalized
    }
}

extension TaskStatus {
    var color: Color {
        switch self {
        case .new:
            return .red
        case .close:
            return .black
        }
    }

    var title: String {
        switch self {
        case .new:
            return "New"
        case .close:
            return "Close"
        }
    }
}

extension Array where Element == IncidentModel {
    static let mock: Self = [
        IncidentModel(
            id: "1",
            title: "Mock Incident 1",
            priority: .high,
            status: .new,
            scheduleOn: "2023-09-20 10:00 AM",
            image: "incident1_image"
        ),
        IncidentModel(
            id: "2",
            title: "Mock Incident 2",
            priority: .medium,
            status: .new,
            scheduleOn: "2023-09-21 11:30 AM",
            image: "incident2_image"
        ),
        IncidentModel(
            id: "3",
            title: "Mock Incident 3",
            priority: .low,
            status: .close,
            scheduleOn: "2023-09-22 2:15 PM",
            image: "incident3_image"
        ),
        IncidentModel(
            id: "4",
            title: "Mock Incident 4",
            priority: .medium,
            status: .new,
            scheduleOn: "2023-09-23 3:45 PM",
            image: "incident4_image"
        ),
        IncidentModel(
            id: "5",
            title: "Mock Incident 5",
            priority: .high,
            status: .close,
            scheduleOn: "2023-09-24 4:30 PM",
            image: "incident5_image"
        ),
        IncidentModel(
            id: "6",
            title: "Mock Incident 6",
            priority: .low,
            status: .new,
            scheduleOn: "2023-09-25 9:00 AM",
            image: "incident6_image"
        ),
        IncidentModel(
            id: "7",
            title: "Mock Incident 7",
            priority: .medium,
            status: .new,
            scheduleOn: "2023-09-26 1:45 PM",
            image: "incident7_image"
        ),
        IncidentModel(
            id: "8",
            title: "Mock Incident 8",
            priority: .high,
            status: .close,
            scheduleOn: "2023-09-27 5:30 PM",
            image: "incident8_image"
        ),
        IncidentModel(
            id: "9",
            title: "Mock Incident 9",
            priority: .low,
            status: .new,
            scheduleOn: "2023-09-28 8:30 AM",
            image: "incident9_image"
        ),
        IncidentModel(
            id: "10",
            title: "Mock Incident 10",
            priority: .medium,
            status: .new,
            scheduleOn: "2023-09-29 11:00 AM",
            image: "incident10_image"
        ),
    ]
}
