
//Note :- This method is used for Handling Api Response

protocol ResponseCallback:class {
    func servicesManagerSuccessResponse<T:Codable>(responseObject : T)
    func servicesManagerError(error : ErrorModel)
}

