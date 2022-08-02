//
//  EpisodesTableViewCell.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {
    
    let namaEpisodeLabel = UILabel(text: "",
                                   font: .getBoldLabel22(),
                                   color: .specialBlueLabel,
                                   line: 0)
    
    let episodeLabel = UILabel(text: "",
                               font: .getRegularLabel18(),
                               color: .specialGreen,
                               line: 0)
    
    let dateLabel = UILabel(text: "",
                            font: .getRegularLabel18(),
                            color: .specialGreen,
                            line: 0)
    
    private var episodeStackView = UIStackView()
    
    //MARK: - Override
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    
    private func setupViews() {
        backgroundColor = .specialCellBackground
        selectionStyle = .none
        
        episodeStackView =  UIStackView(arrangedSubviews: [namaEpisodeLabel,
                                                           episodeLabel,
                                                           dateLabel],
                                        axis: .vertical,
                                        spacing: 8)
        addSubview(episodeStackView)
    }
    
    //MARK: - CellConfigure
    
    func cellConfigure(model: Episode) {
        namaEpisodeLabel.text = model.name
        episodeLabel.text = "Episode: \(model.episode)"
        dateLabel.text =  "Air date: \(model.airDate)"
    }
    
    func setHiglightToLable(searchText: String, text: String) {
        self.namaEpisodeLabel.setHighlighted(text, with: searchText)
    }
    
    //MARK: - SetConstraints
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            episodeStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            episodeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            episodeStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
