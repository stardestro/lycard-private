//
//  CameraManager.swift
//  LyCard
//
//  Created by Hussain Alkatheri on 2/10/24.
//  From https://www.kodeco.com/26244793-building-a-camera-app-with-swiftui-and-combine
//  Also https://www.youtube.com/watch?v=cLnw5z8ZGqM
//  Also https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbGRqOW5FMmNXQzNLQU9DT0RnaWJoR1JTSXhOUXxBQ3Jtc0tsSWpjdmFsMnp6NVVBbnZuTjBBdVVQN2FNTHNmUWpMUzByVnVZUERVSHlFTk4xOGZfbkRIRXhlZWNybnJqZm1xajZKSmhmY0hndXNzaDhZcnp2VVUzM0ZfcGJNakFMdzE2UnpKQk5sZm1RazBIamozTQ&q=https%3A%2F%2Fgithub.com%2Fdaved01%2FLiveCameraSwiftUI%2Ftree%2Fmain&v=cLnw5z8ZGqM

import AVFoundation
import CoreImage
import UIKit

class FrameHandler: NSObject, ObservableObject {
    @Published var frame: CGImage?
    private var permissionGranted = true
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private let context = CIContext()
    private var photoOutput: AVCapturePhotoOutput?
    @Published var capturedImage: UIImage?
    
    override init() {
        super.init()
        self.checkPermission()
        sessionQueue.async { [unowned self] in
            self.setupCaptureSession()
            captureSession.sessionPreset = AVCaptureSession.Preset.photo
            self.captureSession.startRunning()
        }
    }
    
    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                self.permissionGranted = true
                
            case .notDetermined: // The user has not yet been asked for camera access.
                self.requestPermission()
                
        // Combine the two other cases into the default case
        default:
            self.permissionGranted = false
        }
    }
    
    func requestPermission() {
        // Strong reference not a problem here but might become one in the future.
        AVCaptureDevice.requestAccess(for: .video) { [unowned self] granted in
            self.permissionGranted = granted
        }
    }
    
    func setupCaptureSession() {
        let videoOutput = AVCaptureVideoDataOutput()
        
        guard permissionGranted else { return }
        guard let videoDevice = AVCaptureDevice.default(.builtInDualWideCamera,for: .video, position: .back) else { return }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
        guard captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
        captureSession.addOutput(videoOutput)
        
//        videoOutput.connection(with: .video)?.videoOrientation = .portrait
        
        videoOutput.connection(with: .video)?.isVideoMirrored = true
        videoOutput.connection(with: .video)?.videoRotationAngle = 90
        
        do {
            //you only get here if there is a camera ( ! ok )
            let captureDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: {(success, error) in
            })
            captureSession.addOutput(photoOutput!)
            captureSession.commitConfiguration()

        } catch {
            print("Error creating AVCaptureDeviceInput:", error)
        }
    }
    func startRunningCaptureSession() {
        let settings = AVCapturePhotoSettings()

        captureSession.startRunning()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }//startRunningCaptureSession

    func stopRunningCaptureSession() {
        captureSession.stopRunning()
    }//startRunningCaptureSession
        

}


extension FrameHandler: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let cgImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
        
        // All UI updates should be/ must be performed on the main queue.
        DispatchQueue.main.async { [unowned self] in
            self.frame = cgImage
        }
    }
    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CGImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        
        return cgImage
    }
    
}

extension FrameHandler: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            return
        }
        capturedImage = image
    }
}


class CaptureModel: NSObject, ObservableObject {
    let captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var currentCamera: AVCaptureDevice?
    @Published
    var capturedImage: UIImage?

    override init() {
        super.init()
        setupCaptureSession()
        setupDevices()
        setupInputOutput()
    }

    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }//setupCaptureSession

    func setupDevices() {

        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: .video, position: .unspecified)

        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }//if else
        }//for in

        currentCamera = frontCamera

    }//setupDevices

    func setupInputOutput() {

        do {
            //you only get here if there is a camera ( ! ok )
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: {(success, error) in
            })
            captureSession.addOutput(photoOutput!)
            captureSession.commitConfiguration()

        } catch {
            print("Error creating AVCaptureDeviceInput:", error)
        }

    }//setupInputOutput

    func startRunningCaptureSession() {
        let settings = AVCapturePhotoSettings()

        captureSession.startRunning()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }//startRunningCaptureSession

    func stopRunningCaptureSession() {
        captureSession.stopRunning()
    }//startRunningCaptureSession
}

extension CaptureModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            return
        }
        capturedImage = image
    }
}
