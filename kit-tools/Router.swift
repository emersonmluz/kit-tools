//
//  Router.swift
//  kit-tools
//
//  Created by Émerson M Luz on 02/04/23.
//

import UIKit

protocol RouterProtocol {
    var navigation: UINavigationController { get }
    static var shared: Router { get }
    func showApp(coordinator: CoordinatorProtocol)
}

final class Router: RouterProtocol {
    var navigation = UINavigationController()
    static var shared = Router()
    
    func showApp(coordinator: CoordinatorProtocol) {
        coordinator.start()
    }
}
