//
//  TodosTableViewController.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 10/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "todo_cell_reuse_identifier"
private let segueToNewTodoIdentifier = "newTodoSegue"

class TodosTableViewController: UITableViewController {

	private var todos: [Todo] = []

	private func complete(todoAt indexPath: IndexPath) {
		let removedTodo = todos.remove(at: indexPath.row)
		let editedTodo = Todo(title: removedTodo.title,
							  description: removedTodo.description,
							  completed: !removedTodo.completed)
		todos.insert(editedTodo, at: indexPath.row)
		tableView.reloadData()
	}

	private func delete(todoAt indexPath: IndexPath) {
		todos.remove(at: indexPath.row)
		tableView.reloadData()
	}
}

// MARK: - Lifecycle
extension TodosTableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
															target: self,
															action: #selector(addTodo))
	}

}

// MARK: - Actions
extension TodosTableViewController {

	@objc func addTodo() {
		performSegue(withIdentifier: segueToNewTodoIdentifier, sender: nil)
	}

}

// MARK: - Data Source
extension TodosTableViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return todos.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueCell(withStyle: .subtitle, usingIdentifier: cellReuseIdentifier)
		return TodoCellFactory.fill(cell: cell, withTodo: todos[indexPath.row])
	}

}

// MARK: - Table View
extension TodosTableViewController {

	override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let action = UIContextualAction(style: .normal,
										title: todos[indexPath.row].completed ? "Not Done" : "Done",
										handler: { _, _, completion in
											self.complete(todoAt: indexPath)
											completion(true)
		})
		action.backgroundColor = .green
		return UISwipeActionsConfiguration(actions: [action])
	}

	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let action = UIContextualAction(style: .destructive,
										title: "Delete",
										handler: { _, _, completion in
											self.delete(todoAt: indexPath)
											completion(true)
		})
		return UISwipeActionsConfiguration(actions: [action])
	}

}

// MARK: - Navigation
extension TodosTableViewController {

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard
			let navigationController = segue.destination as? UINavigationController,
			let newTodoViewController = navigationController.viewControllers.first as? NewTodoViewController else {
				return
		}
		newTodoViewController.delegate = self
	}

}

// MARK: - New Todo
extension TodosTableViewController: NewTodoDelegate {

	func didCancelNewTodo() {
	}

	func didAddNew(todo: Todo) {
		todos.append(todo)
		tableView.reloadData()
	}

}
