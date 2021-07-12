//
//  RequestHeaderFields.swift
//  HablaNow
//
//  Created by promatics on 6/19/20.
//  Copyright © 2020 Temp. All rights reserved.
//

import Foundation

public enum RequestHeaderFields: String {
    case acceptCharset = "Accept-Charset"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case expect = "Expect"
    case from = "From"
    case host = "Host"
    case ifMatch = "If-Match"
    case ifModifiedSince = "If-Modified-Since"
    case ifNoneMatch = "If-None-Match"
    case ifRange = "If-Range"
    case ifUnmodifiedSince = "If-Unmodified-Since"
    case maxForwards = "Max-Forwards"
    case proxyAuthorization = "Proxy-Authorization"
    case range = "Range"
    case referer = "Referer"
    case te = "TE"
    case userAgent = "User-Agent"
}
