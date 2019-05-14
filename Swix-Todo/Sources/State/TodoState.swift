import Foundation

struct TodoState {
	
	let todos: [Todo]
	let newTodo: Todo
	let currentRoute: Route
	
}

extension TodoState {
	
	static var initial: TodoState {
		return TodoState(todos: [], newTodo: Todo.initial, currentRoute: .todosList)
	}
	
}
