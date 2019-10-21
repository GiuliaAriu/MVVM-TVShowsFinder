//
//  TVShowTableViewCell.swift
//  MVVM-TVShowsFinder
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import Foundation
import UIKit

class TVShowTableViewCell: UITableViewCell {
    
    var tvShowViewModel: TVShowViewModel?
    
    var spinnerIndicator : UIActivityIndicatorView = {
      var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
      activityIndicator.color = .systemPurple
      activityIndicator.hidesWhenStopped = true
      activityIndicator.translatesAutoresizingMaskIntoConstraints = false
      activityIndicator.accessibilityIdentifier = "spinnerIndicator"
      return activityIndicator
    }()
    
    var tvShowName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemPurple
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "nameLabel"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpConstraints()
        emptyCellSetUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with tvShowViewModel: TVShowViewModel?) {
        if let tvShowViewModel = tvShowViewModel {
            
            DispatchQueue.main.async {
                self.tvShowViewModel = tvShowViewModel
                self.tvShowName.text = tvShowViewModel.name
                self.cellWithDataSetUp()
            }
        } else {
            emptyCellSetUp()
        }
    }
    
    func cellWithDataSetUp() {
        
        DispatchQueue.main.async { [unowned self] in
            self.spinnerIndicator.stopAnimating()
        }
        
        tvShowName.isHidden = false
        
    }
    
    func emptyCellSetUp() {
        
        DispatchQueue.main.async { [unowned self] in
            self.spinnerIndicator.startAnimating()
        }
        
        tvShowName.isHidden = true
        
    }
    
    
    private func setUpConstraints() {
        contentView.addSubview(tvShowName)
        contentView.addSubview(spinnerIndicator)
        
        //Spinner Indicator
        NSLayoutConstraint.activate([ spinnerIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                      spinnerIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        // Title Label
        NSLayoutConstraint.activate([ tvShowName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                      tvShowName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
