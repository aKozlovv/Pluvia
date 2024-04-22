import UIKit

enum WeatherState {
    case sunny
    case windy
    case rain
    case storm
    case cloudy
    
    var gradient: CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.locations = [0.1, 0.4, 1.0]
        
        switch self {
        case .sunny:
            gradient.colors = getSunnyGradient()
            
        case .windy:
            gradient.colors = getWindyGradient()
            
        case .rain:
            gradient.colors = getRainGradient()
            
        case .storm:
            gradient.colors = getStormGradient()
            
        case .cloudy:
            gradient.colors = getCloudyGradient()
        }
        
        return gradient
    }
    
    
    // MARK: - Private methods
    private func applyGradient(with colors: [CGColor]) {
        self.gradient.colors = colors
        self.gradient.locations = [0.1, 0.4, 1.0]
    }
    
    
    // MARK: - Specific weather gradients
    private func getSunnyGradient() -> [CGColor] {
        let colorTop = UIColor(red: 253 / 255.0, green: 210 / 255.0, blue: 122 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 246 / 255.0, green: 166 / 255.0, blue: 112 / 255.0, alpha: 1.0).cgColor
        let clearColor = UIColor.white.cgColor
        return [colorTop, colorBottom, clearColor]
    }
    
    private func getWindyGradient() -> [CGColor] {
        let colorTop = UIColor(red: 184 / 255.0, green: 231 / 255.0, blue: 243 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 184 / 255.0, green: 208 / 255.0, blue: 243 / 255.0, alpha: 1.0).cgColor
        let clearColor = UIColor.white.cgColor
        return [colorTop, colorBottom, clearColor]
    }
    
    private func getRainGradient() -> [CGColor] {
        let colorTop = UIColor(red: 81 / 255.0, green: 92 / 255.0, blue: 247 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 49 / 255.0, green: 61 / 255.0, blue: 236 / 255.0, alpha: 1.0).cgColor
        let clearColor = UIColor.white.cgColor
        return [colorTop, colorBottom, clearColor]
    }
    
    private func getStormGradient() -> [CGColor] {
        let colorTop = UIColor(red: 49 / 255.0, green: 54 / 255.0, blue: 127 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 83 / 255.0, green: 89 / 255.0, blue: 178 / 255.0, alpha: 1.0).cgColor
        let clearColor = UIColor.white.cgColor
        return [colorTop, colorBottom, clearColor]
    }
    
    private func getCloudyGradient() -> [CGColor] {
        let colorTop = UIColor(red: 161 / 255.0, green: 162 / 255.0, blue: 179 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 196 / 255.0, green: 198 / 255.0, blue: 220 / 255.0, alpha: 1.0).cgColor
        let clearColor = UIColor.white.cgColor
        return [colorTop, colorBottom, clearColor]
    }
}
