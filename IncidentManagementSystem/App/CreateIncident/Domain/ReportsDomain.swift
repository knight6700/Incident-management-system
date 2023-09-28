import Dependencies

struct ReportsDomain {
    var typesToDomain: ([ActivityElementDTO]) -> [TypesModel]
}

extension ReportsDomain: DependencyKey {
    static var liveValue: Self {
        .init(
            typesToDomain: { typesDTO in
                typesDTO.map { types in
                    TypesModel(
                        id: types.id,
                        englishName: types.englishName,
                        arabicName: types.arabicName,
                        subTypes: types.subTypes?.map { subTypeDTO in
                            TypesModel(
                                id: subTypeDTO.id,
                                englishName: subTypeDTO.englishName,
                                arabicName: subTypeDTO.arabicName,
                                subTypes: [] // You may need to map the sub-subtypes here if needed
                            )
                        } ?? []
                    )
                }
            }
        )
    }
}

extension ReportsDomain: TestDependencyKey {
    static var testValue: Self {
        .init(typesToDomain: { _ in
            .mockTypes
        })
    }

    static var previewValue: Self {
        .testValue
    }
}

extension DependencyValues {
    var reportsDomain: ReportsDomain {
        get { self[ReportsDomain.self] }
        set { self[ReportsDomain.self] = newValue }
    }
}
