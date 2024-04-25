import UIKit
import Combine

final class FavoritesView: UITableViewController {
    
    // MARK: - Private properties
    private var viewModel: FavoritesViewModel
    private lazy var subscriptions = Set<AnyCancellable>()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTable()
        setupSearchBar()
        setupBindings()
    }
    
    
    // MARK: - Init
    init(viewModel: FavoritesViewModel) {
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
        
        viewModel.$filtredData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    private func setupSearchBar() {
        let searchVC = UISearchController()
        navigationItem.searchController = searchVC
    }
    
    private func setupTable() {
        tableView.rowHeight = 120
        tableView.register(cell: LocationsCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    // MARK: - Navigation
    private func presentWeather(with vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    // MARK: - Overrides
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = viewModel.filtredData[indexPath.row]
        let vm = WeatherViewModel(city: city)
        let vc = WeatherView(viewModel: vm)
        
        presentWeather(with: vc)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filtredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationsCell = tableView.dequeue(for: indexPath)
        
        let city = viewModel.filtredData[indexPath.row]
        let vm = LocationCellViewModel(city: city)
        cell.bind(with: vm)
        
        return cell
    }
}
