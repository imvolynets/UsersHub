import Foundation
import UIKit
import AVFoundation
import SnapKit

class QrScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession = AVCaptureSession()
    var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    var alertController: UIAlertController?
    
    private let scanningFrame = QrScannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        leaveControler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
    
    private func initViewController() {
        view.backgroundColor = .black
        
        setNavBarStyle()
        setupScanner()
        setupBox()
    }
    
}

//MARK: - leave Controller
extension QrScannerViewController {
    private func leaveControler() {
        self.captureSession.stopRunning()
        self.navigationController?.popViewController(animated: true)
        AppUtility.lockOrientation(.all)
    }
}

//MARK: - setting QrScanner
extension QrScannerViewController {
    private func setupScanner() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        let input: AVCaptureDeviceInput
        
        do {
            input = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            print(error)
            return
        }
        
        captureSession = AVCaptureSession()
        captureSession.addInput(input)
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            print("Could not add metadata output")
            return
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
}

//MARK: - AVCaptureMetadataOutputObjectsDelegate
extension QrScannerViewController {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObject = metadataObjects.first else { return }
        guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
        guard let result = readableObject.stringValue else {return}
        
        guard alertController == nil else {
            return
        }
        
        showAlert(message: result)
    }
}

//MARK: - alertController
extension QrScannerViewController {
    
    private func showAlert(message: String) {
        alertController = UIAlertController(title: "QR Code", message: message, preferredStyle: .alert)
        
        guard let alert = alertController else {
            return
        }
        
        if let url = URL(string: message) {
            alert.addAction(UIAlertAction(title: "Go to", style: .default, handler: { _ in
                UIApplication.shared.open(url)
                self.alertController = nil
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
                self.alertController = nil
                
            }))
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.captureSession.stopRunning()
                self.navigationController?.popViewController(animated: true)
            }))
        }
        
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - setting frame box
extension QrScannerViewController {
    private func setupBox() {
        view.addSubview(scanningFrame)
        
        scanningFrame.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
}

//MARK: - setting navBar style
extension QrScannerViewController {
    private func setNavBarStyle() {
        self.navigationItem.title = "QR Scanner"
        self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.font: UIFont(name: Constants.Fonts.mainFont, size: 16) ?? .systemFont(ofSize: 16), .foregroundColor: UIColor(named: Constants.Colors.forMainElements) ?? .systemGray]
    }
}
