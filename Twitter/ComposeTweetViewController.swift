//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by Deepthy on 9/28/17.
//  Copyright © 2017 Deepthy. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class ComposeTweetViewController: UIViewController /*, TTTAttributedLabelDelegate*/{
    @IBOutlet weak var composeTextView: UITextView!

    @IBOutlet var mainView: UIView!
    @IBOutlet var mainPushUpView: UIView!

    @IBOutlet weak var profileImage: UIImageView!
    fileprivate var cutomTextView: UIView!
    @IBOutlet weak var ScreeName: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var ReplyToLabel: TTTAttributedLabel!
    
    fileprivate var topCounterLabel:UILabel!
    fileprivate var bottomCounterLabel: UILabel!
    
    fileprivate var replyButton: UIButton!
    fileprivate var isReadyToTweet = false

    var replyingTweet: Tweet?
    
    let user = User.currentUser
    var initialY: CGFloat!
    var offset: CGFloat!
    
    var prfImg: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (notification: Notification) in
           
            if self.replyingTweet == nil {

            self.keyboardWillShow()
            }
        }
        setupNavbar()
        self.automaticallyAdjustsScrollViewInsets = false

        composeTextView.placeholder = "What's happening?"
        composeTextView.delegate = self

        setupCustomBottomBar()
        initialY = mainPushUpView.frame.origin.y
        offset = -50

        if replyingTweet != nil {
            composeTextView.placeholder = "Tweet your reply"
            let replyText = "Replying to @\((replyingTweet!.tweeter?.screenname!)!)" + " "
            ReplyToLabel.text = replyText

            ReplyToLabel.enabledTextCheckingTypes = NSTextCheckingAllTypes
        
            composeTextView.placeholder = ""
            setCountdownLabels(left: 140)
            setReplyButton(ready: true)
            
            if let user = replyingTweet?.tweetCreater {
                
                //print("profileImageView \(profileImageView)")
                
                profileImage?.layer.cornerRadius = 3.0
                profileImage?.layer.masksToBounds = true
                
                profileImage?.layer.cornerRadius = (profileImage?.frame.size.width)!/2
                profileImage?.clipsToBounds = true
                if let normalImageUrl = user.profileImageUrl {
                    
                    let largeImageUrl = normalImageUrl.replacingOccurrences(of: "normal", with: "200x200")

                    if let url = URL(string: largeImageUrl) {
                        
                        profileImage?.setImageWith(url)
                    }
                }
                
                if let name = user.name {
                    ScreeName?.text = name
                }
                
                if let screenname = user.screenname {
                    userName?.text = "@\(screenname)"
                    let range = ReplyToLabel.text?.range(of: "@\(screenname)")
                    let nsrange = ReplyToLabel.text?.nsRange(from: range!)
                    let url = URL(string: "http:// ")
                    //NSRange range = [label.text rangeOfString:@"me"];
                    //[label addLinkToURL:[NSURL URLWithString:@"http://github.com/mattt/"] withRange:range];
                    
                    self.ReplyToLabel.linkAttributes = [NSForegroundColorAttributeName: UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 0.5)]

                    self.ReplyToLabel.addLink(to: url, with: nsrange!)
                   // self.ReplyToLabel.delegate = self

                }
                


            }
        }
        else{
            ReplyToLabel.isHidden = true
            userName.isHidden = true
            ScreeName.isHidden = true
            keyboardWillShow()
           

        }
        //composeTextView.becomeFirstResponder()
        

    }
    func keyboardWillShow() {
        
        print("keyboard will show")
        mainPushUpView.frame.origin.y = initialY + offset
       // ReplyToLabel.frame.origin.y = initialY + offset

      //  userName.frame.origin.y = initialY + offset

      //  ScreeName.frame.origin.y = initialY + offset

        //  let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
      //  composeTextView.endEditing(true)
    }
    func setupNavbar() {
        if replyingTweet != nil {
            
            let composeImageView = UIImageView(image: UIImage(named: "compose"))
            composeImageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
            let composeTap = UITapGestureRecognizer(target: self, action: #selector(composeTweet))
            composeTap.numberOfTapsRequired = 1
            composeImageView.addGestureRecognizer(composeTap)
            let rightBarButton = UIBarButtonItem.init(customView: composeImageView)
            self.navigationItem.rightBarButtonItem = rightBarButton
            
            
            

        }
        else{

        if let profileImageUrl = user?.profileImageUrl {
            let largeImageUrl = profileImageUrl.replacingOccurrences(of: "normal", with: "200x200")
            
            if let url = URL(string: largeImageUrl) {
                let profileImage = UIImage()
                let profileImageView = UIImageView(image: profileImage)
                profileImageView.setImageWith(url)
                profileImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                
                profileImageView.layer.cornerRadius = (profileImageView.frame.size.width)/2
                profileImageView.clipsToBounds = true
                prfImg = profileImageView.image
                let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
                profileImageTap.numberOfTapsRequired = 1
                profileImageView.isUserInteractionEnabled = true
                profileImageView.addGestureRecognizer(profileImageTap)

                let leftbarButton = UIBarButtonItem.init(customView: profileImageView)
                self.navigationItem.leftBarButtonItem = leftbarButton
                
               
            }
            
            
        }
            
        let cancelImageView = UIImageView(image: UIImage(named: "cancel"))
        cancelImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
       // let cancelTap = UITapGestureRecognizer(target: self, action: #selector(cancelTapped))
       // cancelTap.numberOfTapsRequired = 1
       // cancelImageView.addGestureRecognizer(cancelTap)
       // let rightbarButton = UIBarButtonItem.init(customView: cancelImageView)
       // self.navigationItem.rightBarButtonItem = rightbarButton
        }
        
        if let navigationBar = self.navigationController?.navigationBar {
            let navBarWidth = navigationBar.frame.width
            
            let frame = CGRect(x: navBarWidth - 75, y: 0, width: 35, height: navigationBar.frame.height)
            print("\(navigationBar.frame.width)")
            print("\(4*navigationBar.frame.width/5)")
            
            topCounterLabel = UILabel(frame: frame)
            topCounterLabel.textColor = UIColor.black
            topCounterLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            
            
            navigationBar.addSubview(topCounterLabel)
        }

        
    }
    
    
    func profileImageTapped() {
        
        let imageView = UIImageView(frame: CGRect.init(x: 220, y: 10, width: 20, height: 20))//(220, 10, 40, 40))
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "user")
//imageView.image.
        
let  alert = UIAlertAction.init(title: "Deepthy \n rkdeepthy@gmail.com", style: .default, image: UIImage(named: "user")!)
        let cancelImageView = UIImageView(image: UIImage(named: "cancel"))
        let alertMessage = UIAlertController(title: "My Title", message: "My Message", preferredStyle: .actionSheet)
        let retweetAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
 
        /*retweetAlert.addAction(UIAlertAction(title: "Retweet", style: .default, handler: { (action) in
        
            let image = UIImage(named: "myImage")
            //var action = UIAlertAction(title: "OK", style: .default, handler: nil)
            retweetAlert.setValue(image, forKey: "image")
            
            
            let margin:CGFloat = 10.0
            let rect = CGRect(x: margin, y: margin, width: alertMessage.view.bounds.size.width - margin * 4.0, height: 120)
            let customView = UIView(frame: rect)
            
            let customsubview = UIView()
            
            let name = UILabel()
            name.text = "hi"
            let subview = retweetAlert.view.subviews.first! as UIView
            
            let alertContentView = subview.subviews.first! as UIView
            customsubview.addSubview(name)
            alertContentView.addSubview(imageView)

            customView.addSubview(customsubview)
            // customView.backgroundColor = .green
            customView.addSubview(imageView)
            retweetAlert.view.addSubview(alertContentView)
            retweetAlert .addAction(action)

        }
        
        ))*/
        
        retweetAlert.addAction(alert)


        
        self.present(retweetAlert, animated: true, completion: nil)
        /*let retweetAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if (!tweet.retweetedByMe!) {
            retweetAlert.addAction(UIAlertAction(title: "Retweet", style: .default, handler: { (action) in
                
                self.tweet.retweetedByMe = true
                self.tweet.increateRTCount()
                self.delegate?.tweetCell?(tweetCell: self, didFinishRetweet: self.tweet)
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self.bottomRTImageView?.transform = CGAffineTransform(scaleX: 3, y: 3)
                    self.setRetweetImage(selected: true)
                    
                }, completion: { (finish) in
                    
                    UIView.animate(withDuration: 0.1, animations: {
                        self.bottomRTImageView?.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }, completion: { (finish) in
                        
                        TwiSwiftClient.sharedInstance?.reweet(tweetIdString: "\(self.tweet.remoteId!)", completionHandler: { (finish) in
                            if (!finish!) {
                                self.tweet.decreaseRTCount()
                                self.setRetweetImage(selected: false)
                                self.tweet.retweetedByMe = false
                            }
                        })
                    })
                })
            }))
        } else {
            retweetAlert.addAction(UIAlertAction(title: "Undo Retweet", style: .destructive, handler: { (action) in
                
                self.tweet.retweetedByMe = false
                self.tweet.decreaseRTCount()
                self.setRetweetImage(selected: false)
                self.delegate?.tweetCell?(tweetCell: self, didFinishRetweet: self.tweet)
                
                // unretweet
                let originalRemoteIdString = self.tweet.originalTweetIdStr
                TwiSwiftClient.sharedInstance?.findMyRetweet(originalTweetIdString: originalRemoteIdString!, completionHandler: { (finish) in
                    
                    if (!finish!) {
                        self.tweet.retweetedByMe = true
                        self.tweet.increateRTCount()
                        self.setRetweetImage(selected: true)
                    }
                })
            }))
        }
        
        retweetAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(retweetAlert, animated: true, completion: nil)*/
    }


    func setupCustomBottomBar() {
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))

        customView.backgroundColor = UIColor.white
        customView.layer.borderColor = UIColor(red: 170/255, green: 184/255, blue: 194/255, alpha: 1).cgColor
        
        customView.layer.borderWidth = 0.3
        composeTextView.inputAccessoryView = customView
        
        self.view.addSubview(composeTextView)
        let screenWidth = UIScreen.main.bounds.width
        
        bottomCounterLabel = UILabel()
        bottomCounterLabel.frame = CGRect(x: screenWidth - 120, y: 0, width: 30, height: 50)
        bottomCounterLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        setCountdownLabels(left: 140)
        
        customView.addSubview(bottomCounterLabel)
        
        replyButton = UIButton()
        replyButton.frame = CGRect(x: screenWidth - 80, y: 10, width: 70, height: 30)
        replyButton.setTitle("Reply", for: .normal)
        replyButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        replyButton.layer.cornerRadius = replyButton.frame.height / 2
        replyButton.clipsToBounds = true
        replyButton.layer.masksToBounds = true
        setReplyButton(ready: isReadyToTweet)
        customView.addSubview(replyButton)
        
        replyButton.addTarget(self, action: #selector(sendTweet), for: .touchUpInside)
        
    }

    @IBAction func onCancelButto(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        topCounterLabel.isHidden = true
        self.navigationController?.navigationBar.addSubview(UIView())

        print("onCancelButton \(sender)")
        if replyingTweet != nil {
            
            //self.performSegue(withIdentifier: "loginSegue", sender: nil)
           // self.performSegue(withIdentifier: "composeTweet", sender: self)
            

        }
        else {
             self.dismiss(animated: true, completion: nil)

            //self.performSegue(withIdentifier: "loginSegue", sender: nil)

        }

        
    }
    func composeTweet() {
        setCountdownLabels(left: 140)

        performSegue(withIdentifier: "ComposeFromTweet", sender: self)
    }

    func cancelTapped() {
        composeTextView.resignFirstResponder()
        topCounterLabel.isHidden = true
        self.navigationController?.navigationBar.addSubview(UIView())

       // self.dismiss(animated: true, completion: nil)
       // navigationController?.popViewController(animated: true)
    }
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("segue.identifier \(segue.identifier)")
        
        self.navigationController?.navigationBar.addSubview(UIView())

        if segue.identifier == "ComposeFromTweet" {
            
            if let composeTweetViewController = segue.destination as? ComposeTweetViewController {
                topCounterLabel.isHidden = true

                    composeTweetViewController.replyingTweet = self.replyingTweet

            }
            
            //let navigationController = segue.destination as! UINavigationController
            
            /*let filterViewController = navigationController.topViewController as! FiltersViewController
            filterViewController.delegate = self
            searchBar.text = ""
            filters[Constants.filterTerm] = "" as AnyObject
            filterViewController.filters = filters*/
            
        }
       /* else if segue.identifier == Constants.segueListSearchIdentifier {
            
            let listViewController = (segue.destination as! UINavigationController).topViewController as! BusinessesViewController
            
            listViewController.businesses = businesses
            listViewController.filters = filters
            listViewController.searchBar = searchBar//self.searchBar
            
        }*/
    }

    
    func setCountdownLabels(left: Int) {
       
        topCounterLabel.text = "\(left)"
        bottomCounterLabel.text = "\(left)"

        if (left > 20) {
        
            topCounterLabel.textColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
            bottomCounterLabel.textColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
        } else {
       
            topCounterLabel.textColor = UIColor.red
            bottomCounterLabel.textColor = UIColor.red
        }
    }
    
    func setReplyButton(ready: Bool) {
        
        replyButton.setTitleColor(UIColor.white, for: .normal)
        replyButton.layer.borderWidth = 0
        isReadyToTweet = ready
        replyButton.isUserInteractionEnabled = ready


        if (!ready) {
            replyButton.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 0.5)
            //tweetButton.setTitleColor(UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1), for: .normal) // grey
            //tweetButton.layer.borderColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1).cgColor //dary grey
        } else {
            replyButton.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        }
    }
    
    func sendTweet() {
        composeTextView.resignFirstResponder()
        topCounterLabel.isHidden = true
        self.navigationController?.navigationBar.addSubview(UIView())

        
        TwitterClient.sharedInstance.update(status: composeTextView.text, inReplyToStatusId: replyingTweet?.remoteIdStr,            success: { (tweet: Tweet?) in
            if let newTweet = tweet {
                let userInfo:[String: Tweet] = ["tweet": newTweet]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newTweet"), object: nil, userInfo: userInfo)
            }
        }) { (error: Error) in
            print("error \(error.localizedDescription)")
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tweetViewController = storyboard.instantiateViewController(withIdentifier: "Homeline") as! UINavigationController
        self.navigationController?.pushViewController(tweetViewController.topViewController!, animated: true)

       // self.dismiss(animated: true, completion: nil)

    }
    
    /*func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWithPhoneNumber phoneNumber: String!) {
        if let url = URL(string: "tel://\(phoneNumber!)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }*/

}

extension ComposeTweetViewController : UITextViewDelegate {
    
    // MARK: - Text View delegate methods
    func textViewDidChange(_ textView: UITextView) {
        
        print("textViewDidChange in compose")
        let currentCount = textView.text.characters.count
        
        if (currentCount > 0) {
            textView.placeholder = ""
        }
        else{
            textView.placeholder = "What's happening?"
        }
        
        let charactersLeft = 140 - currentCount
        setCountdownLabels(left: charactersLeft)
        
        if (isReadyToTweet) {
            if (charactersLeft < 0 || charactersLeft > 139) {
                setReplyButton(ready: false)
            }
        } else {
            if (charactersLeft < 140 && charactersLeft > -1) {
                setReplyButton(ready: true)
            }
        }
    }
    
}
extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {

        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {

        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        print("resizePlaceholder")

        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        print("addPlaceholder")

        let placeholderLabel = UILabel()
        placeholderLabel.frame = CGRect(x: 8, y: 9, width: 280, height: 30)

        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        placeholderLabel.textColor = UIColor(red: 170/255, green: 184/255, blue: 194/255, alpha: 1)
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.characters.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self

    }
    

    
}


extension String {
    func nsRange(from range: Range<Index>) -> NSRange {
        let lower = UTF16View.Index(range.lowerBound, within: utf16)
        let upper = UTF16View.Index(range.upperBound, within: utf16)
        return NSRange(location: utf16.startIndex.distance(to: lower), length: lower.distance(to: upper))
    }
}

extension UIAlertAction {
    convenience init(title: String?, style: UIAlertActionStyle, image: UIImage, handler: ((UIAlertAction) -> Void)? = nil) {
        self.init(title: title, style: style, handler: handler)
        self.actionImage = image
    }
    
    convenience init?(title: String?, style: UIAlertActionStyle, imageNamed imageName: String, handler: ((UIAlertAction) -> Void)? = nil) {
        if let image = UIImage(named: imageName) {
            self.init(title: title, style: style, image: image, handler: handler)
        } else {
            return nil
        }
    }
    
    var actionImage: UIImage {
        get {
            return self.value(forKey: "image") as? UIImage ?? UIImage()
        }
        set(image) {
            self.setValue(image, forKey: "image")
        }
    }
}
