
import UIKit


class UserDefaults: NSObject {

    // save to user default
    class func getUserDefaultForKey( _ key : String!) -> AnyObject?{
       
        let value = Foundation.UserDefaults.standard.object(forKey: key)
        if let _ = value{
            return value! as AnyObject?
        }
        else
        {
            return value as AnyObject?
        }
    }
    
    class func saveToUserDefault( _ value: AnyObject!,key:String!){
        let defaults : Foundation.UserDefaults =   Foundation.UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    class func removeUserDefaultForKey( _ key:String)
    {
        let defaults = Foundation.UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    class func objectAlreadyExist(key: String) -> Bool {
       let defaults : Foundation.UserDefaults =   Foundation.UserDefaults.standard
        if (defaults.object(forKey: key) != nil) {
            return true
        }
        return false
    }
}
