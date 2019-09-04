//
//  OnboardingVC
//  NorthLoopFin
//
//  Created by SagarR on 26/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class OnboardingVC: BaseViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.prepareView()
    }
    
    @IBAction func signup_clicked(_ sender: UIButton) {
    }
    
    @IBAction func signIn_clicked(_ sender: UIButton) {
    }
    
    func prepareView() {
        carouselCollectionView.register(UINib(nibName: "CarouselCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCell")
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        carouselCollectionView.reloadData()
    }
}

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppConstants.OnboardingItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselCell
        let carouselItem = AppConstants.OnboardingItem.init(id: indexPath.item+1)
        cell.carouselImage.image = carouselItem?.image()
        cell.lblTitle.text = carouselItem?.title()
        cell.lblDetail.text = carouselItem?.description()
        
        if (carouselItem?.title() != nil) {
            cell.lblTitleHight.constant = indexPath.row == 3 ? 25 : 50;
        }
        else {
            cell.lblTitleHight.constant =  0
        }
        
        cell.carouselImage.contentMode = indexPath.row == 0 ? UIView.ContentMode.scaleAspectFill :UIView.ContentMode.center
        cell.imgBottom.constant = indexPath.row == 0 ? 100 : 160;
        cell.titleTopToImage.constant = indexPath.row == 0 ? 60 : 22;

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
    }
    
    @objc func btnMonthly_clicked(btn:UIButton){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ConfirmUpgradeController") as! ConfirmUpgradeController
        vc.isMonthly = btn.tag == 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
