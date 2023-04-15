//
//  WeatherCoordinator.swift
//  kit-tools
//
//  Created by Émerson M Luz on 12/04/23.
//

import UIKit

class WeatherCoordinator: CoordinatorProtocol {
    var navigation: UINavigationController?
    var router: RouterProtocol?
    
    init(navigation: UINavigationController? = nil, router: RouterProtocol? = Router.shared) {
        self.navigation = navigation
        self.router = router
    }
    
    func start() {
        let controller = WeatherViewController()
        navigation?.pushViewController(controller, animated: false)
    }
}
