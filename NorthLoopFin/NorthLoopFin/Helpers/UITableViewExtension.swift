
//Note:- This extension contains UITableViewCell Extension

import Foundation
import UIKit


extension UITableView {
    
    /**
     This method is used to get the cell Object from generic UITableViewCell Type
     
     - parameter userProfileTableView: UITableViewCell
     
     - returns :UITableViewCell
     */
    func getCell<T:UITableViewCell>(withCellType cellType:T.Type) ->T {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellType)) as! T
    }
    
    /**
     This method is used to get the cell Object from generic UITableViewCell Type
     
     - parameter userProfileTableView: UITableViewCell
     
     - returns :UITableViewCell
     */
    func getCell<T:UITableViewCell>(withCellType cellType:T.Type, atIndexPath indexPath: IndexPath) ->T {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! T
    }
    
    /**
     This method is used to get the header Object from generic UITableViewHeaderFooterView Type
     
     - parameter headerType: UITableViewHeaderFooterView
     
     - returns :UITableViewHeaderFooterView
     */
    func getHeader<T:UITableViewHeaderFooterView>(withHeaderType headerType:T.Type) ->T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: headerType)) as! T
    }
    
    /*
     This method is a generic method to register UITableViewCell
     
     - parameter : T.Type object where <T:UITableViewCell>
     
     - returns : Void
     */
    func registerTableViewCell<T:UITableViewCell>(tableViewCell ofType:T.Type) ->Void{
        self.register(UINib(nibName: String(describing: T.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: T.self))
    }

    /*
     This method is a generic method to register UITableViewHeaderFooterView
     
     - parameter : T.Type object where <T:UITableViewHeaderFooterView>
     
     - returns : Void
     */
    func registerTableViewHeaderFooterView<T:UITableViewHeaderFooterView>(tableViewHeaderFooter ofType:T.Type) ->Void{
        self.register(UINib(nibName: String(describing: T.self), bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }
}
