//
//  StringExtension.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 20/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
