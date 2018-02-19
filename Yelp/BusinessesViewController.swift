//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  UISearchResultsUpdating {
    
    
    
    var businesses: [Business]!
    var filteredData: [Business]!
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.filteredData = self.businesses
            self.tableView.reloadData()
            /*
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            */
            }

        )
    }
        
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
        } else {
            return 0
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        
        cell.business = (indexPath.row < (filteredData.count)) ? filteredData[indexPath.row] : businesses[indexPath.row]
            
        return cell
            
    }
    
    
       
    /* Example of Yelp search with more search options specified */
    
    /*
     Business.searchWithTerm(term: searchText, sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
     self.businesses = businesses
     
     for business in businesses {
     print(business.name!)
     print(business.address!)
     }
     }
     */
    
    public func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? businesses: businesses.filter( { (data: Business) -> Bool in
                return (data.name)?.range(of: searchText, options: .caseInsensitive) != nil
            })
            
            print("changed filtered data")
            
            tableView.reloadData()
        }
    }
        /*
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? businesses: businesses.filter { (data: Business) -> Bool in
            
            if let item = data.name {
                return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            return false
        }
        tableView.reloadData()
        
    }*/
        
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

