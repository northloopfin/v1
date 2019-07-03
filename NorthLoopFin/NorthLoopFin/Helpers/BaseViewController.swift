//All UIViewController must inherit from base view controller

import UIKit
import SVProgressHUD
import GiFHUD_Swift
import AlertHelperKit

class BaseViewController: UIViewController, BaseViewProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRightNavigationBar(){
        let leftBarItem = UIBarButtonItem()
        leftBarItem.style = UIBarButtonItem.Style.plain
        leftBarItem.target = self
        leftBarItem.image = UIImage(named: "Back")?.withRenderingMode(.alwaysOriginal)
        leftBarItem.action = #selector(self.goBack)
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    func setNavigationBarTitle(title:String){
        self.navigationController?.navigationBar.setTitleFont(UIFont(name: "Calibri-Bold", size: 15)!,color: Colors.Taupe776857)
        self.navigationItem.title = title
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    @objc func goBack(){
        self.navigationController?.popViewController(animated: false)
    }
    
    
    func showLoader() {
//        GIFHUD.shared.setGif(named: "northloop.gif")
//        GIFHUD.shared.show()
        //UIApplication.shared.beginIgnoringInteractionEvents()
        SVProgressHUD.show()
    }

    func hideLoader() {
//        GIFHUD.shared.dismiss {
//            print("dismissed")
//        }
        //if UIApplication.shared.isIgnoringInteractionEvents { UIApplication.shared.endIgnoringInteractionEvents() }
        SVProgressHUD.dismiss()
    }
    
    func showErrorAlert(_ alertTitle: String, alertMessage: String) {
        AlertHelperKit().showAlert(self, title: alertTitle, message: alertMessage, button: "OK")
        //self.showAlert(title: alertTitle, message: alertMessage)
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showActionSheet(title : String, message : String, titleArray : [String],delegate : @escaping (UIAlertAction) ->Void) {
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        for values in titleArray{
            alert.addAction(UIAlertAction(title: values, style: UIAlertAction.Style.default, handler: delegate))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
//    func showAlertWithAction(title:String, message:String, buttonArray: [String],destructiveButton:String,delegate : @escaping (UIAlertAction)->()){
//        
//        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        for values in buttonArray{
//            alert.addAction(UIAlertAction(title: values, style: UIAlertAction.Style.default, handler: delegate))
//        }
//        if destructiveButton != ""{
//            // Cancel button
//            let cancel = UIAlertAction(title: destructiveButton, style: .destructive, handler: { (action) -> Void in
//                
//            })
//            alert.addAction(cancel)
//        }
//        self.present(alert, animated: true, completion: nil)
//    }
    
    func showAlertWithTextInputAndAction(title:String,message:String, buttonArray:[String],destructiveButton:String,textFieldPlaceholder:String,delegate : @escaping (UIAlertAction)->Void){
        
    }
}
