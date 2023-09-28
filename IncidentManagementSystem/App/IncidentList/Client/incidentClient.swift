import Dependencies

struct IncidentClient {
    var fetchList: () async throws -> IncidentDTO
}

extension IncidentClient: DependencyKey {
    static var liveValue: Self {
        .init(
            fetchList: {
                try await ApiClient.load(
                    IncidentDTO.self,
                    with: .init(
                        endpoint: "incident/",
                        method: .get
                    )
                )
            }
        )
    }
}

extension IncidentClient: TestDependencyKey {
    static var testValue: Self {
        .init(fetchList: {
            .init(
                baseURL: "",
                incidents: .mockIncidents
            )
        })
    }

    static var previewValue: Self {
        testValue
    }
}

extension DependencyValues {
    var incidentClient: IncidentClient {
        get { self[IncidentClient.self] }
        set { self[IncidentClient.self] = newValue }
    }
}
