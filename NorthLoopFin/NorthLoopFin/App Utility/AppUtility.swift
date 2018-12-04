

import Foundation

class AppUtility {
    // Method used to get key from infolist
    
    class func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
    }
    
    
    /// This function is used to return the formatted date form UTC date string
    ///
    /// - Parameters:
    ///   - dateStr: UTC date in string
    ///   - format: Required date format
    /// - Returns: Reqiuired date in string
    class func getDateFromUTCFormat(dateStr: String, format: String = "dd/MM/yyyy") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        guard let date = dateFormatter.date(from: dateStr) else { return "" }
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        return AppUtility.getFormattedDate(withFormat: format, date: date)
    }
    
    /// Format date with given format
    ///
    /// - Parameters:
    ///   - format: string date format
    ///   - date: Date to be formatted
    /// - Returns: Formatted date string
    class func getFormattedDate(withFormat format: String, date: Date)->String{
        let dateFormatter = DateFormatter()
        //Set Locale
        let enUSPOSIXLocale: Locale = Locale(identifier:"en_US_POSIX")
        dateFormatter.locale = enUSPOSIXLocale
        //Set Formatter
        dateFormatter.dateFormat = format
        //Get Formatted Date
        let dateInString = dateFormatter.string(from: date)
        return dateInString
    }
    
    class func checkIfDateFallsAfterYear2014(dateStr: String)->Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        let date1 = dateFormatter.date(from: dateStr)!
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy"
        dateFormatter2.locale = Locale(identifier:"en_US_POSIX")
        let date2 = dateFormatter2.date(from: "2014")!
        
        if date1.compare(date2) == ComparisonResult.orderedDescending{
            return true
        }
        else{
            return false
        }
    }
    
}
