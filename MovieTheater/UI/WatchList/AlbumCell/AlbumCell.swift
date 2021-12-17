//
//  AlbumCell.swift
//  MovieTheater
//
//  Created by duytran on 12/13/21.
//

import UIKit

class AlbumCell: UITableViewCell {

    static var nib : UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    static var reuseableIdentifier:String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupDisplay(album:Album, quantity:Int = 0) {
        self.textLabel?.text = album.name
        self.detailTextLabel?.text = "\(quantity) items"
        self.detailTextLabel?.textColor = .secondaryLabel
        self.imageView?.image = UIImage(systemName: album.imageName)
    }

}
