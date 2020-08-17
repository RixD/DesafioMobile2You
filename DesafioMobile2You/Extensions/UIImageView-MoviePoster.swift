//
//  UIImageView-MoviePoster.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import UIKit

extension UIImageView {
    func getMoviePosterImage(from posterPath: String, with size: String) {
        let cache = CacheManager.shared.cache
        
        let moviePosterImageProvider = TmdbMovieProvider.getMoviePosterImage(posterPath: posterPath, size: size)
        
        let cacheKey = NSString(string: posterPath)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        if let url = moviePosterImageProvider.urlRequest {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                if error != nil { return }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
                guard let data = data else { return }
                
                guard let image = UIImage(data: data) else { return }
                cache.setObject(image, forKey: cacheKey)
                
                DispatchQueue.main.async { self.image = image }
            }
            
            task.resume()
        } else {
            self.image = UIImage(named: "movieEmptyPoster")!
        }
    }
}
