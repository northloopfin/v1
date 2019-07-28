//
//  CountryPickerViewPresenter.swift
//  NorthLoopFin
//
//  Created by MyMac on 27/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

protocol CountryPickerViewDelegate: NSObjectProtocol {
    func countryPickerView(picker: CountryPickerView, didSelectCountry country: Country)
    func countryPickerViewDidDismiss(picker: CountryPickerView)
}
