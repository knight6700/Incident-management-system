import Dependencies
import Foundation
import Combine

class IncidentListViewModel: ObservableObject {
    struct State: Equatable {
        var incidents: [IncidentModel] = [IncidentModel].mock
        var searchText: String = ""
        var isLoading: Bool = true
        var isPresent: Bool = false
        var searchResults: [IncidentModel] {
            searchText.isEmpty
                ? incidents
                : incidents.filter { $0.title.contains(searchText) }
        }
    }
    
    enum Action {
        case load
        case present
    }

    @Dependency(\.incidentClient) private var api
    @Dependency(\.incidentDomain) private var incidentsDomain
    var reportViewModel: CreateIncidentViewModel = .init()

    @Published var state: State = .init()
    var alertItem: AlertItem?

    private var cancellable = Set<AnyCancellable>()

    func trigger(_ action: Action) {
        switch action {
        case .load:
            loadIncidents()
        case .present:
            state.isPresent = true
            reportViewModel = .init()
            intializeObservers()
        }
    }

    private func loadIncidents() {
        state.isLoading = true
        Task { @MainActor in
            do {
                let incidents = try await api.fetchList()
                state.incidents = incidentsDomain.toDomain(incidents)
            } catch {
                let error =  error as? NetworkError
                showAlert(error: .custom(message: error?.customDescription ?? ""))
            }
            state.isLoading = false
        }
    }
    
    private func intializeObservers() {
        reportViewModel.successPublisher.sink { _ in
            
        } receiveValue: { [weak self] _ in
            guard let self else {
                return
            }
            self.state.isPresent = false
        }
        .store(in: &cancellable)

    }
    @MainActor
    func showAlert(error: CustomError) {
        alertItem = error.showUrlAlert()
    }
}
