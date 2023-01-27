//
//  HomeViewController.swift
//  Fitner
//
//  Created by Aske on 2022/12/17.
//

import UIKit
import SnapKit

final class HeaderView: UICollectionReusableView {
    static let id = "MainSectionHeader"
    private let label: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0  ))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareTitle(_ string: String) {
        self.label.text = string
    }
}

class HomeViewController: UIViewController {
    
    private var exercises: [Exercise] = []
    private var service: ExerciseService
    enum Section: CaseIterable {
        case exercise
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    
    // Derives the order of the sections
    lazy var sections: [LayoutSection] =
        [ExerciseLayoutSection()]
    
    private lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self.sections[sectionIndex].layoutSection
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProgramCollectionViewCell.self, forCellWithReuseIdentifier: "ProgramCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.id)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        dataSource = UICollectionViewDiffableDataSource
            <Section, AnyHashable>(collectionView: collectionView) {
                (collectionView: UICollectionView,
                indexPath: IndexPath,
                app: AnyHashable) -> UICollectionViewCell? in
                
                return self.sections[indexPath.section].configureCell (
                    collectionView: collectionView,
                    indexPath: indexPath,
                    item: app,
                    position: indexPath.row)
        }
    
        return collectionView
    }()
    
    func configureHeader() {
        dataSource.supplementaryViewProvider = {
          (
          collectionView: UICollectionView,
          kind: String,
          indexPath: IndexPath)
            -> UICollectionReusableView? in
            return self.sections[indexPath.section].header(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
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
    
    
    init(service: ExerciseService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        setupNavigationBar()
        makeSubviews()
        setupLayout()
        configureHeader()
        loadData()
    }
    
    private func makeSubviews() {
        self.view.addSubview(collectionView)
        self.view.addSubview(addRoutineButton)
    }
    
    private func setupLayout() {

        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0))
        }
        
        addRoutineButton.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            make.height.equalTo(50)
            make.bottom.equalTo(self.view).offset(-20)
        }
    }
    
    private func setupNavigationBar() {

        self.navigationItem.title = "FitStrap"
        let  settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(self.pressSettingButton))
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = settingButton
    }
    
    private func loadData() {
        fetchAllExercises { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.exercises += response.sorted { $0.target < $1.target }
                var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
                snapshot.appendSections([.exercise])
                snapshot.appendItems(self.exercises, toSection: .exercise)
                self.dataSource.apply(snapshot, animatingDifferences: false)
//                self.collectionView.reloadData()
            case .failure(let error):
                print("error = \(error.message)")
            }
        }
    }
    
    private func fetchAllExercises(completion: @escaping (Result<[Exercise], RequestError>) -> Void) {
        Task(priority: .background) {
            let result = await service.getAllExercises()
            completion(result)
        }
    }

    
    @objc func pressSettingButton() {
        print("press Setting Button")
    }
    
    @objc func pressAddRoutineButton() {
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(item: exercises.count - 1, section: 0), at: .bottom, animated: false)
    }
}

//extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgramCell", for: indexPath) as! ProgramCollectionViewCell
//        cell.configure(exercises[indexPath.item])
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        exercises.count
//    }
//
//
////    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
////        guard kind == UICollectionView.elementKindSectionHeader,  let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.id, for: indexPath) as? HeaderView else { return
////            UICollectionReusableView()
////
////        }
////        header.prepareTitle(sections[indexPath.section])
////        return header
////    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//        return CGSize(width: self.collectionView.bounds.width, height: 40)
//    }
//}
