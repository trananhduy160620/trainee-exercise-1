//
//  HeaderTableView.swift
//  MovieTheater
//
//  Created by duytran on 10/6/21.
//

import UIKit

class HeaderTableView: UITableViewHeaderFooterView {
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.backgroundColor = .white
        return stack
    }()
    public weak var headerDelegate:HeaderTableViewDelegate?
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }
    
    private func setupSubViews() {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        backgroundView = whiteView
        setupStackView()
    }
    
    private func setupStackView() {
        // Trending Label
        let trendingLabel = UILabel()
        trendingLabel.text = "Trending"
        trendingLabel.textAlignment = .natural
        trendingLabel.font = UIFont.boldSystemFont(ofSize: 25)
        trendingLabel.textColor = .black
        trendingLabel.backgroundColor = .white
        
        // ShowAll Button
        let showAllButton = UIButton()
        showAllButton.setTitle("Show All", for: .normal)
        showAllButton.backgroundColor = UIColor(red: 4/255, green: 36/255, blue: 65/255, alpha: 1)
        showAllButton.setTitleColor(.white, for: UIControl.State.normal)
        showAllButton.addTarget(self, action: #selector(showAllButtonClick), for: UIControl.Event.touchUpInside)
        showAllButton.layer.cornerRadius = 15
        showAllButton.layer.masksToBounds = true
        
        stackView.addArrangedSubview(trendingLabel)
        stackView.addArrangedSubview(showAllButton)
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    // action for show all button click
    @objc func showAllButtonClick() {
        headerDelegate?.handleShowAllButtonClick()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
