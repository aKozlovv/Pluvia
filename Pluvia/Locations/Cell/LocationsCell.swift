import UIKit
import Combine

final class LocationsCell: UITableViewCell {
    
    // MARK: - Private properties
    private var spacing: CGFloat = 20
    private var subscriptions = Set<AnyCancellable>()

    
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
        
        viewModel.$cityName
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: cityTitle)
            .store(in: &subscriptions)
        
        viewModel.$countryName
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: countryTitle)
            .store(in: &subscriptions)
    }
    
    private func setupUI() {
        contentView.addSubviewsUsingAutoLayout(countryTitle,cityTitle)
        
        countryTitle
            .topAnchor(equalTo: contentView.topAnchor, constant: spacing)
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: spacing)
        
        cityTitle
            .topAnchor(equalTo: countryTitle.bottomAnchor, constant: spacing)
            .leadingAnchor(equalTo: contentView.leadingAnchor, constant: spacing)
    }
}
