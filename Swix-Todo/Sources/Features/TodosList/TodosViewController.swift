//
//  TodosViewController.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 10/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "todo_cell_reuse_identifier"
private let segueToNewTodoIdentifier = "newTodoSegue"

class TodosViewController: UIViewController {

	var tableView: UITableView!

	private let store: Store<TodoState, TodoAction>
	private let dispatcher: Dispatcher<TodoState, TodoAction>
	private let router: Router

	init(store: Store<TodoState, TodoAction>,
		 dispatcher: Dispatcher<TodoState, TodoAction>,
		 router: Router) {
		self.store = store
		self.dispatcher = dispatcher
		self.router = router
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

// MARK: - Lifecycle
extension TodosViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		store.subscribe(onStateChange)

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
															target: self,
															action: #selector(addTodo))
		tableView = UITableView(frame: view.bounds, style: .plain)
		tableView.dataSource = self
		view.addSubview(tableView)
	}

}

// MARK: - Swix
extension TodosViewController {

	func onStateChange(_ state: TodoState) {
		tableView.reloadData()
	}

}

// MARK: - Actions
extension TodosViewController {

	@objc func addTodo() {
		dispatcher.dispatch(action: .changeRoute(.newTodo))
	}

//	private func delete(todoAt indexPath: IndexPath) {
//		todos.remove(at: indexPath.row)
//		tableView.reloadData()
//	}

}

// MARK: - Data Source
extension TodosViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return store.state.todos.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueCell(withStyle: .subtitle, usingIdentifier: cellReuseIdentifier)
		return TodoCellFactory.fill(cell: cell, withTodo: store.state.todos[indexPath.row])
	}

}

// MARK: - Table View
//extension TodosViewController {
//
//	override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//		let action = UIContextualAction(style: .normal,
//										title: todos[indexPath.row].completed ? "Not Done" : "Done",
//										handler: { _, _, completion in
//											self.complete(todoAt: indexPath)
//											completion(true)
//		})
//		action.backgroundColor = .green
//		return UISwipeActionsConfiguration(actions: [action])
//	}
//
//	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//		let action = UIContextualAction(style: .destructive,
//										title: "Delete",
//										handler: { _, _, completion in
//											self.delete(todoAt: indexPath)
//											completion(true)
//		})
//		return UISwipeActionsConfiguration(actions: [action])
//	}
//
//}
