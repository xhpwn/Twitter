//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Anubhav Saxena on 2/20/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var followersLabeel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.getCurrentAccount(completion: { (user, error) in
            if let error = error {
                print (error)
            } else if let user = user {
                self.userNameLabel.text = user.userName
                self.tagLabel.text = "@" + user.name
                self.imageView.af_setImage(withURL: user.profileImage!)
                self.followersLabeel.text = "\(user.followersCount!)"
                self.followingLabel.text = "\(user.followingCount!)"
                self.tweetsLabel.text = "\(user.totalTweets!)"
            }
        })
        
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
