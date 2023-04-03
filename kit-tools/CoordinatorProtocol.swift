//
//  Coordinator.swift
//  kit-tools
//
//  Created by Émerson M Luz on 02/04/23.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigation: UINavigationController? { get set }
    var router: Router? { get set }
    func start()
}
