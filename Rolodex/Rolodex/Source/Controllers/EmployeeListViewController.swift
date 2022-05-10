//
//  EmployeeListViewController.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-09.
//

import UIKit

enum TableViewState<T: Decodable & Equatable, E: Error & Equatable>: Equatable {
	case loading
	case loaded([T])
	case error(E)
	
	var numberOfRows: Int {
		guard case let .loaded(data) = self else {
			return 0
		}
		return data.count
	}
}

class EmployeeListViewController: UITableViewController {
	typealias State = TableViewState<Employee, EmployeeApiClient.RequestError>
	
	var state: State = .loading {
		didSet {
			guard oldValue != state else { return }
			render()
		}
	}
	
	private lazy var loadingIndicator: UIActivityIndicatorView = {
		let hud = UIActivityIndicatorView()
		hud.translatesAutoresizingMaskIntoConstraints = false
		hud.style = .medium
		hud.backgroundColor = view.backgroundColor
		hud.hidesWhenStopped = true
		return hud
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Rolodex"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		render()
	}
	
	private func loadEmployeeList() {
		
	}
	
	private func render() {
		view.removeAllSubviews()
		
		switch state {
		case .loading:
			showLoadingIndicator()
			loadEmployeeList()
			
		case .loaded(let data):
			guard data.isEmpty == false else {
				showEmptyState(.noData(ressourceName: "employees"))
				return
			}
			
			tableView.reloadData()
			
		case .error(let error):
			let status: EmptyStateView.Status
			switch error {
			case .missingData:
				status = .noData(ressourceName: "employees")
			case .networkError:
				status = .noConnection
			case .decodingError, .invalidUrl:
				status = .genericError
			}
			
			showEmptyState(status)
		}
	}
	
	private func showLoadingIndicator() {
		loadingIndicator.startAnimating()
		
		view.addSubview(loadingIndicator)
		NSLayoutConstraint.activate([
			loadingIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
		])
	}
	
	private func showEmptyState(_ status: EmptyStateView.Status) {
		let emptyState = EmptyStateView(status: status) { [weak self] in
			self?.state = .loading
		}
		
		view.addSubview(emptyState)
		NSLayoutConstraint.activate([
			emptyState.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			emptyState.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
		])
	}
}

