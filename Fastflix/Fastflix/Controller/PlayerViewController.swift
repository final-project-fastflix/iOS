//
//  PlayerViewController.swift
//  Fastflix
//
//  Created by HongWeonpyo on 20/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import SnapKit
import AVKit


class PlayerViewController: UIViewController {

    var player: AVPlayer?
    
    var playerView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }()
    
    // 🔸상단 타이틀 및 닫기
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "가디언즈 오브 갤럭시"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "close")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    // 🔸뒤로가기 버튼 관련
    let backWardButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "backward")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(backwardButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "circle")
        imageView.image = image
        imageView.alpha = 0
        return imageView
    }()
    let backLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    let backMovingLabel: UILabel = {
        let label = UILabel()
        label.text = "-10"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()
    
    // 🔸멈추기 및 재생 버튼
    let pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(pauseAndPlayDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    // 🔸앞으로가기 버튼 관련
    let forwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "forward")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(forwardButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    let forwardImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "circle")
        imageView.image = image
        imageView.alpha = 0
        return imageView
    }()
    let forwardLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    let forwardMovingLabel: UILabel = {
        let label = UILabel()
        label.text = "+10"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()
    
    // 🔸하단 슬라이더 관련 스택뷰
    lazy var sliderStackView: UIStackView = {
        let sview = UIStackView(arrangedSubviews: [mainSlider, movieRunningTimeLabel])
        sview.axis = .horizontal
        sview.distribution = .fill
        sview.spacing = 20
        return sview
    }()
    let mainSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .red
        slider.thumbTintColor = .red
        return slider
    }()
    let movieRunningTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2:23:27"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    // 🔸하단 자막 및 음성 버튼 관련
    lazy var subtitleStackView: UIStackView = {
        let sview = UIStackView(arrangedSubviews: [subtitleImageButton, subtitleButton])
        sview.axis = .horizontal
        sview.distribution = .fill
        sview.spacing = 10
        return sview
    }()
    let subtitleImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "subtitle")
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 0)
        button.addTarget(self, action: #selector(subtitleButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    let subtitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("자막 및 음성", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // 🔸재생 중인지 아닌지 확인 속성
    var isPlaying = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupSNP()
  }
    
    // 🔸addSubview 및 autoLayout
    private func setupSNP() {
        view.addSubview(playerView)
        
        [movieTitleLabel, closeButton, backWardButton, pausePlayButton, forwardButton, subtitleStackView, sliderStackView, backLabel, forwardLabel, backMovingLabel, forwardMovingLabel].forEach { playerView.addSubview($0) }
        
        backWardButton.addSubview(backImageView)
        forwardButton.addSubview(forwardImageView)
        // 전체뷰
        playerView.snp.makeConstraints {
            $0.topMargin.leading.trailing.equalTo(0)
            $0.bottom.equalTo(0)
        }
        // 영화 메인 타이틀 레이블
        movieTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(35)
        }
        // 닫기버튼
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(15)
            $0.top.equalTo(35)
            $0.trailing.equalTo(-60)
        }
        // 뒤로가기 관련
        backWardButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-3)
            $0.centerX.equalToSuperview().multipliedBy(0.5)
            $0.width.equalTo(view.snp.height).multipliedBy(0.1)
            $0.height.equalTo(backWardButton.snp.width).multipliedBy(1.1287)
        }
        backImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(3)
            $0.height.width.equalTo(view.snp.width).multipliedBy(0.045)
        }
        backLabel.snp.makeConstraints {
            $0.centerX.equalTo(backWardButton)
            $0.centerY.equalTo(backWardButton).offset(2)
            $0.width.height.equalTo(30)
        }
        backMovingLabel.snp.makeConstraints {
            $0.centerX.equalTo(backWardButton)
            $0.centerY.equalTo(backWardButton)
            $0.width.height.equalTo(40)
        }
        // 멈추기 / 플레이
        pausePlayButton.snp.makeConstraints {
            $0.center.equalTo(playerView)
            $0.width.height.equalTo(37)
        }
        // 앞으로가기 관련
        forwardButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-3)
            $0.centerX.equalToSuperview().multipliedBy(1.5)
            $0.width.equalTo(view.snp.height).multipliedBy(0.1)
            $0.height.equalTo(backWardButton.snp.width).multipliedBy(1.1287)
        }
        forwardImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(3)
            $0.height.width.equalTo(view.snp.width).multipliedBy(0.045)
        }
        forwardLabel.snp.makeConstraints {
            $0.centerX.equalTo(forwardButton)
            $0.centerY.equalTo(forwardButton).offset(2)
            $0.width.height.equalTo(30)
        }
        forwardMovingLabel.snp.makeConstraints {
            $0.centerX.equalTo(forwardButton)
            $0.centerY.equalTo(forwardButton)
            $0.width.height.equalTo(40)
        }
        // 슬라이더 및 시간 스택뷰
        sliderStackView.snp.makeConstraints {
            $0.leading.equalTo(60)
            $0.trailing.equalTo(-60)
            $0.bottom.equalTo(-80)
        }
        // 자막 및 음성 관련
        subtitleImageButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.height.equalTo(35)
        }
        subtitleStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(-35)
        }
    }
    
    // 🔸멈추기 및 재생 버튼 눌렀을때
    @objc private func pauseAndPlayDidTap(_ sender: UIButton) {
        // 버튼 애니메이션 관련
        if isPlaying {
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.05, animations: {
                    sender.transform = CGAffineTransform.identity
                    sender.setImage(UIImage(named: "play"), for: .normal)
                })
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.05, animations: {
                    sender.transform = CGAffineTransform.identity
                    sender.setImage(UIImage(named: "pause"), for: .normal)
                })
            })
        }
        isPlaying = !isPlaying
    }
    
    // 🔸뒤로가기 눌렀을 때
    @objc private func backwardButtonDidTap(_ sender: UIButton) {
        backwardButtonAnimation()
        
        
    }
    
    // 🔸앞으로가기 눌렀을 때
    @objc private func forwardButtonDidTap(_ sender: UIButton) {
        forwardButtonAnimation()
        
    }
    
    // 🔸닫기버튼 눌렀을때
    @objc private func closeButtonDidTap(_ sender: UIButton) {
        
    }
    
    // 🔸자막 및 음성 버튼 눌렀을때
    @objc private func subtitleButtonDidTap(_ sender: UIButton) {
        
    }
    
    
    // 🔸 버튼 애니메이션 효과
    private func backwardButtonAnimation() {
        // 버튼 애니메이션 관련
        self.backLabel.alpha = 0
        self.backImageView.alpha = 1
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                self.backWardButton.transform = CGAffineTransform(rotationAngle: CGFloat(-40 * Double.pi / 180))
                self.backImageView.alpha = 0
            })
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                self.backWardButton.transform = .identity
                self.backImageView.transform = .identity
            })
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.backMovingLabel.transform = self.backMovingLabel.transform.translatedBy(x: -70, y: 0)
                self.backMovingLabel.alpha = 1
            })
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
                self.backMovingLabel.alpha = 0
            })
            // 끝나면 제자리로 돌아가기
        }) { (bool) -> Void in
            self.backMovingLabel.transform = .identity
            self.backLabel.alpha = 1
            self.backMovingLabel.alpha = 0
        }
    }
    
    private func forwardButtonAnimation() {
        // 버튼 애니메이션 관련
        self.forwardLabel.alpha = 0
        self.forwardImageView.alpha = 1
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                self.forwardButton.transform = CGAffineTransform(rotationAngle: CGFloat(40 * Double.pi / 180))
                self.forwardImageView.alpha = 0
            })
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                self.forwardButton.transform = .identity
                self.forwardImageView.transform = .identity
            })
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.forwardMovingLabel.transform = self.backMovingLabel.transform.translatedBy(x: 70, y: 0)
                self.forwardMovingLabel.alpha = 1
            })
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
                
                self.forwardMovingLabel.alpha = 0
            })
            // 끝나면 제자리로 돌아가기
        }) { (bool) -> Void in
            self.forwardMovingLabel.transform = .identity
            self.forwardLabel.alpha = 1
            self.forwardMovingLabel.alpha = 0
        }
    }
    
    
    
    
    
    
}
