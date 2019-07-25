//
//  DetailViewUpperCell.swift
//  Fastflix
//
//  Created by HongWeonpyo on 17/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

protocol PlayButtonDelegate: class {
  func playButtonDidTap(sender: UIButton)
  func didTapDismissBtn()
}

final class DetailViewUpperCell: UITableViewCell {
  
  //이미지뷰 가로 크기(고정)
  private let imageWidth: CGFloat = 133
  
  private lazy var dissmissButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .black
    button.tintColor = .white
    //        let image = UIImage(named: "close")
    //        button.setImage(image, for: .normal)
    button.setTitle("X", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    button.layer.cornerRadius = 8
    button.addTarget(self, action: #selector(didTapDismissBtn(_:)), for: .touchUpInside)
    return button
  }()
  
  private let backgroundBlurView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "toystory")
    return view
  }()
  
    private let backgroundLayerView: UIImageView = {
        let view = UIImageView()
        view.alpha = 1
        view.image = UIImage(named: "blurview")
        return view
    }()
  
  // 디테일뷰 메인이미지
  private let mainImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "toystory")
    imageView.layer.shadowColor = UIColor.black.cgColor
    imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
    imageView.layer.shadowOpacity = 0.5
    imageView.layer.shadowRadius = 5
    imageView.clipsToBounds = false
    return imageView
  }()
  
  // 일치율, 출시년도 관람등급, 상영시간
  private let suggestionLabel: UILabel = {
    let label = UILabel()
    label.text = "74%일치"
    label.textColor = #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  private lazy var movieExplainLabel: UILabel = {
    let label = UILabel()
    label.text = "2009   청불   1시간 39분"
    label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    return label
  }()
  private lazy var imageBelowStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [suggestionLabel, movieExplainLabel])
    stackView.alignment = .fill
    stackView.spacing = 25
    stackView.axis = .horizontal
    return stackView
  }()
  
  // 플레이버튼: 델리게이트로 뷰컨트롤러에 전달
  private lazy var playButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .red
    button.setTitle("▶︎  재생", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 2
    button.addTarget(self, action: #selector(play(_:)), for: .touchUpInside)
    return button
  }()
  
  // 보던 영화일 경우, 남은시간 표시
  private let slider: UISlider = {
    let slider = UISlider()
    slider.thumbTintColor = .clear
    slider.tintColor = .red
    return slider
  }()
  private let leftTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "남은시간: 1시간 4분"
    label.font = UIFont.systemFont(ofSize: 10, weight: .light)
    label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    return label
  }()
  private lazy var movieTimeStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [slider, leftTimeLabel])
    stackView.alignment = .fill
    stackView.spacing = 10
    stackView.axis = .horizontal
    return stackView
  }()
  
  // 영화 정보 설명
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.text = "전직경찰이자 자칭 보안관 백단 오지랖으로 수호하는 마을. 평화롭던 이곳에 수상한 외지인이 등장했다. 잘나가는 이 사업가에게 토박이들이 마음을 여는 사이, 보안관은 오히려 구린 냄새에 뒤를 캐기 시작한다. 우리 마을은 내가 지켜!"
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    return label
  }()
  private let directorAndCastLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 12, weight: .light)
    label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    label.text = """
    출연: 이성민, 조진웅, 김성균
    감독: 김형주
    """
    return label
  }()
  private lazy var movieDescriptionStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [descriptionLabel, directorAndCastLabel])
    stackView.alignment = .fill
    stackView.spacing = 10
    stackView.axis = .vertical
    return stackView
  }()
  
  // 내가 찜한 콘텐츠 버튼
  private lazy var myPokedContentsButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(named: "add")
    button.setImage(image, for: .normal)
    button.tintColor = .white
    //button.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
    return button
  }()
  private lazy var myPokedContentsButtonLabel: UIButton = {
    let button = UIButton()
    button.setTitle("내가 찜한 콘텐츠", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .light)
    button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
    // button.addTarget(self, action: #selector(play), for: .touchUpInside)
    return button
  }()
  private lazy var myPokedStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [myPokedContentsButton, myPokedContentsButtonLabel])
    stackView.alignment = .center
    stackView.spacing = 7
    stackView.axis = .vertical
    return stackView
  }()
  
  // 평가 버튼
  private lazy var evaluationButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(named: "like")
    button.setImage(image, for: .normal)
    button.tintColor = .white
    //button.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
    return button
  }()
  private lazy var evaluationButtonLabel: UIButton = {
    let button = UIButton()
    button.setTitle("평가", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .light)
    button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
    // button.addTarget(self, action: #selector(play), for: .touchUpInside)
    return button
  }()
  private lazy var evaluationStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [evaluationButton, evaluationButtonLabel])
    stackView.alignment = .center
    stackView.spacing = 7
    stackView.axis = .vertical
    return stackView
  }()
  
  // 공유버튼
  private lazy var shareButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(named: "share")
    button.setImage(image, for: .normal)
    button.tintColor = .white
    //button.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
    return button
  }()
  private lazy var shareButtonLabel: UIButton = {
    let button = UIButton()
    button.setTitle("공유", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .light)
    button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
    // button.addTarget(self, action: #selector(play), for: .touchUpInside)
    return button
  }()
  private lazy var shareStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [shareButton, shareButtonLabel])
    stackView.alignment = .center
    stackView.spacing = 7
    stackView.axis = .vertical
    return stackView
  }()
  
  weak var delegate: PlayButtonDelegate?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configure()
    setupSNP()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc private func didTapDismissBtn(_ sender: UIButton) {
    print("dismiss")
    delegate?.didTapDismissBtn()
  }
  
  // 뷰 설정
  private func configure() {
    self.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1)
    self.selectionStyle = .none
    
    backgroundBlurView.addBlurEffect()
  }
  
  // 스냅킷 오토레이아웃
  private func setupSNP() {
    [backgroundBlurView, backgroundLayerView, mainImageView, imageBelowStackView, playButton, movieTimeStackView, movieDescriptionStackView, myPokedStackView, evaluationStackView, shareStackView, dissmissButton].forEach { contentView.addSubview($0) }
    
    let buttonWidth = (UIScreen.main.bounds.width - 20)/4
    
    dissmissButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.equalToSuperview().offset(44)
            $0.trailing.equalToSuperview().offset(-15)
          }
    
    backgroundBlurView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(contentView.snp.top)
      $0.bottom.equalTo(contentView.snp.bottom)
      $0.leading.equalTo(contentView.snp.leading).offset(-100)
      $0.trailing.equalTo(contentView.snp.trailing).offset(100)
    }
    
    backgroundLayerView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalTo(backgroundBlurView)
    }
    
    mainImageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(contentView.snp.top).offset(80)
      $0.width.equalTo(imageWidth)
      $0.height.equalTo(mainImageView.snp.width).multipliedBy(1.4436)
    }
    
    imageBelowStackView.snp.makeConstraints {
      $0.top.equalTo(mainImageView.snp.bottom).offset(15)
      $0.centerX.equalToSuperview()
      $0.height.equalTo(15)
    }
    
    playButton.snp.makeConstraints {
      $0.top.equalTo(imageBelowStackView.snp.bottom).offset(30)
      $0.leading.equalTo(contentView.snp.leading).offset(8)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-8)
      $0.height.equalTo(35)
    }
    
    movieTimeStackView.snp.makeConstraints {
      $0.top.equalTo(playButton.snp.bottom).offset(10)
      $0.leading.equalTo(contentView.snp.leading).offset(8)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-8)
      $0.height.equalTo(12)
    }
    
    movieDescriptionStackView.snp.makeConstraints {
      $0.top.equalTo(movieTimeStackView.snp.bottom).offset(4)
      $0.leading.equalTo(contentView.snp.leading).offset(8)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-8)
    }
    
    myPokedContentsButton.snp.makeConstraints {
      $0.width.height.equalTo(20)
    }
    
    myPokedStackView.snp.makeConstraints {
      $0.top.equalTo(movieDescriptionStackView.snp.bottom).offset(12)
      $0.width.equalTo(buttonWidth)
      $0.height.equalTo(40)
      $0.leading.equalTo(contentView.snp.leading).offset(10)
      $0.bottom.equalTo(contentView.snp.bottom).offset(-10)
    }
    
    evaluationButton.snp.makeConstraints {
      $0.width.height.equalTo(20)
    }
    
    evaluationStackView.snp.makeConstraints {
      $0.top.equalTo(myPokedStackView.snp.top)
      $0.width.equalTo(buttonWidth)
      $0.height.equalTo(40)
      $0.leading.equalTo(myPokedStackView.snp.trailing)
      $0.bottom.equalTo(contentView.snp.bottom).offset(-10)
    }
    
    shareButton.snp.makeConstraints {
      $0.width.equalTo(16)
      $0.height.equalTo(20)
    }
    
    shareStackView.snp.makeConstraints {
      $0.top.equalTo(myPokedStackView.snp.top)
      $0.width.equalTo(buttonWidth)
      $0.height.equalTo(40)
      $0.leading.equalTo(evaluationStackView.snp.trailing)
      $0.bottom.equalTo(contentView.snp.bottom).offset(-10)
    }
  }
  
  // 플레이버튼 눌렀을 때의 동작
  @objc private func play(_ sender: UIButton) {
    delegate?.playButtonDidTap(sender: sender)
  }
}

// 블러이펙트
extension UIImageView {
  func addBlurEffect() {
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.bounds
    
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
    self.addSubview(blurEffectView)
  }
}
