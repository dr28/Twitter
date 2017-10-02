//
//  Constants.swift
//  Twitter
//
//  Created by Deepthy on 9/27/17.
//  Copyright © 2017 Deepthy. All rights reserved.
//

import UIKit

struct Constants {
    
        
    static let detailsReuseIdentifier = "Details"
    
    enum Timeline: String {
        
        case home = "1.1/statuses/home_timeline.json"
        case mentions = "1.1/statuses/mentions_timeline"
        case user = "1.1/statuses/user_timeline"
        case favorite = "1.1/favorites/list.json"
    }
    
    struct Favorites {
        struct Url {
            static let Create = "1.1/favorites/create.json?id="
            static let Destroy = "1.1/favorites/destroy.json?id="
        }
       
        struct Method {
            static let Create = "create"
            static let Destroy = "destroy"

        }
        
    }
    
    struct Tweet {
        struct Url {
            static let Retweet = "1.1/statuses/retweet/"
            static let UserRetweet = "1.1/statuses/show/"

            static let Destroy = "1.1/statuses/destroy/"
        }
        
    }
    
   // static let retweetEndpoint = "1.1/statuses/retweet/"
    
    static func getRetweetUrl(tweetId: String) -> String {
        
        return "\(Tweet.Url.Retweet)\(tweetId).json"
    }
    
   // static let showUserRetweetEndpoint = "1.1/statuses/show/"

    static func showUserRetweetUrl(tweetId: String) -> String {
        
        return "\(Tweet.Url.UserRetweet)\(tweetId).json"
    }
    
    static func DestroyTweetUrl(tweetId: String) -> String {
        
        return "\(Tweet.Url.Destroy)\(tweetId).json"
    }
    
    static func getTimeStampLabel(date: Date) -> String {
        //return date.string(dateStyle: .short, timeStyle: .short, in: nil)
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "hh:mm a . dd MMM yy"
        dateFormatter.dateFormat = "M/dd/yy, hh:mm a "
        return dateFormatter.string(from: date)

    }
    
    static func getTimeAgoLabel(date: Date) -> String {
        
        
        //let componentsDictionary =  date.t
//date.timeIntervalSinceNow.in([.day, .hour, .minute, .second])
        let timeFromDate = date.timeIntervalSinceNow
        let calendarScale: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = Calendar.current.dateComponents(calendarScale, from: Date(), to: date)

        let day = difference.day//componentsDictionary.[Calendar.Component.day] ?? 0
        let hour = difference.hour//componentsDictionary[Calendar.Component.hour] ?? 0
        let minute = difference.minute//componentsDictionary[Calendar.Component.minute] ?? 0
        let second = difference.second//componentsDictionary[Calendar.Component.second] ?? 0
        
        if abs(day!) > 0 {
            return "\(abs(day!))d"
        } else if abs(hour!) > 0 {
            return "\(abs(hour!))h"
        } else if abs(minute!) > 0 {
            return "\(abs(minute!))m"
        } else if (abs(second!) > 0 || second! == 0) {
            return "\(abs(second!))s"
        }
        return ""
    }
    
  
}
