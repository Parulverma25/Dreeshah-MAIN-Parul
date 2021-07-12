//
//  ThumbnailGenerator.swift
//  Mumtalikati
//
//  Created by Promatics on 24/08/20.
//  Copyright © 2020 Promatics. All rights reserved.
//

import Foundation
import AVKit

/**
 Generate Thumbnail of selected Video
 */

class ThumbnailGenerator{
    
    static let shared = ThumbnailGenerator()
    
    func generateThumbnail(path: URL) -> UIImage? {
        
        do {
            
            let asset = AVURLAsset(url: path, options: nil)
            
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            
            imgGenerator.appliesPreferredTrackTransform = true
            
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            
            let thumbnail = UIImage(cgImage: cgImage)
            
            
            
            return thumbnail
            
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            
            return nil
            
        }
        
    }
    
    
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        
        DispatchQueue.global().async {
            
            //1
            
            
            
            let asset = AVAsset(url: url) //2
            
            
            
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            
            // let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            
            var time = asset.duration
            
            time.value = min(time.value, 2)
            
            do {
                
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil) //6
                
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                
                DispatchQueue.main.async { //8
                    
                    completion(thumbImage) //9
                    
                }
                
            } catch {
                
                print(error.localizedDescription) //10
                
                DispatchQueue.main.async {
                    
                    completion(nil) //11
                    
                }
                
            }
        }
    }
}

