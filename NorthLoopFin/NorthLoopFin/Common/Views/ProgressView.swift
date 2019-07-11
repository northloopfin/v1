//
//  ProgressView.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 04/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var containerView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureView()
    }
    
    func configureView(){
        Bundle.main.loadNibNamed("ProgressView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame=self.bounds
        containerView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        progressView.progress = 0.0
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 4
        progressView.subviews[1].clipsToBounds = true
    }
}
