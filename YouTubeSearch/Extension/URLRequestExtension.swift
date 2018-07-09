//
//  URLRequestExtension.swift
//  VacunAccion
//
//  Created by praxis on 26/01/18.
//  Copyright © 2018 Carlos Slim Salud. All rights reserved.
//

import UIKit

enum Method {
    case GET
    case DELETE
    case POST
    case PATCH
    case PUT
    
    /// Return method in string
    ///
    /// - Returns: Method in string
    func methodString()->String{
        switch self {
        case .GET:
            return "GET"
        case .DELETE:
            return "DELETE"
        case .POST:
            return "POST"
        case .PATCH:
            return "PATCH"
        case .PUT:
            return "PUT"
        }
    }
    
}

extension URLRequest{
    
    /// Build structure to request
    ///
    /// - Parameters:
    ///   - method: Can be POST, GET, DELETE, PATCH
    ///   - parameters: Is a directory where contain all parameter the endpoint need
    ///   - headers: Is a directory where contain the headers
    ///   - endPoint: The name by enpoint to send the petition
    /// - Returns: Return the request structure
    static func buildRequest(method:Method, parameters:[String:Any]?, headers: [String:String], urlStr:String)->URLRequest?{
        var newURLStr = urlStr
        if method == .GET || method == .DELETE{
            if let params = parameters{
                for key in params.keys{
                    if let value = params[key]{
                        if params.first?.key == key {
                            newURLStr += "?" + "\(key)=\(value)"
                        }else{
                            newURLStr += "&" + "\(key)=\(value)"
                        }
                    }
                }
            }
        }
        if let url = URL(string: newURLStr){
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = headers
            request.httpMethod = method.methodString()
            request.timeoutInterval = 20
            if method == .POST || method == .PATCH || method == .PUT{
                do{
                    if let params = parameters{
                        let jsonBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                        request.httpBody = jsonBody
                        return request
                    }
                    return request
                }catch{
                    return nil
                }
            }else{
                return request
            }
        }
        return nil
    }
    
}
