//
//  Athlete.swift
//  AtheletsInfo
//
//  Created by Vortex on 8/14/17.
//  Copyright © 2017 Apptcom. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON
import Kingfisher

class Athlete : NSObject, Mappable {
    private var name : String!
    private var imageLink : String!
    private var brief : String!
    private var image : UIImage!
    private var network : Networking!
    private var athleteArray = [Athlete]()
    
    weak var delegate : AthleteDelegate?
    
    var _name : String {
        get {
            if name == nil {
                name = ""
            }
            return name
        }
        set {
            name = newValue
        }
    }
    
    var _brief : String {
        get {
            if brief == nil {
                brief = ""
            }
            return brief
        }
        set {
            brief = newValue
        }
    }
    
    var _image : UIImage {
        get {
            if image == nil {
                image = UIImage()
            }
            return image
        } set {
            image = newValue
        }
    }
    
    required init?(map: Map) {
        
    }
    
    override init() {
        network = Networking(requestTimeout: 10)
    }
    
    func mapping(map: Map) {
        _name <- map["name"]
        imageLink <- map["image"]
        _brief <- map["brief"]
        
    }
    
    func downloadAthletes() {
        delegate?.onDownloadStart()
        network.manager.request(dataURL).responseJSON {
            response in
            let result = response.result
            switch result {
                
                case .success(let value):
                    var json = JSON(value)
                    if let athletesArray = json["athletes"].array {
                        for athleteObject in athletesArray {
                            let athlete = Athlete()
                            athlete.mapping(map: Map(mappingType: .fromJSON, JSON: athleteObject.dictionaryObject!))
                            if athlete.imageLink == "" {
                                athlete.imageLink = defaultProfilePictureURL
                            }
                            KingfisherManager.shared.retrieveImage(with: URL(string: athlete.imageLink)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                                if let img = image {
                                    athlete._image = img
                                }
                                self.athleteArray.append(athlete)
                                self.delegate?.onDownloadSuccess(self.athleteArray)
                            })
                        }
                        
                        
                    } else {
                        self.delegate?.onUnexpectedResponse("The server returned with an unexpected response please try again later")
                    }
                    break
                
                case .failure(let error) :
                    self.delegate?.onRequestFailure(error as NSError)
                    break
            }
        }
    }
}
