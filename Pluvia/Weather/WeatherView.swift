import UIKit
import Combine

final class WeatherView: UIViewController {
    
    // MARK: - Private proeprties
    private var viewModel: WeatherViewModel
    
    
    // MARK: - Private properties
    private var constraintsSpacing: CGFloat = 15
    private var subscriptions = Set<AnyCancellable>()
    
    
    // MARK: - UI Elements
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var topDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiaryLabel
        return view
    }()
    
    private lazy var errorMessage: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.isHidden = true
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var locationTitle: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var temperatureTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 120, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private lazy var weatherTitle: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var feelsLikeTitle: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiaryLabel
        return view
    }()
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: .fixedSpacedFlowLayout())
        collection.register(cell: WeatherCell.self)
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        layoutUI()
        bind()
    }
    
    
    // MARK: - Init
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Private methods
    private func bind() {
        
        viewModel.$location
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: locationTitle)
            .store(in: &subscriptions)
        
        viewModel.$temperature
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: temperatureTitle)
            .store(in: &subscriptions)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: errorMessage)
            .store(in: &subscriptions)
        
        viewModel.$hourlyWeather
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weather in
                self?.collection.reloadData()
            }
            .store(in: &subscriptions)
        
    }
    
    @objc
    private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    
    // MARK: - UI methods
    private func setupUI() {
        view.addSubviewsUsingAutoLayout(
            backButton,
            topDivider,
            locationTitle,
            weatherTitle,
            collection,
            bottomDivider,
            temperatureTitle,
            feelsLikeTitle,
            errorMessage)
        
    }
    
    private func layoutUI() {
        // On the top of view
        backButton
            .topAnchor(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: constraintsSpacing)
            .heightAnchor(equalTo: view.heightAnchor, multiplier: 0.1)
        
        topDivider
            .topAnchor(equalTo: backButton.bottomAnchor, constant: constraintsSpacing)
            .heightAnchor(equalTo: 1)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: constraintsSpacing)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: -constraintsSpacing)
        
        locationTitle
            .topAnchor(equalTo: topDivider.bottomAnchor, constant: constraintsSpacing)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: constraintsSpacing)
        
        weatherTitle
            .topAnchor(equalTo: topDivider.bottomAnchor, constant: constraintsSpacing)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: -constraintsSpacing)
        
        // On the bottom
        collection
            .heightAnchor(equalTo: view.heightAnchor, multiplier: 0.1)
            .leadingAnchor(equalTo: view.leadingAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .bottomAnchor(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        bottomDivider
            .bottomAnchor(equalTo: collection.topAnchor, constant: -constraintsSpacing)
            .leadingAnchor(equalTo: topDivider.leadingAnchor)
            .trailingAnchor(equalTo: topDivider.trailingAnchor)
            .heightAnchor(equalTo: 1)
        
        temperatureTitle
            .bottomAnchor(equalTo: bottomDivider.topAnchor, constant: -constraintsSpacing)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: constraintsSpacing)
        
        feelsLikeTitle
            .bottomAnchor(equalTo: bottomDivider.topAnchor, constant: -constraintsSpacing)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: -constraintsSpacing)
        
        errorMessage.toCenter(of: view)
    }
}


extension WeatherView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.hours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WeatherCell = collectionView.dequeue(for: indexPath)
        
        let hour = viewModel.getTime(for: indexPath)
        let hourlyWeather = viewModel.getHourlyWeather(for: indexPath)
        
        let cellVM = WeatherCellViewModel(time: hour, weather: hourlyWeather)
        cell.configure(with: cellVM)
        
        return cell
    }
}
