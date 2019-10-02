//
//  ScanIDPolicy.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 20/09/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ScanIDPolicy: UIView {

    @IBOutlet weak var vwPrivacyContent: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupView() {
        vwPrivacyContent.roundCorners(corners: [.topLeft, .topRight], radius: 20)
    }
    
    @IBAction func btnClose_pressed(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()

        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        //Disable this if you are adding constraints manually
        //or you're going to have a 'bad time'
        //self.translatesAutoresizingMaskIntoConstraints = false
        
        //Add custom constraint code here
    }

}
