//
//  CollectionCell.swift
//  kit-tools
//
//  Created by Émerson M Luz on 30/03/23.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    static var identifier = "collectionCell"
    
    var imageName: [String] = {
        var name: [String] = []
        name.append("Do It")
        name.append("Calculadora")
        name.append("Pomodoro")
        name.append("Holidays")
        name.append("Clima")
        let namesSorted = name.sorted()
        return namesSorted
    }()
    
    lazy var toolIconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor.black.cgColor
        return image
    }()
    
    lazy var toolNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 16)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    func setCell(indexCell: Int) {
        setTool(indexImageName: indexCell)
        setComponents()
        setConstraints()
    }
    
    private func setComponents() {
        contentView.addSubview(toolIconImageView)
        contentView.addSubview(toolNameLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            toolIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            toolIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            toolIconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            toolIconImageView.bottomAnchor.constraint(equalTo: toolNameLabel.topAnchor, constant: -6),
            
            toolNameLabel.heightAnchor.constraint(equalToConstant: 20),
            toolNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            toolNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            toolNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setTool(indexImageName: Int) {
        toolNameLabel.text = imageName[indexImageName]
        toolIconImageView.image = UIImage(named: imageName[indexImageName])
    }
    
}
