import Foundation
import UIKit
import AVFoundation
import SnapKit

class QrScannerView: UIView {
    private let scanningFrame: UIView = {
        let obj = UIView()
        obj.layer.borderColor = UIColor.green.cgColor
        obj.layer.borderWidth = 2.0
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(scanningFrame)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        scanningFrame.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
}

