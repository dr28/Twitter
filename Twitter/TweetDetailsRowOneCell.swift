//
//  TweetCellDetails.swift
//  Twitter
//
//  Created by Deepthy on 9/29/17.
//  Copyright © 2017 Deepthy. All rights reserved.
//

import UIKit

class TweetDetailsRowOneCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var screenLabel: UILabel!

    //@IBOutlet weak var timeAgoLabel: UILabel?
        
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel?
    
   // @IBOutlet weak var tweetCount: UILabel!
    
   // @IBOutlet weak var tweetLabel: UILabel!
    
   // @IBOutlet weak var favoriteCount: UILabel!
    
   // @IBOutlet weak var favoriteLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            
            if let user = tweet.tweetCreater {
                
                print("profileImageView \(profileImageView)")
                
                profileImageView?.layer.cornerRadius = 3.0
                profileImageView?.layer.masksToBounds = true
                
                profileImageView?.layer.cornerRadius = (profileImageView?.frame.size.width)!/2
                profileImageView?.clipsToBounds = true
                if let normalImageUrl = user.profileImageUrl {
                    
                    print("normalImageUrl \(normalImageUrl)")
                    let largeImageUrl = normalImageUrl.replacingOccurrences(of: "normal", with: "200x200")
                    print("largeImageUrl \(largeImageUrl)")
                    
                    if let url = URL(string: largeImageUrl) {
                        print("url \(url)")
                        
                        profileImageView?.setImageWith(url)
                    }
                }
                
                if let name = user.name {
                    nameLabel?.text = name
                }
                
                if let screenname = user.screenname {
                    screenLabel?.text = "@\(screenname)"
                }
                
         /*       if (tweet.isRetweeted() && tweet.tweeter != nil) {
                    if let senderName = tweet.tweeter?.name! {
                        retweetViewLabel?.text = "\(senderName) Retweeted"
                        if (User.isCurrentUser(user: tweet.tweeter!)) {
                            retweetViewLabel?.text = "You Retweeted"
                        }
                    }
                } else {
                    retweetViewImage?.isHidden = true
                    retweetViewLabel?.isHidden = true
                    retweetView?.isHidden = true
                }*/
            }
            print("tweet.createdAt in rowone \(tweet.createdAt)")

            if let date = tweet.createdAt {
                timestampLabel?.text = Constants.getTimeStampLabel(date: date)
            }
            print("tweet.text \(tweet.text)")
            if let text = tweet.text {
                print("text \(text)")

                tweetTextLabel?.text = text
            }
            
            print("tweet.retweetCount in rowone \(tweet.retweetCount)")

            
           /* if let rtCount = tweet.retweetCount {
                tweetCount.text = "\(rtCount)"
                if rtCount == 1 {
                    tweetLabel.text = "RETWEET"
                } else {
                    tweetLabel.text = "RETWEETS"
                }
            }
            
            if let favCount = tweet.favoriteCount {
                favoriteCount.text = "\(favCount)"
                if favCount == 1 {
                    favoriteLabel.text = "FAVORITE"
                } else {
                    favoriteLabel.text = "FAVORITES"
                }
            }
            
            for label in [tweetLabel, favoriteCount] {
                //  label?.font = UIFont(name: UIConstants.getTextFontNameBold(), size: 16)
                label?.textColor = UIColor.black
                label?.adjustsFontSizeToFitWidth = true
            }
            
            for label in [tweetLabel, favoriteLabel] {
                //  label?.font = UIFont(name: UIConstants.getTextFontNameLight(), size: 16)
                //  label?.textColor = UIConstants.twitterLightGray
            }*/
            
            /*
             topRTImageView?.image = UIImage(named: "retweet-unselected")
             
             isLiked = tweet.favorited ?? false
             
             if (!isLiked) {
             setLikeImage(selected: false)
             } else {
             setLikeImage(selected: true)
             }
             
             if (!tweet.retweetedByMe!) {
             setRetweetImage(selected: false)
             } else {
             setRetweetImage(selected: true)
             }
             
             bottomReplyImageView?.image = UIImage(named: "reply")
             
             setUpLabelAppearances()*/
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
