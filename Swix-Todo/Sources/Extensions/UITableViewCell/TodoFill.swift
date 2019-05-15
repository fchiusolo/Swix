import UIKit

extension UITableViewCell {

	func fill(with todo: Todo) -> UITableViewCell {
		textLabel?.text = todo.title
		detailTextLabel?.text = todo.description
		accessoryType = todo.completed ? .checkmark : .none
		return self
	}

}
