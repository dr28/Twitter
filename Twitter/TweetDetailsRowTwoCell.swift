//
//  TweetDetailsRowTwoCell.swift
//  Twitter
//
//  Created by Deepthy on 9/29/17.
//  Copyright © 2017 Deepthy. All rights reserved.
//

import UIKit

class TweetDetailsRowTwoCell: UITableViewCell {
    
      @IBOutlet weak var tweetCount: UILabel!
    
      @IBOutlet weak var tweetLabel: UILabel!
    
      @IBOutlet weak var favoriteCount: UILabel!
    
      @IBOutlet weak var favoriteLabel: UILabel!

    var tweet: Tweet! {
        didSet {
            
            print("tweet.retweetCount \(tweet.retweetCount)")
             if let rtCount = tweet.retweetCount {
             tweetCount.text = "\(rtCount)"
             if rtCount <= 1 {
             tweetLabel.text = "Retweet"
             } else {
             tweetLabel.text = "Retweets"
             }
             }
             
             if let favCount = tweet.favoriteCount {
             favoriteCount.text = "\(favCount)"
             if favCount <= 1 {
             favoriteLabel.text = "Favorite"
             } else {
             favoriteLabel.text = "Favorites"
             }
             }
             
             for label in [tweetLabel, favoriteCount] {
             //  label?.font = UIFont(name: UIConstants.getTextFontNameBold(), size: 16)
             label?.textColor = UIColor.black
             //label?.adjustsFontSizeToFitWidth = true
             }
             
             for label in [tweetLabel, favoriteLabel] {
             //  label?.font = UIFont(name: UIConstants.getTextFontNameLight(), size: 16)
             //  label?.textColor = UIConstants.twitterLightGray
             }

            
            
            
         /*   for label in [tweetLabel, favoriteCount] {
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
