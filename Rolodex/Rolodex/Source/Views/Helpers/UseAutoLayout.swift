//
//  UseAutoLayout.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-11.
//

import UIKit

/// Source: https://github.com/bielikb/UseAutoLayout
@propertyWrapper
public struct UseAutoLayout<T: UIView> {
	public var wrappedValue: T {
		didSet {
			setAutoLayout()
		}
	}

	public init(wrappedValue: T) {
		self.wrappedValue = wrappedValue
		setAutoLayout()
	}

	func setAutoLayout() {
		wrappedValue.translatesAutoresizingMaskIntoConstraints = false
	}
}
