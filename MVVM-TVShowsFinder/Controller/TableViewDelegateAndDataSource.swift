//
//  TableViewDelegateAndDataSource.swift
//  MVVM-TVShowsFinder
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import Foundation
import UIKit

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if !tvShowViewModelList.lastPageReached {
            return tvShowViewModelList.currentNumberOfTVShows + 1
        } else {
             return tvShowViewModelList.currentNumberOfTVShows
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TVShowTableViewCell
        
        if (indexPath.row < tvShowViewModelList.currentNumberOfTVShows) {
            cell.configureCell(with: tvShowViewModelList.tvShows[indexPath.row])
        } else {
            cell.configureCell(with: nil)
        }
        
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let cellHeight = tableView.rowHeight
        let currentOffset = tableView.contentOffset.y
        let maximumOffset = tableView.contentSize.height - tableView.frame.size.height
        
        if currentOffset >= maximumOffset - cellHeight{
            if !service.isFetchingNextPage {
                tvShowViewModelList.fetchPage()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        goToTheTopButton.isHidden = tableView.contentOffset.y > 0 ? false : true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsViewController = DetailsViewController(tvShowViewModel: tvShowViewModelList.tvShows[indexPath.row])
        
        
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    
    
}
