//
//  FaceDetectionViewController.swift
//  3-MitsuPrevention
//
//  Created by 吉川椛 on 2020/04/10.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import AVKit
import Vision
import ARKit

class FaceDetectionViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, ARSCNViewDelegate  {
    
    let mainBoundSize: CGSize = UIScreen.main.bounds.size
    let numberOfFaces: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemTeal
        label.font = UIFont(name: "Avenir-Heavy", size: 30)
        label.text = "No face"
        return label
    }()
    
    //0
    let blueAlertLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemTeal
        label.font = UIFont(name: "Avenir-Heavy", size: 30)
        label.text = "大丈夫です。"
        return label
    }()
    //1
    let greenAlertLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .green
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        label.text = "間隔に気を付けましょう。"
        return label
    }()
    //2
    let yellowAlertLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .yellow
        label.font = UIFont(name: "Avenir-Heavy", size: 30)
        label.text = "気をつけましょう。"
        return label
    }()
    //4
    let orangeAlertLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        label.text = "退出することをお勧めします。"
        label.numberOfLines = 2
        return label
    }()
    //6
    let pinkAlertLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemPink
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        label.text = "退出することをお勧めします。"
        return label
    }()
    //8
    let redAlertLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        label.text = "危険です。今すぐ退出を。"
        label.numberOfLines = 2
        return label
    }()
    
//    let toHomeButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .orange
//        button.setTitle("３密とは？", for: .application)
//        button.titleLabel?.textColor = UIColor.white
//        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25)
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
//        setupTabBar()
        setupCamera()
        setupLabel()
        let Safe = NSLocalizedString("Safe", comment: "")
        let Caution = NSLocalizedString("Caution", comment: "")
        let Warning = NSLocalizedString("Warning", comment: "")
        let Danger = NSLocalizedString("Danger", comment: "")
        let Maximumdanger = NSLocalizedString("Maximum danger", comment: "")
        
        print(Safe)
        print(Caution)
        print(Warning)
        print(Danger)
        print(Maximumdanger)
        
        self.blueAlertLabel.text = Safe
        self.greenAlertLabel.text = Caution
        self.yellowAlertLabel.text = Warning
        self.orangeAlertLabel.text = Danger
        self.redAlertLabel.text = Maximumdanger
//        setupButton()
    }
    override var prefersStatusBarHidden: Bool {
      return true
    }
    @objc func pushButton(sender: UIButton){
        print("button pushed.")
    }
    
    fileprivate func setupCamera() {
        //デバイスからの入力と出力を管理するオブジェクトの作成
        let captureSession = AVCaptureSession()
        //画質
        captureSession.sessionPreset = .high
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        //リアルタイムキャプチャー
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }
    
//    fileprivate func setupButton() {
//        toHomeButton.layer.cornerRadius = 10
//    }
    
    fileprivate func setupLabel() {
        view.addSubview(numberOfFaces)
        view.addSubview(blueAlertLabel)
        view.addSubview(greenAlertLabel)
        view.addSubview(yellowAlertLabel)
        view.addSubview(orangeAlertLabel)
        view.addSubview(pinkAlertLabel)
        view.addSubview(redAlertLabel)
//        view.addSubview(toHomeButton)
        
        self.greenAlertLabel.isHidden = true
        self.blueAlertLabel.isHidden = true
        self.yellowAlertLabel.isHidden = true
        self.orangeAlertLabel.isHidden = true
        self.pinkAlertLabel.isHidden = true
        self.redAlertLabel.isHidden = true
        
        numberOfFaces.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -600).isActive = true
        numberOfFaces.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        numberOfFaces.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        numberOfFaces.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        blueAlertLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        blueAlertLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        blueAlertLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        blueAlertLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        greenAlertLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        greenAlertLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        greenAlertLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        greenAlertLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        yellowAlertLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        yellowAlertLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        yellowAlertLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        yellowAlertLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        orangeAlertLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        orangeAlertLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        orangeAlertLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        orangeAlertLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        pinkAlertLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        pinkAlertLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pinkAlertLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pinkAlertLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        redAlertLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        redAlertLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        redAlertLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        redAlertLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
//        let screenWidth:CGFloat = self.view.frame.width
//        toHomeButton.frame = CGRect(x: 50, y: 0, width: screenWidth/4, height: 50)
    }
    
    //1フレームごとの処理
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let request = VNDetectFaceRectanglesRequest { (req, err) in
            
            if let err = err {
                print("Failed to detect faces:", err)
                return
            }
            
            DispatchQueue.main.async {
                if let results = req.results {
                    self.numberOfFaces.text = "\(results.count) face(s)"
//                    var populationDensity: Float = Float(results.count)/Float((self.mainBoundSize.width*self.mainBoundSize.height))
//                    print(populationDensity)
//                    var populationDensity: CGSize = CGSize(results.count)/mainBoundSize
                    if self.numberOfFaces.text == "1 face(s)" {
                        self.numberOfFaces.text = "\(results.count) face"
                    }
                    if self.numberOfFaces.text == "0 face(s)" {
                        self.numberOfFaces.text = "No face"
                    }
                    if results.count == 0 {
                        self.numberOfFaces.textColor = UIColor.systemTeal
                        self.blueAlertLabel.isHidden = false
                        self.greenAlertLabel.isHidden = true
                        self.yellowAlertLabel.isHidden = true
                        self.orangeAlertLabel.isHidden = true
                        self.pinkAlertLabel.isHidden = true
                        self.redAlertLabel.isHidden = true
                    }
                    if results.count >= 1 {
                        self.numberOfFaces.textColor = UIColor.green
                        self.blueAlertLabel.isHidden = true
                        self.greenAlertLabel.isHidden = false
                        self.yellowAlertLabel.isHidden = true
                        self.orangeAlertLabel.isHidden = true
                        self.pinkAlertLabel.isHidden = true
                        self.redAlertLabel.isHidden = true
                    }
                    if results.count >= 2 {
                        self.numberOfFaces.textColor = UIColor.yellow
                        self.blueAlertLabel.isHidden = true
                        self.greenAlertLabel.isHidden = true
                        self.yellowAlertLabel.isHidden = false
                        self.orangeAlertLabel.isHidden = true
                        self.pinkAlertLabel.isHidden = true
                        self.redAlertLabel.isHidden = true
                    }
                    if results.count >= 4 {
                        self.numberOfFaces.textColor = UIColor.orange
                        self.blueAlertLabel.isHidden = true
                        self.greenAlertLabel.isHidden = true
                        self.yellowAlertLabel.isHidden = true
                        self.orangeAlertLabel.isHidden = false
                        self.pinkAlertLabel.isHidden = true
                        self.redAlertLabel.isHidden = true
                    }
                    if results.count >= 6 {
                        self.numberOfFaces.textColor = UIColor.systemPink
                        self.blueAlertLabel.isHidden = true
                        self.greenAlertLabel.isHidden = true
                        self.yellowAlertLabel.isHidden = true
                        self.orangeAlertLabel.isHidden = true
                        self.pinkAlertLabel.isHidden = false
                        self.redAlertLabel.isHidden = true
                    }
                    if results.count >= 8 {
                        self.numberOfFaces.textColor = UIColor.red
                        self.blueAlertLabel.isHidden = true
                        self.greenAlertLabel.isHidden = true
                        self.yellowAlertLabel.isHidden = true
                        self.orangeAlertLabel.isHidden = true
                        self.pinkAlertLabel.isHidden = true
                        self.redAlertLabel.isHidden = false
                    }
                }
            }
            
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            do {
                try handler.perform([request])
            } catch let reqErr {
                print("Failed to perform request:", reqErr)
            }
        }
        
    }
    
}
