//
//  Dispatcher.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 11/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import Foundation

class Dispatcher<Action> {

	private var history = [Action]()
	private let store = Store<TodoState, TodoAction>(state: TodoState(), reducers: [])

	func dispatch(action: Action) {
		history.append(action)
	}

}
