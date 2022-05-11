//
//  Badge.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-11.
//

import UIKit

class Badge: UIView {
	private enum Spacing {
		static let vertical: CGFloat = 2
		static let horizontal: CGFloat = 4
		static let minimumWidth: CGFloat = 40
	}
	
	@UseAutoLayout
	private var label: UILabel = {
		let label = UILabel()
		label.font = .preferredFont(forTextStyle: .caption1, compatibleWith: .current)
		label.textAlignment = .center
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layer.borderWidth = 1
		layer.cornerRadius = 6
		layer.masksToBounds = true
		
		addSubview(label)
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Self.Spacing.horizontal),
			label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Self.Spacing.horizontal),
			label.topAnchor.constraint(equalTo: topAnchor, constant: Self.Spacing.vertical),
			label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Self.Spacing.vertical),
			widthAnchor.constraint(greaterThanOrEqualToConstant: Self.Spacing.minimumWidth)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with text: String, color: UIColor) {
		label.text = text
		backgroundColor = color.withAlphaComponent(0.3)
		layer.borderColor = color.cgColor
	}
}
