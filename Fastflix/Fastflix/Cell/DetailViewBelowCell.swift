//
//  DetailViewBelowCell.swift
//  Fastflix
//
//  Created by HongWeonpyo on 17/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

protocol DetailViewCellDelegate: class {
    func detailViewDidSelectItemAt(indexPath: IndexPath)
}

final class DetailViewBelowCell: UITableViewCell {
    
    private let firstBlackLine: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .black
        return uiView
    }()
    
    private let redLine: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .red
        return uiView
    }()
    
    private let similarLabel: UILabel = {
        let label = UILabel()
        label.text = "비슷한 콘텐츠"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let cellWidth = (UIScreen.main.bounds.width - 40)/3
  
    private lazy var cellHeight = cellWidth * 1.447064
    
    private let collectionView: UICollectionView = {
        let cellWidth = (UIScreen.main.bounds.width - 40)/3
        let cellHeight = cellWidth * 1.447064
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    weak var delegate: DetailViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setupSNP()
        collectionViewSetup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1)
        self.selectionStyle = .none
    }
    
    private func setupSNP() {
        [firstBlackLine, redLine, similarLabel, collectionView].forEach { contentView.addSubview($0) }
        
        firstBlackLine.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.top.equalTo(contentView.snp.top).offset(0)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        
        redLine.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.top.equalTo(firstBlackLine.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading).offset(10)
            $0.width.equalTo(87)
        }
        
        similarLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(10)
            $0.top.equalTo(redLine.snp.bottom).offset(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(similarLabel.snp.bottom).offset(2)
            $0.leading.equalTo(contentView.snp.leading).offset(0)
            $0.trailing.equalTo(contentView.snp.trailing).offset(0)
            $0.height.equalTo(cellHeight*2 + 36)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-30)
        }
    }
    
    
    private func collectionViewSetup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "DetailCollectionViewCell")
        collectionView.backgroundColor = #colorLiteral(red: 0.09802495688, green: 0.09804918617, blue: 0.09802179784, alpha: 1)
        
    }
}

// (비슷한콘텐츠) 컬렉션뷰 데이터 소스
extension DetailViewBelowCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as! DetailCollectionViewCell
//        cell.detailImageView.image = UIImage(named: "toystory")
//        cell.detailImageView.contentMode = .scaleToFill
      cell.configure(imageName: "toystory")
        return cell
    }
}

// (비슷한 콘텐츠)에서 한가지 눌렀을때의 동작 (델리게이트)
extension DetailViewBelowCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        delegate?.detailViewDidSelectItemAt(indexPath: indexPath)
    }
}
