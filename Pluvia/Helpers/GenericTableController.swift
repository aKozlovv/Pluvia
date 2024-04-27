import UIKit

class GenericCell<T>: UITableViewCell {
    
}

class BaseTableViewController<C: GenericCell<City>>: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(cell: C.self)
        tableView.rowHeight = 120
        
        setupSearchBar()
    }
    
    func setupSearchBar() {
        let searchVC = UISearchController()
        navigationItem.searchController = searchVC
    }
    
    func presentWeather(with vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
