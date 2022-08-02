//
//  ViewController.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let addPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rickandmorty")
        imageView.alpha = 0.3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var characterButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .getBoldLabel22()
        button.backgroundColor = .specialBlueLabel
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.specialGreen.cgColor
        button.setTitle("CHARACTERS", for: .normal)
        button.setTitleColor(UIColor.specialYellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(characterButtonTap), for: .touchUpInside)
        button.applyShadow(cornerRadius: 10, opacity: 1.0)
        return button
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .getBoldLabel22()
        button.backgroundColor = .specialBlueLabel
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.specialGreen.cgColor
        button.setTitle("LOCATIONS-S-s", for: .normal)
        button.setTitleColor(UIColor.specialYellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(locationButtonTap), for: .touchUpInside)
        button.applyShadow(cornerRadius: 10, opacity: 1.0)
        return button
    }()
    
    lazy var episodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .getBoldLabel22()
        button.backgroundColor = .specialBlueLabel
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.specialGreen.cgColor
        button.setTitle("EPISODES", for: .normal)
        button.setTitleColor(UIColor.specialYellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(episodeButtonTap), for: .touchUpInside)
        button.applyShadow(cornerRadius: 10, opacity: 1.0)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(addPhotoImageView)
        view.addSubview(characterButton)
        view.addSubview(locationButton)
        view.addSubview(episodeButton)
    }
    
    @objc private func characterButtonTap() {
        let characterViewController = CharacterViewController()
        navigationItem.backButtonTitle = "B-B-b-back!"
        navigationController?.pushViewController(characterViewController, animated: true)
        characterViewController.modalPresentationStyle = .fullScreen
    }
    
    @objc private func locationButtonTap() {
        let locationViewController = LocationViewController()
        navigationItem.backButtonTitle = "B-B-b-back!"
        navigationController?.pushViewController(locationViewController, animated: true)
        locationViewController.modalPresentationStyle = .fullScreen
    }
    
    @objc private func episodeButtonTap() {
        let episodesViewController = EpisodesViewController()
        navigationItem.backButtonTitle = "B-B-b-back!"
        navigationController?.pushViewController(episodesViewController, animated: true)
        episodesViewController.modalPresentationStyle = .fullScreen
    }
}


//MARK: - SetConstraints

extension MainViewController {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            characterButton.topAnchor.constraint(equalTo: view.centerYAnchor),
            characterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterButton.widthAnchor.constraint(equalToConstant: 300),
            characterButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: characterButton.bottomAnchor, constant: 40),
            locationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationButton.widthAnchor.constraint(equalToConstant: 300),
            locationButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            episodeButton.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 40),
            episodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            episodeButton.widthAnchor.constraint(equalToConstant: 300),
            episodeButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            addPhotoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            //  addPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPhotoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            addPhotoImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            addPhotoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            //            addPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            //            addPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
    }
}
