//
//  EmployeeListSortType.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-12.
//

import Foundation

enum EmployeeListSortType: String, Equatable {
	case nameAtoZ
	case nameZtoA
	case teamAtoZ
	case teamZtoA
	
	func sort(employees: [Employee]) -> [Employee] {
		switch self {
		case .nameAtoZ:
			return employees.sorted { e1, e2 in
				e1.fullName < e2.fullName
			}
		case .nameZtoA:
			return employees.sorted { e1, e2 in
				e1.fullName > e2.fullName
			}
		case .teamAtoZ:
			return employees.sorted { e1, e2 in
				e1.team.rawValue < e2.team.rawValue
			}
		case .teamZtoA:
			return employees.sorted { e1, e2 in
				e1.team.rawValue > e2.team.rawValue
			}
		}
	}
}
