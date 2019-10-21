//
//  DetailsViewController.swift
//  MVVM-TVShowsFinder
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let tvShowViewModel: TVShowViewModel
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "posterImageView"
        return imageView
    }()
    
    
    let name: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 30)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "titleLabel"
        return label
    }()
    
    let overview: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .black
        textView.font = UIFont(name: "Avenir", size: 20)
        textView.accessibilityIdentifier = "overviewLabel"
        return textView
    }()
        
    let date: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 18)
        label.accessibilityIdentifier = "dateLabel"
        return label
    }()
    
    let vote: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 18)
        label.accessibilityIdentifier = "dateLabel"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        setUpView()
    }
    
    init(tvShowViewModel: TVShowViewModel) {
        
        self.tvShowViewModel = tvShowViewModel
        self.image.load(url: tvShowViewModel.posterPath!)
        
        self.name.text = tvShowViewModel.name
        self.date.text = "📅 First aired: \(tvShowViewModel.firstAirDate)"
        self.vote.text = "⭐️ Vote:  \(tvShowViewModel.voteAverage)"
        self.overview.text = tvShowViewModel.overview
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpView() {
        view.addSubview(image)
        view.addSubview(name)
        view.addSubview(date)
        view.addSubview(vote)
        view.addSubview(overview)
        
        // TVShow name
        NSLayoutConstraint.activate([ name.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
                                      name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                      name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20), name.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)])
        
        // Poster Image View
        NSLayoutConstraint.activate([ image.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 40),
                                      image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                      image.widthAnchor.constraint(equalToConstant: 200),
                                      image.heightAnchor.constraint(equalToConstant: 300)])
        

        //Date
        NSLayoutConstraint.activate([ date.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
                                      date.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
                                      date.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)])
        
        //Vote
        NSLayoutConstraint.activate([ vote.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 20),
                                      vote.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
                                      vote.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)])
        
        //Overview
        NSLayoutConstraint.activate([ overview.topAnchor.constraint(equalTo: vote.bottomAnchor, constant: 20),
                                      overview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
                                      overview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
                                      overview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)])
        
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
