//
//  TweetDetailsRowThreeCell.swift
//  Twitter
//
//  Created by Deepthy on 9/30/17.
//  Copyright © 2017 Deepthy. All rights reserved.
//

import UIKit

@objc protocol TweetDetailsRowThreeCellDelegate {
    
    @objc optional func tweetDetailsRowThreeCell(tweetDetailsRowThreeCell: TweetDetailsRowThreeCell, didReply tweet: Tweet)
    @objc optional func tweetDetailsRowThreeCell(tweetDetailsRowThreeCell: TweetDetailsRowThreeCell, didRetweetChange tweet: Tweet)
    @objc optional func tweetDetailsRowThreeCell(tweetDetailsRowThreeCell: TweetDetailsRowThreeCell, didFavoriteChange tweet: Tweet)
    
}


class TweetDetailsRowThreeCell: UITableViewCell {
    
    @IBOutlet weak var replyImageView: UIImageView?
    
 //   @IBOutlet weak var replyCountLabel: UILabel!
    
    @IBOutlet weak var retweetImageView: UIImageView?
    
  //  @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var likeImageView: UIImageView?
    
  //  @IBOutlet weak var likeCountLabel: UILabel!
    
    weak var delegate: TweetDetailsRowThreeCellDelegate?
    var isLiked: Bool = false

    var tweet: Tweet! //{
        //didSet {
                     /*   if let user = tweet.tweetCreater {
                
                //print("profileImageView \(profileImageView)")
                
                profileImageView?.layer.cornerRadius = 3.0
                profileImageView?.layer.masksToBounds = true
                
                profileImageView?.layer.cornerRadius = (profileImageView?.frame.size.width)!/2
                profileImageView?.clipsToBounds = true
                if let normalImageUrl = user.profileImageUrl {
                    
                    // print("normalImageUrl \(normalImageUrl)")
                    let largeImageUrl = normalImageUrl.replacingOccurrences(of: "normal", with: "200x200")
                    //print("largeImageUrl \(largeImageUrl)")
                    
                    if let url = URL(string: largeImageUrl) {
                        //   print("url \(url)")
                        
                        profileImageView?.setImageWith(url)
                    }
                }
                
                if let name = user.name {
                    nameLabel?.text = name
                }
                
                if let screenname = user.screenname {
                    screenLabel?.text = "@\(screenname)"
                }
                
                print("tweet.isRetweeted() ====================================== \(tweet.isRetweeted())")
                print("tweet.tweeter != nil ====================================== \(tweet.tweeter != nil)")
                print("tweet.tweetCreater ====================================== \(tweet.tweetCreater?.name)")
                print("tweet.tweeter ====================================== \(tweet.tweeter?.name)")
                
                if (tweet.isRetweeted() && tweet.tweeter != nil) {
                    print("tweet.tweeter?.name! ====================================== \(tweet.tweeter?.name!)")
                    
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
                }
            }
            
            if let date = tweet.createdAt {
                timeAgoLabel?.text = Constants.getTimeAgoLabel(date: date)
                //timestampLabel?.text = UIConstants.getTimeStampLabel(date: date)
            }
            
            if let text = tweet.text {
                tweetTextLabel?.text = text
            }
            
            if let rtCount = tweet.retweetCount {
                retweetCountLabel.text = "\(rtCount)"
                /*if rtCount == 1 {
                 retweetLabel.text = "RETWEET"
                 } else {
                 retweetLabel.text = "RETWEETS"
                 }*/
            }
            
            if let favCount = tweet.favoriteCount {
                likeCountLabel.text = "\(favCount)"
                /*if favCount == 1 {
                 favoriteLabel.text = "FAVORITE"
                 } else {
                 favoriteLabel.text = "FAVORITES"
                 }*/
            }
            
            /*
             topRTImageView?.image = UIImage(named: "retweet-unselected")*/
            
            print("tweet.favorited  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ \(tweet.favorited )")
            isLiked = tweet.favorited ?? false
            print("isLiked  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ \(isLiked )")
            
            if (!isLiked) {
                setLikeImage(selected: false)
            } else {
                setLikeImage(selected: true)
            }
            
            if (!tweet.retweetedByUser!) {
                setRetweetImage(selected: false)
            } else {
                setRetweetImage(selected: true)
            }*/
            
            /*bottomReplyImageView?.image = UIImage(named: "reply")
             
             setUpLabelAppearances()*/
        //}
   // }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let replyButtonTap = UITapGestureRecognizer(target: self, action: #selector(replyButtonTapped))
        replyButtonTap.numberOfTapsRequired = 1
        replyImageView?.isUserInteractionEnabled = true
        replyImageView?.addGestureRecognizer(replyButtonTap)


        let reTweetButtonTap = UITapGestureRecognizer(target: self, action: #selector(reTweetButtonTapped))
        reTweetButtonTap.numberOfTapsRequired = 1
        retweetImageView?.isUserInteractionEnabled = true
        retweetImageView?.addGestureRecognizer(reTweetButtonTap)
        
        
        let likeButtonTap = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped))
        likeButtonTap.numberOfTapsRequired = 1
        likeImageView?.isUserInteractionEnabled = true
        likeImageView?.addGestureRecognizer(likeButtonTap)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        isLiked = tweet.favorited ?? false
        
        if (!isLiked) {
            setLikeImage(selected: false)
        } else {
            setLikeImage(selected: true)
        }
        
        if (!tweet.retweetedByUser!) {
            setRetweetImage(selected: false)
        } else {
            setRetweetImage(selected: true)
        }
        
    }
    
    func replyButtonTapped() {
        delegate?.tweetDetailsRowThreeCell!(tweetDetailsRowThreeCell: self, didReply: self.tweet)
        
    }
    func reTweetButtonTapped() {
        self.delegate?.tweetDetailsRowThreeCell!(tweetDetailsRowThreeCell: self, didRetweetChange: self.tweet)
    }
    
    func setRetweetImage(selected: Bool) {
        if (selected) {
            retweetImageView?.image = UIImage(named: "retweet")
        } else {
            retweetImageView?.image = UIImage(named: "undoretweet")
        }
    }
    
    func likeButtonTapped() {
        self.delegate?.tweetDetailsRowThreeCell?(tweetDetailsRowThreeCell: self, didFavoriteChange: self.tweet)
        
    }
    
    
    func setLikeImage(selected: Bool) {
        if (selected) {
            print("Entered setLikeImage true")
            
            likeImageView?.image = UIImage(named: "like")
        } else {
            likeImageView?.image = UIImage(named: "dislike")
        }
    }


}
