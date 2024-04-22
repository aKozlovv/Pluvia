import Combine

final class LocationCellViewModel {
 
    // MARK: - Properties
    private var city: City
    @Published var cityName: String!
    @Published var countryName: String!
    
    
    // MARK: - Init
    init(city: City) {
        self.city = city
        self.cityName = city.name
        self.countryName = city.country
    }
}
