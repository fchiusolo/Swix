//
//  TodoReducers.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 12/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import Foundation

func addTodo(_ state: TodoState, _ action: TodoAction) -> TodoState {
	switch action {
	case .addTodo(let newTodo):
		let newTodos = concat(todos: state.todos, with: newTodo)
		return TodoState(todos: newTodos,
						 currentRoute: state.currentRoute)
	default:
		return state
	}
}

private func concat(todos: [Todo], with todo: Todo) -> [Todo] {
	var newTodos = [Todo]()
	for todo in todos {
		newTodos.append(todo)
	}
	newTodos.append(todo)
	return newTodos
}
