//
//  GoalsViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 11/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class GoalsViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var addButton: UIButton!
   // var collectionViewLayout: CustomImageFlowLayout!

    @IBAction func addButtonClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let addGoalViewController = storyBoard.instantiateViewController(withIdentifier: "v") as! AddGoalViewController
        self.navigationController?.pushViewController(addGoalViewController, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collectionView.setCollectionViewLayout(layout, animated: true)
        self.prepareView()
        self.configureCollectionView()
        self.collectionView.reloadData()
    }
    
    /// Will Prepare view look wise
    func prepareView(){
        self.addShadowToView()
        self.setNavigationBarTitle(title: "Goals")
        self.setupRightNavigationBar()
    }
    
    /// Will add shadow to bottom View
    func addShadowToView(){
        //set shadow to container view
        var shadowOffst = CGSize.init(width: 0, height: 2)
        var shadowOpacity = 0.08
        var shadowRadius = 30
        var shadowColor = UIColor.init(red: 0, green: 0, blue: 0)
        self.bottomView.layer.addShadowAndRoundedCorners(roundedCorner: 12.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
        shadowOffst = CGSize.init(width: 0, height: 17)
        shadowOpacity = 0.09
        shadowRadius = 20
        shadowColor = UIColor.init(red: 0, green: 0, blue: 0)
        self.addButton.layer.addShadowAndRoundedCorners(roundedCorner: 35.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }
}

extension GoalsViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    /// Will configure collection View
    func configureCollectionView(){
        self.collectionView.dataSource=self
        self.collectionView.delegate=self
        //collectionViewLayout = CustomImageFlowLayout()
       // collectionView.collectionViewLayout = collectionViewLayout
        
        collectionView.register(UINib.init(nibName: "GoalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GoalCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoalCollectionViewCell", for: indexPath) as! GoalCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:widthPerItem+30)
    }
}
