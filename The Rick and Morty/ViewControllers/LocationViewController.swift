//
//  LocationViewController.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import UIKit

class LocationViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 120
        tableView.backgroundColor = .specialCellBackground
        tableView.separatorColor = .specialBlueLabel
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var characterCount = 0
    private var page = 1
    private var nextPage = true
    private var searchController = UISearchController()
    private var searchedText = String()
    private var isFiltred = false
    private let idTableViewCell = "idTableViewCell"
    
    private var characters: PagedLocation?
    private var resultsArray = [Location]()
    private var filtredArray = [Location]()
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCharacters(page: page)
        navigationBarSettings()
        setupViews()
        setupDelegate()
        setConstraints()
        
        tableView.register(LocationsTableViewCell.self, forCellReuseIdentifier: idTableViewCell)
    }
    
    //MARK: - Setups
    private func setupViews() {
        view.backgroundColor = .specialCellBackground
        view.addSubview(tableView)
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchBar.delegate = self
    }
    
    private func navigationBarSettings() {
        
        if let navController = navigationController {
            navController.navigationBar.barStyle = .black
            navController.navigationBar.tintColor = .specialYellow
            
            searchController = UISearchController(searchResultsController: nil)
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.returnKeyType = .done
            searchController.searchBar.placeholder = "Search location..."
            navigationItem.searchController = searchController
            definesPresentationContext = true
            navigationItem.hidesSearchBarWhenScrolling = false
            searchController.isActive = true
        }
    }
    
    private func refreshData() {
        filtredArray.removeAll()
        isFiltred = false
        tableView.reloadData()
    }
    
    private func filtringLocation(text: String) {
        for location in resultsArray {
            if location.name.lowercased().contains(text.lowercased())  {
                filtredArray.append(location)
            }
        }
    }
}

//MARK: - UITableViewDataSource

extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltred ? filtredArray.count : resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTableViewCell, for: indexPath) as! LocationsTableViewCell
        let characterModel = isFiltred ? filtredArray[indexPath.row] : resultsArray[indexPath.row]
        cell.cellConfigure(model: characterModel)
        cell.setHiglightToLable(searchText: self.searchedText, text: characterModel.name)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension LocationViewController: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = scrollView.frame.size.height
        let contentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if contentOffset > contentHeight - height {
            guard nextPage else { return }
            page += 1
            fetchCharacters(page: page)
        }
    }
}

//MARK: - UISearchBarDelegate

extension LocationViewController: UISearchBarDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        refreshData()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        filtredArray = [Location]()
        filtringLocation(text: text)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refreshData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredArray = [Location]()
        isFiltred = (searchText.count > 0 ? true : false)
        filtringLocation(text: searchText)
        self.searchedText = searchText
        tableView.reloadData()
    }
}
//MARK: - FetchCharacters

extension LocationViewController {
    
    func fetchCharacters(page: Int) {
        NetworkManager.shared.getLocations(page: page, name: nil, type: nil, dimension: nil) { [weak self] (locations) in
            guard let self = self else {return}
            let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.resultsArray += locations
                let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: false)
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - SetConstraints

extension LocationViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
