//
//  TableViewState.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-10.
//

import Foundation

typealias TableViewStateData = Decodable & Equatable
typealias TableViewStateError = Error & Equatable

/// Maintains the current state of a table view between loading, loaded, and error states.
enum TableViewState<T: TableViewStateData, E: TableViewStateError>: Equatable {
	case loading
	case loaded([T])
	case error(E)
	
	var numberOfRows: Int {
		guard case let .loaded(data) = self else {
			return 0
		}
		return data.count
	}
	
	var data: [T] {
		guard case let .loaded(data) = self else {
			return []
		}
		return data
	}
}
