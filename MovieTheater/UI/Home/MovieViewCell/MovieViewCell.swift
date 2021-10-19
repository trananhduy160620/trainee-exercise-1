//
//  MovieViewCell.swift
//  MovieTheater
//
//  Created by duytran on 10/5/21.
//

import UIKit

class MovieViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var showDetailButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // custom cell
        backgroundColor = .white
        layer.cornerRadius = 5
        
        // Custom container view
        containerView.layer.borderColor = UIColor.systemGreen.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = containerView.frame.height / 2
        containerView.layer.masksToBounds = true
        
        // custom image color for button
        let image = UIImage(systemName: "ellipsis.circle.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        showDetailButton.setImage(image, for: .normal)
    }
    
    func setupDisplay(movie: Movie) {
        guard let movieImagePath = movie.posterPath else { return }
        guard let movieReleaseDate = movie.releaseDate else { return }
        guard let movieRating = movie.voteAverage else { return  }
        let urlString = "https://www.themoviedb.org/t/p/w220_and_h330_face" + movieImagePath
        guard let url = URL(string: urlString) else { return }
        movieImageView.downloaded(from: url)
        movieNameLabel.text = movie.title
        movieDateLabel.text = movieReleaseDate.toDate()
        ratingLabel.text = Double(movieRating * 10).clean + "%"
        
    }
}
