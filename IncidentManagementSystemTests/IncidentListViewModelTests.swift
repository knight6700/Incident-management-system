//
//  IncidentListViewModelTests.swift
//  IncidentManagementSystemTests
//
//  Created by MahmoudFares on 28/09/2023.
//

import XCTest
import Dependencies
@testable import IncidentManagementSystem

final class IncidentListViewModelTests: XCTestCase {

    @MainActor func testPosts() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let model = withDependencies {
            // 1️⃣ Override any dependencies that your feature uses.
            $0.incidentClient = .testValue
            $0.incidentDomain = .testValue
        } operation: {
            IncidentListViewModel()
        }
        // Initial State
        XCTAssertEqual(
            model.state,
            .init(incidents: .mock, searchText: "", isLoading: true, isPresent: false)
        )

        // 2️⃣ Trigger the asynchronous operation
        model.trigger(.load)
        // 3️⃣ Wait for the asynchronous operation to complete
        try await ImmediateClock().sleep(for: .seconds(0.01))
        // 4️⃣ Make assertions after the asynchronous operation is complete
        XCTAssertEqual(
            model.state,
            .init(incidents: .mock, searchText: "", isLoading: false, isPresent: false)
        )
    }

}
