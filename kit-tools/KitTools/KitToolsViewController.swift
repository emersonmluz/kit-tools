//
//  ViewController.swift
//  kit-tools
//
//  Created by Émerson M Luz on 30/03/23.
//

import UIKit

final class KitToolsViewController: UIViewController {
    
    let coordinator: KitToolsCoordinator?
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collection.translatesAutoresizingMaskIntoConstraints = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection.collectionViewLayout = layout
        collection.showsVerticalScrollIndicator = false
        collection.contentMode = .scaleToFill
        collection.register(KitToolsCollectionCell.self, forCellWithReuseIdentifier: KitToolsCollectionCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    init(coordinator: KitToolsCoordinator?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupUI() {
        view.backgroundColor = .white
        setNavigationItem()
        setComponents()
        setConstraints()
    }
    
    func setNavigationItem() {
        self.navigationItem.backButtonTitle = " "
        self.navigationItem.title = "Kit Tools"
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
        let cell = KitToolsCollectionCell()
        return cell.imageName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KitToolsCollectionCell.identifier, for: indexPath) as! KitToolsCollectionCell
        cell.setCell(indexCell: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KitToolsCollectionCell.identifier, for: indexPath) as! KitToolsCollectionCell
        let app = cell.imageName[indexPath.row]
        var coordinatorReference: CoordinatorProtocol?
        switch app {
        case appName.doIt.rawValue:
            coordinatorReference = DoItCoordinator(navigation: coordinator?.navigation)
        case appName.calculadora.rawValue:
            coordinatorReference = CalculatorCoordinator(navigation: coordinator?.navigation)
        case appName.pomodoro.rawValue:
            coordinatorReference = PomodoroCoordinator(navigation: coordinator?.navigation)
        case appName.clima.rawValue:
            coordinatorReference = WeatherCoordinator(navigation: coordinator?.navigation)
        case appName.holidays.rawValue:
            coordinatorReference = HolidaysCoordinator(navigation: coordinator?.navigation)
        default:
            let alert = UIAlertController(title: "Erro", message: "Algo deu errado! Tente novamente mais tarde.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Entendi", style: .default))
            self.present(alert, animated: true)
        }
        if let coordinatorReference = coordinatorReference {
            self.navigationController?.navigationBar.prefersLargeTitles = false
            coordinator?.goToApp(coordinator: coordinatorReference)
        }
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
