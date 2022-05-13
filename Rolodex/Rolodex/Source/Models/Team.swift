//
//  Team.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-11.
//

import UIKit
import SwiftUI

enum Team: String, Decodable {
	case appointments = "Appointments"
	case cash = "Cash"
	case core = "Core"
	case hardware = "Hardware"
	case invoices = "Invoices"
	case pointOfSale = "Point of Sale"
	case pointOfSalePlatform = "Point of Sale Platform"
	case publicWebAndMarketing = "Public Web & Marketing"
	case restaurents = "Restaurants"
	case retail = "Retail"
	
	/// Provides a consistent color for each team.
	var badgeColor: UIColor {
		let color: Color
		
		switch self {
		case .appointments: color = .pink
		case .cash: color = .red
		case .core: color = .orange
		case .hardware: color = .yellow
		case .invoices: color = .green
		case .pointOfSale: color = .mint
		case .pointOfSalePlatform: color = .cyan
		case .publicWebAndMarketing: color = .blue
		case .restaurents: color = .indigo
		case .retail: color = .purple
		}
		
		return UIColor(color)
	}
}
