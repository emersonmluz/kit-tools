//
//  KitToolsCoordinator.swift
//  kit-tools
//
//  Created by Émerson M Luz on 02/04/23.
//

import UIKit

final class KitToolsCoordinator: CoordinatorProtocol {
    var navigation: UINavigationController?
    var router: Router?
    
    init(navigation: UINavigationController? = nil, router: Router? = Router.shared) {
        self.navigation = navigation
        self.router = router
    }
    
    func start() {
        let controller = KitToolsViewController(coordinator: self)
        navigation?.pushViewController(controller, animated: true)
    }
    
    func goToApp(coordinator: CoordinatorProtocol) {
        router?.showApp(coordinator: coordinator)
    }
}
