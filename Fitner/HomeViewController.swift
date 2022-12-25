//
//  HomeViewController.swift
//  Fitner
//
//  Created by Aske on 2022/12/17.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private var routines: [String] = ["asda","asdgasdgs"]
    
    private lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProgramCollectionViewCell.self, forCellWithReuseIdentifier: "ProgramCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var addRoutineButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.pressAddRoutineButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initSubviews()
        // Do any additional setup after loading the view.
    }
    
    private func initSubviews() {
        setupNavigationBar()
        makeCollectionView()
        makeButtons()
    }
    
    private func makeCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view)
        }
    }
    
    private func makeButtons() {
        self.view.addSubview(addRoutineButton)
        addRoutineButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            make.height.equalTo(50)
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.bottom.greaterThanOrEqualTo(self.view)
        }
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "FitStrap"
        let  settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(self.pressSettingButton))
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = settingButton
    }

    
    @objc func pressSettingButton() {
        print("press Setting Button")
    }
    
    @objc func pressAddRoutineButton() {
        routines.append("\(Int.random(in: 0..<40000))")
        collectionView.reloadData()
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgramCell", for: indexPath) as! ProgramCollectionViewCell
        cell.configure(routines[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        routines.count
    }
    
}
