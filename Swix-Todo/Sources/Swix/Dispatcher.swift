//
//  Dispatcher.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 11/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import Foundation

class Dispatcher<State, Action> {

	private var history = [Action]()
	private let store: Store<State, Action>

	init(store: Store<State, Action>) {
		self.store = store
	}

	func dispatch(action: Action) {
		history.append(action)
		store.handle(action: action)
	}

}
