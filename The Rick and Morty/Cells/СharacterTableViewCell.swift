//
//  СharacterTableViewCell.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import UIKit

class СharacterTableViewCell: UITableViewCell {
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.specialGreen.cgColor
        imageView.applyShadow(cornerRadius: 2.0, opacity: 0.5)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameCharacterLabel = UILabel(text: "",
                                     font: .getBoldLabel22(),
                                     color: .specialBlueLabel, line: 0)
    
    let speciesLabel = UILabel(text: "",
                               font: .getRegularLabel18(),
                               color: .specialGreen, line: 0)
    
    let genderLabel = UILabel(text: "",
                              font: .getRegularLabel18(),
                              color: .specialGreen, line: 0)
    
    private let locationTextLabel = UILabel(text: "",
                                            font: .getRegularLabel18(),
                                            color: .specialGreen, line: 0)
    
    private var characterStackView = UIStackView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
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
        
        characterStackView =  UIStackView(arrangedSubviews: [nameCharacterLabel,
                                                             speciesLabel,
                                                             genderLabel,
                                                             locationTextLabel],
                                          axis: .vertical,
                                          spacing: 2)
        addSubview(characterImageView)
        addSubview(characterStackView)
    }
    
    func cellConfigure(model: Result) {
        nameCharacterLabel.text = model.name
        speciesLabel.text = "Species: \(model.species)"
        genderLabel.text =  "Gender: \(model.gender)"
        locationTextLabel.text = "Location: \(model.location.name )"

        let url: URL = URL(string: "https://rickandmortyapi.com/api/character/avatar/\(model.id).jpeg")!

        NetworkImageFetch.shared.requestImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                self.characterImageView.image = image
            case .failure(_):
                print("no image")
            }
        }
    }
    
    func setHiglightToLable(searchText: String, text: String) {
        self.nameCharacterLabel.setHighlighted(text, with: searchText)
    }
    
    //MARK: - SetConstraints
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            characterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            characterImageView.heightAnchor.constraint(equalToConstant: 120),
            characterImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            characterStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterStackView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            characterStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
