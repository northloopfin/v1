//
//  PhoneNumberController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 23/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class PhoneNumberController: BaseViewController {

    @IBOutlet weak var phoneNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var countryCodeTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var nextBtn: RippleButton!
    @IBOutlet weak var customProgressView: ProgressView!
    
    let countryPicker = CountryPickerView.instanceFromNib()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.prepareView()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        self.countryPicker.delegate = self

        self.customProgressView.progressView.setProgress(0.17*2, animated: true)
     }
    
    @IBAction func btnNext_pressed(_ sender: UIButton) {
    }
}

extension PhoneNumberController:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.countryCodeTextField{
            //self.countryCodeDropDown.show()
            self.countryPicker.tag = 0
            self.countryPicker.show()
            return false
        }
        else
        {
            return true
        }
    }
}

extension PhoneNumberController:CountryPickerViewDelegate {
    func countryPickerView(picker: CountryPickerView, didSelectCountry country: Country) {
        if self.countryPicker.tag == 0{
            self.countryCodeTextField.text = " " + country.dialCode
            
            let leftView = UIView()
            leftView.frame = CGRect(x: 0, y: 0, width: 24, height: self.countryCodeTextField.frame.size.height)

            let vw = UIImageView(image: UIImage(named: country.code))
            vw.frame = CGRect(x: 0, y: 25, width: 24, height: 21)
            vw.contentMode = .scaleAspectFit
            leftView.addSubview(vw)

            countryCodeTextField.leftView = leftView
            countryCodeTextField.leftViewMode = .always
        }
    }
    
    func countryPickerViewDidDismiss(picker: CountryPickerView) {
        
    }
}
