//
//  Fetchable.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-09.
//

import Foundation

protocol Fetchable: Decodable {
	static var endpointPath: String { get }
	static var jsonDecoder: JSONDecoder { get }
}
