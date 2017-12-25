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

    fileprivate var scanImageView = UIImageView()
    fileprivate var session : AVCaptureSession = AVCaptureSession()
    fileprivate var deviceInput : AVCaptureDeviceInput? = nil
    fileprivate var metaOutput : AVCaptureMetadataOutput = AVCaptureMetadataOutput()
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
        scanImageView = aniView
        startAnimation()
    }
}

extension QRCodeViewController {
    fileprivate func startCaptureSession() {
        //创建输入源
        let captureDevice = AVCaptureDevice.devices(for:AVMediaType.video).first
        let captureInput = try? AVCaptureDeviceInput(device: captureDevice!)
        session.addInput(captureInput!)
        self.deviceInput = captureInput!
        //绘制预览层
        //创建输出源
        let metaOutput = AVCaptureMetadataOutput()
        session.addOutput(metaOutput)
        self.metaOutput = metaOutput
        //MARK: - 需要先添加在设置
        metaOutput.metadataObjectTypes = metaOutput.availableMetadataObjectTypes
        metaOutput.rectOfInterest = CGRect(x: 0, y: 0, width: 1, height: 1) //设置扫描区域
        metaOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.global())
        //启动
        session.startRunning()
        drawPrelayer()
    }
    fileprivate func resetCaptureSessio() {
//        guard let deviceInput = deviceInput else { return }
//        session.removeInput(deviceInput)
//        let metaOutput = self.metaOutput
//        session.removeOutput(metaOutput)
//
//        session.beginConfiguration()
//        session.addInput(deviceInput)
//        session.addOutput(metaOutput)
//        session.commitConfiguration()
//        self.metaOutput = metaOutput
//        self.deviceInput = deviceInput

        session.startRunning()
        startAnimation()
    }
    fileprivate func stopCaptureSession() {
         session.stopRunning()
    }
    fileprivate func drawPrelayer() {
        prelayer = AVCaptureVideoPreviewLayer(session: session)
        prelayer?.frame = view.bounds
        view.layer.insertSublayer(prelayer!, at: 0)
    }

    fileprivate func startAnimation() {
        //为aniView添加动画
        let anima = CAKeyframeAnimation(keyPath: "position.y")
        anima.values = [0.0,100.0,200.0]
        anima.keyTimes = [0,0.5,1]
        anima.duration = 1.5
        anima.repeatCount = Float(LONG_MAX)
        anima.autoreverses = true
        scanImageView.layer.add(anima, forKey: "scanAnimation")
    }

    fileprivate func stopAnimation() {
       scanImageView.layer.removeAnimation(forKey:"scanAnimation")
    }
    fileprivate func showAlert(_ string : String) {
          let alert = UIAlertController(title: nil, message: string, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (alertAction) in
            self.startAnimation()
            self.resetCaptureSessio()
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension QRCodeViewController : AVCaptureMetadataOutputObjectsDelegate {

    /// 输出源代理方法
    ///
    /// - Parameters:
    ///   - output: 输出源源对象
    ///   - metadataObjects: 采集到的output的数据对象数组
    ///   - connection: 连接对象，可以根据连接对象区分输出的源
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObject =  metadataObjects.first as? AVMetadataMachineReadableCodeObject else {return}
        stopAnimation()
        stopCaptureSession()
        showAlert(metadataObject.stringValue ?? "no answer")
        print(metadataObject.stringValue ?? "default Value")
    }
}
