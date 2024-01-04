//
//  RxFaceTrackingVC.swift
//  swift-example
//
//  Created by 픽셀로 on 2024/01/03.
//

import UIKit
import AVFoundation
import Vision
import Photos

import RxSwift
import RxCocoa
import SnapKit
import Then

final class RxFaceTrackingVC: UIViewController {
    
    // MARK: - Properties
    
    var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            var isAuthorized = status == .authorized    // 사용자가 이전에 카메라 접근 권한을 가지고 있었는지 아닌지 판단
            
            if status == .notDetermined {   // 만약 접근 권한을 받은 적이 없다면
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }
    
    private let captureSession = AVCaptureSession() // 비디오의 입력과 출력을 관리하는 세션
    
    private let videoDataOutput = AVCaptureVideoDataOutput() // 비디오의 출력을 설정
    
    private var faceLayers: [CALayer] = []
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "나는 포차코"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    private let takePictureButton = UIButton(type: .system).then {
        $0.setTitle("take picture", for: .normal)
    }
    
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession).then {    // captureSession의 시각적 출력을 프리뷰
        $0.videoGravity = .resizeAspectFill
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        configureVideoCapture()
        setAddTarget()
    }
}

// MARK: - Methods

extension RxFaceTrackingVC {
    private func setAddTarget() {
        self.takePictureButton.addTarget(self, action: #selector(takePictureButtonDidTap), for: .touchUpInside)
    }
    
    /// 카메라 접근 권한 확인 및 처리
    private func setUpCaptureSession() async {
        guard await isAuthorized else { return }
    }
    
    /// 카메라로부터 비디오를 입력받기
    private func configureVideoCapture() {
        captureSession.beginConfiguration() // AVCaptureSession의 설정 변경 시작
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                  for: .video,
                                                  position: .front)   // 카메라 옵션 설정
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!),
              captureSession.canAddInput(videoDeviceInput) else { return }  // AVCaptureDeviceInput 생성 시도, 성공 시 세션에 입력 추가할 수 있는지 확인
        captureSession.addInput(videoDeviceInput)   // 세션에 생성된 비디오의 입력을 추가
        setUpPreviewLayer() // 비디오 프리뷰 출력
    }
    
    /// 입력받은 비디오 출력
    private func setUpPreviewLayer() {
        let width: CGFloat = 300
        let height: CGFloat = 300

        self.previewLayer.frame = CGRect(
            x: (view.bounds.width - width) / 2,
            y: (view.bounds.height - height) / 2,
            width: width,
            height: height
        )
        
        view.layer.addSublayer(previewLayer)    // 현재 뷰의 하위 레이어로 추가
        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]    // [Core Viedo에서 사용되는 픽셀 형식 : 32bit BGRA 형식, 일반적으로 사용되는 형식]
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera queue")) // 비디오 출력에 대한 샘플 버퍼 딜리게이트 설정
        self.captureSession.addOutput(self.videoDataOutput) // captureSession에 output 추가
        
        // input과 output 간의 connection 생성
        let videoConnection = self.videoDataOutput.connection(with: .video)
        videoConnection?.videoOrientation = .portrait   // 비디오 방향 세로 설정
        
        self.captureSession.commitConfiguration() // AVCaptureSession의 설정 변경 완료
        // AVCaptureSession를 백그라운드 스레드에서 시작
        DispatchQueue.global().async {
            self.captureSession.startRunning()
        }
    }
    
    /// Face Observation 값들 처리
    private func handleFaceDetectionObservations(observations: [VNFaceObservation]) {
        for observation in observations {
            let faceRectConverted = self.previewLayer.layerRectConverted(fromMetadataOutputRect: observation.boundingBox)
            let faceRectanglePath = CGPath(rect: faceRectConverted, transform: nil)

            let faceLayer = CALayer()
            faceLayer.bounds = faceRectConverted
            faceLayer.position = CGPoint(x: faceRectanglePath.boundingBox.midX, y: faceRectanglePath.boundingBox.midY)

            // 얼굴 범위에 이미지 추가하기
            let faceImage = UIImage(named: "pochaco_face_img")
            let faceImageLayer = CALayer()
            faceImageLayer.contents = faceImage?.cgImage
            faceImageLayer.bounds = faceLayer.bounds
            faceImageLayer.position = CGPoint(x: faceLayer.bounds.midX, y: faceLayer.bounds.midY)
            faceLayer.addSublayer(faceImageLayer)

            // preview layer에 face layer 더하기
            self.faceLayers.append(faceLayer)
            self.previewLayer.addSublayer(faceLayer)
        }
    }
    
    private func savePhoto() {
        let diameter: CGFloat = 100
        let rect = CGRect(origin: CGPoint.zero,
                          size: CGSize(width: diameter, height: diameter))
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        let lenderedImage = renderer.image { context in
            return faceLayers[0].render(in: context.cgContext)
        }
        
        UIImageWriteToSavedPhotosAlbum(lenderedImage, self, #selector(saveImage), nil)
    }
}

// MARK: - @objc Function

extension RxFaceTrackingVC {
    @objc private func takePictureButtonDidTap() {
        savePhoto()
    }
    
    @objc private func saveImage() {
        
    }
}

// MARK: - UI & Layout

extension RxFaceTrackingVC {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(titleLabel, takePictureButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        takePictureButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension RxFaceTrackingVC: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }  // CMSampleBuffer에서 이미지 버퍼를 가져옴
        
        // VNDetectFaceLandmarksRequest: 얼굴 특징 감지
        let faceDetectionRequest = VNDetectFaceLandmarksRequest(completionHandler: { ( request: VNRequest, error: Error?) in
            DispatchQueue.main.async {
                // 새로운 특징을 감지할 때마다, 이전의 레이어를 삭제하고 새로운 특징을 표시하게 함
                self.faceLayers.forEach({ $0.removeFromSuperlayer() })
                
                // 요청 결과에서 face observation을 얻을 경우 처리
                if let observations = request.results as? [VNFaceObservation] {
                    self.handleFaceDetectionObservations(observations: observations)
                }
            }
        })
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: imageBuffer, orientation: .leftMirrored, options: [:])
        
        do {
            try imageRequestHandler.perform([faceDetectionRequest])
        } catch {
            print(error.localizedDescription)
        }
    }
}

