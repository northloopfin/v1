//
//  SettingsDelegates.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 20/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol SettingsDelegates:BaseViewProtocol{
    func didSaveAppSettings()
    func didGetAppSettings(data:GetPreferencesData)
    func didCheckUpdate(data:CheckUpdateResponse)
}
