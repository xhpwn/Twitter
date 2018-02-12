//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            profileImage.layer.cornerRadius = profileImage.frame.size.width/2
            profileImage.clipsToBounds = true
            profileImage.af_setImage(withURL: tweet.user.profileImage!)
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            userNameLabel.text = "@" + tweet.user.userName!
            dateLabel.text = tweet.createdAtString
            favoriteButton.setTitle(String(tweet.favoriteCount), for: UIControlState.normal)
            retweetButton.setTitle(String(tweet.retweetCount), for: UIControlState.normal)
           
            (tweet.favorited)! ? self.favoriteButton.setTitle("Favorited \(tweet.favoriteCount)", for: UIControlState.normal) : self.favoriteButton.setTitle("Favorite \(tweet.favoriteCount)", for: UIControlState.normal)
            
            (tweet.retweeted) ? self.retweetButton.setTitle("Retweeted \(tweet.retweetCount)", for: UIControlState.normal) : self.retweetButton.setTitle("Retweet \(tweet.retweetCount)", for: UIControlState.normal)
            
        }
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        
        if (tweet.favorited != true) {
            tweet.favorited = true
            tweet.favoriteCount += 1
            self.favoriteButton.setTitle("Favorited \(tweet.favoriteCount)", for: UIControlState.normal)
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting \(error.localizedDescription)")
                    
                }
            }
        }
        else {
            tweet.favorited = false
            tweet.favoriteCount -= 1
            self.favoriteButton.setTitle("Favorite \(tweet.favoriteCount)", for: UIControlState.normal)
            APIManager.shared.unfavorite(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting \(error.localizedDescription)")
                    
                }
            }
        }
        
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        if (tweet.retweeted != true) {
            tweet.retweeted = true
            tweet.retweetCount += 1
            self.retweetButton.setTitle("Retweeted \(tweet.retweetCount)", for: UIControlState.normal)
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting \(error.localizedDescription)")
                    
                }
            }
        }
        else {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            self.retweetButton.setTitle("Retweet \(tweet.retweetCount)", for: UIControlState.normal)
            APIManager.shared.unretweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error untweeting \(error.localizedDescription)")
                    
                }
            }
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
