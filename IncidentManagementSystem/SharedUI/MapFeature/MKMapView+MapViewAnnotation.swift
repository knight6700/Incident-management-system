
import MapKit

@available(iOS, introduced: 13.0)
extension MKMapView {
    
    
    var mapViewAnnotations: [MapViewAnnotation] {
        annotations.compactMap { $0 as? MapViewAnnotation }
    }
    
    
    var selectedMapViewAnnotations: [MapViewAnnotation] {
        selectedAnnotations.compactMap { $0 as? MapViewAnnotation }
    }
    
}
