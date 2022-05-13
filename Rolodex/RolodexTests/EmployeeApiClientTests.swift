//
//  EmployeeApiClientTests.swift
//  RolodexTests
//
//  Created by Mat Schmid on 2022-05-12.
//

import Foundation
import XCTest
@testable import Rolodex

class EmployeeApiClientTests: XCTestCase {
	func testProductionUrl() {
		let url = EmployeeApiClient.Endpoint.production.url
		let expectedUrl = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")
		XCTAssertEqual(url, expectedUrl)
	}
}
