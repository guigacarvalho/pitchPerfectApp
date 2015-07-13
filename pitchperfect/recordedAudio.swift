//
//  recordedAudio.swift
//  pitchperfect
//
//  Created by Guilherme Carvalho on 6/28/15.
//  Copyright (c) 2015 Guilherme Carvalho. All rights reserved.
//

import Foundation

// Class that holds the audio info
class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    // Class initializer
    init(title:String, filePathUrl:NSURL) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}