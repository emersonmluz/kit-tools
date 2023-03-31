//
//  ViewController.swift
//  kit-tools
//
//  Created by Émerson M Luz on 30/03/23.
//

import UIKit

class KitToolsViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collection.translatesAutoresizingMaskIntoConstraints = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection.collectionViewLayout = layout
        collection.showsVerticalScrollIndicator = false
        collection.contentMode = .scaleToFill
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.shared.identifier)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        setComponents()
        setConstraints()
    }
    
    func setComponents() {
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension KitToolsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionCell.shared.getNumberOfTools()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.shared.identifier, for: indexPath) as! CollectionCell
        cell.setCell(indexCell: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
