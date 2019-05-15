import UIKit
import Swix

class TodoRouter: Router {

	var navigationController: UINavigationController

	let store: Store<TodoState, TodoAction>
	let dispatcher: Dispatcher<TodoState, TodoAction>

	init(navigationController: UINavigationController,
		 store: Store<TodoState, TodoAction>,
		 dispatcher: Dispatcher<TodoState, TodoAction>) {
		self.navigationController = navigationController
		self.store = store
		self.dispatcher = dispatcher
	}

	func start() {
		store.subscribe(onStateChange)
		pushTodosList()
	}

	private func pushTodosList() {
		let todosViewController = TodosViewController(store: store, dispatcher: dispatcher, router: self)
		navigationController.pushViewController(todosViewController, animated: true)
	}

	private func dismissNewTodo() {
		navigationController.presentedViewController?.dismiss(animated: true)
	}

	private func presentNewTodo() {
		let newTodoViewController = NewTodoViewController(store: store, dispatcher: dispatcher, router: self)
		let embeddingNavigationController = UINavigationController(rootViewController: newTodoViewController)
		navigationController
			.viewControllers
			.first
			.flatMap { $0.present(embeddingNavigationController, animated: true)}
	}

}

extension TodoRouter {
	func onStateChange(_ state: TodoState) {
		switch (state.lastRoute, state.currentRoute) {
		case (.newTodo, .todosList):
			dismissNewTodo()
		case (.todosList, .newTodo):
			presentNewTodo()
		default:
			return
		}
	}
}
