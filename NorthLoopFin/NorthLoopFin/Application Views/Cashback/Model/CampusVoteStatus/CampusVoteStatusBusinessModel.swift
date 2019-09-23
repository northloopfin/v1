//
//  CampusVoteStatusBusinessModel
//  NorthLoopFin
//
//  Created by Milan Mendpara on 21/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class CampusVoteStatusBusinessModel {
    
    deinit {
        print("CampusVoteStatusBusinessModel deinit")
    }
    
    
    /// Perform login with
    ///
    /// - Parameters:
    ///   - loginModel: LoginRequestModel
    ///   - presenterDelegate: ResponseCallBack delegate
    
    func performCampusVoteStatus(withRequestModel model: CampusVoteStatusRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        CampusVoteStatusAPIRequest().makeAPIRequest(withReqFormData: model, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
}
