//
//  AppDelegate.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 10/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	var store: Store<TodoState, TodoAction>!
	var dispatcher: Dispatcher<TodoState, TodoAction>!
	let reducers = [
		newTodoReducer,
		todosReducer,
		routingReducer
	]

	var router: Router?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)

		store = Store<TodoState, TodoAction>(state: TodoState.initial(), reducers: reducers)
		dispatcher = Dispatcher<TodoState, TodoAction>(store: store)

		let navigationController = UINavigationController()

		router = TodoRouter(navigationController: navigationController,
							store: store,
							dispatcher: dispatcher)

		router?.start()

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		return true
	}

}
