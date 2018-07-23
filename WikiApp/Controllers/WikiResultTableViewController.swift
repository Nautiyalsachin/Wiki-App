//
//  WikiResultTableViewController.swift
//  WikiApp
//
//  Created by Sachin Nautiyal on 7/24/18.
//  Copyright © 2018 Sachin Nautiyal. All rights reserved.
//

import UIKit

class WikiResultTableViewController: UITableViewController {

    var wikiResults : Wiki?
    let searchController = UISearchController(searchResultsController: nil)
    
    struct  Constants {
        static let cellidentifier = "WikiResultTableViewCell"
        static let title = "Wiki Search"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.title
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        self.title = Constants.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getWikiResults()
    }
    
    private func getWikiResults() {
        let networkHandler = NetworkHandler()
        networkHandler.getWikiData { (wiki) in
            if let wiki = wiki {
                self.wikiResults = wiki
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let wikiResults = wikiResults else { return 0 }
        guard let pages = wikiResults.query?.pages else { return 0 }
        return pages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellidentifier, for: indexPath) as? WikiResultTableViewCell {
            guard let pages = wikiResults?.query?.pages else { return UITableViewCell() }
            cell.pageResult = pages[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func filterContentForSearchText(_ searchText: String) { //FIXME : API call will be added here
//        filteredCandies = candies.filter({( ) -> Bool in
//            let doesCategoryMatch = (scope == "All") || (candy.category == scope)
//
//            if searchBarIsEmpty() {
//                return doesCategoryMatch
//            } else {
//                return doesCategoryMatch && candy.name.lowercased().contains(searchText.lowercased())
//            }
//        })
//        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}

extension WikiResultTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
}

extension WikiResultTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let text = searchBar.text {
            filterContentForSearchText(text)
            print("text key : ",text)
        }
    }
}
