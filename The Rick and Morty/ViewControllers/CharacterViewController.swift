//
//  CharacterViewController.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import UIKit

class CharacterViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 150
        tableView.backgroundColor = .specialCellBackground
        tableView.separatorColor = .specialBlueLabel
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var characterCount = 0
    private var page = 1
    private var nextPage = true
    private let idTableViewCell = "idTableViewCell"
    
    private var searchController = UISearchController()
    private var searchedText = String()
    private var isFiltred = false
    
    private var characters: CharacterList?
    private var resultsArray = [Character]()
    private var filtredArray = [Character]()
    
    //MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCharacters(page: page)
        navigationBarSettings()
        setupViews()
        setupDelegate()
        setConstraints()
        
        tableView.register(СharacterTableViewCell.self, forCellReuseIdentifier: idTableViewCell)
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
            searchController.searchBar.placeholder = "Search character..."
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
    
    private func filtringCharacter(text: String) {
        for location in resultsArray {
            if location.name.lowercased().contains(text.lowercased())  {
                filtredArray.append(location)
            }
        }
    }
}
//MARK: - UISearchBarDelegate

extension CharacterViewController: UISearchBarDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        refreshData()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        filtredArray = [Character]()
        filtringCharacter(text: text)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refreshData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredArray = [Character]()
        isFiltred = (searchText.count > 0 ? true : false)
        filtringCharacter(text: searchText)
        self.searchedText = searchText
        tableView.reloadData()
    }
}
//MARK: - UITableViewDataSource

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltred ? filtredArray.count : resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTableViewCell, for: indexPath) as! СharacterTableViewCell
        let characterModel = isFiltred ? filtredArray[indexPath.row] : resultsArray[indexPath.row]
        cell.cellConfigure(model: characterModel)
        cell.setHiglightToLable(searchText: self.searchedText, text: characterModel.name)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension CharacterViewController: UITableViewDelegate {
    
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

extension CharacterViewController {
    
    private func fetchCharacters(page: Int)  {
        NetworkManager.shared.getCaracters(page: page, name: nil, status: nil, species: nil, gender: nil) { [weak self] (characters) in
            guard let self = self else {return}
            let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.resultsArray += characters
                self.tableView.reloadData()
                let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: false)
            }
        }
    }
}

//MARK: - SetConstraints

extension CharacterViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
