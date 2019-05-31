

import Foundation
import ZendeskSDK
import ZendeskCoreSDK
import MFSideMenu

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
    class func getDateFromUTCFormat(dateStr: String, format: String = "dd MMMM YYYY") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        guard let date = dateFormatter.date(from: dateStr) else { return "" }
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        return AppUtility.getFormattedDate(withFormat: format, date: date)
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
    class func dateFromMilliseconds(seconds: Double)-> String{
        
        //Convert to Date
        let date = Date.init(timeIntervalSince1970: seconds/1000)//NSDate(timeIntervalSince1970: seconds)
        
        //Date formatting
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMM yyy" //HH:mm:a"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let dateString = dateFormatter.string(from: date)
        print("formatted date is =  \(dateString)")
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
                        let country : Country = Country.init(name: country["name"] as! String, code: country["code"] as! String)
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
    
    class func configureZendesk(data:ZendeskData){
        
        Zendesk.initialize(appId: "00ca8f987b37a9caeefb796b76ca62d145d851439c3b8241",
                           clientId: "mobile_sdk_client_76a94439fa38a9e41ecb",
                           zendeskUrl: "https://northloop.zendesk.com")
        let identity = Identity.createJwt(token: data.accessToken)
        Zendesk.instance?.setIdentity(identity)
        Support.initialize(withZendesk: Zendesk.instance)
    }
    
    class func moveToHomeScreen() {
        let containerViewController:MFSideMenuContainerViewController=MFSideMenuContainerViewController()
        var initialNavigationController:UINavigationController
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let sideMenu:SideMenuViewController = (storyBoard.instantiateViewController(withIdentifier: String(describing: SideMenuViewController.self)) as? SideMenuViewController)!
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        initialNavigationController = UINavigationController(rootViewController:homeViewController)
        sideMenu.delegate = homeViewController
        containerViewController.leftMenuViewController=sideMenu
        containerViewController.centerViewController=initialNavigationController
        containerViewController.setMenuWidth(UIScreen.main.bounds.size.width * 0.70, animated:true)
        containerViewController.shadow.enabled=true;
        containerViewController.panMode = MFSideMenuPanModeDefault
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = containerViewController
    }
}
