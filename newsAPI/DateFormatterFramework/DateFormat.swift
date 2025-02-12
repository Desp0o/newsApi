
import Foundation

public protocol DateFormatProtocol {
    func formatDate(date: String) -> String
}

public final class DateFormat: DateFormatProtocol  {
    
    public init() { }
    
    public func formatDate(date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = inputFormatter.date(from: date) else { return String()}
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE, MMMM dd yyyy"
        
        return outputFormatter.string(from: date)
    }
}
