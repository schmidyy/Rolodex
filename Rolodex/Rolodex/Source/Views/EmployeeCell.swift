//
//  EmployeeCell.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-10.
//

import Foundation
//import SwiftUI
import UIKit
import AlamofireImage

class EmployeeCell: UITableViewCell {
	private static var placeholderAvatar: UIImage? = {
		let config = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .largeTitle))
		let image = UIImage(systemName: "person.circle.fill", withConfiguration: config)
		return image
	}()
	
	@UseAutoLayout
	private var avatarView: UIImageView = {
		let avaterView = UIImageView()
		avaterView.tintColor = .gray
		return avaterView
	}()
	
	@UseAutoLayout
	private var nameLabel: UILabel = {
		let nameLabel = UILabel()
		nameLabel.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
		nameLabel.numberOfLines = 0
		return nameLabel
	}()
	
	@UseAutoLayout
	private var teamBadge = Badge()
	
	@UseAutoLayout
	private var bioLabel: UILabel = {
		let bioLabel = UILabel()
		bioLabel.font = .preferredFont(forTextStyle: .callout, compatibleWith: .current)
		bioLabel.numberOfLines = 0
		return bioLabel
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		// Make sure things don't get squished horizontally
		avatarView.setContentCompressionResistancePriority(.required, for: .horizontal)
		nameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
		teamBadge.setContentCompressionResistancePriority(.required, for: .horizontal)
		
		let nameAndTeamStackView = UIStackView(arrangedSubviews: [nameLabel, teamBadge])
		nameAndTeamStackView.translatesAutoresizingMaskIntoConstraints = false
		nameAndTeamStackView.axis = .horizontal
		nameAndTeamStackView.alignment = .center
		nameAndTeamStackView.spacing = 6
		
		let detailsStackView = UIStackView(arrangedSubviews: [nameAndTeamStackView, bioLabel])
		detailsStackView.translatesAutoresizingMaskIntoConstraints = false
		detailsStackView.axis = .vertical
		detailsStackView.alignment = .leading
		detailsStackView.spacing = 6
		
		let mainStackView = UIStackView(arrangedSubviews: [avatarView, detailsStackView])
		mainStackView.translatesAutoresizingMaskIntoConstraints = false
		mainStackView.axis = .horizontal
		mainStackView.alignment = .top
		mainStackView.spacing = 6
		
		contentView.addSubview(mainStackView)
		NSLayoutConstraint.activate([
			avatarView.widthAnchor.constraint(equalToConstant: 42),
			avatarView.heightAnchor.constraint(equalToConstant: 42),
			mainStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
			mainStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			mainStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with employee: Employee) {
		avatarView.af.setImage(
			withURL: employee.photoUrlSmall,
			cacheKey: employee.uuid,
			placeholderImage: Self.placeholderAvatar,
			filter: CircleFilter()
		)
		
		nameLabel.text = employee.fullName
		teamBadge.configure(with: employee.team.rawValue, color: employee.team.badgeColor)
		bioLabel.text = employee.biography
	}
}
