import Dependencies

struct IncidentDomain {
    var toDomain: (IncidentDTO) -> [IncidentModel]
}

extension IncidentDomain: DependencyKey {
    static var liveValue: Self {
        .init(toDomain: {
            $0.incidents.map {IncidentModel(id: $0.id, title: $0.description, priority: $0.priority ?? .low, status: $0.status, scheduleOn: $0.createdAt?.formattedString() ?? "N/A", image: $0.medias.first?.url ?? "-")}
        })
    }
}

extension IncidentDomain: TestDependencyKey {
    static var testValue: Self {
        .init(toDomain: { _ in
                .mock
        })
    }
    
    static var previewValue: Self {
        .testValue
    }
}


extension DependencyValues {
    var incidentDomain: IncidentDomain {
    get { self[IncidentDomain.self] }
    set { self[IncidentDomain.self] = newValue }
  }
}
