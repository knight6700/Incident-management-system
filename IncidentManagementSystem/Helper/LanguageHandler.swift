import Foundation
struct LanguageHandler {
    static var isArabic: Bool {
        let languageCode = Locale.current.language.languageCode?.identifier
        return languageCode == "ar" // "ar" represents the Arabic language code
    }
}
