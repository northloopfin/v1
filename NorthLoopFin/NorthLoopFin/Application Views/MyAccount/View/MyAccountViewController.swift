//
//  MyAccountViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 11/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()

        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        self.setNavigationBarTitle()
        self.setupRightNavigationBar()
    }
    /// Methode to set title of screen
    func setNavigationBarTitle(){
        self.navigationController?.navigationBar.setTitleFont(UIFont(name: "Calibri-Bold", size: 15)!,color: Colors.Taupe776857)
        self.navigationController?.navigationBar.topItem?.title = "My Account"
    }
    
    //Methode initialises the rightbutton for navigation
    func setupRightNavigationBar(){
        let leftBarItem = UIBarButtonItem()
        leftBarItem.style = UIBarButtonItem.Style.plain
        leftBarItem.target = self
        leftBarItem.image = UIImage(named: "Back")?.withRenderingMode(.alwaysOriginal)
        leftBarItem.action = #selector(self.goBack)
        navigationItem.leftBarButtonItem = leftBarItem
    }
    @objc func goBack(){
        self.navigationController?.popViewController(animated: false)
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
