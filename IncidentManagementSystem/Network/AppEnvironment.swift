

enum AppEnvironment {

    static var isLive: Bool {
        #if DEBUG
        return false
        #elseif RELEASE
        return true
        #else
        return false
        #endif
    }

}
