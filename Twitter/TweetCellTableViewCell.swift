//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Rebecca Li on 9/22/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    
    var favorited:Bool = false
    var tweetId:Int = -1
    var retweeded:Bool = false
    
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        retweeded = isRetweeted
        if(retweeded){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
            print("Successful in Retweeting tweet: \(self.tweetId)")
        }, failure: { (Error) in
            print("Error for retweeting: \(Error)")
        })
//        let isRetweeted = !retweeded
//        if(isRetweeted){
//            TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {
//                self.setRetweeted(true)
//                print("Successful in Retweeting tweet: \(self.tweetId)")
//            }, failure: { (Error) in
//                print("Error for retweeting: \(Error)")
//            })
//        }
//        else{
//            TwitterAPICaller.client?.unreTweet(tweetId: tweetId, success: {
//                self.setRetweeted(false)
//                print("Successful in UNretweeting: \(self.tweetId)")
//            }, failure: { (Error) in
//                print("Error for UNretweeting: \(Error)")
//            })
//        }

    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
                print("Successful in favoriting Tweet: \(self.tweetId)")
            }, failure: { (Error) in
                print("Favorited Failed: \(Error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
                print("Successful in UNfavoriting tweet: \(self.tweetId)")
            }, failure: { (Error) in
                print("UNFavorited Failed: \(Error)")
            })
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
