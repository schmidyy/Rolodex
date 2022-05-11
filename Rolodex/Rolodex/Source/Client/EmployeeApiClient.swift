//
//  EmployeeApiClient.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-09.
//

import Foundation

enum EmployeeApiClient {
	enum Endpoint: String {
		private static let base = "https://s3.amazonaws.com/sq-mobile-interview/"
		
		case production
		case malformed
		case empty
		
		var path: String {
			switch self {
			case .production:
				return "employees"
			case .malformed:
				return "employees_malformed"
			case .empty:
				return "employees_empty"
			}
		}
		
		var url: URL? {
			return URL(string: Self.base + path)?.appendingPathExtension("json")
		}
	}
	
	enum RequestError: Error, Equatable {
		case invalidUrl
		case networkError
		case missingData
		case decodingError
	}
	
	static func fetch(endpoint: Endpoint = .production, completion: @escaping (Result<Employees, RequestError>) -> Void) {
		guard let url = endpoint.url else {
			completion(.failure(.invalidUrl))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, _, possibleError in
			if let error = possibleError {
				print("Error received when fetching \(endpoint.rawValue) endpoint: \(error.localizedDescription)")
				completion(.failure(.networkError))
				return
			}
			
			guard let data = data else {
				completion(.failure(.missingData))
				return
			}
			
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			
			do {
				let employees = try decoder.decode(Employees.self, from: data)
				completion(.success(employees))
			} catch {
				print("Could not decode object from \(endpoint.rawValue) endpoint: \(error.localizedDescription)")
				completion(.failure(.decodingError))
			}
		}
		
		task.resume()
	}
}
