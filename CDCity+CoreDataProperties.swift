import Foundation
import CoreData


extension CDCity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCity> {
        return NSFetchRequest<CDCity>(entityName: "CDCity")
    }
    
    @NSManaged public var name: String
    @NSManaged public var country: String
    @NSManaged public var long: Double
    @NSManaged public var lat: Double
    
}

extension CDCity : Identifiable {
    
    func convertToCityModel() -> City {
        return City(name: self.name, country: self.country, latitude: self.lat, longitude: self.long)
    }
}
