
import SwiftUI
import MapKit
import Combine
import UIKit

public struct MapView: UIViewRepresentable {
    
    let mapType: MKMapType
    
   
    @Binding var coordinate: CLLocationCoordinate2D?

    let isZoomEnabled: Bool
    let isScrollEnabled: Bool
    let isRotateEnabled: Bool
    
    let showsUserLocation: Bool
  
    let userTrackingMode: MKUserTrackingMode
    let defaultSpan = 0.5
    @Binding var span: MKCoordinateSpan
    
    var asMKCoordinateRegion: MKCoordinateRegion {
        .init(center: coordinate ?? .applePark, span: span)
    }
    
    @Binding var annotation: MapViewAnnotation?

    
    public init(mapType: MKMapType = .standard,
                coordinate: Binding<CLLocationCoordinate2D?> = .constant(nil),
                span: Binding<MKCoordinateSpan>,
                isZoomEnabled: Bool = true,
                isScrollEnabled: Bool = true,
                isRotateEnabled: Bool = true,
                showsUserLocation: Bool = true,
                userTrackingMode: MKUserTrackingMode = .none,
                annotation: Binding<MapViewAnnotation?>) {
        self.mapType = mapType
        self._coordinate = coordinate
        self.isZoomEnabled = isZoomEnabled
        self.isScrollEnabled = isScrollEnabled
        self.isRotateEnabled = isRotateEnabled
        self.showsUserLocation = showsUserLocation
        self.userTrackingMode = userTrackingMode
        self._annotation = annotation
        self._span = span
    }

    // MARK: - UIViewRepresentable
    public func makeCoordinator() -> MapView.Coordinator {
        return Coordinator(for: self)
    }

    public func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.register(MapAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(MapAnnotationClusterView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)

        configureView(mapView, context: context)

        return mapView
    }

    public func updateUIView(_ mapView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        configureView(mapView, context: context)
    }

    private func configureView(_ mapView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        // basic map configuration
        mapView.mapType = mapType
        if let mapRegion = coordinate {
            
            let region = mapView.regionThatFits(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate?.latitude ?? .zero , longitude: coordinate?.longitude ?? .zero), span: span))
            
            if region.center != mapView.region.center || region.span != mapView.region.span {
                mapView.setRegion(region, animated: true)
            }
        }
        mapView.isZoomEnabled = isZoomEnabled
        mapView.isScrollEnabled = isScrollEnabled
        mapView.isRotateEnabled = isRotateEnabled
        mapView.showsUserLocation = showsUserLocation
        mapView.userTrackingMode = userTrackingMode
        mapView.showsUserLocation = true
        
        updateAnnotations(in: mapView)
        
    }
    
    private func updateAnnotations(in mapView: MKMapView) {
        guard let annotation else {
            return
        }
        mapView.removeAnnotation(annotation)
        mapView.addAnnotation(annotation)
    }

    
    // MARK: - Interaction and delegate implementation
    public class Coordinator: NSObject, MKMapViewDelegate {
        
        /**
         Reference to the SwiftUI `MapView`.
        */
        private let context: MapView
        
        init(for context: MapView) {
            self.context = context
            super.init()
        }
        
        // MARK: MKMapViewDelegate
        public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            
            
        }
        
        public func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            
        }
        public func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) {
            print("Idle")
        }
        
        public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            DispatchQueue.main.async {
                self.context.coordinate = mapView.centerCoordinate
                self.context.span = mapView.region.span
            }
            
        }
        
        
        
    }
    
}

// MARK: - Previews

#if DEBUG
struct MapView_Previews: PreviewProvider {

    static var previews: some View {
        MapView( span: .constant(MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), annotation: .constant(CustomAnnotation(title: "Apple", coordinate: .applePark)))
    }

}
#endif

