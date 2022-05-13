//
//  EmployeeListSortTypeTests.swift
//  RolodexTests
//
//  Created by Mat Schmid on 2022-05-12.
//

import Foundation
import XCTest
@testable import Rolodex

class EmployeeListSortTypeTests: XCTestCase {
	private var mat: Employee { mockEmployee(name: "Mat Schmid", team: .core) }
	private var jack: Employee { mockEmployee(name: "Jack Dorsey", team: .appointments) }
	private var bobby: Employee { mockEmployee(name: "Bobby Tables", team: .retail) }
	private var jony: Employee { mockEmployee(name: "Jony Ive", team: .hardware) }
	private var employees: [Employee] { [mat, jack, bobby, jony] }
	
	func testNameAtoZSort() {
		let sortType = EmployeeListSortType.nameAtoZ
		let sortedEmployees = sortType.sort(employees: employees)
		let expectedEmployees = [bobby, jack, jony, mat]
		XCTAssertEqual(sortedEmployees, expectedEmployees)
	}
	
	func testNameZtoASort() {
		let sortType = EmployeeListSortType.nameZtoA
		let sortedEmployees = sortType.sort(employees: employees)
		let expectedEmployees = [mat, jony, jack, bobby]
		XCTAssertEqual(sortedEmployees, expectedEmployees)
	}
	
	func testTeamAtoZSort() {
		let sortType = EmployeeListSortType.teamAtoZ
		let sortedEmployees = sortType.sort(employees: employees)
		let expectedEmployees = [jack, mat, jony, bobby]
		XCTAssertEqual(sortedEmployees, expectedEmployees)
	}
	
	func testTeamZtoASort() {
		let sortType = EmployeeListSortType.teamZtoA
		let sortedEmployees = sortType.sort(employees: employees)
		let expectedEmployees = [bobby, jony, mat, jack]
		XCTAssertEqual(sortedEmployees, expectedEmployees)
	}
	
	private func mockEmployee(name: String, team: Team) -> Employee {
		let mockUrl = URL(string: "https://www.square.com")!
		return .init(
			uuid: "",
			fullName: name,
			phoneNumber: "",
			emailAddress: "",
			biography: "",
			photoUrlSmall: mockUrl,
			photoUrlLarge: mockUrl,
			team: team,
			employeeType: .fullTime
		)
	}
}
