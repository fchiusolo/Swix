import Foundation

func newTodoReducer(_ state: TodoState, _ action: TodoAction) -> TodoState {
	switch action {
	case .addTodo(let newTodo):
		return TodoState(todos: state.todos + newTodo,
						 newTodo: Todo.initial,
						 currentRoute: state.currentRoute,
						 lastRoute: state.lastRoute)
	case .editNewTitle(let title):
		return TodoState(todos: state.todos,
						 newTodo: Todo(title: title, description: state.newTodo.description, completed: false),
						 currentRoute: state.currentRoute,
						 lastRoute: state.lastRoute)
	case .editNewDescription(let description):
		return TodoState(todos: state.todos,
						 newTodo: Todo(title: state.newTodo.title, description: description, completed: false),
						 currentRoute: state.currentRoute,
						 lastRoute: state.lastRoute)
	case .cancelAddTodo:
		return TodoState(todos: state.todos,
						 newTodo: Todo(title: "", description: "", completed: false),
						 currentRoute: state.currentRoute,
						 lastRoute: state.lastRoute)
	default:
		return state
	}
}
