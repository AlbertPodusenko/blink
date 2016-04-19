//
//  APIWorker.swift
//  Blink
//
//  Created by Albert Podusenko on 19.04.16.
//  Copyright © 2016 Albert Podusenko. All rights reserved.
//

import Foundation
import SwiftyVK


class APIWorker {
    
    static let appID = "5423543"
    static let scope = [VK.Scope.messages,.offline,.friends,.wall,.photos,.audio,.video,.docs,.market,.email]
    
    class func action(tag: Int) {
        switch tag {
        case 1:
            autorize()
        case 2:
            logout()
        case 3:
            capthca()
        case 4:
            usersGet()
        case 5:
            friendsGet()
        case 6:
            validation()
        default:
            print("Unrecognized action!")
        }
    }
    
    
    class func autorize() {
        VK.logOut()
        print("SwiftyVK: LogOut")
        VK.autorize()
        print("SwiftyVK: Autorize")
    }
    
    
    
    class func logout() {
        VK.logOut()
        print("SwiftyVK: LogOut")
    }
    
    
    
    class func capthca() {
        let req = VK.API.custom(method: "captcha.force")
        req.successBlock = {response in print("SwiftyVK: Captha success \n \(response)")}
        req.errorBlock = {error in print("SwiftyVK: Captha fail \n \(error)")}
        req.send()
    }
    
    
    
    class func validation() {
        let req = VK.API.custom(method: "account.testValidation")
        req.successBlock = {response in print("SwiftyVK: Captha success \n \(response)")}
        req.errorBlock = {error in print("SwiftyVK: Captha fail \n \(error)")}
        req.send()
    }
    
    
    
    class func usersGet() {
        let req = VK.API.Users.get([VK.Arg.userId : "1"])
        req.maxAttempts = 1
        req.timeout = 10
        req.isAsynchronous = true
        req.catchErrors = true
        req.successBlock = {response in print("SwiftyVK: usersGet success \n \(response)")}
        req.errorBlock = {error in print("SwiftyVK: usersGet fail \n \(error)")}
        req.send()
    }
    
    
    
    class func friendsGet() {
        let req = VK.API.Friends.get([
            .count : "1",
            .fields : "city,domain"
            ])
        req.successBlock = {response in print("SwiftyVK: friendsGet success \n \(response)")}
        req.errorBlock = {error in print("SwiftyVK: friendsGet fail \n \(error)")}
        req.send()
        
        VK.API.custom(method: "users.get", parameters: [VK.Arg.userId : "1"])
    }
    
    
    
    class func uploadPhoto(sharedImage: UIImage) {

        let data: NSData = UIImagePNGRepresentation(sharedImage)!
        let media = Media(imageData: data, type: .JPG)
        let req = VK.API.Upload.Photo.toWall.toUser(media, userId: "0")
        req.progressBlock = { (done, total) -> () in print("SwiftyVK: uploadPhoto progress: \(done) of \(total))")}
        req.successBlock = {response in print("SwiftyVK: uploadPhoto success \n \(response)")}
        req.errorBlock = {error in print("SwiftyVK: uploadPhoto fail \n \(error)")}
        req.send()
    }
}