//
//  ViewController.swift
//  TechtaGram
//
//  Created by 春田実利 on 2022/08/20.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraImageView: UIImageView!
    
    var originalImage: UIImage!
    
    var filter: CIFilter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
        } else {
            print("error")
        }
        
    }
    
    @IBAction func savePhoto() {
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
        
    }
    
    @IBAction func colorFilter() {
        let filterImage: CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        filter.setValue(1.0, forKey: "inputSaturation")//彩度
        filter.setValue(0.5, forKey: "inputBrightness")//明度
        filter.setValue(2.5, forKey: "inputContrast")//コントラスト
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        
        cameraImageView.image = UIImage(cgImage: cgImage!)
        
    }
    
    @IBAction func openAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func snsPhoto() {
        let shareText = "写真加工いえい"
        let shareImage = cameraImageView.image!
        
        let activtyItems: [Any] = [shareText,shareImage]
    
        let activtyViewController = UIActivityViewController(activityItems: activtyItems, applicationActivities: nil)
        
        let excludedActivtyTypes = [UIActivity.ActivityType.postToWeibo, .saveToCameraRoll, .print]
        
        activtyViewController.excludedActivityTypes = excludedActivtyTypes
        
        present(activtyViewController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        cameraImageView.image = info[.editedImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
        
        originalImage = cameraImageView.image
    }


}

