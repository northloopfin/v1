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
    var presenter:UpgradePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        self.presenter.sendUpgradePremiumRequest(sendToAPI: true)
    }
    
    func prepareView() {
        self.setupRightNavigationBar()
        self.presenter = UpgradePresenter.init(delegate: self)
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
            cell.lblTitleHight.constant = 50
        }
        else {
            cell.lblTitleHight.constant = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.frame.size.width)
        print(collectionView.frame.size.height)
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
    }
}

extension CarouselViewComtroller:UpgradeDelegates{
    func didUpgradePremium() {
        
    }
}
