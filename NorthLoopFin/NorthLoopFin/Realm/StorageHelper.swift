//
//  StorageHelper.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 28/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import FileProvider
class StorageHelper{
    
    static func saveImageDocumentDirectory(fileName:String,data:Data){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(fileName)
        //let image = UIImage(named: "apple.jpg")
        //let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: data, attributes: nil)
    }
    static func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    static func getImagePath(imgName:String)->String{
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imgName)
        return paths
    }
    
    static func getImageFromPath(path:String)->UIImage?{
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path){
            //self.imageView.image = UIImage(contentsOfFile: imagePAth)
            return UIImage(contentsOfFile: path)
        }else{
            print("No Image")
            return nil
        }
    }
    static func getImage(fileName:String)-> UIImage?{
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(fileName)
        if fileManager.fileExists(atPath: imagePAth){
            //self.imageView.image = UIImage(contentsOfFile: imagePAth)
            return UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
            return nil
        }
    }
    static func createDirectory(directoryName:String){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(directoryName)
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Already dictionary created.")
        }
    }
    func deleteDirectory(directoryName:String){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(directoryName)
        if fileManager.fileExists(atPath: paths){
            try! fileManager.removeItem(atPath: paths)
        }else{
            print("Something wronge.")
        }
    }
    
    static func clearAllFileFromDirectory() {
        let fileManager = FileManager.default
        let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            try fileManager.removeItem(at: myDocuments)
        } catch {
            return
        }
    }
}
