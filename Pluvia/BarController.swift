import UIKit

final class BarController: UITabBarController {
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            generateVC(
                vc: LocationsView(viewModel: LocationsViewModel()),
                title: "Cities",
                icon: UIImage(systemName: "rectangle.grid.1x2.fill")),
            
            generateVC(
                vc: FavoritesView(
                    viewModel: FavoritesViewModel(dataManager: CititesRepository(dataManager: CoreDataManager.shared))),
                title: "Favorites",
                icon: UIImage(systemName: "rectangle.grid.1x2.fill"))
        ]
    }
    
    
    // MARK: - Private methods
    private func generateVC(vc: UIViewController, title: String, icon: UIImage?) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: vc)
        navVC.tabBarItem.title = title
        navVC.tabBarItem.image = icon
        return navVC
    }
}
