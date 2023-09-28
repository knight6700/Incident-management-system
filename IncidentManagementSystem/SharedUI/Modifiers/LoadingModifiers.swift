import SwiftUI
import Combine

public struct ShowLoaderModifier: ViewModifier {
    @Binding var isLoading: Bool

    public init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
    }

    public func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isLoading ? 2 : 0)
                .disabled(isLoading)
            if isLoading {
                LoadingThreeBalls()
            }
        }
    }
}

public extension View {
    func showLoader(isLoading: Binding<Bool>) -> some View {
        modifier(ShowLoaderModifier(isLoading: isLoading))
    }
}
