//
//  HttpClient.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import Foundation

class HttpClient {
	enum StatusCodeMeaning {
		case Information
		case Success
		case Redirection
		case ClientError
		case ServerError
		case Nonstandard
		case Unknown
	}
	
	public func defineStatusCode(code: Int) -> StatusCodeMeaning {
		if (code >= 100 && code < 200) {
			return StatusCodeMeaning.Information
		} else if (code >= 200 && code < 300) {
			return StatusCodeMeaning.Success
		} else if (code >= 300 && code < 400) {
			return StatusCodeMeaning.Redirection
		} else if (code >= 400 && code < 500) {
			return StatusCodeMeaning.ClientError
		} else if (code >= 500 && code < 600) {
			return StatusCodeMeaning.ServerError
		} else if (code > 600) {
			return StatusCodeMeaning.Nonstandard
		} else {
			return StatusCodeMeaning.Unknown
		}
	}
	
	public func post(url: String, body: Any? = nil, contentType: String? = "application/json") -> HTTPURLResponse? {
		print("HttpClient POST \(url) [-->]: \(String(describing: body))")
		
		let url = URL(string: url)!
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue(
			contentType,
			forHTTPHeaderField: "Content-Type"
		)
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			let response = response as! HTTPURLResponse
			print("HttpClient POST \(url) [<--]: \(self.defineStatusCode(code: response.statusCode)):\(response.statusCode); \(String(describing: (data != nil) ? String(data: data!, encoding: .utf8) : ""))");
		}
		
		task.resume()
		
		return task.response as? HTTPURLResponse;
	}
}
