//
//  PhotoIDViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 15/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class PhotoIDViewController: BaseViewController {

    @IBOutlet weak var mainTitleLabel: LabelWithLetterSpace!
    
    @IBOutlet weak var secondPhotoLabel: LabelWithLetterSpace!
    @IBOutlet weak var firstPhotoLabel: LabelWithLetterSpace!
    @IBOutlet weak var secondPhotoButton: CommonButton!
    @IBOutlet weak var firstPhotoButton: CommonButton!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var continueButton: RippleButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    func prepareView(){
        self.setDashBorderForButton(button: firstPhotoButton)
        self.setDashBorderForButton(button: secondPhotoButton)
        self.progressView.progressView.setProgress(0.17*2, animated: true)
        self.continueButton.isEnabled=false
        self.mainTitleLabel.textColor = Colors.MainTitleColor
        self.mainTitleLabel.font = AppFonts.mainTitleCalibriBold25
        self.continueButton.titleLabel?.font = AppFonts.btnTitleCalibri18
    }
    func setDashBorderForButton(button:UIButton)
    {
        let buttonBorder = CAShapeLayer()
        buttonBorder.strokeColor = UIColor.black.cgColor
        buttonBorder.lineDashPattern = [2, 2]
        buttonBorder.frame = button.bounds
        buttonBorder.fillColor = nil
        buttonBorder.path = UIBezierPath(rect: button.bounds).cgPath
        button.layer.addSublayer(buttonBorder)
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        ß
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
