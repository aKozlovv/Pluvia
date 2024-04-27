import UIKit
import Combine

final class LocationsView: BaseTableViewController<LocationsCell> {
    
    // MARK: - Private properties
    private var viewModel: LocationsViewModel
    private lazy var subscriptions = Set<AnyCancellable>()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
        
        guard let textField = navigationItem.searchController?.searchBar.searchTextField.textPublisher()
        else { return }
        
        viewModel
            .bind(field: textField)
        
        viewModel.$cities
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    
    // MARK: - Overrides
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let city = viewModel.city(at: indexPath)
        let weatherVM = WeatherViewModel(city: city)
        let weatherVC = WeatherView(viewModel: weatherVM)
        
        presentWeather(with: weatherVC)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationsCell = tableView.dequeue(for: indexPath)
        
        let city = viewModel.city(at: indexPath)
        let cellVM = LocationCellViewModel(city: city)
        cell.bind(with: cellVM)
        
        return cell
    }
}


