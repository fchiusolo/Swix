import Foundation

struct Todo {
	let title: String
	let description: String
	let completed: Bool
}

extension Todo {

	static var initial: Todo {
		return Todo(title: "", description: "", completed: false)
	}

}
