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
        
        var initialHomeNavigationController:UINavigationController
        var initialExpenseNavigationController:UINavigationController
//        var initialCashbackNavigationController:UINavigationController

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        initialHomeNavigationController = UINavigationController(rootViewController:homeViewController!)

//        let cashbackDetail = storyBoard.instantiateViewController(withIdentifier: "CashbackController")
//        initialCashbackNavigationController = UINavigationController(rootViewController:cashbackDetail)

        let analysisController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "AnalysisViewController") as! AnalysisViewController
        initialExpenseNavigationController = UINavigationController(rootViewController:analysisController)
 
        initialHomeNavigationController.tabBarItem = ESTabBarItem.init(TabContentView(), title: nil, image: UIImage(named: "ic_home"), selectedImage: UIImage(named: "ic_home_selected"))
        initialExpenseNavigationController.tabBarItem = ESTabBarItem.init(TabContentView(), image: UIImage(named: "ic_expenses"), selectedImage: UIImage(named: "ic_expenses_selected"))
//        initialCashbackNavigationController.tabBarItem = ESTabBarItem.init(TabContentView(), image: UIImage(named: "ic_cashback_tab"), selectedImage: UIImage(named: "ic_cashback_tab_selected"))
        self.viewControllers = [initialExpenseNavigationController, initialHomeNavigationController]
        self.selectedViewController = initialHomeNavigationController
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



