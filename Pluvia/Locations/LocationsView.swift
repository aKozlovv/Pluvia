import UIKit
import Combine

final class LocationsView: UITableViewController {
    
    // MARK: - Private properties
    private var viewModel: LocationsViewModel
    private lazy var subscriptions = Set<AnyCancellable>()

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTable()
        setupBindings()
    }
    
    
    // MARK: - Init
    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Private methods
    private func setupBindings() {
        viewModel.$cities
            .receive(on: DispatchQueue.main)
            .sink { [weak self] city in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    private func setupTable() {
        tableView.rowHeight = 120
        tableView.register(cell: UITableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
    // MARK: - Overrides
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

