import UIKit
import Swix

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

		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
														   target: self,
														   action: #selector(cancel))
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

		titleField.addTarget(self, action: #selector(titleFieldDidChange), for: UIControl.Event.editingChanged)
		descriptionField.addTarget(self, action: #selector(descriptionFieldDidChange), for: UIControl.Event.editingChanged)
	}

}

// MARK: - Swix
extension NewTodoViewController {

	func onStateChange(_ state: TodoState) {
	}

}

// MARK: - Actions
extension NewTodoViewController {

	@objc func cancel(_ sender: UIBarButtonItem) {
		dispatcher.dispatch(action: .cancelAddTodo)
		dispatcher.dispatch(action: .changeRoute(.todosList))
	}

	@objc func save(_ sender: UIBarButtonItem) {
		dispatcher.dispatch(action: .addTodo(store.state.newTodo))
		dispatcher.dispatch(action: .changeRoute(.todosList))
	}

}

// MARK: - TextField
extension NewTodoViewController {

	@objc func titleFieldDidChange(textField: UITextField) {
		guard let text = textField.text else { return }
		dispatcher.dispatch(action: .editNewTitle(text))
	}

	@objc func descriptionFieldDidChange(textField: UITextField) {
		guard let text = textField.text else { return }
		dispatcher.dispatch(action: .editNewDescription(text))
	}

}
