//
//  DoItCoordinator.swift
//  kit-tools
//
//  Created by Émerson M Luz on 02/04/23.
//

import UIKit

final class DoItCoordinator: CoordinatorProtocol {
    var navigation: UINavigationController?
    var router: RouterProtocol?
    
    init(navigation: UINavigationController? = nil, router: RouterProtocol? = Router.shared) {
        self.navigation = navigation
        self.router = router
    }
    
    func start() {
        let controller = DoItViewController()
        navigation?.pushViewController(controller, animated: true)
    }
}
