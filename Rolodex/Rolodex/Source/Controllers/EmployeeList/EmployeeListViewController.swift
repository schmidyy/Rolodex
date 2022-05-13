//
//  EmployeeListViewController.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-09.
//

import UIKit

class EmployeeListViewController: UITableViewController {
	// MARK: Properties
	private typealias State = TableViewState<Employee, EmployeeApiClient.RequestError>
	
	private var state: State = .loading {
		didSet {
			guard oldValue != state else { return }
			DispatchQueue.main.async {
				self.addRefreshControlIfNeeded()
				self.render()
			}
		}
	}
	
	private var sortType: EmployeeListSortType = .teamAtoZ {
		didSet {
			render()
		}
	}
	
	private let endpoint: EmployeeApiClient.Endpoint
	
	private lazy var refresh = UIRefreshControl()
	private var emptyState: EmptyStateView?
	
	private lazy var loadingIndicator: UIActivityIndicatorView = {
		let hud = UIActivityIndicatorView()
		hud.translatesAutoresizingMaskIntoConstraints = false
		hud.style = .medium
		hud.backgroundColor = view.backgroundColor
		hud.hidesWhenStopped = true
		return hud
	}()
	
	// MARK: Lifecycle
	init(endpoint: EmployeeApiClient.Endpoint = .production) {
		self.endpoint = endpoint
		super.init(style: .plain)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Rolodex"
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "arrow.up.arrow.down"),
			menu: UIMenu(options: .singleSelection, children: menuActions)
		)
		
		tableView.register(EmployeeCell.self, forCellReuseIdentifier: "employee.cell")
		render()
	}
	
	// MARK: Loading and rendering
	private func addRefreshControlIfNeeded() {
		switch state {
		case .loaded:
			guard tableView.refreshControl == nil else { return }
			refresh.endRefreshing()
			refresh.addAction(UIAction(handler: { [weak self] _ in
				self?.state = .loading
			}), for: .valueChanged)
			tableView.refreshControl = refresh
		case .error:
			refresh.endRefreshing()
		case .loading:
			break
		}
	}
	
	private func loadEmployeeList() {
		EmployeeApiClient.fetch(endpoint: endpoint) { [weak self, weak refresh] result in
			guard let self = self else { return }
			
			DispatchQueue.main.async {
				refresh?.endRefreshing()
			}
			
			switch result {
			case .success(let root):
				self.state = .loaded(root.employees)
			case .failure(let error):
				self.state = .error(error)
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
			
			if data.isEmpty {
				showEmptyState(.noData(ressourceName: "employees"))
			}
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
		
		tableView.reloadData()
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
		
		let employee = sortType.sort(employees: state.data)[indexPath.row]
		cell.configure(with: employee)
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension EmployeeListViewController {
	var menuActions: [UIAction] {
		let nameAtoZAction = UIAction(title: "Employee name (A-Z)") { [weak self] action in
			self?.sortType = .nameAtoZ
		}
		let nameZtoAAction = UIAction(title: "Employee name (Z-A)") { [weak self] action in
			self?.sortType = .nameZtoA
		}
		let teamAtoZAction = UIAction(title: "Team name (A-Z)", state: .on) { [weak self] action in
			self?.sortType = .teamAtoZ
		}
		let teamZtoAAction = UIAction(title: "Team name (Z-A)") { [weak self] action in
			self?.sortType = .teamZtoA
		}
		
		return [nameAtoZAction, nameZtoAAction, teamAtoZAction, teamZtoAAction]
	}
}
