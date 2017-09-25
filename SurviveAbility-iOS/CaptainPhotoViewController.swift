import UIKit
import AVFoundation

class CaptainPhotoViewController: UIViewController {
    
    @IBOutlet var cameraView: UIView!
    @objc var session: AVCaptureSession?
    @objc var stillImageOutput = AVCapturePhotoOutput()
    @objc var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    @objc var photoBuffer: CMSampleBuffer?
    
    var captainStore: CaptainStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSession.Preset.photo
        
        let rearCamera = AVCaptureDevice.default(for: AVMediaType.video)
        var error: NSError?
        var input: AVCaptureDeviceInput!
        
        do {
            input = try AVCaptureDeviceInput(device: rearCamera!)
        } catch let captureError as NSError {
            error = captureError
            input = nil
            print(error?.localizedDescription ?? "CaptainPhotoViewController: AVCaptureSession error")
            return
        }
        
        if error == nil && session!.canAddInput(input) {
            session?.addInput(input)
        }
        
        if session!.canAddOutput(stillImageOutput) {
            session!.addOutput(stillImageOutput)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
            videoPreviewLayer!.videoGravity = AVLayerVideoGravity.resizeAspect
            videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            videoPreviewLayer!.frame = cameraView.layer.bounds
            videoPreviewLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill;
            cameraView.layer.addSublayer(videoPreviewLayer!)
            session!.startRunning()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer!.frame = cameraView.bounds
    }

    @IBAction func didTakePhoto(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.__availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                             kCVPixelBufferWidthKey as String: 160,
                             kCVPixelBufferHeightKey as String: 160]
        settings.previewPhotoFormat = previewFormat
        self.stillImageOutput.capturePhoto(with: settings, delegate: self)
    }

}

extension CaptainPhotoViewController: AVCapturePhotoCaptureDelegate {
    @objc func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
        }
        
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "newCaptainViewController") as? NewCaptainViewController
            let _ = controller?.view
            controller?.imageView.image = UIImage(data: dataImage)
            controller?.captainStore = captainStore
            self.navigationController?.pushViewController(controller!, animated: true)
        }
    }
}

