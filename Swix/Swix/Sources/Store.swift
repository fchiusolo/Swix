import Foundation

public class Store<State, Action> {
	public typealias Subscriber = (State) -> Void
	public typealias Reducer = (State, Action) -> State

	private var _state: State
	private var subscribers: [Subscriber]
	private let reduce: Reducer

	public var state: State {
		return _state
	}

	public init(state: State, reducers: [Reducer]) {
		self._state = state
		self.subscribers = []
		self.reduce = Store.compose(reducers: reducers)
	}

	public func subscribe(_ subscriber: @escaping Subscriber) {
		subscribers.append(subscriber)
	}

	public func handle(action: Action) {
		_state = reduce(state, action)
		subscribers.forEach { $0(state) }
	}

}

public extension Store {

	static func compose(reducers: [Reducer]) -> Reducer {
		let identity: Reducer = { state, action in return state }

		return reducers.reduce(identity) { acc, fun in
			return { state, action in
				return fun(acc(state, action), action)
			}
		}
	}

}
