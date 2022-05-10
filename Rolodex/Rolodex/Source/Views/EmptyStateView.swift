//
//  EmptyStateView.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-10.
//

import Foundation
import UIKit

class EmptyStateView: UIView {
	// MARK: Properties
	
	enum Status {
		case noData(ressourceName: String)
		case noConnection
		case genericError
		
		var iconName: String {
			switch self {
			case .noData:
				return "person.crop.circle.badge.exclamationmark.fill"
			case .noConnection:
				return "wifi.exclamationmark"
			case .genericError:
				return "exclamationmark.icloud.fill"
			}
		}
		
		var title: String {
			switch self {
			case .noData(let ressourceName):
				return "No \(ressourceName) found"
			case .noConnection:
				return "No connection"
			case .genericError:
				return "Something went wrong"
			}
		}
	}
	
	private let status: Status
	
	typealias RetryAction = () -> Void
	var retryAction: RetryAction?
	
	// MARK: Subviews
	
	private lazy var iconView: UIImageView = {
		let scale = UIImage.SymbolConfiguration(scale: .large)
		let size = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 42.0))
		let config = scale.applying(size)
		
		let image = UIImage(systemName: status.iconName, withConfiguration: config)
		
		let iconView = UIImageView(image: image)
		iconView.translatesAutoresizingMaskIntoConstraints = false
		iconView.tintColor = .gray
		return iconView
	}()
	
	private lazy var titleLabel: UILabel = {
		let titleLabel = UILabel()
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.text = status.title
		titleLabel.font = UIFont.preferredFont(forTextStyle: .title3, compatibleWith: .current)
		return titleLabel
	}()
	
	private lazy var retryButton: UIButton = {
		var config = UIButton.Configuration.tinted()
		config.title = "Try again"
		config.buttonSize = .medium
		config.cornerStyle = .medium
		
		let action = UIAction(handler: { [weak self] _ in
			self?.retryAction?()
		})
		
		let retryButton = UIButton(configuration: config, primaryAction: action)
		retryButton.translatesAutoresizingMaskIntoConstraints = false
		
		return retryButton
	}()
	
	// MARK: Lifecycle and layout
	
	init(status: Status, retryAction: @escaping RetryAction) {
		self.status = status
		self.retryAction = retryAction
		super.init(frame: .zero)
		
		layoutViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func layoutViews() {
		translatesAutoresizingMaskIntoConstraints = false
		
		let stackView = UIStackView(arrangedSubviews: [iconView, titleLabel, retryButton])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = 20
		
		addSubview(stackView)
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}
}
