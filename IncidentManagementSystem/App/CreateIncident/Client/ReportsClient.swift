import Dependencies

struct ReportsClient {
    var fetchTypes: () async throws -> [ActivityElementDTO]
    var submit: (_ parameters: ReportParameters) async throws -> IncidentDTO
}

extension ReportsClient: DependencyKey {
    static var liveValue: Self {
        .init(
            fetchTypes: {
                try await ApiClient.load(
                    [ActivityElementDTO].self,
                    with: .init(
                        endpoint: "types/",
                        method: .get
                    )
                )
            }, submit: {
                try await ApiClient.load(
                    IncidentDTO.self,
                    with: .init(
                        endpoint: "incident/",
                        body: $0,
                        method: .post
                    )
                )
            }
        )
    }
}

extension ReportsClient: TestDependencyKey {
    static var testValue: Self {
        .init(
            fetchTypes: {
                .mockActivityElements
            }, submit: { _ in
                    .init(baseURL: "", incidents: .mockIncidents)
            }
        )
    }

    static var previewValue: Self {
        .testValue
    }
}

extension DependencyValues {
    var reportsClient: ReportsClient {
        get { self[ReportsClient.self] }
        set { self[ReportsClient.self] = newValue }
    }
}
