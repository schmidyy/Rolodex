//
//  Views+Extensions.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-10.
//

import UIKit

extension UIView {
	func removeAllSubviews() {
		subviews.forEach { $0.removeFromSuperview() }
	}
}
