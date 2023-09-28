

#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport

@available(iOS 14.0, *)
struct LibraryViewContent: LibraryContentProvider {

    @LibraryContentBuilder
    var views: [LibraryItem] {
        LibraryItem(MapView( span: .constant(.init(latitudeDelta: 0.05, longitudeDelta: 0.05)), annotation: .constant(CustomAnnotation(title: "Apple", coordinate: .applePark))))
    }

}
#endif
