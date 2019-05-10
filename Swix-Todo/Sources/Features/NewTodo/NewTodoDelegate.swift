//
//  NewTodoDelegate.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 10/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import Foundation

protocol NewTodoDelegate: AnyObject {

	func didCancelNewTodo()

	func didAddNew(todo: Todo)

}
