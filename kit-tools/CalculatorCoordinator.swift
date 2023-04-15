//
//  CalculatorCoordinator.swift
//  kit-tools
//
//  Created by Émerson M Luz on 04/04/23.
//

import UIKit

class CalculatorCoordinator: CoordinatorProtocol {
    var navigation: UINavigationController?
    var router: RouterProtocol?
    
    init(navigation: UINavigationController? = nil, router: RouterProtocol? = Router.shared) {
        self.navigation = navigation
        self.router = router
    }
    
    func start() {
        let controller = CalculatorViewController()
        navigation?.pushViewController(controller, animated: false)
    }
}
