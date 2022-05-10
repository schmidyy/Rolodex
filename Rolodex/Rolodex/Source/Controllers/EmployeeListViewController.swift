//
//  EmployeeListViewController.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-09.
//

import UIKit

class EmployeeListViewController: UITableViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Rolodex"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		EmployeeApiClient.fetch { result in
			print(result)
		}
	}
}

