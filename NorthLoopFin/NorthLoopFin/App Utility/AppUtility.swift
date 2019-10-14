

import Foundation
//import ZendeskSDK
//import ZendeskCoreSDK
import MFSideMenu
import SwiftyRSA

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
    class func getDateStringFromUTCFormat(dateStr: String, format: String = "dd MMMM YYYY") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        guard let date = dateFormatter.date(from: dateStr) else { return "" }
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        return AppUtility.getFormattedDate(withFormat: format, date: date)
    }

    class func getDateObjectFromUTCFormat(dateStr: String, format: String = "dd MMMM YYYY") -> Date? {        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        return dateFormatter.date(from: dateStr)
    }

    //This function return date in form 8th December 2018
    class  func getDateFromUTCFormatUsingNumberOrdinal(dateStr: String, format: String = "MMMM YYYY")->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        guard let date = dateFormatter.date(from: dateStr) else { return "" }
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        
        //We need to change only day so getting that component from Calender
        let calendar = Calendar.current
        let dateComponent = calendar.component(.day, from: date)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        let day = numberFormatter.string(from: dateComponent as NSNumber)
        dateFormatter.dateFormat = format
        return "\(day!) \(dateFormatter.string(from: date))"
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
    
    
    /// Date from miliseconds
    ///
    /// - Parameter seconds: miliseconds
    class func dateFromMilliseconds(seconds: Double)-> Date{
        
        //Convert to Date
        let date = Date.init(timeIntervalSince1970: seconds/1000)//NSDate(timeIntervalSince1970: seconds)

        return date
    }
    
    class func dateStringFromMillisecondsWithoutTime(seconds: Double)-> String{
        
        //Convert to Date
        let date = Date.init(timeIntervalSince1970: seconds/1000)//NSDate(timeIntervalSince1970: seconds)
        
        return getDateStringWithoutTime(date: date)
    }
    
    class func getDateStringWithoutTime(date: Date) -> String{
        //Date formatting
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMM yyy" //HH:mm:a"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }

    class func getDashedDateStringWithoutTime(date: Date) -> String{
        //Date formatting
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyy" //HH:mm:a"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }

    class func getFormattedDateFullString(date: Date)->String{
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let dayOfMonth = calendar.component(.day, from: date)
        
        let daySub = AppUtility.daySuffix(date: date)
        
        //Date formatting
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyy" //HH:mm:a"
        
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        var dateString = dateFormatter.string(from: date)
        let pre = (dayOfMonth<10 ? "0" : "")
        //print("formatted date is =  \(dateString)")
        let range:Range<String.Index>  = dateString.range(of: "\(pre)\(dayOfMonth)")!
        let index: Int = dateString.distance(from: dateString.startIndex, to: range.lowerBound) + 2
        
        dateString.insert(daySub.first!, at: dateString.index(dateString.startIndex, offsetBy: index))
        dateString.insert(daySub.last!, at: dateString.index(dateString.startIndex, offsetBy: index+1))
        dateString.insert(",", at: dateString.index(dateString.startIndex, offsetBy: index+2))
        
        return dateString
    }
    
    class func getDateFromString(dateString:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMM yyy" //HH:mm:a"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let date = dateFormatter.date(from: dateString)
        //print("formatted date is =  \(dateString)")
        return date!
    }
    
    class func daySuffix(date: Date) -> String {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let dayOfMonth = calendar.component(.day, from: date)
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }

    class func datefromStringUsingCalender(date:String)->Date{
        let calendar = Calendar.current
        var dateComponents: DateComponents? = calendar.dateComponents([.hour, .minute, .second], from: Date())
        
        let separatedDate = date.components(separatedBy: "/")
        dateComponents?.day = Int(separatedDate[0])
        dateComponents?.month = Int(separatedDate[1])
        dateComponents?.year = Int(separatedDate[2])
        
        let date: Date? = calendar.date(from: dateComponents!)
        return date!
    }
    
    class func timeStringWithDay(date: Date)-> String{
         var dateString = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        dateString = formatter.string(from: date)
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        dateString =  dateString + " " + weekdays[weekDay-1]
        
        return dateString
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
    
    class func getStatesArray()->[String]{
        var statesArr:[String]=[]
        statesArr.append(contentsOf: [AppConstants.States.Alabama.rawValue,AppConstants.States.Alaska.rawValue,AppConstants.States.Arizona.rawValue,AppConstants.States.Arkansas.rawValue,AppConstants.States.California.rawValue,AppConstants.States.Colorado.rawValue,AppConstants.States.Connecticut.rawValue,AppConstants.States.Delaware.rawValue,AppConstants.States.Georgia.rawValue,AppConstants.States.Hawaii.rawValue,AppConstants.States.Idaho.rawValue,AppConstants.States.Illinois.rawValue,AppConstants.States.Indiana.rawValue,AppConstants.States.Iowa.rawValue,AppConstants.States.Kansas.rawValue,AppConstants.States.Kentucky.rawValue,AppConstants.States.Louisiana.rawValue,AppConstants.States.Maine.rawValue,AppConstants.States.Maryland.rawValue,AppConstants.States.Massachusetts.rawValue,AppConstants.States.Michigan.rawValue,AppConstants.States.Minnesota.rawValue,AppConstants.States.Mississippi.rawValue,AppConstants.States.Missouri.rawValue,AppConstants.States.Montana.rawValue,AppConstants.States.Nebraska.rawValue,AppConstants.States.Nevada.rawValue,AppConstants.States.NewHampshire.rawValue,AppConstants.States.NewJersey.rawValue,AppConstants.States.NewMexico.rawValue,AppConstants.States.NewYork.rawValue,AppConstants.States.NorthCarolina.rawValue,AppConstants.States.NorthDakota.rawValue,AppConstants.States.Ohio.rawValue,AppConstants.States.Oklahoma.rawValue,AppConstants.States.Pennsylvania.rawValue,AppConstants.States.NewMexico.rawValue,AppConstants.States.RhodeIsland.rawValue,AppConstants.States.SouthCarolina.rawValue,AppConstants.States.SouthDakota.rawValue,AppConstants.States.WestVirginia.rawValue,AppConstants.States.Texas.rawValue,AppConstants.States.Utah.rawValue,AppConstants.States.Vermont.rawValue,AppConstants.States.Virginia.rawValue,AppConstants.States.Washington.rawValue,AppConstants.States.Wisconsin.rawValue,AppConstants.States.Wyoming.rawValue,AppConstants.States.AmericanSamoa.rawValue,AppConstants.States.DistrictofColumbia.rawValue,AppConstants.States.FederatedStatesofMicronesia.rawValue,AppConstants.States.Guam.rawValue,AppConstants.States.MarshallIslands.rawValue,AppConstants.States.NorthernMarianaIslands.rawValue,AppConstants.States.AmericanSamoa.rawValue,AppConstants.States.Palau.rawValue,AppConstants.States.PuertoRico.rawValue,AppConstants.States.VirginIslands.rawValue])
        return statesArr
    }
    
    class func getCountryList()->[Country]{
        var countryList:[Country]=[]
        if let path = Bundle.main.path(forResource: "country", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let countries = jsonResult["countries"] as? [NSDictionary] {
                    for country: NSDictionary in countries {
                        //let country : Country = Country.init(name: country["name"] as! String, code: country["alpha2Code"] as! String), dial
                        let country: Country = Country.init(name: country["name"] as! String, code: country["code"] as! String, dialCode: country["dial_code"] as! String)
                        countryList.append(country)
                    }
                }
            } catch {
                // handle error
            }
        }
        return countryList
    }
    class func getCountriesOnly()->[String]{
        var arr:[String]=[]
        let countriesArr = self.getCountryList()
        for country in countriesArr{
            arr.append(country.name)
        }
        return arr
    }
    
    class func getCountryInitialOnly()->[String]{
        var arr:[String]=[]
        let countriesArr = self.getCountryList()
        for country in countriesArr{
            arr.append(country.code)
        }
        
        let sortedArray = arr.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }

        return sortedArray
    }
    
    class func getCountryCodeOnly()->[String]{
        var arr:[String]=[]
        let countriesArr = self.getCountryList()
        for country in countriesArr{
            arr.append(country.dialCode)
        }
        return arr
    }

    class func getCountryOfInitial(initial:String)->String{
        let countriesArr = self.getCountryList()
        for country in countriesArr{
            if country.code == initial{
                return country.dialCode
            }
        }
        return ""
    }
    
    class func getMerchantCategoryIconName(category:String)->String {
        let dic:Dictionary = ["ach":"Transfer.png","atm":"deposit.png","cash":"withdrawal.png","interchange":"POS.png","pos":"POS.png","wire":"Transfer.png"]
        for cat in dic.keys {
            if category.lowercased().contains(cat){
                return dic[cat]!
            }
        }
        return ""
    }

    class func greetingAccToTime()->String{
        let hour = Calendar.current.component(.hour, from: Date())
        var greeting = ""
        
        switch hour {
        case 6..<12 : greeting = "Good Morning, "//print(NSLocalizedString("Morning", comment: "Morning"))
        case 12 : greeting = "Good Afternoon, "//print(NSLocalizedString("Noon", comment: "Noon"))
        case 13..<17 : greeting = "Good Afternoon, "//print(NSLocalizedString("Afternoon", comment: "Afternoon"))
        case 17..<24 : greeting = "Good Evening, "//print(NSLocalizedString("Evening", comment: "Evening"))
        default: greeting = "Good Evening, " //print(NSLocalizedString("Night", comment: "Night"))
        }
        return greeting
    }
    
    class func configureZendesk(data:ZendeskData){
        
//        Zendesk.initialize(appId: "00ca8f987b37a9caeefb796b76ca62d145d851439c3b8241",
//                           clientId: "mobile_sdk_client_76a94439fa38a9e41ecb",
//                           zendeskUrl: "https://northloop.zendesk.com")
//        let identity = Identity.createJwt(token: data.accessToken)
//        Zendesk.instance?.setIdentity(identity)
//        Support.initialize(withZendesk: Zendesk.instance)
    }
    
    class func moveToHomeScreen() {
        let containerViewController:MFSideMenuContainerViewController=MFSideMenuContainerViewController()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let sideMenu:SideMenuViewController = (storyBoard.instantiateViewController(withIdentifier: String(describing: SideMenuViewController.self)) as? SideMenuViewController)!
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let tabBarController = storyBoard.instantiateViewController(withIdentifier: "HomeTabController") as! HomeTabController
        tabBarController.homeViewController = homeViewController
        containerViewController.leftMenuViewController=sideMenu
        containerViewController.centerViewController=tabBarController
        containerViewController.setMenuWidth(UIScreen.main.bounds.size.width * 0.70, animated:true)
        containerViewController.shadow.enabled=true;
        containerViewController.panMode = MFSideMenuPanModeNone
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = containerViewController
    }
    
    class func moveToWelcome(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        //self.navigationController?.pushViewController(transactionDetailController, animated: false)
        var initialNavigationController1:UINavigationController
        
        initialNavigationController1 = UINavigationController(rootViewController:vc)
        initialNavigationController1.navigationBar.makeTransparent()
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = initialNavigationController1
        //self.window?.rootViewController = initialNavigationController1
        //self.window?.makeKeyAndVisible()
        //self.navigationController.rootvi
    }
    
    class func encryptString(input:String)->String{
        let publicKeyString:String = """
-----BEGIN RSA PUBLIC KEY-----
MEgCQQCKWGgLK1s7Zpav57A9y5W44WnP2y6M4lJR/WdarSJoH5j8XjT+kYZwBQgu
DALKudDM5tDg1HkQcwjIK1O5iZTnAgMBAAE=
-----END RSA PUBLIC KEY-----
"""
        var base64String = ""
        
        do {
            let publicKey = try PublicKey(pemEncoded: publicKeyString)
            let clear = try ClearMessage(string: input, using: .utf8)
            let encrypted = try clear.encrypted(with: publicKey, padding: .PKCS1)
            base64String = encrypted.base64String
        }catch{
            print(error)
        }
        return base64String
    }
}
