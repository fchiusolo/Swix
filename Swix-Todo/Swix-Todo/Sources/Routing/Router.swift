import UIKit

protocol Router {
	var navigationController: UINavigationController { get set }

	func start()
}
