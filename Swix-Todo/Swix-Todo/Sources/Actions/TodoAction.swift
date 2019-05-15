import Foundation

enum TodoAction {
	case addTodo(Todo)
	case cancelAddTodo
	case editNewTitle(String)
	case editNewDescription(String)
	case deleteTodo(Todo)
	case completeTodo(Todo)
	case changeRoute(Route)
}
