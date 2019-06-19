import UIKit

class UserInformationUtility: NSObject {
    static let sharedInstance = UserInformationUtility()

    var user:User = User()
    var userattemptsIn10Min:Int = 0
    var userattepmtsIn30Min:Int = 0
    
     override init() {
        super.init()
     }
    
    func saveUser(model:User){
        self.user = model
        let userData: Data = NSKeyedArchiver.archivedData(withRootObject: self.user)
        UserDefaults.saveToUserDefault(userData as AnyObject, key: AppConstants.UserDefaultKeyForUser)
    }
    
    func getCurrentUser() -> User?
    {
        if let userData: Data = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForUser) as? Data
        {
            if let user: User = NSKeyedUnarchiver.unarchiveObject(with: userData) as? User{
                return user
            }
        }
        return nil
    }
    
    func deleteCurrentUser()
    {
        UserDefaults.removeUserDefaultForKey(AppConstants.UserDefaultKeyForUser)
        self.user = User()
    }
}
