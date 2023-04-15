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
        navigation?.pushViewController(controller, animated: false)
    }
}
