//
//  HomeViewController.swift
//  MovieTheater
//
//  Created by duytran on 10/5/21.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var popularMovieCollectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .myColor
        
        setupLeftBarButton()
        setupTitleView()
        setupRightBarButtons()
        
        popularMovieCollectionView.dataSource = self
        popularMovieCollectionView.delegate = self
        popularMovieCollectionView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieViewCell")
        
    }
    
    private func setupLeftBarButton() {
        let leftImage = UIImage(systemName: "line.horizontal.3")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let moreBarButton = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = moreBarButton
    }
    private func setupRightBarButtons() {
        let searchImage = UIImage(systemName: "magnifyingglass")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: nil)
        
        let userImage = UIImage(systemName: "person.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let userBarButton = UIBarButtonItem(image: userImage, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [searchBarButton, userBarButton]
    }
    private func setupTitleView() {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "img_tmdb")
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }

    

}


extension HomeViewController : UICollectionViewDelegate {
    
}

extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 5
        return cell
    }
    
    
}




extension UIColor {
    static let myColor = UIColor(red: 13/255, green: 37/255, blue: 63/255, alpha: 1)
}


