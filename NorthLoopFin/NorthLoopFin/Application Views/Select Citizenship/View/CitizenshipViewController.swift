//
//  CitizenshipViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 12/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CitizenshipViewController: BaseViewController {
    
    @IBOutlet weak var mainTitle: LabelWithLetterSpace!
    @IBOutlet weak var continueButton: CommonButton!
    @IBOutlet weak var customProgressView: ProgressView!
    @IBOutlet weak var CitizenShipTextField: UITextField!
    let countryPicker = CountryPickerView.instanceFromNib()
    let countryWithCode = AppUtility.getCountryList()
    var selectedCountry:Country!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.countryPicker.delegate = self
        self.continueButton.isEnabled=false
        // Do any additional setup after loading the view.
    }
    func prepareView(){
        self.customProgressView.progressView.setProgress(0.17*2, animated: true)
        
        self.CitizenShipTextField.inputView = UIView.init(frame: CGRect.zero)
        self.CitizenShipTextField.inputAccessoryView = UIView.init(frame: CGRect.zero)
        self.CitizenShipTextField.setRightIcon(UIImage.init(named: "chevron")!)
 
        //Set text color to view components
        self.mainTitle.textColor = Colors.MainTitleColor
        self.CitizenShipTextField.textColor = Colors.DustyGray155155155
        
        
        // Set Font to view components
        self.mainTitle.font = AppFonts.mainTitleCalibriBold25
        self.CitizenShipTextField.font = AppFonts.textBoxCalibri16
        self.continueButton.titleLabel?.font = AppFonts.btnTitleCalibri18
        
        self.CitizenShipTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.CitizenShipTextField.setLeftPaddingPoints(19)
    }
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.continueButton.isEnabled=false
        }else{
            //self.checkForMandatoryFields()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func nextClicked(_ sender: Any) {
        
    }

}
extension CitizenshipViewController:UITextFieldDelegate{

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.CitizenShipTextField
        {
            //IQKeyboardManager.shared.resignFirstResponder()
            self.countryPicker.tag = 1
            self.countryPicker.show()
            //self.citizenShipDropDown.show()
            return false
        }
        else
        {
            return true
        }
    }
}
extension CitizenshipViewController:CountryPickerViewDelegate {
    func countryPickerView(picker: CountryPickerView, didSelectCountry country: Country) {
        if self.countryPicker.tag == 0{
            //self.countryCodeTextField.text = country.dialCode
        }else{
            //self.CitizenShipTextField.text = country.name
           // self.selectedCountry = country
           // self.checkForMandatoryFields()
        }
    }
    
    func countryPickerViewDidDismiss(picker: CountryPickerView) {
        
    }
}
