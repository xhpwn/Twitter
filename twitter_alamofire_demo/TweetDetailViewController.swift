//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Anubhav Saxena on 2/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        if let tweet = tweet {
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
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
