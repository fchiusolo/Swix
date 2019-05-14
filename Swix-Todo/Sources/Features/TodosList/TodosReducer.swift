import Foundation

func todosReducer(_ state: TodoState, _ action: TodoAction) -> TodoState {
	switch action {
	case .completeTodo(let todo):
		guard let index = state.todos.firstIndex(where: { $0.title == todo.title }) else {
			return state
		}
		let oldTodo = state.todos[index]
		var newTodos = state.todos
		newTodos.remove(at: index)
		newTodos.insert(Todo(title: oldTodo.title, description: oldTodo.title.description, completed: true),
						at: index)
		return TodoState(todos: newTodos,
						 newTodo: state.newTodo,
						 currentRoute: state.currentRoute)
	case .deleteTodo(let todo):
		guard let index = state.todos.firstIndex(where: { $0.title == todo.title }) else {
			return state
		}
		var newTodos = state.todos
		newTodos.remove(at: index)
		return TodoState(todos: newTodos,
						 newTodo: state.newTodo,
						 currentRoute: state.currentRoute)
	default:
		return state
	}
}

private func concat(todos: [Todo], with todo: Todo) -> [Todo] {
	var newTodos = [Todo]()
	for todo in todos {
		newTodos.append(todo)
	}
	newTodos.append(todo)
	return newTodos
}
