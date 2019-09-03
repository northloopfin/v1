
//
//  CarouselViewComtroller.swift
//  NorthLoopFin
//
//  Created by SagarR on 26/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CarouselViewComtroller: BaseViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    @IBOutlet weak var btnUpgrade: RippleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        carouselCollectionView.setContentOffset(CGPoint(x: carouselCollectionView.frame.size.width * 3, y: 0), animated: false)
    }
    
    func prepareView() {
        self.setupRightNavigationBar()
        carouselCollectionView.register(UINib(nibName: "CarouselCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCell")
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        carouselCollectionView.reloadData()
    }
}

extension CarouselViewComtroller: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppConstants.CarouselItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselCell
        let carouselItem = AppConstants.CarouselItem.init(id: indexPath.item+1)
        cell.carouselImage.image = carouselItem?.image()
        cell.lblTitle.text = carouselItem?.title()
        cell.lblDetail.text = carouselItem?.description()
        
        if (carouselItem?.title() != nil) {
            cell.lblTitleHight.constant = indexPath.row == 3 ? 25 : 50;
        }
        else {
            cell.lblTitleHight.constant =  0
        }
        
        cell.vwUpgradeHeight.constant = indexPath.row == 3 ? 110 : 0;
        cell.btnMonthly.addTarget(self, action: #selector(btnMonthly_clicked(btn:)), for: .touchUpInside)
        cell.btnAnnually.addTarget(self, action: #selector(btnMonthly_clicked(btn:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
        btnUpgrade.isHidden = self.pageControl.currentPage == 3
    }
    
    @objc func btnMonthly_clicked(btn:UIButton){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ConfirmUpgradeController") as! ConfirmUpgradeController
        vc.isMonthly = btn.tag == 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
