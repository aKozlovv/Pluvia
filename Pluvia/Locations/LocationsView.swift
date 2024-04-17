import UIKit

final class LocationsView: UITableViewController {
    
    // MARK: - Private properties
    private var viewModel: LocationsViewModel

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
    }
    
    
    // MARK: - Init
    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    

}

