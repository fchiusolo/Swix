//
//  UITableView+DequeueCell.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 10/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import UIKit

extension UITableView {
	func dequeueCell(withStyle style: UITableViewCell.CellStyle, usingIdentifier identifier: String) -> UITableViewCell {
		if let cell = dequeueReusableCell(withIdentifier: identifier) {
			return cell
		}
		return UITableViewCell(style: style, reuseIdentifier: identifier)
	}
}
