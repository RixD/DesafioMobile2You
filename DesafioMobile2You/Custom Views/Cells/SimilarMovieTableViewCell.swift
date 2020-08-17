//
//  SimilarMovieTableViewCell.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import UIKit

class SimilarMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var similarMoviePosterImage: UIImageView!
    @IBOutlet weak var similarMovieTitle: UILabel!
    @IBOutlet weak var similarMovieSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(movie: Movie, genreList: GenreList? = nil) {
        similarMovieTitle.text = movie.originalTitle
        similarMovieSubTitle.text = movie.originalTitle
        
        let movieReleaseYear = movie.releaseDate.getYear(from: movie.releaseDate, with: "yyyy-MM-dd")
        var genresString = ""
        
        if let genresIds = movie.genreIds {
            for genreId in genresIds {
                if let genreId = genreId {
                    genresString.append(genreId == genresIds[0] ? " " : ", ")
                    genresString.append("\(genreList?.getGenre(with: genreId) ?? "")")
                }
            }
        }
        
        let subtitleString = "\(movieReleaseYear) \(genresString)"        
        let subtitleAttributedString = highlightYearColor(from: subtitleString, with: movieReleaseYear)
        
        similarMovieSubTitle.text = subtitleString
        similarMovieSubTitle.attributedText = subtitleAttributedString
        
        similarMoviePosterImage.getMoviePosterImage(from: movie.posterPath, with: "w92")
    }
    
    func highlightYearColor(from subTitleText: String, with yearString: String) -> NSMutableAttributedString {
        var result = NSMutableAttributedString()
                
        result = NSMutableAttributedString(string: subTitleText)
        result.setColorForText(textForAttribute: yearString, withColor: UIColor(hex: "487870"))
            
        return result
    }
}
