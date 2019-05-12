//
//  Router.swift
//  Swix-Todo
//
//  Created by Francesco Chiusolo on 12/05/2019.
//  Copyright © 2019 Francesco Chiusolo. All rights reserved.
//

import UIKit

protocol Router {
	var navigationController: UINavigationController { get set }

	func start()
}
