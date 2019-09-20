//All UIViewController must inherit from base view controller

import UIKit
import SVProgressHUD
import GiFHUD_Swift
import AlertHelperKit
import Toast_Swift

class BaseViewController: UIViewController, BaseViewProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setGifLoaderImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toast(message:String){
        self.view.makeToast(message, duration: 3.0, position: .bottom)
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
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        //GIFHUD.shared.show()
        SVProgressHUD.show()
    }

    func hideLoader() {

        if UIApplication.shared.isIgnoringInteractionEvents { UIApplication.shared.endIgnoringInteractionEvents() }
        SVProgressHUD.dismiss()
//        GIFHUD.shared.dismiss(completion: {
//            print("GiFHUD dismissed")
//        })
    }
    
    func openScanIDPrivacy(){
        let vw = ScanIDPolicy.instantiateFromNib()
        let window = UIApplication.shared.keyWindow!
        vw.frame = window.bounds
        window.addSubview(vw);
    }
    
    func setGifLoaderImage (withImageName imageName: String = "northloop.gif") {
        GIFHUD.shared.setGif(named: imageName)
        GIFHUD.shared.frame = CGRect (x: 0, y: 0, width: 300, height: 300)
        GIFHUD.shared.imageView?.frame =  CGRect (x: 0, y: 0, width: 300, height: 300)
        GIFHUD.shared.layer.backgroundColor = UIColor.red.cgColor
        GIFHUD.shared.layer.cornerRadius = 20
        GIFHUD.shared.layer.masksToBounds = true
        GIFHUD.shared.show()
    }
    
    func configureHud(size:CGSize){
        GIFHUD.shared.hudSize = CGSize(width: size.width, height: size.height)
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

extension UIViewController{
    var previousViewController:UIViewController?{
        if let controllersOnNavStack = self.navigationController?.viewControllers{
            let n = controllersOnNavStack.count
            //if self is still on Navigation stack
            if controllersOnNavStack.last === self, n > 1{
                return controllersOnNavStack[n - 2]
            }else if n > 0{
                return controllersOnNavStack[n - 1]
            }
        }
        return nil
    }
    
    func getControllerWithIdentifier(_ identifier: String) -> UIViewController{
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
}
