import UIKit

class UserInformationUtility: NSObject {
    
    
    static let sharedInstance = UserInformationUtility()

    var isLoggedIn:Bool = false
    
     override init() {
        super.init()
     }
    
    func saveUser(islogged:Bool){
        self.isLoggedIn=islogged
        UserDefaults.saveToUserDefault(self.isLoggedIn as AnyObject, key: AppConstants.UserDefaultKeyForUser)
    }
    
    func getUser()->Bool{
        return (UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForUser) as? Bool)!
    }
}
