//
//  ImagePreviewViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 19/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ImagePreviewViewController: BaseViewController {
    @IBOutlet weak var imagePreview : UIImageView!
    @IBOutlet weak var confirmButton : UIButton!
    @IBOutlet weak var retakeButton : UIButton!
    
    var delegate: ImagePreviewDelegate!
    var index:Int=0
    var image:UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title:"Image Preview")
        if let image = self.image {
            self.imagePreview.image=image
        }
    }
    @IBAction func confirmClicked( _ sender: Any){
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func retakeClicked( _ sender: Any){
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.imagePreview.image = image
            self.delegate.imageUpdatedFor(index: self.index, image: image)
        }
    }
}
