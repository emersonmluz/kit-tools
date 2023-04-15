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
    var navigation: UINavigationController = {
        let navigation = UINavigationController()
        let backImage = UIImage(systemName: "arrowshape.left.fill")
        navigation.navigationBar.backIndicatorImage = backImage
        navigation.navigationBar.backIndicatorTransitionMaskImage = backImage
        UIBarButtonItem.appearance().tintColor = .black
        return navigation
    }()
    
    static var shared = Router()
    
    func showApp(coordinator: CoordinatorProtocol) {
        coordinator.start()
    }
}
