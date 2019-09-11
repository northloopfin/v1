//
//  vwAddAccountFooter.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 09/09/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class vwAddAccountFooter: UIView {
    @IBOutlet weak var btnAddBank: UIButton!
    @IBOutlet weak var lblAddBank: LabelWithLetterSpace!
    @IBOutlet weak var amountTextField: UITextField!
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        
        let vw = UILabel(frame:  CGRect(x: 0, y: 0, width: 40, height: amountTextField.frame.size.height))
        vw.font = amountTextField.font
        vw.text = "  $"
        vw.textAlignment = .center
        vw.textColor = amountTextField.textColor
         amountTextField.leftView = vw
        amountTextField.leftViewMode = .always
    }
}

extension vwAddAccountFooter:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        amountTextField.borderColor = Colors.PurpleColor17673149
        amountTextField.textColor = Colors.PurpleColor17673149
        if let lbl = amountTextField.leftView as? UILabel{
            lbl.textColor = Colors.PurpleColor17673149
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        amountTextField.borderColor = Colors.Alto224224224
        amountTextField.textColor = Colors.DustyGray155155155
        if let lbl = amountTextField.leftView as? UILabel{
            lbl.textColor = Colors.DustyGray155155155
        }
    }
}
