//
//  Store.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 11/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import Foundation

class Store<State, Action> {

	typealias Subscriber = (State) -> Void
	typealias Reducer = (State, Action) -> State

	private(set) var state: State
	private var subscribers: [Subscriber]
	private let reduce: Reducer

	init(state: State, reducers: [Reducer]) {
		self.state = state
		self.subscribers = []
		self.reduce = Store.compose(reducers: reducers)
	}

	func subscribe(_ subscriber: @escaping Subscriber) {
		subscribers.append(subscriber)
	}

	func handle(action: Action) {
		state = reduce(state, action)
		subscribers.forEach { $0(state) }
	}

}

extension Store {

	static func compose(reducers: [Reducer]) -> Reducer {
		let identity: Reducer = { state, action in return state }

		return reducers.reduce(identity) { acc, fun in
			return { state, action in
				return fun(acc(state, action), action)
			}
		}
	}

}
