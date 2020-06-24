////
////  DownloaderX.swift
////  Musaned
////
////  Copyright © 2020 ALHANOUF . All rights reserved.
////
//
//import Foundation
//import Firebase
//import FirebaseStorage
//
//
//
//let storage = Storage.storage()
//
//
//func downloadImagesAsString1(urls:String, withBlock: @escaping (_ imgString:[String?]) -> Void) {
//    let linkArray = seperateImageLinks(allLinks: urls)
//    var imageStringArray: [String] = []
//    var downloadCounter = 0
//    
//    
//    for link in linkArray {
//        let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
//        
//        downloadQueue.async {
//            downloadCounter += 1
//
//            
//            imageStringArray.append(link)
//            if downloadCounter == imageStringArray.count {
//                DispatchQueue.main.async {
//                    withBlock(imageStringArray)
//                }
//            }
//
//            else {
//                print("couldn't dowload image")
//                withBlock(imageStringArray)
//            }
//            
//        }
//    }
//}
//
//
//func downloadImages1(urls: String, withBLock: @escaping (_ image: [UIImage?]) -> Void) {
//    let linkArray = seperateImageLinks(allLinks: urls)
//    var imageArray: [UIImage] = []
//    var downloadCounter = 0
//    
//    
//    for link in linkArray {
//         let url = NSURL(string: link)
//        let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
//        
//        downloadQueue.async {
//            downloadCounter += 1
//            let data = NSData(contentsOf: url! as URL)
//            
//            if data != nil {
//                imageArray.append(UIImage(data: data! as Data)!)
//                if downloadCounter == imageArray.count {
//                    DispatchQueue.main.async {
//                        withBLock(imageArray)
//                    }
//                }
//            } else {
//                print("couldn't dowload image")
//                withBLock(imageArray)
//            }
//        }
//    }
//}
//
//
//
//func uploadImages1(images:[UIImage], userId:String, postId:String, withBlock: @escaping(_ imageLink: String?) -> Void) {
//    
//    convertImagesToData(images: images) { (pictures) in
//        var uploadCounter = 0
//        var nameSuffix = 0
//        var linkString = ""
//        
//        
//        for picture in pictures {
//            let longString = "\(nameSuffix)"
//            nameSuffix += 1
//            
//            let storageRef = Storage.storage().reference().child("PostImages").child(postId).child(longString)
//            var task: StorageUploadTask!
//            
//            
//            task = storageRef.putData(picture, metadata: nil, completion: { (metadata, error) in
//                uploadCounter += 1
//                if error != nil {
//                    print("error uploading picture \(error!.localizedDescription)")
//                    return
//                }
//                
//                storageRef.downloadURL(completion: { (url, err) in
//                    if let err = err {
//                        print("Failed to get downloadurl", err)
//                        return
//                    }
//                
//                
//                let link = url
//                linkString = linkString + link!.absoluteString + ","
//                if uploadCounter == pictures.count {
//                    task.removeAllObservers()
//                    withBlock(linkString)
//                }
//            })
//                
//                })
//        }
//    }
//}
//
//
//    func convertImagesToData1(images:[UIImage], withBlock: @escaping (_ dates:[Data])-> Void) {
//        var dataArray: [Data] = []
//        for image in images {
//            dataArray.append(image.jpegData(compressionQuality: 0.5)!)
//        }
//        withBlock(dataArray)
//    }
//
//    func seperateImageLinks1(allLinks:String) ->[String] {
//        var linkArray = allLinks.components(separatedBy: ",")
//        linkArray.removeLast()
//        return linkArray
//    }
//
//
//
//
//
//
////
////let storage1 = Storage.storage()
////
////
////func downloadImagesAsStringg(urls:String, withBlock: @escaping (_ imgString:[String?]) -> Void) {
////    let linkArray = seperateImageLinks(allLinks: urls)
////    var imageStringArray: [String] = []
////    var downloadCounter = 0
////
////
////    for link in linkArray {
////        let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
////
////        downloadQueue.async {
////            downloadCounter += 1
////
////
////            imageStringArray.append(link)
////            if downloadCounter == imageStringArray.count {
////                DispatchQueue.main.async {
////                    withBlock(imageStringArray)
////                }
////            }
////
////            else {
////                print("couldn't dowload image")
////                withBlock(imageStringArray)
////            }
////
////        }
////    }
////}
////
////
////
////
////
////func downloadImages1(urls: String, withBLock: @escaping (_ image: [UIImage?]) -> Void) {
////    let linkArray = seperateImageLinks(allLinks: urls)
////    var imageArray: [UIImage] = []
////    var downloadCounter = 0
////
////
////    for link in linkArray {
////         let url = NSURL(string: link)
////        let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
////
////        downloadQueue.async {
////            downloadCounter += 1
////            let data = NSData(contentsOf: url! as URL)
////
////            if data != nil {
////                imageArray.append(UIImage(data: data! as Data)!)
////                if downloadCounter == imageArray.count {
////                    DispatchQueue.main.async {
////                        withBLock(imageArray)
////                    }
////                }
////            } else {
////                print("couldn't dowload image")
////                withBLock(imageArray)
////            }
////        }
////    }
////}
////
////
////
////func uploadImages1(images:[UIImage], userId:String, postId:String, withBlock: @escaping(_ imageLink: String?) -> Void) {
////
////    convertImagesToData(images: images) { (pictures) in
////        var uploadCounter = 0
////        var nameSuffix = 0
////        var linkString = ""
////
////
////        for picture in pictures {
////            let longString = "\(nameSuffix)"
////            nameSuffix += 1
////
////            let storageRef = Storage.storage().reference().child("PostImages").child(postId).child(longString)
////            var task: StorageUploadTask!
////
////
////            task = storageRef.putData(picture, metadata: nil, completion: { (metadata, error) in
////                uploadCounter += 1
////                if error != nil {
////                    print("error uploading picture \(error!.localizedDescription)")
////                    return
////                }
////
////                storageRef.downloadURL(completion: { (url, err) in
////                    if let err = err {
////                        print("Failed to get downloadurl", err)
////                        return
////                    }
////
////
////                let link = url
////                linkString = linkString + link!.absoluteString + ","
////                if uploadCounter == pictures.count {
////                    task.removeAllObservers()
////                    withBlock(linkString)
////                }
////            })
////
////                })
////        }
////    }
////}
////
////
////    func convertImagesToData1(images:[UIImage], withBlock: @escaping (_ dates:[Data])-> Void) {
////        var dataArray: [Data] = []
////        for image in images {
////            dataArray.append(image.jpegData(compressionQuality: 0.5)!)
////        }
////        withBlock(dataArray)
////    }
////
////    func seperateImageLinkss(allLinks:String) ->[String] {
////        var linkArray = allLinks.components(separatedBy: ",")
////        linkArray.removeLast()
////        return linkArray
////    }
