//
//  HomeTabController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 08/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class HomeTabController: ESTabBarController {
    var homeViewController: HomeViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var initialNavigationController:UINavigationController

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        initialNavigationController = UINavigationController(rootViewController:homeViewController!)

        let wireDetail = storyBoard.instantiateViewController(withIdentifier: "CurrencyProtectController") as! CurrencyProtectController

        let wireList = storyBoard.instantiateViewController(withIdentifier: "WireRateController") as! WireRateController

        initialNavigationController.tabBarItem = ESTabBarItem.init(TabContentView(), title: nil, image: UIImage(named: "ic_home"), selectedImage: UIImage(named: "ic_home_selected"))
        wireList.tabBarItem = ESTabBarItem.init(TabContentView(), image: UIImage(named: "ic_expenses"), selectedImage: UIImage(named: "ic_expenses_selected"))
        wireDetail.tabBarItem = ESTabBarItem.init(TabContentView(), image: UIImage(named: "ic_currency_proj"), selectedImage: UIImage(named: "ic_currency_proj_selected"))
        self.viewControllers = [wireList, initialNavigationController,wireDetail]
        self.selectedViewController = initialNavigationController

    }
}
class TabContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconColor = Colors.TabGray182182182
        highlightIconColor = Colors.PurpleColor17673149
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



