//
//  Employee.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-09.
//

import Foundation

struct Employees: Decodable {
	let employees: [Employee]
}

struct Employee: Decodable, Equatable {
	enum EmployeeType: String, Decodable {
		case fullTime = "FULL_TIME"
		case partTyime = "PART_TIME"
		case contractor = "CONTRACTOR"
	}
	
	/// The unique identifier for the employee. Represented as a UUID.
	let uuid: String
	
	/// The full name of the employee.
	let fullName: String
	
	/// The phone number of the employee, sent as an unformatted string (eg, 5556661234).
	let phoneNumber: String
	
	/// The email address of the employee.
	let emailAddress: String
	
	/// A short, tweet-length (~300 chars) string that the employee provided to describe themselves.
	let biography: String
	
	/// The URL of the employee’s small photo. Useful for list view.
	let photoUrlSmall: URL
	
	/// The URL of the employee’s full-size photo.
	let photoUrlLarge: URL
	
	/// The team they are on, represented as a human readable string.
	let team: String
	
	/// How the employee is classified.
	let employeeType: EmployeeType
}
