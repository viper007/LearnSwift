//
//  RoomPushViewController.swift
//  DY
//
//  Created by 满艺网 on 2017/12/18.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit
import SnapKit
import LocalAuthentication

class RoomPushViewController: UIViewController {

    var urlString : String! = "rtmp://192.168.21.227:1935/live/lvzhenhua"
    fileprivate lazy var player : IJKFFMoviePlayerController = IJKFFMoviePlayerController()
    fileprivate lazy var activityView : UIActivityIndicatorView = {
        let avtivity = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.whiteLarge)
        avtivity.backgroundColor = UIColor.black
        return avtivity
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        touchIDAuth()
//        setupPlayer()
//        setupUI()
//        addObserver()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension RoomPushViewController {
     fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(activityView)
        activityView.backgroundColor = UIColor.black
        activityView.snp.makeConstraints { (make) in
//            make.width.height.equalTo(100)
//            make.center.equalTo(self.view.center)
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        activityView.isHidden = false
        activityView.startAnimating()
     }
     fileprivate func setupPlayer() {
         let options = IJKFFOptions.byDefault()!
         options.setPlayerOptionIntValue(0, forKey: "videotoolbox")
         player = IJKFFMoviePlayerController(contentURLString: urlString, with:options)
         player.scalingMode = .aspectFill
        //创建预览图层
        view.addSubview(player.view)
        player.view.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        player.prepareToPlay()
     }

    fileprivate func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerPrepareToPlay(_ :)) , name: NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange, object: player)
        NotificationCenter.default.addObserver(self, selector: #selector(playerLoadStateChange(_ :)), name: NSNotification.Name.IJKMPMoviePlayerLoadStateDidChange, object: player)
    }
}


// MARK: - 通知改变播放的状态信息流
extension RoomPushViewController {
    @objc fileprivate func playerPrepareToPlay(_ note : Notification) {
        activityView.stopAnimating()
        activityView.isHidden = true
        print("----\(note)")
        player.play()
    }
    @objc fileprivate func playerLoadStateChange(_ note : NSNotification) {
        let player = note.object as! IJKFFMoviePlayerController
        if player.isPlaying() {
           //播放结束或者获取资料结束了
            switch player.loadState {
            case IJKMPMovieLoadState.playable :
               print("playable")
            break
            case IJKMPMovieLoadState.playthroughOK: break
            case IJKMPMovieLoadState.stalled:
                 anchorOutline()
            break
            default: print("IJKMPMovieLoadState.unknown")
            }
        }
    }
    /// 主播已经下线
    func anchorOutline() {
         print("主播已经下线")
    }
}

extension RoomPushViewController {
    //MARK: - 对密码进行编码
    fileprivate func codePwd() {
        //密码
        let str : String = "123456"
        print(str.md5String())
        //注册的时候获得的加密key
        let hmacKey = "WangPengfei".md5String()
        print(hmacKey)
        //第一次进行hash加密
        let first = str.hmacMD5StringWithKey(key: hmacKey)
        print(first)
        //添加上时间戳，可以制作出 密码锁
        let time = Date.getCurrentFormatterTime()
        print(time)
        //第二次hash散列加密
        let second : String = (first + time).hmacMD5StringWithKey(key: hmacKey)
        print(second)
    }

    fileprivate func touchIDAuth() {
        let lactx = LAContext()
        let canYes = lactx.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil)
        if canYes {
            lactx.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "授权登录信息", reply: { (result, error) in
                if result {
                    print("成功")
                } else {
                    print("不成功")
                }
            })
        }
    }
}
