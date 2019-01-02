//
//  AllDoneViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class AllDoneViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
    }
    func setupRightNavigationBar(){
        let leftBarItem = UIBarButtonItem()
        leftBarItem.style = UIBarButtonItem.Style.plain
        leftBarItem.target = self
        leftBarItem.image = UIImage(named: "Back")?.withRenderingMode(.alwaysOriginal)
        leftBarItem.action = #selector(self.goBack)
        navigationItem.leftBarButtonItem = leftBarItem
    }
    //Method to go back to previous screen
    @objc func goBack(){
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func doneClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
}
