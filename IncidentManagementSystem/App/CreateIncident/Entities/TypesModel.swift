//
//  TypesModels.swift
//  IncidentManagementSystem
//
//  Created by MahmoudFares on 28/09/2023.
//

import Foundation

struct TypesModel: Identifiable, Hashable {
    let id: Int
    let englishName: String
    let arabicName: String
    var isSelected: Bool = false
    var subTypes: [TypesModel]
    
}

extension Array where Element == TypesModel {
    static let mockTypes: [TypesModel] = [
        .init(id: 0, englishName: "Generators", arabicName: "مولدات", subTypes: .mockTypes),
        .init(id: 1, englishName: "Electronics", arabicName: "إلكترونيات", subTypes: .mockTypes),
        .init(id: 2, englishName: "Furniture", arabicName: "أثاث", subTypes: .mockTypes),
        .init(id: 3, englishName: "Clothing", arabicName: "ملابس", subTypes: .mockTypes),
        .init(id: 4, englishName: "Books", arabicName: "كتب", subTypes: .mockTypes),
        .init(id: 5, englishName: "Appliances", arabicName: "أجهزة كهربائية", subTypes: .mockTypes),
        .init(id: 6, englishName: "Toys", arabicName: "ألعاب", subTypes: .mockTypes),
        .init(id: 7, englishName: "Sports Equipment", arabicName: "معدات رياضية", subTypes: .mockTypes),
        .init(id: 8, englishName: "Jewelry", arabicName: "مجوهرات", subTypes: .mockTypes),
        .init(id: 9, englishName: "Home Decor", arabicName: "ديكور المنزل", subTypes: .mockTypes),
    ]
}
extension TypesModel {
    var name: String {
        LanguageHandler.isArabic ? arabicName : englishName
    }
}
