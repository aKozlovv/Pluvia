import UIKit
import Combine

final class LocationsCell: UITableViewCell {
    
    // MARK: - Private properties
    private var spacing: CGFloat = 20
    private var subscriptions = Set<AnyCancellable>()

    private var viewModel: LocationCellViewModel!
    
    
    // MARK: - UI Elements
    private lazy var countryTitle: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .secondaryLabel
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var cityTitle: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .extraLargeTitle)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .label
        return label
    }()
    
    private lazy var favIcon: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .label
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Methods
    func bind(with viewModel: LocationCellViewModel) {
        
        self.viewModel = viewModel
        
        viewModel.$cityName
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: cityTitle)
            .store(in: &subscriptions)
        
        viewModel.$countryName
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: countryTitle)
            .store(in: &subscriptions)
        
        viewModel.$isFavorite
            .receive(on: DispatchQueue.main)
            .sink {[weak self] bool in
                switch bool {
                case true:
                    self?.favIcon.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    
                case false:
                    self?.favIcon.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
            .store(in: &subscriptions)
        
    }
    
    @objc
    private func favButtonTapped() {
        viewModel.tryAddToFavorites()
    }
    
    private func setupUI() {
        contentView.addSubviewsUsingAutoLayout(favIcon, countryTitle, cityTitle)
        
        countryTitle
            .topAnchor(equalTo: contentView.topAnchor, constant: spacing)
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: spacing)
        
        cityTitle
            .topAnchor(equalTo: countryTitle.bottomAnchor, constant: spacing)
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: spacing)
        
        favIcon
            .bottomAnchor(equalTo: contentView.bottomAnchor, constant: -spacing)
            .trailingAnchor(equalTo: contentView.trailingAnchor, constant: -spacing)
            .heightAnchor(equalTo: 32)
            .widthAnchor(equalTo: 32)
    }
}
