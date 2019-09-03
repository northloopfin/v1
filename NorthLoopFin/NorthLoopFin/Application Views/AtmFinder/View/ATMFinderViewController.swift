//
//  ATMFinderViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ATMFinderViewController: BaseViewController {
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var searchBtn: CommonButton!
    @IBOutlet weak var inputZipLabel: LabelWithLetterSpace!
    @IBOutlet weak var atmTableView: UITableView!
    var presenter:ATMFinderPresenter!

    var dataSource: [ATM] = [] {
        didSet {
            self.atmTableView.reloadData()
        }
    }
    @IBAction func sendLinkBtnClicked(_ sender: Any) {
        // call API to find ATM based on current location
        //self.getATMsWithZip()
        self.zipTextField.text=""
        LocationService.sharedInstance.delegate = self
        LocationService.sharedInstance.startUpdatingLocation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "ATM Finder")
        self.prepareView()
        self.updateTextFieldUI()
        self.configureTableView()
        self.presenter = ATMFinderPresenter.init(delegate: self)
        self.getCurrentLocationAndCallAPI()
    }
    
    //Get current location of user and call ATM finder api
    func getCurrentLocationAndCallAPI(){
        LocationService.sharedInstance.delegate = self
        LocationService.sharedInstance.startUpdatingLocation()
    }
    
    func getATMs(lat: String, lon: String){
      // self.presenter.sendATMFetch(lat: "37.789593", long: "-122.401054", zip: "")
        self.presenter.sendATMFetch(lat: lat, long: lon, zip: "")
    }
    
    func getATMsWithZip(){
        self.presenter.sendATMFetch(lat: "", long: "", zip: self.zipTextField.text!)
    }
    
    /// Prepare view by setting color and fonts to view components
    func prepareView(){
        //Set text color to view components
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.zipTextField.textColor = Colors.DustyGray155155155
        self.inputZipLabel.textColor = Colors.NeonCarrot25414966
        
        // Set Font to view components
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.zipTextField.font = AppFonts.textBoxCalibri16
        self.searchBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
        self.inputZipLabel.font = AppFonts.calibriBold15
        
        //Visual effect of btn tap
        self.searchBtn.showsTouchWhenHighlighted=true
    }
    
    func updateTextFieldUI(){
        self.zipTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.zipTextField.applyAttributesWithValues(placeholderText: "Enter ZIP Code*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.zipTextField.setLeftPaddingPoints(19)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            
        }
    }
    
    
}

extension ATMFinderViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (!(self.zipTextField.text?.isEmpty)!)
        {
            if Validations.isValidZip(value: self.zipTextField.text!){
                self.getATMsWithZip()
            }else{
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.ZIP_NOT_VALID.rawValue)
            }
        }
    }
}

extension ATMFinderViewController:UITableViewDelegate,UITableViewDataSource {
    
    func configureTableView() {
        self.atmTableView.rowHeight = 62;
        self.atmTableView.delegate = self
        self.atmTableView.dataSource = self
        self.atmTableView.registerTableViewCell(tableViewCell: ATMTableViewCell.self)
        self.atmTableView.registerTableViewCell(tableViewCell: ATMFirstTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ATMFirstTableViewCell") as! ATMFirstTableViewCell
            let backgroundView = UIView()
            backgroundView.backgroundColor = Colors.Cameo213186154
            cell.selectedBackgroundView = backgroundView
            cell.bindData(count: String(self.dataSource.count))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ATMTableViewCell") as! ATMTableViewCell
            let backgroundView = UIView()
            backgroundView.backgroundColor = Colors.Cameo213186154
            cell.selectedBackgroundView = backgroundView
            cell.bindData(data: self.dataSource[indexPath.row-1])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 121.0
        if indexPath.row == 0 {
            height = 44.0
        }
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.dataSource.count == 0 {
            return
        }
        logEventsHelper.logEventWithName(name: "Help", andProperties: ["Event": "ATM Map"])
        let selectedAtm = self.dataSource[indexPath.row + 1]
        let addressString = "\(selectedAtm.atmLocation.address.street)"
        
        let coordinate = CLLocationCoordinate2D(latitude: selectedAtm.atmLocation.coordinates.latitude, longitude: selectedAtm.atmLocation.coordinates.longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = selectedAtm.atmLocation.locationDescription
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDefault])
    }
    
    // will remove this comment once client confirm 
//    func openGoogleDirectionMap(_ destinationLat: String, _ destinationLng: String) {
//
//        //let LocationManager = CLLocationManager()
//
//        if let myLat = LocationService.sharedInstance.currentLocation?.coordinate.latitude, let myLng = LocationService.sharedInstance.currentLocation?.coordinate.longitude {
//
//            if let tempURL = URL(string: "comgooglemaps://?saddr=&daddr=\(destinationLat),\(destinationLng)&directionsmode=driving") {
//
//                UIApplication.shared.open(tempURL, options: [:], completionHandler: { (isSuccess) in
//
//                    if !isSuccess {
//
//                        if UIApplication.shared.canOpenURL(URL(string: "https://www.google.co.th/maps/dir///")!) {
//
//                            UIApplication.shared.open(URL(string: "https://www.google.co.th/maps/dir/\(myLat),\(myLng)/\(destinationLat),\(destinationLng)/")!, options: [:], completionHandler: nil)
//
//                        } else {
//
//                            print("Can't open URL.")
//
//                        }
//
//                    }
//
//                })
//
//            } else {
//
//                print("Can't open GoogleMap Application.")
//
//            }
//
//        } else {
//
//            print("Prease allow permission.")
//
//        }
//    }
}

extension ATMFinderViewController: ATMFinderDelegates{
    func didFetchATM(data:ATMFinderData)
 {
     self.dataSource = data.atms
    }
}
extension ATMFinderViewController:LocationServiceDelegate{
    func tracingLocation(_ currentLocation: CLLocation) {
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        print(lat)
        print(lon)
        LocationService.sharedInstance.stopUpdatingLocation()
        self.getATMs(lat: String(lat), lon: String(lon))
        
    }
    
    func tracingLocationDidFailWithError(_ error: NSError) {
        print("tracing Location Error : \(error.description)")
    }
}
