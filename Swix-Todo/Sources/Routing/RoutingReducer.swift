import Foundation

func routingReducer(_ state: TodoState, _ action: TodoAction) -> TodoState {
	switch action {
	case .changeRoute(let route):
		return TodoState(todos: state.todos,
						 newTodo: state.newTodo,
						 currentRoute: route)
	default:
		return state
	}
}
