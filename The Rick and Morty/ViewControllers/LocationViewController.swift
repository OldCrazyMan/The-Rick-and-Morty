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
        tableView.register(LocationsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var characterCount = 0
    private var page = 1
    private var nextPage = true
    private var searchController = UISearchController()
    private var searchedText = String()
    private var isFiltred = false
    
    private var characters: PagedLocation?
    private var resultsArray = [Location]()
    private var filtredArray = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCharacters(page: page)
        tableView.reloadData()
        navigationBarSettings()
        setupViews()
        setupDelegate()
        setConstraints()
    }
    
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
    
    private func filtringRecipes(text: String) {
        for location in resultsArray {
            if location.name.lowercased().contains(text.lowercased())  {
                filtredArray.append(location)
            }
        }
    }
}
extension LocationViewController: UISearchBarDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        refreshData()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        filtredArray = [Location]()
        filtringRecipes(text: text)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refreshData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredArray = [Location]()
        isFiltred = (searchText.count > 0 ? true : false)
        filtringRecipes(text: searchText)
        self.searchedText = searchText
        tableView.reloadData()
    }
    
}
//MARK: - UITableViewDataSource

extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltred ? filtredArray.count : resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationsTableViewCell
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

//MARK: - FetchCharacters

extension LocationViewController {
    
    func fetchCharacters(page: Int) {
        NetworkDataFetch.shared.getLocationsData(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                if self.resultsArray.count < self.characterCount { self.nextPage = false }
                
                self.resultsArray += response.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: false)
                }
            case .failure(_):
                let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: true)
                self.alertOk(title: "Connect error", message: "Please, check your internet connection.")
            }
        }
    }
    
    func fetchCharacterCount() {
        NetworkDataFetch.shared.fetchCharacterCount() { [weak self] result in
            guard let self =  self else { return }
            
            switch result {
            case .success(let response):
                self.characterCount = response.info.count
            case .failure(_):
                return
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
