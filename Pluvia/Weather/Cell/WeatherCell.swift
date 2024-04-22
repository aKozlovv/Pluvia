import UIKit
import Combine

final class WeatherCell: UICollectionViewCell {
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    
    
    // MARK: - UI Elements
    private lazy var timeTitle: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        label.text = "now"
        return label
    }()
    
    private lazy var temperatureValue: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        label.text = "17 C"
        return label
    }()
    
    private lazy var timeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeTitle, temperatureValue])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Private methods
    private func setupUI() {
        contentView.addSubviewsUsingAutoLayout(timeStack)
        timeStack.toCenter(of: contentView)
    }
    
    
    // MARK: - Public methods
    func configure(with viewModel: WeatherCellViewModel) {
        
        viewModel.$time
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: timeTitle)
            .store(in: &subscriptions)
        
        viewModel.$weather
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: temperatureValue)
            .store(in: &subscriptions)
    }
}
