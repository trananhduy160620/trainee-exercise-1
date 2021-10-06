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
        containerView.layer.cornerRadius = containerView.frame.height / 2
        containerView.layer.masksToBounds = true
        
        // custom image color for button
        let image = UIImage(systemName: "ellipsis.circle.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        showDetailButton.setImage(image, for: .normal)
    }
    
    func setupDisplay(movie: Movie) {
        let urlString = "https://www.themoviedb.org/t/p/w220_and_h330_face" + movie.posterPath
        guard let url = URL(string: urlString) else { return }
        movieImageView.downloaded(from: url)
        movieNameLabel.text = movie.title
        movieDateLabel.text = movie.releaseDate.toDate()
        ratingLabel.text = "\(round(movie.rating * 10))"
    }
}
