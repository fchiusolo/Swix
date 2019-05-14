import Foundation

public class Dispatcher<State, Action> {

	private var history = [Action]()
	private let store: Store<State, Action>

	public init(store: Store<State, Action>) {
		self.store = store
	}

	public func dispatch(action: Action) {
		history.append(action)
		store.handle(action: action)
	}

}
