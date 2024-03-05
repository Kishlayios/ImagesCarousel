//
//  HomeVC.swift
//  ImagesCarousel
//
//  Created by Kishlay Kishore on 04/03/24.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    // MARK: - Variables
    private var homeViewModel: HomeViewModel?
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        //search.showsCancelButton = true
        search.delegate = self
        search.placeholder = "Search by author name..."
        search.sizeToFit()
        return search
    }()
    var isSearchBtnEnabled = false
    var currentVisibleIndex = 0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableInit()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "List"
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Helper methods
    func setupTableInit() {
        self.tableView.register(UINib(nibName: "TableFirstSectionCell", bundle: nil), forCellReuseIdentifier: "TableFirstSectionCell")
        self.tableView.register(UINib(nibName: "DisplayImageInList", bundle: nil), forCellReuseIdentifier: "DisplayImageInList")
    }
    
    func setupViewModel() {
        homeViewModel = HomeViewModel()
        homeViewModel?.delegate = self
        homeViewModel?.callInitialApis()
    }

}

// MARK: - Table View DataSource Methods
extension HomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return homeViewModel?.arrImageList.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableFirstSectionCell", for: indexPath) as! TableFirstSectionCell
            cell.delegate = self
            cell.reloadInnerSetup(data: homeViewModel?.arrImageList ?? [])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayImageInList", for: indexPath) as! DisplayImageInList
            cell.setupData(data: homeViewModel?.arrImageList[currentVisibleIndex].childList?[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 44))
//        headerView.addSubview(searchBar)
        return searchBar
    }
    
}

// MARK: - TableView Delegates Methods
extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            //code
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        } else {
            return 44
        }
    }
}

// MARK: - Search Bar Delegate Methods
extension HomeVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        //hideKeyboardWhenTappedAOutsideSearchbar()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //if self.isSearchBtnEnabled {
            self.searchBar.text = ""
            self.searchBar.resignFirstResponder()
        //}
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.homeViewModel?.arrFilteredAuthorList = self.homeViewModel?.arrAuthorList ?? []
//        if !searchText.isEmpty {
//            self.homeViewModel?.arrFilteredAuthorList = (self.homeViewModel?.arrAuthorList ?? []).filter({($0.author?.lowercased() ?? "").contains(searchText.lowercased())})
//        }
//        reloadCollection()
    }
}

// MARK: - View Model Methods
extension HomeVC: HomeListVMTrigger,ImagesCardViewTrigger {
    func particularCardTapped(data: Any) {
        //code
    }
    
    func reloadTableData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func reloadOnDataReceive() {
        reloadTableData()
//        self.homeViewModel?.arrFilteredAuthorList = self.homeViewModel?.arrAuthorList ?? []
//        reloadCollection()
    }
    
}
