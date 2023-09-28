import Foundation
import Foundation

// MARK: - ActivityElement
struct ActivityElementDTO: Decodable {
    let id: Int
    let arabicName, englishName: String
    let subTypes: [ActivityElementDTO]?
    let categoryID: Int?

    enum CodingKeys: String, CodingKey {
        case id, arabicName, englishName, subTypes
        case categoryID = "categoryId"
    }
}

extension Array where Element == ActivityElementDTO {
  static let subType1 = ActivityElementDTO(id: 10, arabicName: "Subtype Arabic 1", englishName: "Subtype English 1", subTypes: nil, categoryID: 110)
  static  let subType2 = ActivityElementDTO(id: 11, arabicName: "Subtype Arabic 2", englishName: "Subtype English 2", subTypes: nil, categoryID: 111)

   static let mockActivityElements: [ActivityElementDTO] = [
        ActivityElementDTO(id: 0, arabicName: "Arabic Name 0", englishName: "English Name 0", subTypes: [subType1, subType2], categoryID: 100),
        ActivityElementDTO(id: 1, arabicName: "Arabic Name 1", englishName: "English Name 1", subTypes: [subType1], categoryID: 101),
        ActivityElementDTO(id: 2, arabicName: "Arabic Name 2", englishName: "English Name 2", subTypes: nil, categoryID: 102),
        ActivityElementDTO(id: 3, arabicName: "Arabic Name 3", englishName: "English Name 3", subTypes: [subType2], categoryID: 103),
        ActivityElementDTO(id: 4, arabicName: "Arabic Name 4", englishName: "English Name 4", subTypes: nil, categoryID: 104),
        ActivityElementDTO(id: 5, arabicName: "Arabic Name 5", englishName: "English Name 5", subTypes: nil, categoryID: 105),
        ActivityElementDTO(id: 6, arabicName: "Arabic Name 6", englishName: "English Name 6", subTypes: [subType1], categoryID: 106),
        ActivityElementDTO(id: 7, arabicName: "Arabic Name 7", englishName: "English Name 7", subTypes: nil, categoryID: 107),
        ActivityElementDTO(id: 8, arabicName: "Arabic Name 8", englishName: "English Name 8", subTypes: nil, categoryID: 108),
        ActivityElementDTO(id: 9, arabicName: "Arabic Name 9", englishName: "English Name 9", subTypes: [subType2], categoryID: 109)
    ]
}
