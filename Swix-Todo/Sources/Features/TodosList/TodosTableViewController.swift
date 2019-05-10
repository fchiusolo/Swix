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

	var todos: [Todo] = []

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
