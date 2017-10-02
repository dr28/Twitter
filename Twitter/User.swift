//
//  User.swift
//  Twitter
//
//  Created by Deepthy on 9/26/17.
//  Copyright © 2017 Deepthy. All rights reserved.
//

import UIKit


class User: NSObject {
    static var _currentUser: User?
    static let currentUserKey = "CurrentUserKey"

    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var userid: String?
    var dictionary: Dictionary<String, AnyObject>?
    
    init(dictionary: Dictionary<String, AnyObject>) {
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        userid = dictionary["id_str"] as? String

        self.dictionary = dictionary

    }
    
    class var currentUser: User? {
        get {
            let defaults = UserDefaults.standard
            if _currentUser == nil {
                if let data = defaults.object(forKey: currentUserKey) as? Data {
                    
                    do {
                        let dictionary = try JSONSerialization.jsonObject(with: data, options: [])
                        _currentUser = User(dictionary: dictionary as! Dictionary<String, AnyObject>)
                    } catch {
                        print("JSON serialization error: \(error)")
                    }
                }
            }
            return _currentUser
        }
        set(user) {

            _currentUser = user
            let defaults = UserDefaults.standard
            
            if _currentUser != nil {

                do {
                    let data = try JSONSerialization.data(withJSONObject: (user?.dictionary)! as Any, options: [])
                    defaults.set(data, forKey: currentUserKey)
                } catch {
                    print("JSON deserialization error: \(error)")
                }
            } else {
                defaults.removeObject(forKey: currentUserKey)
            }
            defaults.synchronize()
        }
    }

    class func isCurrentUser(user: User) -> Bool{
        return user.userid == User.currentUser?.userid
    }

    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.deauthorize()
        
      //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userDidLogoutNotification"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserLoggedOut"), object: nil)

        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: User.currentUserKey)
        defaults.synchronize()
        
    }

}
