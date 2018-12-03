
//Note :- This protocol must confirm by all View Controllers


import Foundation

protocol BaseViewProtocol:class {
    func showLoader()
    func hideLoader()
    func showErrorAlert(_ alertTitle : String , alertMessage : String)
}
