

import Foundation
import MapKit


public protocol MapViewAnnotation: MKAnnotation {
    
    var clusteringIdentifier: String? {
        get
    }
    
   
    var glyphImage: UIImage? {
        get
    }
    var tintColor: UIColor? {
        get
    }
    
}


extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
