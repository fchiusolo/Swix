//
//  TodoActions.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 11/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import Foundation

enum TodoAction {
	case addTodo(Todo)
	case deleteTodo(Todo)
	case completeTodo(Todo)
	case changeRoute(Route)
}
