import Foundation

// MARK: - IncidentDTO

struct IncidentDTO: Decodable {
    let baseURL: String
    let incidents: [Incident]
}

// MARK: - Incident

struct Incident: Decodable {
    let id, description: String
    let latitude, longitude: Double
    let status: TaskStatus
    let priority: Priority?
    let typeID: Int
    let issuerID: String
    let assigneeID: String?
    let createdAt, updatedAt: Date?
    let medias: [Media]

    enum CodingKeys: String, CodingKey {
        case id, description, latitude, longitude, status, priority
        case typeID = "typeId"
        case issuerID = "issuerId"
        case assigneeID = "assigneeId"
        case createdAt, updatedAt, medias
    }
}
enum TaskStatus: Int, Decodable, Equatable {
    case new = 0
    case close = 1
}
// MARK: - Media

struct Media: Decodable {
    let id: String
    let mimeType: MIMEType
    let url: String
    let type: Int
    let incidentID: String

    enum CodingKeys: String, CodingKey {
        case id, mimeType, url, type
        case incidentID = "incidentId"
    }
}

enum MIMEType: String, Decodable {
    case imageJpg = "image/jpg"
    case imagePNG = "image/png"
}

enum Priority: String, Decodable, Equatable{
    case high
    case low
    case medium
}

extension Array where Element == Incident {
    static let mockIncidents: [Incident] = [
        Incident(
            id: "1",
            description: "Mock Incident 1",
            latitude: 12.345,
            longitude: 67.890,
            status: .new,
            priority: .high,
            typeID: 1,
            issuerID: "user1",
            assigneeID: "user2",
            createdAt: Date(),
            updatedAt: Date(),
            medias: []
        ),
        Incident(
            id: "2",
            description: "Mock Incident 2",
            latitude: 23.456,
            longitude: 78.901,
            status: .new,
            priority: .medium,
            typeID: 2,
            issuerID: "user2",
            assigneeID: nil,
            createdAt: Date(),
            updatedAt: Date(),
            medias: []
        ),
        Incident(
            id: "3",
            description: "Mock Incident 3",
            latitude: 34.567,
            longitude: 89.012,
            status: .close,
            priority: .low,
            typeID: 3,
            issuerID: "user3",
            assigneeID: "user1",
            createdAt: Date(),
            updatedAt: Date(),
            medias: []
        ),
        Incident(
            id: "4",
            description: "Mock Incident 4",
            latitude: 45.678,
            longitude: 90.123,
            status: .new,
            priority: .medium,
            typeID: 1,
            issuerID: "user1",
            assigneeID: nil,
            createdAt: Date(),
            updatedAt: Date(),
            medias: []
        ),
        Incident(
            id: "5",
            description: "Mock Incident 5",
            latitude: 56.789,
            longitude: 101.234,
            status: .close,
            priority: .high,
            typeID: 2,
            issuerID: "user2",
            assigneeID: "user3",
            createdAt: Date(),
            updatedAt: Date(),
            medias: []
        ),
        Incident(
            id: "6",
            description: "Mock Incident 6",
            latitude: 67.890,
            longitude: 112.345,
            status: .new,
            priority: .low,
            typeID: 3,
            issuerID: "user3",
            assigneeID: nil,
            createdAt: Date(),
            updatedAt: Date(),
            medias: []
        ),
        Incident(
            id: "7",
            description: "Mock Incident 7",
            latitude: 78.901,
            longitude: 123.456,
            status: .new,
            priority: .medium,
            typeID: 1,
            issuerID: "user1",
            assigneeID: "user2",
            createdAt: Date(),
            updatedAt: Date(),
            medias: []
        ),
        Incident(
            id: "8",
            description: "Mock Incident 8",
            latitude: 89.012,
            longitude: 134.567,
            status: .close,
            priority: .high,
            typeID: 2,
            issuerID: "user2",
            assigneeID: "user3",
            createdAt: Date(),
            updatedAt: Date(),
            medias: []
        ),
        Incident(
            id: "9",
            description: "Mock Incident 9",
            latitude: 90.123,
            longitude: 145.678,
            status: .new,
            priority: .low,
            typeID: 3,
            issuerID: "user3",
            assigneeID: nil,
            createdAt: Date(),
            updatedAt: Date(),
            medias: []
        ),
        Incident(
            id: "10",
            description: "Mock Incident 10",
            latitude: 101.234,
            longitude: 156.789,
            status: .new,
            priority: .medium,
            typeID: 1,
            issuerID: "user1",
            assigneeID: nil,
            createdAt: Date(),
            updatedAt: Date(),
            medias: []
        )
    ]

}
