//
//  TableViewStateTests.swift
//  RolodexTests
//
//  Created by Mat Schmid on 2022-05-12.
//

import Foundation
import XCTest
@testable import Rolodex

class TableViewStateTests: XCTestCase {
	typealias State = TableViewState<Int, MockError>
	enum MockError: Error, Equatable {
		case phonyError
	}
	
	func testNumberOfRows() {
		var state: State = .loading
		XCTAssertEqual(state.numberOfRows, 0)
		
		state = .error(.phonyError)
		XCTAssertEqual(state.numberOfRows, 0)
		
		state = .loaded([])
		XCTAssertEqual(state.numberOfRows, 0)
		
		state = .loaded([1, 2, 3])
		XCTAssertEqual(state.numberOfRows, 3)
	}
	
	func testData() {
		var state: State = .loading
		XCTAssertEqual(state.data, [])
		
		state = .error(.phonyError)
		XCTAssertEqual(state.data, [])
		
		state = .loaded([])
		XCTAssertEqual(state.data, [])
		
		state = .loaded([1, 2, 3])
		XCTAssertEqual(state.data, [1, 2, 3])
	}
}
