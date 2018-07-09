//
//  VideoModel.swift
//  YouTubeSearch
//
//  Created by Adrián Salazar G on 08/07/18.
//  Copyright © 2018 Adrián Salazar G. All rights reserved.
//

import UIKit

struct VideoModel {
    
    let idVideo:String
    let imageUrl:String
    let title:String
    let publishDate:Date
    
    /// Get videos model with array of dictionary
    ///
    /// - Parameter arrDic: [[String:Any]]
    /// - Returns: [VudeoModel]
    static func getVideosModelWith(arrDic:[[String:Any]])->[VideoModel]{
        var arrVideosModel:[VideoModel] = []
        
        for item in arrDic{
            if let id = item["id"] as? [String:Any],
            let idVideo = id["videoId"] as? String,
            let snippet = item["snippet"] as? [String:Any],
            let title = snippet["title"] as? String,
            let publishDateStr = snippet["publishedAt"] as? String,
            let publishDate = publishDateStr.dateToString(dateFormatStr: "yyyy-MM-dd'T'HH:mm:ss.SSSZ"),
            let thumbnails = snippet["thumbnails"] as? [String:Any],
            let medium = thumbnails["medium"] as? [String:Any],
            let urlImage = medium["url"] as? String{
                arrVideosModel.append(VideoModel(idVideo: idVideo, imageUrl: urlImage, title: title, publishDate: publishDate))
            }
        }
        
        return arrVideosModel
    }
    
    /// Get video with
    ///
    /// - Parameters:
    ///   - textToSearch: Text to search
    ///   - completion: completion
    static func getVideosWith(textToSearch:String,completion: @escaping(_ error:Error?,_ items:[[String:Any]]?)->Void){
        guard ConnectToNetwork.isConnectedToNetwork() else {
            let error = NSError(domain: "Create Account Response", code: 1000, userInfo: [NSLocalizedDescriptionKey:"Ocurrió un error con la conexión, favor de verificar que su conexión Wi-Fi o de datos móviles esté activada y vuelva a intentarlo."])
            completion(error,nil)
            return
        }
        let urlStr:String = Constants.BASEURL+"&q=\(textToSearch)"+"&key=\(Constants.APIKEY)"
        let header:[String:String] = ["Content-Type":"application/json"]
        guard let request = URLRequest.buildRequest(method: .GET, parameters: nil, headers: header, urlStr: urlStr) else {
            let error = NSError(domain: "VacunAccion", code: 403, userInfo: [NSLocalizedDescriptionKey:"No se pudo realizar la conexión debido a un error interno."])
            completion(error, nil)
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, urlResponse, error) in
                if let e = error{
                    completion(e, nil)
                }else if let httpResponse = urlResponse as? HTTPURLResponse{
                    guard let d = data else{
                        let error = NSError(domain: "VacunAccion", code: 403, userInfo: [NSLocalizedDescriptionKey:"Usuario y/o password incorrecto(s)."])
                        completion(error, nil)
                        return
                    }
                    let code = httpResponse.statusCode
                    switch code{
                    case 200:
                        do{
                            let jsonObject = try JSONSerialization.jsonObject(with: d, options: .allowFragments) as! [String:Any]
                            if let items = jsonObject["items"] as? [[String:Any]]{
                                DispatchQueue.main.async() {
                                    completion(nil,items)
                                }
                            }
                        }catch let error{
                            completion(error, nil)
                        }
                        break
                    case 403:
                        let error = NSError(domain: "VacunAccion", code: code, userInfo: [NSLocalizedDescriptionKey:"Usuario y/o password incorrecto(s)."])
                        completion(error,nil)
                        break
                    default:
                        let error = NSError(domain: "VacunAccion", code: code, userInfo: [NSLocalizedDescriptionKey:"Disculpe, por el momento no podemos conectarnos con el servidor, intente mas tarde"])
                        completion(error, nil)
                        break
                    }
                }
            })
            task.resume()
        }
    }
    
}
