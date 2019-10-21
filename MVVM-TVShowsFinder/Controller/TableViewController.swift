//
//  ViewController.swift
//  MVVM-TVShowsFinder
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, TVShowsViewModelListDelegate {
    
    
    //MARK:- TableView
    let tableView : UITableView = {
        
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = true
        tableView.decelerationRate = .fast
        tableView.contentInset = UIEdgeInsets.zero
        tableView.contentOffset = CGPoint(x: 0.0, y: 0.0)
        return tableView
    }()
    
    let goToTheTopButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("⇧", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowOpacity = 1
        return button
    }()
    
    let cellID = "cellID"
    
    let tvShowViewModelList: TVShowsViewModelList
    
    let service: Service
    
    init(service: Service) {
        
        self.service = service
        self.tvShowViewModelList = TVShowsViewModelList(service: service)
        
        super.init(nibName: nil, bundle: nil)
        
        self.tvShowViewModelList.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async {
            self.buttonConstraints()
            
        }
        
        
        
        goToTheTopButton.addTarget(self, action: #selector(topButtonPressed), for: .touchUpInside)
        
        view.backgroundColor = .white
        setUpTableView()
        
        
    }

    //MARK:- TableView Setup
    private func setUpTableView(){
      tableView.dataSource = self
      tableView.delegate = self
      tableView.register(TVShowTableViewCell.self, forCellReuseIdentifier: cellID)
      view.addSubview(tableView)
      NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                   tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                   tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                   tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
    }
    
    @objc func topButtonPressed () {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        
        print()
    }
    
    func buttonConstraints () {
        
        view.addSubview(goToTheTopButton)
        
        NSLayoutConstraint.activate([goToTheTopButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50), goToTheTopButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50), goToTheTopButton.widthAnchor.constraint(equalToConstant: 50), goToTheTopButton.heightAnchor.constraint(equalToConstant: 50)])
        
        
        
//        NSLayoutConstraint.activate([goToTheTopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), goToTheTopButton.centerYAnchor.constraint(equalTo: view.centerYAnchor), goToTheTopButton.widthAnchor.constraint(equalToConstant: 50), goToTheTopButton.heightAnchor.constraint(equalToConstant: 50)])
        
    }
    
    
    func fetchCompleted() {
        
        tableView.reloadData()
    }

}

