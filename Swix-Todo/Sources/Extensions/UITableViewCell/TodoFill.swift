import UIKit

extension UITableViewCell {

	func fill(with todo: Todo) -> UITableViewCell {
		if todo.completed {
			accessoryType = .checkmark
		}

		textLabel?.text = todo.title
		detailTextLabel?.text = todo.description
		return self
	}

}
