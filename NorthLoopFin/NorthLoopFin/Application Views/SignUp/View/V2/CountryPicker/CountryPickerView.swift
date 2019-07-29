//
//  CountryPickerView.swift
//  NorthLoopFin
//
//  Created by MyMac on 27/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CountryPickerView: UIView {

    @IBOutlet weak var contentViewBottom: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableViewCountry: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    var countries: [Country] = []
    var searchCountries: [Country] = []
    var isSearchEnable: Bool = false
    weak var delegate: CountryPickerViewDelegate?
    override func draw(_ rect: CGRect) {
        
    }
    
    class func instanceFromNib() -> CountryPickerView {
        return UINib(nibName: "CountryPickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CountryPickerView
    }
    
    func setupView() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        countries = AppUtility.getCountryList()
        tableViewCountry.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "CountryCell")
        tableViewCountry.delegate = self
        tableViewCountry.dataSource = self
        tableViewCountry.reloadData()
        txtSearch.delegate = self
    }
    
    func show(view superView: UIView? = nil) {
        if (superView != nil) {
            self.translatesAutoresizingMaskIntoConstraints = false
            superView!.addSubview(self)
            self.topAnchor.constraint(equalTo: superView!.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: superView!.bottomAnchor).isActive = true
            self.leftAnchor.constraint(equalTo: superView!.leftAnchor).isActive = true
            self.rightAnchor.constraint(equalTo: superView!.rightAnchor).isActive = true
            self.setupView()
        }
        else {
            let window = UIApplication.shared.keyWindow!
            self.translatesAutoresizingMaskIntoConstraints = false
            window.addSubview(self)
            self.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
            self.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
            self.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
            self.setupView()
        }
    }
    
    func dismiss() {
        self.isSearchEnable = false
        self.txtSearch.text = ""
        self.contentViewBottom.constant = 50
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        self.removeFromSuperview()
    }
    
    @IBAction func btnOutsideAction(_ sender: Any) {
        if let del = self.delegate {
            del.countryPickerViewDidDismiss(picker: self)
        }
        self.dismiss()
    }
    
    // Keyboard functions: Used to adjust scrollView size
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        if let userInfo = notification.userInfo, let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            if self.contentViewBottom.constant == (keyboardSize.height) {
                return
            }
            
            self.contentViewBottom.constant = keyboardSize.height
            UIView.animate(withDuration: duration, animations: {
                self.layoutSubviews()
            })
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if self.contentViewBottom.constant == 50 {
            return
        }
        
        self.contentViewBottom.constant = 50
        if let userInfo = notification.userInfo, let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: duration, animations: {
                self.layoutSubviews()
            })
        }
    }
}

extension CountryPickerView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            if (updatedText.isEmpty || updatedText == "") {
                isSearchEnable = false
            }
            else {
                isSearchEnable = true
                searchCountries = countries.filter({ (objCountry: Country) -> Bool in
                    if (objCountry.name.lowercased().contains(updatedText.lowercased()) ||
                        objCountry.code.lowercased().contains(updatedText.lowercased()) ||
                        objCountry.dialCode.lowercased().contains(updatedText.lowercased())) {
                        return true
                    }
                    return false
                })
            }
            tableViewCountry.reloadData()
        }
        return true
    }
}

extension CountryPickerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchEnable ? searchCountries.count : countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        let country = isSearchEnable ? searchCountries[indexPath.row] : countries[indexPath.row]
        cell.selectionStyle = .none
        cell.lblName.text = country.name
        cell.lblcountryCode.text = self.tag == 0 ? country.dialCode : ""
        cell.imgFlag.image = UIImage(named: country.code)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let del = self.delegate {
            let country = isSearchEnable ? searchCountries[indexPath.row] : countries[indexPath.row]
            del.countryPickerView(picker: self, didSelectCountry: country)
        }
        self.dismiss()
    }
    
}
