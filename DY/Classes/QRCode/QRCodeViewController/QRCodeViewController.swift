//
//  QRCodeViewController.swift
//  DY
//
//  Created by 满艺网 on 2017/12/19.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit
import AVFoundation
class QRCodeViewController: UIViewController {

    var session : AVCaptureSession = AVCaptureSession()
    var prelayer : AVCaptureVideoPreviewLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavgationBar()
        setupUI()
        startCaptureSession()

     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //stopCaptureSession()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension QRCodeViewController {
    fileprivate func setNavgationBar() {
        view.backgroundColor = UIColor.white
        title = "扫描二维码"
    }
    fileprivate func setupUI() {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.frame.size = CGSize(width: 200, height: 200)
        imageView.center = view.center
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.orange.cgColor
        view.addSubview(imageView)
        //
        let promptLabel = UILabel()
        promptLabel.text = "将二维码放入框内，即可自动扫描"
        promptLabel.textColor = UIColor.orange
        promptLabel.textAlignment = NSTextAlignment.center
        promptLabel.frame = CGRect(x: 0, y: imageView.frame.maxY + 20, width: kScreenW, height: 20)
        view.addSubview(promptLabel)
        //
        let aniView = UIImageView()
        aniView.backgroundColor = UIColor.orange
        aniView.frame = CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: 2)
        imageView.addSubview(aniView)
        //为aniView添加动画
        let anima = CAKeyframeAnimation(keyPath: "position.y")
        anima.values = [0.0,100.0,200.0]
        anima.keyTimes = [0,0.5,1]
        anima.duration = 1.5
        anima.repeatCount = Float(LONG_MAX)
        anima.autoreverses = true
        aniView.layer.add(anima, forKey: nil)
    }
}

extension QRCodeViewController {
    fileprivate func startCaptureSession() {
        //创建输入源
        let captureDevice = AVCaptureDevice.devices(for:AVMediaType.video).first
        let captureInput = try? AVCaptureDeviceInput(device: captureDevice!)
        session.addInput(captureInput!)
        //绘制预览层
        drawPrelayer()
        //启动
        session.startRunning()
    }
    fileprivate func stopCaptureSession() {
         session.stopRunning()
    }

    fileprivate func drawPrelayer() {
        prelayer = AVCaptureVideoPreviewLayer(session: session)
        prelayer?.frame = view.bounds
        view.layer.insertSublayer(prelayer!, at: 0)
    }
}
