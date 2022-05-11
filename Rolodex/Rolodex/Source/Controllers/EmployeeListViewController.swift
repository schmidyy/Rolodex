//
//  EmployeeListViewController.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-09.
//

import UIKit

class EmployeeListViewController: UITableViewController {
	// MARK: Properties
	typealias State = TableViewState<Employee, EmployeeApiClient.RequestError>
	
	private static var placeholderAvatar: UIImage? = {
		let config = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .title1))
		let image = UIImage(systemName: "person.circle.fill", withConfiguration: config)
		return image
	}()
	
	private var state: State = .loading {
		didSet {
			guard oldValue != state else { return }
			DispatchQueue.main.async {
				self.render()
			}
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
	
	private var emptyState: EmptyStateView?
	
	// MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Rolodex"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		tableView.register(EmployeeCell.self, forCellReuseIdentifier: "employee.cell")
		render()
	}
	
	// MARK: Loading and rendering
	private func loadEmployeeList() {
		EmployeeApiClient.fetch { [weak self] result in
			switch result {
			case .success(let root):
				self?.state = .loaded(root.employees)
			case .failure(let error):
				self?.state = .error(error)
			}
		}
	}
	
	/// Renders the screen according to the `state`.
	private func render() {
		removeSubviewsIfNeeded()
		
		switch state {
		case .loading:
			showLoadingIndicator()
			loadEmployeeList()
		case .loaded(let data):
			loadingIndicator.stopAnimating()
			
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
		emptyState = EmptyStateView(status: status) { [weak self] in
			self?.state = .loading
		}
		
		view.addSubview(emptyState!)
		NSLayoutConstraint.activate([
			emptyState!.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			emptyState!.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
		])
	}
	
	private func removeSubviewsIfNeeded() {
		if case .loaded(let data) = state, data.isEmpty == false {
			return
		}
		
		loadingIndicator.removeFromSuperview()
		emptyState?.removeFromSuperview()
	}
}

// MARK: UITableViewDelegate
extension EmployeeListViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return state.numberOfRows
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "employee.cell", for: indexPath) as? EmployeeCell else {
			return UITableViewCell()
		}
		
		let employee = state.data[indexPath.row]
		cell.configure(with: employee)
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
