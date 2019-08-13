//
//  LostCardOptionsController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 13/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class LostCardOptionsController: BaseViewController {

    @IBOutlet weak var btnLost: UIButton!
    @IBOutlet weak var btnDamaged: UIButton!
    @IBOutlet weak var btnStolen: UIButton!
    @IBOutlet weak var btnFraud: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()

        for button in [btnLost, btnDamaged, btnStolen, btnFraud] {
            button!.centerVertically(padding: 10)
            button!.borderColor = Colors.Mercury226226226
            button!.borderWidth = 1
            button!.cornerRadius = 10
        }
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Lost Card")
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
