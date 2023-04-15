//
//  PomodoroCoordinator.swift
//  kit-tools
//
//  Created by Émerson M Luz on 14/04/23.
//

import UIKit

class PomodoroCoordinator: CoordinatorProtocol {
    var navigation: UINavigationController?
    var router: RouterProtocol?
    
    init(navigation: UINavigationController? = nil, router: RouterProtocol? = Router.shared) {
        self.navigation = navigation
        self.router = router
    }
    
    func start() {
        let controller = PomodoroViewController()
        navigation?.pushViewController(controller, animated: false)
    }
    
    
}
