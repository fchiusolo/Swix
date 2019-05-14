import UIKit

extension UITableView {

	func dequeueCell(withStyle style: UITableViewCell.CellStyle, usingIdentifier identifier: String) -> UITableViewCell {
		if let cell = dequeueReusableCell(withIdentifier: identifier) {
			return cell
		}
		return UITableViewCell(style: style, reuseIdentifier: identifier)
	}

}
