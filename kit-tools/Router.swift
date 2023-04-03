//
//  Router.swift
//  kit-tools
//
//  Created by Émerson M Luz on 02/04/23.
//

import UIKit

final class Router {
    var navigation = UINavigationController()
    static var shared = Router()
    
    func showApp(coordinator: CoordinatorProtocol) {
        let coordinator = coordinator
        coordinator.start()
    }
}
