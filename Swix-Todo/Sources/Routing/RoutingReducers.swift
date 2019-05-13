//
//  RoutingReducers.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 12/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import Foundation

func routingReducer(_ state: TodoState, _ action: TodoAction) -> TodoState {
	switch action {
	case .changeRoute(let route):
		return TodoState(todos: state.todos,
						 newTodo: state.newTodo,
						 currentRoute: route)
	default:
		return state
	}
}
