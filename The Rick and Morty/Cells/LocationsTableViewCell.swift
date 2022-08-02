//
//  LocationsTableViewCell.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import UIKit

class LocationsTableViewCell: UITableViewCell {
    
    let namaLocationLabel = UILabel(text: "",
                                    font: .getBoldLabel22(),
                                    color: .specialBlueLabel,
                                    line: 0)
    
    let typeLabel = UILabel(text: "",
                            font: .getRegularLabel18(),
                            color: .specialGreen,
                            line: 0)
    
    let dimensionLabel = UILabel(text: "",
                                 font: .getRegularLabel18(),
                                 color: .specialGreen,
                                 line: 0)
    
    private var locationStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialCellBackground
        selectionStyle = .none
        
        locationStackView =  UIStackView(arrangedSubviews: [namaLocationLabel,
                                                            typeLabel,
                                                            dimensionLabel],
                                         axis: .vertical,
                                         spacing: 8)
        
        addSubview(locationStackView)
    }
    
    func cellConfigure(model: Location) {
        namaLocationLabel.text = model.name
        typeLabel.text = "Type: \(model.type)"
        dimensionLabel.text =  "Dimension: \(model.dimension)"
    }
    
    func setHiglightToLable(searchText: String, text: String) {
        self.namaLocationLabel.setHighlighted(text, with: searchText)
    }
    
    //MARK: - SetConstraints
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            locationStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            locationStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            locationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
