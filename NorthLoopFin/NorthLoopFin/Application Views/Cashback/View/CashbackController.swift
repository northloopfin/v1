
//
//  CashbackController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 13/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
class CashbackController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        
    }
    
    func prepareView(){
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Cashback")
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
