//
//  MovieTableViewCell.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieLikes: UILabel!
    @IBOutlet weak var moviePopularity: UILabel!
    @IBOutlet weak var movieLikeButton: UIButton!
    
    @IBOutlet weak var movieNumberOfLikesButton: UIButton!
    
    var movieLiked: Bool = false
    var movieNumberOfLikes = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(movie: Movie) {
        movieTitle.text = movie.originalTitle
        
        ///Using voteCount because there is no like metric on the Movie Obj
        movieNumberOfLikes = movie.voteCount
        
        movieLikes.text = "\(movieNumberOfLikes) Likes"
        moviePopularity.text = "\(movie.popularity)"
    }
    
    //Mocking the like button action because there is no like metric on the Movie Obj
    @IBAction func LikeMovie(_ sender: UIButton) {
        sender.isSelected.toggle()
        movieNumberOfLikesButton.isSelected = sender.isSelected
        movieNumberOfLikes = sender.isSelected ? movieNumberOfLikes + 1 : movieNumberOfLikes - 1
        movieLikes.text = "\(movieNumberOfLikes) Likes"
        
        let springTimingParameters: UITimingCurveProvider = UISpringTimingParameters(dampingRatio: 0.5,initialVelocity: CGVector(dx:0, dy: 0))
                      
        let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: springTimingParameters)
        sender.transform = CGAffineTransform(scaleX: 1.2, y: 0.8)
        
        animator.addAnimations {
            sender.transform = .identity
        }
                              
        animator.startAnimation()
    }
    
}
