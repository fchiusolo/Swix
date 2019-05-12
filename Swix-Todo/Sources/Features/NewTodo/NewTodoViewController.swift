//
//  NewTodoViewController.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 10/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import UIKit

class NewTodoViewController: UIViewController {
	var titleField: UITextField!
	var descriptionField: UITextField!

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
extension NewTodoViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		store.subscribe(onStateChange)

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
															target: self,
															action: #selector(save))

		let container = UIView()
		titleField = UITextField()
		titleField.placeholder = "Title"
		titleField.borderStyle = .roundedRect
		descriptionField = UITextField()
		descriptionField.placeholder = "Description"
		descriptionField.borderStyle = .roundedRect

		container.addSubview(titleField)
		container.addSubview(descriptionField)
		view.addSubview(container)
		view.backgroundColor = .white

		container.translatesAutoresizingMaskIntoConstraints = false
		container.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
		container.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
		container.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
		container.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true

		titleField.translatesAutoresizingMaskIntoConstraints = false
		titleField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16).isActive = true
		titleField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16).isActive = true
		titleField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16).isActive = true
		titleField.heightAnchor.constraint(equalToConstant: 32).isActive = true

		descriptionField.translatesAutoresizingMaskIntoConstraints = false
		descriptionField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16).isActive = true
		descriptionField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16).isActive = true
		descriptionField.topAnchor.constraint(equalTo: titleField.layoutMarginsGuide.bottomAnchor, constant: 16).isActive = true
		descriptionField.heightAnchor.constraint(equalToConstant: 32).isActive = true
	}

}

// MARK: - Swix
extension NewTodoViewController {
	func onStateChange(_ state: TodoState) {
	}
}

// MARK: - Actions
extension NewTodoViewController {

	func cancel(_ sender: UIBarButtonItem) {
		//		delegate?.didCancelNewTodo()
		//		dismiss(animated: true)
	}

	@objc func save(_ sender: UIBarButtonItem) {
		if let title = titleField.text, let description = descriptionField.text {
			let newTodo = Todo(title: title, description: description, completed: false)
			dispatcher.dispatch(action: .addTodo(newTodo))
		}
		dispatcher.dispatch(action: .changeRoute(.todosList))
	}

}
