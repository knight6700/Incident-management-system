import CoreLocation
import Dependencies
import Foundation
import MapKit
import Combine

class CreateIncidentViewModel: ObservableObject {
    struct State {
        var types: [TypesModel] = []
        var subType: [TypesModel] {
            types.filter(\.isSelected).first?.subTypes ?? []
        }

        var showSubCategory: Bool {
            !(selectedType?.subTypes.isEmpty ?? true)
        }

        var selectedType: TypesModel?
        var selectedSubType: TypesModel?
        var presentType: PresentationDestination?
        var description: String = ""
        var isLoading: Bool = true
        var showMap: Bool = false
        // Location And Map
        var locationManager = LocationManager()
        var coordinate: CLLocationCoordinate2D?
        var span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        var annotation: MapViewAnnotation?
        var address: String?

        var parameters: ReportParameters {
            .init(
                description: description,
                typeID: selectedType?.id ?? .zero,
                subTypeID: selectedSubType?.id ?? .zero,
                latitude: Double(coordinate?.latitude ?? .zero),
                longitude: Double(coordinate?.longitude ?? .zero)
            )
        }

        var isSubmitButtonDisable: Bool {
            !(
                !description.isEmpty
                    && selectedType?.id != nil
                    && selectedSubType?.id != nil
                    && coordinate != nil
                    && address != nil
            )
        }
    }

    enum PresentationDestination: Int, Identifiable {
        var id: Int {
            rawValue
        }

        case types
        case subtypes
    }

    enum Action {
        case load
        case present(PresentationDestination)
        case selectType(TypesModel)
        case requestLocation
        case showMap
        case updateAddress
        case submitButtonTapped
    }

    @Dependency(\.reportsClient) private var api
    @Dependency(\.reportsDomain) private var reportsDomain
    private let successSubject = PassthroughSubject<Void, Never>()

    public var successPublisher: AnyPublisher<Void, Never> {
        successSubject.eraseToAnyPublisher()
    }

    @Published var state: State = .init()

    func trigger(_ action: Action) {
        switch action {
        case .load:
            loadTypes()
        case let .present(destination):
            state.presentType = destination
        case let .selectType(type):
            switch state.presentType {
            case .types:
                handleSelectionType(id: type.id)
            case .subtypes:
                handleSelectionSubType(id: type.id)
            default:
                break
            }
            state.presentType = nil
        case .requestLocation:
            state.locationManager.requestLocation()
        case .showMap:
            state.showMap.toggle()
            setupCurrentLocation()
        case .updateAddress:
            updateAddress()
        case .submitButtonTapped:
            submitReport()
        }
    }

    private func loadTypes() {
        state.isLoading = true
        Task { @MainActor in
            do {
                let types = try await api.fetchTypes()
                state.isLoading = false
                state.types = reportsDomain.typesToDomain(types)
            } catch {
                state.isLoading = false
                print(error)
            }
            state.isLoading = false
        }
    }

    private func submitReport() {
        state.isLoading = true
        Task { @MainActor in
            do {
                let _ = try await api.submit(state.parameters)
                state.isLoading = false
                successSubject.send()
            } catch {
                state.isLoading = false
                print(error)
            }
            state.isLoading = false
        }
    }
}

// MARK: Handle Selections

#warning("TODO: Need To Move this to useCases")
private extension CreateIncidentViewModel {
    func handleSelectionType(id: Int) {
        guard let index = state.types.firstIndex(where: { $0.id == id }) else {
            return
        }
        state.types = state.types.map {
            var array = $0
            array.isSelected = false
            return array
        }
        state.types[index].subTypes = state.types[index].subTypes.map {
            var array = $0
            array.isSelected = false
            return array
        }
        state.types[index].isSelected.toggle()
        state.selectedType = state.types[index]
        state.selectedSubType = nil
    }

    func handleSelectionSubType(id: Int) {
        guard let index = state.types.firstIndex(where: { $0.isSelected }),
              let subTypeIndex = state.types[index].subTypes.firstIndex(where: { $0.id == id })
        else {
            return
        }
        state.types[index].subTypes = state.types[index].subTypes.map {
            var array = $0
            array.isSelected = false
            return array
        }
        state.types[index].subTypes[subTypeIndex].isSelected.toggle()
        state.selectedSubType = state.types[index].subTypes[subTypeIndex]
    }
}

#warning("TODO: Need To Move this to useCases")
private extension CreateIncidentViewModel {
    func updateAddress() {
        guard let lat = state.coordinate?.latitude,
              let long = state.coordinate?.longitude
        else {
            return
        }
        Task { @MainActor in
            state.address = try await state.locationManager.getAddrFrmLtLng(latitude: lat, longitude: long)
        }
    }

    func setupCurrentLocation() {
        guard state.coordinate == nil else {
            return
        }
        state.coordinate = CLLocationCoordinate2D(
            latitude: state.locationManager.lastLocation?.coordinate.latitude ?? 0.0,
            longitude: state.locationManager.lastLocation?.coordinate.longitude ?? 0.0
        )

        state.annotation = CustomAnnotation(
            title: "My Location",
            coordinate: CLLocationCoordinate2D(
                latitude: state.locationManager.lastLocation?.coordinate.latitude ?? 0.0,
                longitude: state.locationManager.lastLocation?.coordinate.longitude ?? 0.0
            ), image: "house.fill"
        )
    }
}
