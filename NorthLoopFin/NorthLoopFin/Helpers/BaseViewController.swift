//All UIViewController must inherit from base view controller

import UIKit
import SVProgressHUD

class BaseViewController: UIViewController, BaseViewProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLoader() {
        SVProgressHUD.show()
    }

    func hideLoader() {
        SVProgressHUD.dismiss()
    }
    
    func showErrorAlert(_ alertTitle: String, alertMessage: String) {
        self.showAlert(title: alertTitle, message: alertMessage)
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showActionSheet(title : String, message : String, titleArray : [String],delegate : @escaping (UIAlertAction) ->Void) {
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        for values in titleArray{
            alert.addAction(UIAlertAction(title: values, style: UIAlertActionStyle.default, handler: delegate))
        }
        self.present(alert, animated: true, completion: nil)
    }
}
