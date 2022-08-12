//
//  ViewController.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rickandmorty")
        imageView.alpha = 0.3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "RickHead")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "portalGun")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mortyHead")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var characterButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .getBoldLabel22()
        button.backgroundColor = .specialBlueLabel
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.specialDarkGreen.cgColor
        button.setTitle("CHARACTERS", for: .normal)
        button.setTitleColor(UIColor.specialYellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(characterButtonTap), for: .touchUpInside)
        button.applyShadow(cornerRadius: 10)
        return button
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = .getBoldLabel22()
        button.backgroundColor = .specialBlueLabel
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.specialDarkGreen.cgColor
        button.setTitle("LOCATIONS", for: .normal)
        button.setTitleColor(UIColor.specialYellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(locationButtonTap), for: .touchUpInside)
        button.applyShadow(cornerRadius: 10)
        return button
    }()
    
    lazy var episodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .getBoldLabel22()
        button.backgroundColor = .specialBlueLabel
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.specialDarkGreen.cgColor
        button.setTitle("EPISODES", for: .normal)
        button.setTitleColor(UIColor.specialYellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(episodeButtonTap), for: .touchUpInside)
        button.applyShadow(cornerRadius: 10)
        return button
    }()
    
    //MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - Setups
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(backgroundImageView)
        view.addSubview(characterButton)
        view.addSubview(characterImageView)
        view.addSubview(locationButton)
        view.addSubview(locationImageView)
        view.addSubview(episodeButton)
        view.addSubview(episodeImageView)
    }
    
    @objc private func characterButtonTap() {
        if characterButton.backgroundColor == UIColor.specialBlueLabel {
            characterButton.backgroundColor = UIColor.specialCellBackground
        }  else if characterButton.backgroundColor == UIColor.specialCellBackground {
            characterButton.backgroundColor = UIColor.specialBlueLabel
        }
        
        let characterViewController = CharacterViewController()
        navigationItem.backButtonTitle = "B-B-b-back!"
        navigationController?.pushViewController(characterViewController, animated: true)
        characterViewController.modalPresentationStyle = .fullScreen
    }
    
    @objc private func locationButtonTap() {
        if locationButton.backgroundColor == UIColor.specialBlueLabel {
            locationButton.backgroundColor = UIColor.specialCellBackground
        }  else if locationButton.backgroundColor == UIColor.specialCellBackground {
            locationButton.backgroundColor = UIColor.specialBlueLabel
        }
        
        let locationViewController = LocationViewController()
        navigationItem.backButtonTitle = "B-B-b-back!"
        navigationController?.pushViewController(locationViewController, animated: true)
        locationViewController.modalPresentationStyle = .fullScreen
    }
    
    @objc private func episodeButtonTap() {
        if episodeButton.backgroundColor == UIColor.specialBlueLabel {
            episodeButton.backgroundColor = UIColor.specialCellBackground
        }  else if episodeButton.backgroundColor == UIColor.specialCellBackground {
            episodeButton.backgroundColor = UIColor.specialBlueLabel
        }
        
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
            characterButton.bottomAnchor.constraint(equalTo: locationButton.topAnchor, constant: -40),
            characterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterButton.widthAnchor.constraint(equalToConstant: 350),
            characterButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: characterButton.topAnchor, constant: 1),
            characterImageView.leadingAnchor.constraint(equalTo: characterButton.leadingAnchor, constant: 0),
            characterImageView.bottomAnchor.constraint(equalTo: characterButton.bottomAnchor, constant: -1),
            characterImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            locationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            locationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationButton.widthAnchor.constraint(equalToConstant: 350),
            locationButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            locationImageView.topAnchor.constraint(equalTo: locationButton.topAnchor, constant: 1),
            locationImageView.leadingAnchor.constraint(equalTo: locationButton.leadingAnchor, constant: 10),
            locationImageView.bottomAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: -1),
            locationImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            episodeButton.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 40),
            episodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            episodeButton.widthAnchor.constraint(equalToConstant: 350),
            episodeButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            episodeImageView.topAnchor.constraint(equalTo: episodeButton.topAnchor, constant: 1),
            episodeImageView.leadingAnchor.constraint(equalTo: episodeButton.leadingAnchor, constant: 5),
            episodeImageView.bottomAnchor.constraint(equalTo: episodeButton.bottomAnchor, constant: -1),
            episodeImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
